import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateIntegrationDto } from './dto/create-integration.dto';
import { UpdateIntegrationDto } from './dto/update-integration.dto';
import { IntegrationType, IntegrationStatus, LogType } from '@prisma/client';

@Injectable()
export class IntegrationsService {
  constructor(private readonly database: DatabaseService) {}

  async create(userId: string, tenantId: string, createDto: CreateIntegrationDto) {
    return this.database.integration.create({
      data: {
        ...createDto,
        tenantId,
        status: IntegrationStatus.ACTIVE,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async findAll(tenantId: string, integrationType?: IntegrationType) {
    return this.database.integration.findMany({
      where: {
        tenantId,
        ...(integrationType && { integrationType }),
      },
      orderBy: { createdAt: 'desc' },
      include: {
        logs: {
          take: 5,
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  async findOne(id: string, tenantId: string) {
    const integration = await this.database.integration.findFirst({
      where: { id, tenantId },
      include: {
        logs: {
          take: 10,
          orderBy: { createdAt: 'desc' },
        },
      },
    });

    if (!integration) {
      throw new NotFoundException(`Integration with ID ${id} not found`);
    }

    return integration;
  }

  async update(id: string, tenantId: string, userId: string, updateDto: UpdateIntegrationDto) {
    await this.findOne(id, tenantId);

    return this.database.integration.update({
      where: { id },
      data: {
        ...updateDto,
        updatedBy: userId,
        updatedAt: new Date(),
      },
    });
  }

  async remove(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    return this.database.integration.delete({
      where: { id },
    });
  }

  async testConnection(id: string, tenantId: string) {
    const integration = await this.findOne(id, tenantId);

    try {
      // Test connection based on integration type
      const result = await this.performConnectionTest(integration);

      await this.createLog(id, {
        logType: LogType.INFO,
        status: IntegrationStatus.ACTIVE,
        request: { test: 'connection' },
        response: result,
        recordsProcessed: 0,
        recordsFailed: 0,
        duration: 0,
      });

      return { success: true, message: 'Connection successful', details: result };
    } catch (error) {
      await this.createLog(id, {
        logType: LogType.ERROR,
        status: IntegrationStatus.ERROR,
        request: { test: 'connection' },
        response: null,
        errorMessage: error.message,
        recordsProcessed: 0,
        recordsFailed: 0,
        duration: 0,
      });

      throw new BadRequestException(`Connection test failed: ${error.message}`);
    }
  }

  async sync(id: string, tenantId: string) {
    const integration = await this.findOne(id, tenantId);

    if (!integration.isActive) {
      throw new BadRequestException('Integration is not active');
    }

    try {
      await this.database.integration.update({
        where: { id },
        data: { status: IntegrationStatus.SYNCING },
      });

      const startTime = Date.now();
      const result = await this.performSync(integration);
      const duration = Date.now() - startTime;

      await this.database.integration.update({
        where: { id },
        data: {
          status: IntegrationStatus.ACTIVE,
          lastSyncAt: new Date(),
          nextSyncAt: this.calculateNextSync(integration.syncFrequency),
          lastError: null,
        },
      });

      await this.createLog(id, {
        logType: LogType.SYNC,
        status: IntegrationStatus.ACTIVE,
        request: result.request,
        response: result.response,
        recordsProcessed: result.recordsProcessed,
        recordsFailed: result.recordsFailed,
        duration,
      });

      return result;
    } catch (error) {
      await this.database.integration.update({
        where: { id },
        data: {
          status: IntegrationStatus.ERROR,
          lastError: error.message,
        },
      });

      await this.createLog(id, {
        logType: LogType.ERROR,
        status: IntegrationStatus.ERROR,
        request: null,
        response: null,
        errorMessage: error.message,
        recordsProcessed: 0,
        recordsFailed: 0,
        duration: 0,
      });

      throw new BadRequestException(`Sync failed: ${error.message}`);
    }
  }

  async getLogs(id: string, tenantId: string, limit = 50) {
    await this.findOne(id, tenantId);

    return this.database.integrationLog.findMany({
      where: { integrationId: id },
      orderBy: { createdAt: 'desc' },
      take: limit,
    });
  }

  async getActiveIntegrations(tenantId: string) {
    return this.database.integration.findMany({
      where: {
        tenantId,
        isActive: true,
        status: IntegrationStatus.ACTIVE,
      },
    });
  }

  async getIntegrationStats(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    const logs = await this.database.integrationLog.findMany({
      where: { integrationId: id },
    });

    const totalSyncs = logs.filter(l => l.logType === LogType.SYNC).length;
    const successfulSyncs = logs.filter(
      l => l.logType === LogType.SYNC && l.status === IntegrationStatus.ACTIVE,
    ).length;
    const failedSyncs = logs.filter(
      l => l.logType === LogType.SYNC && l.status === IntegrationStatus.ERROR,
    ).length;
    const totalRecordsProcessed = logs.reduce((sum, l) => sum + l.recordsProcessed, 0);
    const totalRecordsFailed = logs.reduce((sum, l) => sum + l.recordsFailed, 0);
    const avgDuration = logs.length > 0 ? logs.reduce((sum, l) => sum + l.duration, 0) / logs.length : 0;

    return {
      totalSyncs,
      successfulSyncs,
      failedSyncs,
      successRate: totalSyncs > 0 ? (successfulSyncs / totalSyncs) * 100 : 0,
      totalRecordsProcessed,
      totalRecordsFailed,
      avgDuration,
    };
  }

  async enable(id: string, tenantId: string, userId: string) {
    return this.update(id, tenantId, userId, { isActive: true });
  }

  async disable(id: string, tenantId: string, userId: string) {
    return this.update(id, tenantId, userId, { isActive: false });
  }

  // Private helper methods

  private async createLog(integrationId: string, data: any) {
    return this.database.integrationLog.create({
      data: {
        integrationId,
        ...data,
      },
    });
  }

  private calculateNextSync(syncFrequency?: string): Date | null {
    if (!syncFrequency) return null;

    const now = new Date();
    const minutes = parseInt(syncFrequency);
    
    if (isNaN(minutes)) return null;

    return new Date(now.getTime() + minutes * 60000);
  }

  private async performConnectionTest(integration: any): Promise<any> {
    switch (integration.integrationType) {
      case IntegrationType.ACCOUNTING_SOFTWARE:
        return this.testAccountingSoftware(integration);
      case IntegrationType.ERP:
        return this.testERP(integration);
      case IntegrationType.BANK:
        return this.testBank(integration);
      case IntegrationType.EMAIL:
        return this.testEmail(integration);
      case IntegrationType.CLOUD_STORAGE:
        return this.testCloudStorage(integration);
      case IntegrationType.SSO:
        return this.testSSO(integration);
      case IntegrationType.API:
        return this.testAPI(integration);
      case IntegrationType.WEBHOOK:
        return this.testWebhook(integration);
      default:
        throw new BadRequestException('Unsupported integration type');
    }
  }

  private async performSync(integration: any): Promise<any> {
    switch (integration.integrationType) {
      case IntegrationType.ACCOUNTING_SOFTWARE:
        return this.syncAccountingSoftware(integration);
      case IntegrationType.ERP:
        return this.syncERP(integration);
      case IntegrationType.BANK:
        return this.syncBank(integration);
      case IntegrationType.CLOUD_STORAGE:
        return this.syncCloudStorage(integration);
      default:
        throw new BadRequestException('Sync not supported for this integration type');
    }
  }

  // Integration type specific methods (simplified placeholders)

  private async testAccountingSoftware(integration: any): Promise<any> {
    // Test QuickBooks/Xero connection
    return { status: 'connected', version: '1.0' };
  }

  private async testERP(integration: any): Promise<any> {
    // Test ERP connection
    return { status: 'connected' };
  }

  private async testBank(integration: any): Promise<any> {
    // Test bank API connection
    return { status: 'connected' };
  }

  private async testEmail(integration: any): Promise<any> {
    // Test email connection
    return { status: 'connected' };
  }

  private async testCloudStorage(integration: any): Promise<any> {
    // Test cloud storage connection (Google Drive/OneDrive)
    return { status: 'connected' };
  }

  private async testSSO(integration: any): Promise<any> {
    // Test SSO connection
    return { status: 'connected' };
  }

  private async testAPI(integration: any): Promise<any> {
    // Test generic API connection
    return { status: 'connected' };
  }

  private async testWebhook(integration: any): Promise<any> {
    // Test webhook configuration
    return { status: 'configured' };
  }

  private async syncAccountingSoftware(integration: any): Promise<any> {
    // Sync data from accounting software
    return {
      request: { type: 'sync', source: 'accounting' },
      response: { imported: true },
      recordsProcessed: 100,
      recordsFailed: 0,
    };
  }

  private async syncERP(integration: any): Promise<any> {
    // Sync data from ERP
    return {
      request: { type: 'sync', source: 'erp' },
      response: { imported: true },
      recordsProcessed: 50,
      recordsFailed: 0,
    };
  }

  private async syncBank(integration: any): Promise<any> {
    // Sync bank transactions
    return {
      request: { type: 'sync', source: 'bank' },
      response: { imported: true },
      recordsProcessed: 25,
      recordsFailed: 0,
    };
  }

  private async syncCloudStorage(integration: any): Promise<any> {
    // Sync documents from cloud storage
    return {
      request: { type: 'sync', source: 'cloud_storage' },
      response: { imported: true },
      recordsProcessed: 10,
      recordsFailed: 0,
    };
  }
}
