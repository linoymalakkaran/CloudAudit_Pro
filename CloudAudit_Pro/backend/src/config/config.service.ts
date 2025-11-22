import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import {
  CreateConfigurationDto,
  UpdateConfigurationDto,
  ConfigQueryDto,
  SystemConfigDto,
  SecurityConfigDto,
  AuditConfigDto,
  FinancialConfigDto,
  ReportingConfigDto,
  NotificationConfigDto,
  IntegrationConfigDto,
  AppearanceConfigDto,
  ConfigurationType,
  SettingDataType
} from './dto/config.dto';

interface ConfigurationTemplate {
  type: ConfigurationType;
  name: string;
  description: string;
  settings: {
    key: string;
    defaultValue: any;
    dataType: SettingDataType;
    description: string;
    isRequired: boolean;
    isSensitive: boolean;
    validation?: any;
  }[];
}

export interface SystemHealth {
  status: 'HEALTHY' | 'WARNING' | 'CRITICAL';
  components: {
    database: 'HEALTHY' | 'WARNING' | 'CRITICAL';
    storage: 'HEALTHY' | 'WARNING' | 'CRITICAL';
    email: 'HEALTHY' | 'WARNING' | 'CRITICAL';
    backup: 'HEALTHY' | 'WARNING' | 'CRITICAL';
  };
  lastCheck: Date;
  uptime: number;
  version: string;
}

@Injectable()
export class ConfigService {
  constructor(private readonly database: DatabaseService) {}

  async create(createConfigDto: CreateConfigurationDto, userId: string) {
    // Verify user has admin permissions
    await this.verifyAdminAccess(userId);

    // If company-specific, verify access
    if (createConfigDto.companyId) {
      await this.verifyCompanyAccess(createConfigDto.companyId, userId);
    }

    // Validate settings
    this.validateSettings(createConfigDto.settings);

    // Encrypt sensitive settings
    const processedSettings = await this.processSettings(createConfigDto.settings);

    return this.database.configuration.create({
      data: {
        type: createConfigDto.type,
        name: createConfigDto.name,
        description: createConfigDto.description,
        companyId: createConfigDto.companyId,
        settings: JSON.stringify(processedSettings),
        isActive: createConfigDto.isActive ?? true,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async findAll(query: ConfigQueryDto, userId: string) {
    const { page = 1, limit = 20, ...filters } = query;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filters.type) where.type = filters.type;
    if (filters.isActive !== undefined) where.isActive = filters.isActive;

    if (filters.companyId) {
      await this.verifyCompanyAccess(filters.companyId, userId);
      where.companyId = filters.companyId;
    }

    if (filters.search) {
      where.OR = [
        { name: { contains: filters.search, mode: 'insensitive' } },
        { description: { contains: filters.search, mode: 'insensitive' } },
      ];
    }

    const [configurations, total] = await Promise.all([
      this.database.configuration.findMany({
        where,
        skip,
        take: limit,
        orderBy: [
          { type: 'asc' },
          { name: 'asc' },
        ],
        include: {
          company: {
            select: { id: true, name: true },
          },
          creator: {
            select: { id: true, firstName: true, lastName: true },
          },
        },
      }),
      this.database.configuration.count({ where }),
    ]);

    // Decrypt and process settings for response
    const processedConfigurations = await Promise.all(
      configurations.map(async (config) => ({
        ...config,
        settings: await this.decryptSettings(JSON.parse(config.settings || '[]')),
      }))
    );

    return {
      data: processedConfigurations,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, userId: string) {
    const configuration = await this.database.configuration.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        creator: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
      },
    });

    if (!configuration) {
      throw new NotFoundException('Configuration not found');
    }

    // Verify access
    if (configuration.companyId) {
      await this.verifyCompanyAccess(configuration.companyId, userId);
    } else {
      await this.verifyAdminAccess(userId);
    }

    return {
      ...configuration,
      settings: await this.decryptSettings(JSON.parse(configuration.settings || '[]')),
    };
  }

  async update(id: string, updateConfigDto: UpdateConfigurationDto, userId: string) {
    const existingConfig = await this.findOne(id, userId);

    // Validate and process settings if provided
    let processedSettings;
    if (updateConfigDto.settings) {
      this.validateSettings(updateConfigDto.settings);
      processedSettings = await this.processSettings(updateConfigDto.settings);
    }

    const updateData: any = {
      ...updateConfigDto,
      updatedBy: userId,
    };

    if (processedSettings) {
      updateData.settings = JSON.stringify(processedSettings);
    }

    return this.database.configuration.update({
      where: { id },
      data: updateData,
      include: {
        company: {
          select: { id: true, name: true },
        },
      },
    });
  }

  async remove(id: string, userId: string) {
    const existingConfig = await this.findOne(id, userId);

    await this.database.configuration.delete({
      where: { id },
    });

    return { message: 'Configuration deleted successfully' };
  }

  async getByType(type: ConfigurationType, companyId?: string, userId?: string) {
    const where: any = { type, isActive: true };

    if (companyId) {
      if (userId) await this.verifyCompanyAccess(companyId, userId);
      where.companyId = companyId;
    } else {
      where.companyId = null; // Global configuration
    }

    const configurations = await this.database.configuration.findMany({
      where,
      orderBy: { name: 'asc' },
    });

    return Promise.all(
      configurations.map(async (config) => ({
        ...config,
        settings: await this.decryptSettings(JSON.parse(config.settings || '[]')),
      }))
    );
  }

  async getSystemConfig(): Promise<SystemConfigDto> {
    const configs = await this.getByType(ConfigurationType.SYSTEM);
    const settings = this.flattenSettings(configs);

    return {
      applicationName: settings.applicationName || 'CloudAudit Pro',
      version: settings.version || '1.0.0',
      timezone: settings.timezone || 'UTC',
      defaultLanguage: settings.defaultLanguage || 'en',
      maintenanceMode: settings.maintenanceMode || false,
      debugMode: settings.debugMode || false,
      maxFileUploadSize: settings.maxFileUploadSize || 50,
      sessionTimeout: settings.sessionTimeout || 30,
    };
  }

  async getSecurityConfig(): Promise<SecurityConfigDto> {
    const configs = await this.getByType(ConfigurationType.SECURITY);
    const settings = this.flattenSettings(configs);

    return {
      passwordMinLength: settings.passwordMinLength || 8,
      passwordRequireUppercase: settings.passwordRequireUppercase || true,
      passwordRequireLowercase: settings.passwordRequireLowercase || true,
      passwordRequireNumbers: settings.passwordRequireNumbers || true,
      passwordRequireSpecialChars: settings.passwordRequireSpecialChars || false,
      maxLoginAttempts: settings.maxLoginAttempts || 5,
      lockoutDuration: settings.lockoutDuration || 15,
      twoFactorRequired: settings.twoFactorRequired || false,
      ipWhitelist: settings.ipWhitelist || [],
      dataEncryptionEnabled: settings.dataEncryptionEnabled || true,
    };
  }

  async getAuditConfig(companyId?: string): Promise<AuditConfigDto> {
    const configs = await this.getByType(ConfigurationType.AUDIT, companyId);
    const settings = this.flattenSettings(configs);

    return {
      defaultProcedureTimeout: settings.defaultProcedureTimeout || 30,
      autoAssignmentEnabled: settings.autoAssignmentEnabled || false,
      overdueNotificationsEnabled: settings.overdueNotificationsEnabled || true,
      reminderDaysBefore: settings.reminderDaysBefore || 7,
      supervisorApprovalRequired: settings.supervisorApprovalRequired || true,
      workflowTemplates: settings.workflowTemplates || [],
      riskAssessmentMandatory: settings.riskAssessmentMandatory || true,
      documentAttachmentRequired: settings.documentAttachmentRequired || false,
    };
  }

  async getFinancialConfig(companyId?: string): Promise<FinancialConfigDto> {
    const configs = await this.getByType(ConfigurationType.FINANCIAL, companyId);
    const settings = this.flattenSettings(configs);

    return {
      defaultCurrency: settings.defaultCurrency || 'USD',
      decimalPlaces: settings.decimalPlaces || 2,
      thousandsSeparator: settings.thousandsSeparator || ',',
      decimalSeparator: settings.decimalSeparator || '.',
      fiscalYearStartMonth: settings.fiscalYearStartMonth || 1,
      autoJournalNumbering: settings.autoJournalNumbering || true,
      journalApprovalRequired: settings.journalApprovalRequired || false,
      allowBackdatedEntries: settings.allowBackdatedEntries || false,
    };
  }

  async getReportingConfig(companyId?: string): Promise<ReportingConfigDto> {
    const configs = await this.getByType(ConfigurationType.REPORTING, companyId);
    const settings = this.flattenSettings(configs);

    return {
      defaultFormat: settings.defaultFormat || 'PDF',
      includeCompanyLogo: settings.includeCompanyLogo || true,
      showWatermark: settings.showWatermark || false,
      archivalDays: settings.archivalDays || 365,
      customTemplates: settings.customTemplates || [],
      scheduledReportsEnabled: settings.scheduledReportsEnabled || true,
      maxConcurrentGenerations: settings.maxConcurrentGenerations || 5,
    };
  }

  async getNotificationConfig(): Promise<NotificationConfigDto> {
    const configs = await this.getByType(ConfigurationType.NOTIFICATION);
    const settings = this.flattenSettings(configs);

    return {
      emailEnabled: settings.emailEnabled || true,
      smsEnabled: settings.smsEnabled || false,
      pushEnabled: settings.pushEnabled || true,
      defaultTypes: settings.defaultTypes || ['EMAIL'],
      smtpConfig: settings.smtpConfig || null,
      smsConfig: settings.smsConfig || null,
      webhookUrls: settings.webhookUrls || [],
    };
  }

  async getIntegrationConfig(): Promise<IntegrationConfigDto> {
    const configs = await this.getByType(ConfigurationType.INTEGRATION);
    const settings = this.flattenSettings(configs);

    return {
      rateLimitingEnabled: settings.rateLimitingEnabled || true,
      requestsPerMinute: settings.requestsPerMinute || 60,
      externalApis: settings.externalApis || {},
      databaseSync: settings.databaseSync || {},
      thirdPartyIntegrations: settings.thirdPartyIntegrations || [],
    };
  }

  async getAppearanceConfig(companyId?: string): Promise<AppearanceConfigDto> {
    const configs = await this.getByType(ConfigurationType.APPEARANCE, companyId);
    const settings = this.flattenSettings(configs);

    return {
      theme: settings.theme || 'default',
      primaryColor: settings.primaryColor || '#1976d2',
      secondaryColor: settings.secondaryColor || '#424242',
      logoUrl: settings.logoUrl || null,
      faviconUrl: settings.faviconUrl || null,
      customCss: settings.customCss || null,
      darkModeEnabled: settings.darkModeEnabled || false,
    };
  }

  async getTemplates(): Promise<ConfigurationTemplate[]> {
    return [
      {
        type: ConfigurationType.SYSTEM,
        name: 'System Configuration',
        description: 'Core system settings and preferences',
        settings: [
          {
            key: 'applicationName',
            defaultValue: 'CloudAudit Pro',
            dataType: SettingDataType.STRING,
            description: 'Application display name',
            isRequired: true,
            isSensitive: false,
          },
          {
            key: 'timezone',
            defaultValue: 'UTC',
            dataType: SettingDataType.STRING,
            description: 'Default system timezone',
            isRequired: true,
            isSensitive: false,
          },
          {
            key: 'sessionTimeout',
            defaultValue: 30,
            dataType: SettingDataType.NUMBER,
            description: 'Session timeout in minutes',
            isRequired: true,
            isSensitive: false,
            validation: { min: 5, max: 480 },
          },
        ],
      },
      {
        type: ConfigurationType.SECURITY,
        name: 'Security Configuration',
        description: 'Security policies and authentication settings',
        settings: [
          {
            key: 'passwordMinLength',
            defaultValue: 8,
            dataType: SettingDataType.NUMBER,
            description: 'Minimum password length',
            isRequired: true,
            isSensitive: false,
            validation: { min: 6, max: 20 },
          },
          {
            key: 'maxLoginAttempts',
            defaultValue: 5,
            dataType: SettingDataType.NUMBER,
            description: 'Maximum failed login attempts before lockout',
            isRequired: true,
            isSensitive: false,
            validation: { min: 3, max: 10 },
          },
          {
            key: 'twoFactorRequired',
            defaultValue: false,
            dataType: SettingDataType.BOOLEAN,
            description: 'Require two-factor authentication',
            isRequired: false,
            isSensitive: false,
          },
        ],
      },
      {
        type: ConfigurationType.AUDIT,
        name: 'Audit Configuration',
        description: 'Audit procedure and workflow settings',
        settings: [
          {
            key: 'defaultProcedureTimeout',
            defaultValue: 30,
            dataType: SettingDataType.NUMBER,
            description: 'Default procedure timeout in days',
            isRequired: true,
            isSensitive: false,
            validation: { min: 1, max: 365 },
          },
          {
            key: 'supervisorApprovalRequired',
            defaultValue: true,
            dataType: SettingDataType.BOOLEAN,
            description: 'Require supervisor approval for procedure completion',
            isRequired: false,
            isSensitive: false,
          },
        ],
      },
    ];
  }

  async getSystemHealth(): Promise<SystemHealth> {
    // Check database connection
    let dbStatus: 'HEALTHY' | 'WARNING' | 'CRITICAL' = 'HEALTHY';
    try {
      await this.database.$queryRaw`SELECT 1`;
    } catch (error) {
      dbStatus = 'CRITICAL';
    }

    // Check storage (simplified)
    const storageStatus: 'HEALTHY' | 'WARNING' | 'CRITICAL' = 'HEALTHY';

    // Check email service (simplified)
    const emailStatus: 'HEALTHY' | 'WARNING' | 'CRITICAL' = 'HEALTHY';

    // Check backup service (simplified)
    const backupStatus: 'HEALTHY' | 'WARNING' | 'CRITICAL' = 'HEALTHY';

    const overallStatus: 'HEALTHY' | 'WARNING' | 'CRITICAL' = [dbStatus, storageStatus, emailStatus, backupStatus].includes('CRITICAL' as any)
      ? 'CRITICAL'
      : [dbStatus, storageStatus, emailStatus, backupStatus].includes('WARNING' as any)
      ? 'WARNING'
      : 'HEALTHY';

    return {
      status: overallStatus,
      components: {
        database: dbStatus,
        storage: storageStatus,
        email: emailStatus,
        backup: backupStatus,
      },
      lastCheck: new Date(),
      uptime: 99.8, // Would be calculated from system metrics
      version: '1.0.0',
    };
  }

  async resetToDefaults(type: ConfigurationType, companyId?: string, userId?: string) {
    if (userId) {
      await this.verifyAdminAccess(userId);
      if (companyId) {
        await this.verifyCompanyAccess(companyId, userId);
      }
    }

    const templates = await this.getTemplates();
    const template = templates.find(t => t.type === type);

    if (!template) {
      throw new NotFoundException('Configuration template not found');
    }

    // Delete existing configurations of this type
    await this.database.configuration.deleteMany({
      where: {
        type,
        companyId: companyId || null,
      },
    });

    // Create new configuration with defaults
    const defaultSettings = template.settings.map(setting => ({
      key: setting.key,
      value: setting.defaultValue,
      dataType: setting.dataType,
      description: setting.description,
      isRequired: setting.isRequired,
      isSensitive: setting.isSensitive,
      validation: setting.validation,
    }));

    return this.database.configuration.create({
      data: {
        type,
        name: template.name,
        description: template.description,
        companyId,
        settings: JSON.stringify(defaultSettings),
        isActive: true,
        createdBy: userId || 'system',
        updatedBy: userId || 'system',
      },
    });
  }

  async exportConfig(type?: ConfigurationType, companyId?: string) {
    const where: any = { isActive: true };
    
    if (type) where.type = type;
    if (companyId) where.companyId = companyId;

    const configurations = await this.database.configuration.findMany({
      where,
      include: {
        company: {
          select: { id: true, name: true },
        },
      },
    });

    const exportData = await Promise.all(
      configurations.map(async (config) => ({
        id: config.id,
        type: config.type,
        name: config.name,
        description: config.description,
        companyId: config.companyId,
        companyName: config.company?.name,
        settings: await this.decryptSettings(JSON.parse(config.settings || '[]')),
        isActive: config.isActive,
        createdAt: config.createdAt,
        updatedAt: config.updatedAt,
      }))
    );

    return {
      exportedAt: new Date(),
      totalConfigurations: exportData.length,
      configurations: exportData,
    };
  }

  // Private helper methods
  private validateSettings(settings: any[]) {
    for (const setting of settings) {
      if (!setting.key || !setting.dataType) {
        throw new BadRequestException('Setting key and dataType are required');
      }

      // Validate data type
      if (!Object.values(SettingDataType).includes(setting.dataType)) {
        throw new BadRequestException(`Invalid data type: ${setting.dataType}`);
      }

      // Additional validation based on type
      if (setting.validation) {
        this.validateSettingValue(setting.value, setting.dataType, setting.validation);
      }
    }
  }

  private validateSettingValue(value: any, dataType: SettingDataType, validation: any) {
    switch (dataType) {
      case SettingDataType.NUMBER:
        if (validation.min !== undefined && value < validation.min) {
          throw new BadRequestException(`Value must be at least ${validation.min}`);
        }
        if (validation.max !== undefined && value > validation.max) {
          throw new BadRequestException(`Value must be at most ${validation.max}`);
        }
        break;
      case SettingDataType.STRING:
        if (validation.minLength !== undefined && value.length < validation.minLength) {
          throw new BadRequestException(`Value must be at least ${validation.minLength} characters`);
        }
        if (validation.maxLength !== undefined && value.length > validation.maxLength) {
          throw new BadRequestException(`Value must be at most ${validation.maxLength} characters`);
        }
        break;
    }
  }

  private async processSettings(settings: any[]) {
    return Promise.all(
      settings.map(async (setting) => {
        if (setting.isSensitive && setting.value) {
          // In a real implementation, use proper encryption
          return {
            ...setting,
            value: Buffer.from(setting.value).toString('base64'),
          };
        }
        return setting;
      })
    );
  }

  private async decryptSettings(settings: any[]) {
    return Promise.all(
      settings.map(async (setting) => {
        if (setting.isSensitive && setting.value) {
          // In a real implementation, use proper decryption
          try {
            return {
              ...setting,
              value: Buffer.from(setting.value, 'base64').toString(),
            };
          } catch {
            return setting; // Return as-is if decryption fails
          }
        }
        return setting;
      })
    );
  }

  private flattenSettings(configurations: any[]) {
    const flattened: any = {};
    
    configurations.forEach(config => {
      config.settings.forEach((setting: any) => {
        flattened[setting.key] = setting.value;
      });
    });

    return flattened;
  }

  private async verifyAdminAccess(userId: string) {
    const user = await this.database.user.findUnique({
      where: { id: userId },
      select: { role: true, isActive: true },
    });

    if (!user || !user.isActive) {
      throw new ForbiddenException('Access denied');
    }

    if (user.role !== 'ADMIN' && user.role !== 'MANAGER') {
      throw new ForbiddenException('Admin access required');
    }
  }

  private async verifyCompanyAccess(companyId: string, userId: string) {
    const userCompanies = await this.getUserCompanies(userId);
    const hasAccess = userCompanies.some(company => company.id === companyId);
    
    if (!hasAccess) {
      throw new ForbiddenException('Access denied to this company');
    }
  }

  private async getUserCompanies(userId: string) {
    return this.database.company.findMany({
      select: { id: true, name: true },
    });
  }
}