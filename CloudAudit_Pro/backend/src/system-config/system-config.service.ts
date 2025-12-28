import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateConfigDto } from './dto/create-config.dto';
import { UpdateConfigDto } from './dto/update-config.dto';
import { ConfigCategory } from '@prisma/client';
import * as crypto from 'crypto';

@Injectable()
export class SystemConfigService {
  private readonly ENCRYPTION_KEY = process.env.CONFIG_ENCRYPTION_KEY || 'default-encryption-key-change-in-production';
  private readonly ENCRYPTION_ALGORITHM = 'aes-256-cbc';

  constructor(private readonly db: DatabaseService) {}

  /**
   * Create a new system configuration
   */
  async create(tenantId: string, userId: string, dto: CreateConfigDto) {
    // Check if configuration key already exists
    const existing = await this.db.systemConfiguration.findUnique({
      where: { configKey: dto.configKey },
    });

    if (existing) {
      throw new BadRequestException(`Configuration key '${dto.configKey}' already exists`);
    }

    // Encrypt value if requested
    const configValue = dto.isEncrypted
      ? this.encryptValue(dto.configValue)
      : dto.configValue;

    return this.db.systemConfiguration.create({
      data: {
        tenantId,
        configKey: dto.configKey,
        configValue,
        category: dto.category,
        description: dto.description,
        dataType: dto.dataType || 'string',
        isEncrypted: dto.isEncrypted || false,
        updatedBy: userId,
      },
    });
  }

  /**
   * Get all configurations, optionally filtered by category
   */
  async findAll(tenantId: string, category?: ConfigCategory) {
    const where: any = { tenantId };
    
    if (category) {
      where.category = category;
    }

    const configs = await this.db.systemConfiguration.findMany({
      where,
      include: {
        updatedByUser: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
      orderBy: {
        configKey: 'asc',
      },
    });

    // Decrypt values if encrypted
    return configs.map((config) => ({
      ...config,
      configValue: config.isEncrypted
        ? this.decryptValue(config.configValue)
        : config.configValue,
    }));
  }

  /**
   * Get configuration by key
   */
  async findOne(configKey: string) {
    const config = await this.db.systemConfiguration.findUnique({
      where: { configKey },
      include: {
        updatedByUser: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });

    if (!config) {
      throw new NotFoundException(`Configuration '${configKey}' not found`);
    }

    // Decrypt value if encrypted
    return {
      ...config,
      configValue: config.isEncrypted
        ? this.decryptValue(config.configValue)
        : config.configValue,
    };
  }

  /**
   * Get configurations by category
   */
  async findByCategory(tenantId: string, category: ConfigCategory) {
    return this.findAll(tenantId, category);
  }

  /**
   * Update configuration
   */
  async update(configKey: string, userId: string, dto: UpdateConfigDto) {
    const config = await this.findOne(configKey);

    // Encrypt value if requested
    const configValue = dto.configValue
      ? dto.isEncrypted
        ? this.encryptValue(dto.configValue)
        : dto.configValue
      : undefined;

    return this.db.systemConfiguration.update({
      where: { configKey },
      data: {
        ...(configValue !== undefined && { configValue }),
        ...(dto.category && { category: dto.category }),
        ...(dto.description !== undefined && { description: dto.description }),
        ...(dto.dataType && { dataType: dto.dataType }),
        ...(dto.isEncrypted !== undefined && { isEncrypted: dto.isEncrypted }),
        updatedBy: userId,
        updatedAt: new Date(),
      },
    });
  }

  /**
   * Delete configuration
   */
  async remove(configKey: string) {
    await this.findOne(configKey);

    return this.db.systemConfiguration.delete({
      where: { configKey },
    });
  }

  /**
   * Bulk update configurations
   */
  async bulkUpdate(tenantId: string, userId: string, configs: UpdateConfigDto[]) {
    const updates = configs.map((dto) => {
      const configValue = dto.configValue
        ? dto.isEncrypted
          ? this.encryptValue(dto.configValue)
          : dto.configValue
        : undefined;

      return this.db.systemConfiguration.update({
        where: { configKey: dto.configKey },
        data: {
          ...(configValue !== undefined && { configValue }),
          ...(dto.category && { category: dto.category }),
          ...(dto.description !== undefined && { description: dto.description }),
          ...(dto.dataType && { dataType: dto.dataType }),
          ...(dto.isEncrypted !== undefined && { isEncrypted: dto.isEncrypted }),
          updatedBy: userId,
          updatedAt: new Date(),
        },
      });
    });

    return Promise.all(updates);
  }

  /**
   * Export all configurations
   */
  async exportConfigs(tenantId: string) {
    return this.findAll(tenantId);
  }

  /**
   * Import configurations
   */
  async importConfigs(tenantId: string, userId: string, configs: CreateConfigDto[]) {
    const imports = configs.map((dto) => {
      const configValue = dto.isEncrypted
        ? this.encryptValue(dto.configValue)
        : dto.configValue;

      return this.db.systemConfiguration.upsert({
        where: { configKey: dto.configKey },
        update: {
          configValue,
          category: dto.category,
          description: dto.description,
          dataType: dto.dataType || 'string',
          isEncrypted: dto.isEncrypted || false,
          updatedBy: userId,
        },
        create: {
          tenantId,
          configKey: dto.configKey,
          configValue,
          category: dto.category,
          description: dto.description,
          dataType: dto.dataType || 'string',
          isEncrypted: dto.isEncrypted || false,
          updatedBy: userId,
        },
      });
    });

    return Promise.all(imports);
  }

  /**
   * Reset configurations to defaults
   */
  async resetToDefaults(tenantId: string, userId: string) {
    // Define default configurations
    const defaults: CreateConfigDto[] = [
      {
        configKey: 'app.name',
        configValue: 'CloudAudit Pro',
        category: ConfigCategory.GENERAL,
        description: 'Application name',
        dataType: 'string',
      },
      {
        configKey: 'app.timezone',
        configValue: 'UTC',
        category: ConfigCategory.GENERAL,
        description: 'Default timezone',
        dataType: 'string',
      },
      {
        configKey: 'security.sessionTimeout',
        configValue: 3600,
        category: ConfigCategory.SECURITY,
        description: 'Session timeout in seconds',
        dataType: 'number',
      },
      {
        configKey: 'email.from',
        configValue: 'noreply@cloudauditpro.com',
        category: ConfigCategory.EMAIL,
        description: 'Default from email address',
        dataType: 'string',
      },
    ];

    return this.importConfigs(tenantId, userId, defaults);
  }

  /**
   * Encrypt a configuration value
   */
  private encryptValue(value: any): any {
    const stringValue = JSON.stringify(value);
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipheriv(
      this.ENCRYPTION_ALGORITHM,
      Buffer.from(this.ENCRYPTION_KEY).slice(0, 32),
      iv,
    );

    let encrypted = cipher.update(stringValue, 'utf8', 'hex');
    encrypted += cipher.final('hex');

    return {
      iv: iv.toString('hex'),
      data: encrypted,
    };
  }

  /**
   * Decrypt a configuration value
   */
  private decryptValue(encryptedValue: any): any {
    if (!encryptedValue.iv || !encryptedValue.data) {
      return encryptedValue;
    }

    const decipher = crypto.createDecipheriv(
      this.ENCRYPTION_ALGORITHM,
      Buffer.from(this.ENCRYPTION_KEY).slice(0, 32),
      Buffer.from(encryptedValue.iv, 'hex'),
    );

    let decrypted = decipher.update(encryptedValue.data, 'hex', 'utf8');
    decrypted += decipher.final('utf8');

    return JSON.parse(decrypted);
  }
}
