import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateDataExportDto } from './dto/create-data-export.dto';
import { UpdateDataExportDto } from './dto/update-data-export.dto';
import { ExportType, ExportStatus } from '@prisma/client';
import * as xlsx from 'xlsx';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class DataExportService {
  constructor(private readonly database: DatabaseService) {}

  async create(userId: string, tenantId: string, createDto: CreateDataExportDto) {
    const fileName = `export-${Date.now()}.xlsx`;
    const filePath = path.join(process.cwd(), 'exports', fileName);

    return this.database.dataExport.create({
      data: {
        companyId: createDto.companyId,
        exportType: createDto.exportType,
        filters: createDto.filters || {},
        options: createDto.options || {},
        tenantId,
        fileName,
        filePath,
        fileSize: 0,
        totalRecords: 0,
        exportedBy: userId,
        status: ExportStatus.PENDING,
      },
    });
  }

  async findAll(tenantId: string, companyId?: string, exportType?: ExportType) {
    return this.database.dataExport.findMany({
      where: {
        tenantId,
        ...(companyId && { companyId }),
        ...(exportType && { exportType }),
      },
      orderBy: { exportedAt: 'desc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const dataExport = await this.database.dataExport.findFirst({
      where: { id, tenantId },
    });

    if (!dataExport) {
      throw new NotFoundException(`Data export with ID ${id} not found`);
    }

    return dataExport;
  }

  async update(id: string, tenantId: string, updateDto: UpdateDataExportDto) {
    await this.findOne(id, tenantId);

    return this.database.dataExport.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string, tenantId: string) {
    const dataExport = await this.findOne(id, tenantId);

    // Delete file if exists
    if (fs.existsSync(dataExport.filePath)) {
      fs.unlinkSync(dataExport.filePath);
    }

    return this.database.dataExport.delete({
      where: { id },
    });
  }

  async processExport(id: string, tenantId: string) {
    const dataExport = await this.findOne(id, tenantId);

    if (dataExport.status !== ExportStatus.PENDING) {
      throw new BadRequestException('Export is not in PENDING status');
    }

    try {
      await this.database.dataExport.update({
        where: { id },
        data: { status: ExportStatus.PROCESSING },
      });

      const data = await this.fetchData(dataExport);
      const filePath = await this.generateFile(data, dataExport);
      const fileSize = fs.statSync(filePath).size;

      await this.database.dataExport.update({
        where: { id },
        data: {
          status: ExportStatus.COMPLETED,
          totalRecords: data.length,
          filePath,
          fileSize,
          completedAt: new Date(),
          expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
        },
      });

      return { filePath, recordCount: data.length };
    } catch (error) {
      await this.database.dataExport.update({
        where: { id },
        data: { status: ExportStatus.FAILED },
      });
      throw new BadRequestException(`Failed to process export: ${error.message}`);
    }
  }

  async downloadFile(id: string, tenantId: string): Promise<string> {
    const dataExport = await this.findOne(id, tenantId);

    if (dataExport.status !== ExportStatus.COMPLETED) {
      throw new BadRequestException('Export is not completed');
    }

    if (!fs.existsSync(dataExport.filePath)) {
      throw new NotFoundException('Export file not found');
    }

    return dataExport.filePath;
  }

  async quickExport(tenantId: string, userId: string, createDto: CreateDataExportDto) {
    const dataExport = await this.create(userId, tenantId, createDto);
    await this.processExport(dataExport.id, tenantId);
    return this.findOne(dataExport.id, tenantId);
  }

  async scheduleExport(tenantId: string, userId: string, createDto: CreateDataExportDto, schedule: any) {
    // Create export and schedule it
    const dataExport = await this.create(userId, tenantId, createDto);
    // TODO: Integrate with scheduling service
    return dataExport;
  }

  async getSummary(tenantId: string, companyId?: string) {
    const exports = await this.findAll(tenantId, companyId);

    return {
      totalExports: exports.length,
      completedExports: exports.filter(e => e.status === ExportStatus.COMPLETED).length,
      failedExports: exports.filter(e => e.status === ExportStatus.FAILED).length,
      processingExports: exports.filter(e => e.status === ExportStatus.PROCESSING).length,
      totalRecordsExported: exports.reduce((sum, e) => sum + e.totalRecords, 0),
    };
  }

  async getAvailableTypes() {
    return Object.values(ExportType).map(type => ({
      value: type,
      label: type.replace(/_/g, ' '),
    }));
  }

  // Private helper methods

  private async fetchData(dataExport: any): Promise<any[]> {
    const { exportType, companyId, filters } = dataExport;

    switch (exportType) {
      case ExportType.ACCOUNTS:
        return this.exportAccounts(companyId, filters);
      case ExportType.TRANSACTIONS:
        return this.exportTransactions(companyId, filters);
      case ExportType.FINANCIAL_STATEMENTS:
        return this.exportFinancialStatements(companyId, filters);
      case ExportType.AUDIT_TRAIL:
        return this.exportAuditTrail(companyId, filters);
      case ExportType.REPORTS:
        return this.exportReports(companyId, filters);
      case ExportType.DOCUMENTS:
        return this.exportDocuments(companyId, filters);
      case ExportType.FULL_BACKUP:
        return this.exportFullBackup(companyId);
      case ExportType.CUSTOM:
        return this.exportCustom(companyId, filters);
      default:
        throw new BadRequestException('Unsupported export type');
    }
  }

  private async generateFile(data: any[], dataExport: any): Promise<string> {
    const format = dataExport.options?.format || 'xlsx';
    const filePath = dataExport.filePath;

    // Ensure directory exists
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    if (format === 'xlsx') {
      this.generateExcel(data, filePath);
    } else if (format === 'csv') {
      this.generateCSV(data, filePath.replace('.xlsx', '.csv'));
      return filePath.replace('.xlsx', '.csv');
    } else if (format === 'json') {
      this.generateJSON(data, filePath.replace('.xlsx', '.json'));
      return filePath.replace('.xlsx', '.json');
    }

    return filePath;
  }

  private generateExcel(data: any[], filePath: string) {
    const worksheet = xlsx.utils.json_to_sheet(data);
    const workbook = xlsx.utils.book_new();
    xlsx.utils.book_append_sheet(workbook, worksheet, 'Export');
    xlsx.writeFile(workbook, filePath);
  }

  private generateCSV(data: any[], filePath: string) {
    if (data.length === 0) {
      fs.writeFileSync(filePath, '');
      return;
    }

    const headers = Object.keys(data[0]);
    const rows = data.map(row => headers.map(h => row[h]));
    const csvContent = [
      headers.join(','),
      ...rows.map(r => r.join(',')),
    ].join('\n');

    fs.writeFileSync(filePath, csvContent);
  }

  private generateJSON(data: any[], filePath: string) {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
  }

  // Export type specific methods (simplified examples)

  private async exportAccounts(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return accounts
    return [];
  }

  private async exportTransactions(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return transactions
    return [];
  }

  private async exportFinancialStatements(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return financial statements
    return [];
  }

  private async exportAuditTrail(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return audit trail
    return [];
  }

  private async exportReports(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return reports
    return [];
  }

  private async exportDocuments(companyId: string, filters: any): Promise<any[]> {
    // Fetch and return documents metadata
    return [];
  }

  private async exportFullBackup(companyId: string): Promise<any[]> {
    // Fetch all data for full backup
    return [];
  }

  private async exportCustom(companyId: string, filters: any): Promise<any[]> {
    // Handle custom export
    return [];
  }
}
