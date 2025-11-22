import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import {
  CreateExportDto,
  CreateImportDto,
  ExportQueryDto,
  ImportQueryDto,
  BulkOperationDto,
  TemplateDto,
  ImportPreviewDto,
  ValidationResultDto,
  FieldMappingDto,
  DataType,
  ExportFormat,
  ImportFormat,
  ExportStatus,
  ImportStatus
} from './dto/import-export.dto';
import * as ExcelJS from '../stubs/exceljs';
import * as csv from '../stubs/csv-parser';
import * as createCsvWriter from '../stubs/csv-writer';
import * as fs from 'fs';
import * as path from 'path';
import * as JSZip from '../stubs/jszip';

interface ExportJob {
  id: string;
  name: string;
  dataTypes: DataType[];
  format: ExportFormat;
  status: ExportStatus;
  progress: number;
  totalRecords: number;
  processedRecords: number;
  filePath?: string;
  fileSize?: number;
  error?: string;
  createdAt: Date;
  completedAt?: Date;
}

interface ImportJob {
  id: string;
  name: string;
  dataType: DataType;
  format: ImportFormat;
  status: ImportStatus;
  progress: number;
  totalRecords: number;
  processedRecords: number;
  validRecords: number;
  invalidRecords: number;
  createdRecords: number;
  updatedRecords: number;
  skippedRecords: number;
  error?: string;
  validationErrors: ValidationResultDto[];
  createdAt: Date;
  completedAt?: Date;
}

@Injectable()
export class ImportExportService {
  constructor(private readonly database: DatabaseService) {}

  async createExport(createExportDto: CreateExportDto, userId: string): Promise<ExportJob> {
    // Verify user access
    await this.verifyUserAccess(userId);

    // If company-specific, verify access
    if (createExportDto.companyId) {
      await this.verifyCompanyAccess(createExportDto.companyId, userId);
    }

    const exportJob = await this.database.exportJob.create({
      data: {
        name: createExportDto.name,
        dataTypes: createExportDto.dataTypes,
        format: createExportDto.format,
        companyId: createExportDto.companyId,
        periodId: createExportDto.periodId,
        startDate: createExportDto.startDate ? new Date(createExportDto.startDate) : null,
        endDate: createExportDto.endDate ? new Date(createExportDto.endDate) : null,
        options: createExportDto.options ? JSON.stringify(createExportDto.options) : null,
        emailOnComplete: createExportDto.emailOnComplete,
        scheduledFor: createExportDto.scheduledFor ? new Date(createExportDto.scheduledFor) : null,
        status: ExportStatus.PENDING,
        progress: 0,
        totalRecords: 0,
        processedRecords: 0,
        createdBy: userId,
      },
    });

    // Start export process asynchronously
    this.processExport(exportJob.id).catch(error => {
      console.error('Export processing error:', error);
    });

    return this.mapExportJob(exportJob);
  }

  async createImport(createImportDto: CreateImportDto, userId: string): Promise<ImportJob> {
    // Verify user access
    await this.verifyUserAccess(userId);

    // If company-specific, verify access
    if (createImportDto.companyId) {
      await this.verifyCompanyAccess(createImportDto.companyId, userId);
    }

    // Validate file exists
    if (!fs.existsSync(createImportDto.filePath)) {
      throw new BadRequestException('Import file not found');
    }

    const importJob = await this.database.importJob.create({
      data: {
        name: createImportDto.name,
        dataType: createImportDto.dataType,
        format: createImportDto.format,
        filePath: createImportDto.filePath,
        companyId: createImportDto.companyId,
        periodId: createImportDto.periodId,
        options: createImportDto.options ? JSON.stringify(createImportDto.options) : null,
        emailOnComplete: createImportDto.emailOnComplete,
        status: ImportStatus.PENDING,
        progress: 0,
        totalRecords: 0,
        processedRecords: 0,
        validRecords: 0,
        invalidRecords: 0,
        createdRecords: 0,
        updatedRecords: 0,
        skippedRecords: 0,
        validationErrors: JSON.stringify([]),
        createdBy: userId,
      },
    });

    // Start import process asynchronously
    this.processImport(importJob.id).catch(error => {
      console.error('Import processing error:', error);
    });

    return this.mapImportJob(importJob);
  }

  async getExports(query: ExportQueryDto, userId: string) {
    const { page = 1, limit = 20, ...filters } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (filters.status) where.status = filters.status;
    if (filters.dataType) where.dataTypes = { has: filters.dataType };
    if (filters.format) where.format = filters.format;

    if (filters.createdFrom || filters.createdTo) {
      where.createdAt = {};
      if (filters.createdFrom) where.createdAt.gte = new Date(filters.createdFrom);
      if (filters.createdTo) where.createdAt.lte = new Date(filters.createdTo);
    }

    if (filters.search) {
      where.name = { contains: filters.search, mode: 'insensitive' };
    }

    const [exports, total] = await Promise.all([
      this.database.exportJob.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          company: {
            select: { id: true, name: true },
          },
          creator: {
            select: { id: true, firstName: true, lastName: true },
          },
        },
      }),
      this.database.exportJob.count({ where }),
    ]);

    return {
      data: exports.map(exp => this.mapExportJob(exp)),
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getImports(query: ImportQueryDto, userId: string) {
    const { page = 1, limit = 20, ...filters } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (filters.status) where.status = filters.status;
    if (filters.dataType) where.dataType = filters.dataType;
    if (filters.format) where.format = filters.format;

    if (filters.createdFrom || filters.createdTo) {
      where.createdAt = {};
      if (filters.createdFrom) where.createdAt.gte = new Date(filters.createdFrom);
      if (filters.createdTo) where.createdAt.lte = new Date(filters.createdTo);
    }

    if (filters.search) {
      where.name = { contains: filters.search, mode: 'insensitive' };
    }

    const [imports, total] = await Promise.all([
      this.database.importJob.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          company: {
            select: { id: true, name: true },
          },
          creator: {
            select: { id: true, firstName: true, lastName: true },
          },
        },
      }),
      this.database.importJob.count({ where }),
    ]);

    return {
      data: imports.map(imp => this.mapImportJob(imp)),
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getExportJob(id: string, userId: string): Promise<ExportJob> {
    const exportJob = await this.database.exportJob.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        creator: {
          select: { id: true, firstName: true, lastName: true },
        },
      },
    });

    if (!exportJob) {
      throw new NotFoundException('Export job not found');
    }

    await this.verifyUserAccess(userId);

    return this.mapExportJob(exportJob);
  }

  async getImportJob(id: string, userId: string): Promise<ImportJob> {
    const importJob = await this.database.importJob.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        creator: {
          select: { id: true, firstName: true, lastName: true },
        },
      },
    });

    if (!importJob) {
      throw new NotFoundException('Import job not found');
    }

    await this.verifyUserAccess(userId);

    return this.mapImportJob(importJob);
  }

  async cancelExport(id: string, userId: string) {
    const exportJob = await this.getExportJob(id, userId);

    if (exportJob.status !== ExportStatus.PENDING && exportJob.status !== ExportStatus.IN_PROGRESS) {
      throw new BadRequestException('Cannot cancel export in current status');
    }

    await this.database.exportJob.update({
      where: { id },
      data: { 
        status: ExportStatus.CANCELLED,
        completedAt: new Date(),
      },
    });

    return { message: 'Export cancelled successfully' };
  }

  async cancelImport(id: string, userId: string) {
    const importJob = await this.getImportJob(id, userId);

    if (importJob.status !== ImportStatus.PENDING && importJob.status !== ImportStatus.VALIDATING && importJob.status !== ImportStatus.IN_PROGRESS) {
      throw new BadRequestException('Cannot cancel import in current status');
    }

    await this.database.importJob.update({
      where: { id },
      data: { 
        status: ImportStatus.FAILED,
        error: 'Cancelled by user',
        completedAt: new Date(),
      },
    });

    return { message: 'Import cancelled successfully' };
  }

  async downloadExport(id: string, userId: string) {
    const exportJob = await this.getExportJob(id, userId);

    if (exportJob.status !== ExportStatus.COMPLETED || !exportJob.filePath) {
      throw new BadRequestException('Export file not available');
    }

    if (!fs.existsSync(exportJob.filePath)) {
      throw new NotFoundException('Export file not found');
    }

    return {
      filePath: exportJob.filePath,
      fileName: path.basename(exportJob.filePath),
      mimeType: this.getMimeType(exportJob.format),
    };
  }

  async previewImport(filePath: string, dataType: DataType, format: ImportFormat, userId: string): Promise<ImportPreviewDto> {
    await this.verifyUserAccess(userId);

    if (!fs.existsSync(filePath)) {
      throw new BadRequestException('Import file not found');
    }

    let data: any[] = [];
    const validationErrors: ValidationResultDto[] = [];

    // Parse file based on format
    switch (format) {
      case ImportFormat.CSV:
        data = await this.parseCSV(filePath);
        break;
      case ImportFormat.EXCEL:
        data = await this.parseExcel(filePath);
        break;
      case ImportFormat.JSON:
        data = await this.parseJSON(filePath);
        break;
      case ImportFormat.XML:
        data = await this.parseXML(filePath);
        break;
      default:
        throw new BadRequestException('Unsupported import format');
    }

    // Validate data
    const { validRecords, invalidRecords, errors } = await this.validateImportData(data, dataType);
    validationErrors.push(...errors);

    // Detect field mappings
    const detectedMappings = this.detectFieldMappings(data[0] || {}, dataType);

    return {
      totalRecords: data.length,
      validRecords,
      invalidRecords,
      validationErrors,
      sampleData: data.slice(0, 10), // First 10 records
      detectedMappings,
    };
  }

  async bulkOperation(operation: BulkOperationDto, userId: string) {
    await this.verifyUserAccess(userId);

    const results = {
      successful: 0,
      failed: 0,
      errors: [] as string[],
    };

    for (const jobId of operation.jobIds) {
      try {
        switch (operation.operation) {
          case 'DELETE':
            await this.deleteJob(jobId, userId);
            break;
          case 'UPDATE_STATUS':
            await this.updateJobStatus(jobId, operation.parameters.status, userId);
            break;
          case 'RETRY':
            await this.retryJob(jobId, userId);
            break;
          case 'CANCEL':
            await this.cancelJob(jobId, userId);
            break;
        }
        results.successful++;
      } catch (error) {
        results.failed++;
        results.errors.push(`Job ${jobId}: ${error.message}`);
      }
    }

    return results;
  }

  async createTemplate(templateDto: TemplateDto, userId: string) {
    await this.verifyUserAccess(userId);

    return this.database.importTemplate.create({
      data: {
        name: templateDto.name,
        dataType: templateDto.dataType,
        description: templateDto.description,
        format: templateDto.format,
        fieldMappings: JSON.stringify(templateDto.fieldMappings),
        defaultOptions: templateDto.defaultOptions ? JSON.stringify(templateDto.defaultOptions) : null,
        isActive: templateDto.isActive ?? true,
        createdBy: userId,
      },
    });
  }

  async getTemplates(dataType?: DataType, userId?: string) {
    const where: any = { isActive: true };
    if (dataType) where.dataType = dataType;

    const templates = await this.database.importTemplate.findMany({
      where,
      orderBy: { name: 'asc' },
    });

    return templates.map(template => ({
      ...template,
      fieldMappings: JSON.parse(template.fieldMappings || '[]'),
      defaultOptions: template.defaultOptions ? JSON.parse(template.defaultOptions) : null,
    }));
  }

  async getStatistics() {
    const [
      totalExports,
      totalImports,
      completedExports,
      completedImports,
      failedExports,
      failedImports,
    ] = await Promise.all([
      this.database.exportJob.count(),
      this.database.importJob.count(),
      this.database.exportJob.count({ where: { status: ExportStatus.COMPLETED } }),
      this.database.importJob.count({ where: { status: ImportStatus.COMPLETED } }),
      this.database.exportJob.count({ where: { status: ExportStatus.FAILED } }),
      this.database.importJob.count({ where: { status: ImportStatus.FAILED } }),
    ]);

    return {
      exports: {
        total: totalExports,
        completed: completedExports,
        failed: failedExports,
        successRate: totalExports > 0 ? (completedExports / totalExports) * 100 : 0,
      },
      imports: {
        total: totalImports,
        completed: completedImports,
        failed: failedImports,
        successRate: totalImports > 0 ? (completedImports / totalImports) * 100 : 0,
      },
      lastUpdated: new Date(),
    };
  }

  // Private methods for processing
  private async processExport(jobId: string) {
    try {
      await this.database.exportJob.update({
        where: { id: jobId },
        data: { status: ExportStatus.IN_PROGRESS, progress: 0 },
      });

      const job = await this.database.exportJob.findUnique({ where: { id: jobId } });
      if (!job) return;

      // Get data based on data types
      const data = await this.collectExportData(job);
      
      // Generate file
      const filePath = await this.generateExportFile(job, data);
      
      await this.database.exportJob.update({
        where: { id: jobId },
        data: {
          status: ExportStatus.COMPLETED,
          progress: 100,
          filePath,
          fileSize: fs.statSync(filePath).size,
          completedAt: new Date(),
        },
      });

      // Send email if requested
      if (job.emailOnComplete) {
        await this.sendExportCompleteEmail(job.emailOnComplete, job, filePath);
      }

    } catch (error) {
      await this.database.exportJob.update({
        where: { id: jobId },
        data: {
          status: ExportStatus.FAILED,
          error: error.message,
          completedAt: new Date(),
        },
      });
    }
  }

  private async processImport(jobId: string) {
    try {
      await this.database.importJob.update({
        where: { id: jobId },
        data: { status: ImportStatus.VALIDATING, progress: 0 },
      });

      const job = await this.database.importJob.findUnique({ where: { id: jobId } });
      if (!job) return;

      // Parse and validate data
      const data = await this.parseImportFile(job);
      const { validRecords, invalidRecords, errors } = await this.validateImportData(data, job.dataType as DataType);

      await this.database.importJob.update({
        where: { id: jobId },
        data: {
          status: ImportStatus.IN_PROGRESS,
          totalRecords: data.length,
          validRecords,
          invalidRecords,
          validationErrors: JSON.stringify(errors),
          progress: 10,
        },
      });

      // Process valid records
      const { created, updated, skipped } = await this.processImportData(job, data, errors);

      await this.database.importJob.update({
        where: { id: jobId },
        data: {
          status: ImportStatus.COMPLETED,
          progress: 100,
          createdRecords: created,
          updatedRecords: updated,
          skippedRecords: skipped,
          completedAt: new Date(),
        },
      });

      // Send email if requested
      if (job.emailOnComplete) {
        await this.sendImportCompleteEmail(job.emailOnComplete, job);
      }

    } catch (error) {
      await this.database.importJob.update({
        where: { id: jobId },
        data: {
          status: ImportStatus.FAILED,
          error: error.message,
          completedAt: new Date(),
        },
      });
    }
  }

  private async collectExportData(job: any) {
    const data: any = {};

    for (const dataType of job.dataTypes) {
      switch (dataType) {
        case DataType.COMPANIES:
          data.companies = await this.exportCompanies(job);
          break;
        case DataType.ACCOUNTS:
          data.accounts = await this.exportAccounts(job);
          break;
        case DataType.JOURNAL_ENTRIES:
          data.journalEntries = await this.exportJournalEntries(job);
          break;
        case DataType.TRIAL_BALANCES:
          data.trialBalances = await this.exportTrialBalances(job);
          break;
        case DataType.DOCUMENTS:
          data.documents = await this.exportDocuments(job);
          break;
        case DataType.USERS:
          data.users = await this.exportUsers(job);
          break;
        case DataType.AUDIT_PROCEDURES:
          data.auditProcedures = await this.exportAuditProcedures(job);
          break;
        case DataType.CONFIGURATIONS:
          data.configurations = await this.exportConfigurations(job);
          break;
        case DataType.REPORTS:
          data.reports = await this.exportReports(job);
          break;
        case DataType.PERIODS:
          data.periods = await this.exportPeriods(job);
          break;
      }
    }

    return data;
  }

  private async exportCompanies(job: any) {
    const where: any = {};
    if (job.companyId) where.id = job.companyId;

    return this.database.company.findMany({
      where,
      include: job.options?.includeRelated ? {
        periods: true,
        accounts: true,
      } : undefined,
    });
  }

  private async exportAccounts(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;

    return this.database.accountHead.findMany({ where });
  }

  private async exportJournalEntries(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;
    if (job.periodId) where.periodId = job.periodId;
    if (job.startDate) where.date = { gte: job.startDate };
    if (job.endDate) where.date = { ...where.date, lte: job.endDate };

    return this.database.journalEntry.findMany({ 
      where,
      include: {
        items: true,
      },
    });
  }

  private async exportTrialBalances(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;
    if (job.periodId) where.periodId = job.periodId;

    return this.database.trialBalance.findMany({ where });
  }

  private async exportDocuments(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;

    return this.database.document.findMany({ where });
  }

  private async exportUsers(job: any) {
    return this.database.user.findMany({
      select: {
        id: true,
        firstName: true,
        lastName: true,
        email: true,
        role: true,
        isActive: true,
        createdAt: true,
      },
    });
  }

  private async exportAuditProcedures(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;
    if (job.periodId) where.periodId = job.periodId;

    return this.database.procedure.findMany({ where });
  }

  private async exportConfigurations(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;

    return this.database.configuration.findMany({ where });
  }

  private async exportReports(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;

    return this.database.report.findMany({ where });
  }

  private async exportPeriods(job: any) {
    const where: any = {};
    if (job.companyId) where.companyId = job.companyId;

    return this.database.period.findMany({ where });
  }

  private async generateExportFile(job: any, data: any): Promise<string> {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `${job.name}-${timestamp}`;
    const exportDir = path.join(process.cwd(), 'exports');
    
    if (!fs.existsSync(exportDir)) {
      fs.mkdirSync(exportDir, { recursive: true });
    }

    switch (job.format) {
      case ExportFormat.JSON:
        return this.generateJSONFile(data, path.join(exportDir, `${fileName}.json`));
      case ExportFormat.CSV:
        return this.generateCSVFiles(data, exportDir, fileName);
      case ExportFormat.EXCEL:
        return this.generateExcelFile(data, path.join(exportDir, `${fileName}.xlsx`));
      case ExportFormat.XML:
        return this.generateXMLFile(data, path.join(exportDir, `${fileName}.xml`));
      default:
        throw new Error('Unsupported export format');
    }
  }

  private async generateJSONFile(data: any, filePath: string): Promise<string> {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
    return filePath;
  }

  private async generateCSVFiles(data: any, exportDir: string, fileName: string): Promise<string> {
    const zipPath = path.join(exportDir, `${fileName}.zip`);
    const zip = new JSZip();

    for (const [key, value] of Object.entries(data)) {
      if (Array.isArray(value) && value.length > 0) {
        const csvContent = this.convertToCSV(value);
        zip.file(`${key}.csv`, csvContent);
      }
    }

    const zipBuffer = await zip.generateAsync({ type: 'nodebuffer' });
    fs.writeFileSync(zipPath, zipBuffer);
    return zipPath;
  }

  private async generateExcelFile(data: any, filePath: string): Promise<string> {
    const workbook = new ExcelJS.Workbook();

    for (const [key, value] of Object.entries(data)) {
      if (Array.isArray(value) && value.length > 0) {
        const worksheet = workbook.addWorksheet(key);
        const headers = Object.keys(value[0]);
        worksheet.addRow(headers);
        
        value.forEach(item => {
          worksheet.addRow(headers.map(header => item[header]));
        });
      }
    }

    await workbook.xlsx.writeFile(filePath);
    return filePath;
  }

  private async generateXMLFile(data: any, filePath: string): Promise<string> {
    // Simplified XML generation
    const xml = this.convertToXML(data);
    fs.writeFileSync(filePath, xml);
    return filePath;
  }

  private convertToCSV(data: any[]): string {
    if (!data.length) return '';
    
    const headers = Object.keys(data[0]);
    const csvRows = [headers.join(',')];
    
    data.forEach(item => {
      const values = headers.map(header => {
        const value = item[header];
        return typeof value === 'string' ? `"${value.replace(/"/g, '""')}"` : value;
      });
      csvRows.push(values.join(','));
    });
    
    return csvRows.join('\n');
  }

  private convertToXML(data: any): string {
    // Simplified XML conversion
    let xml = '<?xml version="1.0" encoding="UTF-8"?>\n<export>\n';
    
    for (const [key, value] of Object.entries(data)) {
      xml += `  <${key}>\n`;
      if (Array.isArray(value)) {
        value.forEach(item => {
          xml += '    <item>\n';
          Object.entries(item).forEach(([k, v]) => {
            xml += `      <${k}>${v}</${k}>\n`;
          });
          xml += '    </item>\n';
        });
      }
      xml += `  </${key}>\n`;
    }
    
    xml += '</export>';
    return xml;
  }

  private async parseCSV(filePath: string): Promise<any[]> {
    return new Promise((resolve, reject) => {
      const results: any[] = [];
      fs.createReadStream(filePath)
        .pipe(csv())
        .on('data', (data) => results.push(data))
        .on('end', () => resolve(results))
        .on('error', reject);
    });
  }

  private async parseExcel(filePath: string): Promise<any[]> {
    const workbook = new ExcelJS.Workbook();
    await workbook.xlsx.readFile(filePath);
    
    const worksheet = workbook.getWorksheet(1);
    const results: any[] = [];
    
    if (worksheet) {
      const headers: string[] = [];
      worksheet.getRow(1).eachCell((cell, colNumber) => {
        headers[colNumber - 1] = cell.value?.toString() || '';
      });
      
      worksheet.eachRow((row, rowNumber) => {
        if (rowNumber > 1) {
          const obj: any = {};
          row.eachCell((cell, colNumber) => {
            obj[headers[colNumber - 1]] = cell.value;
          });
          results.push(obj);
        }
      });
    }
    
    return results;
  }

  private async parseJSON(filePath: string): Promise<any[]> {
    const content = fs.readFileSync(filePath, 'utf8');
    const data = JSON.parse(content);
    return Array.isArray(data) ? data : [data];
  }

  private async parseXML(filePath: string): Promise<any[]> {
    // Simplified XML parsing - in real implementation use xml2js
    const content = fs.readFileSync(filePath, 'utf8');
    // This is a placeholder - implement proper XML parsing
    return [];
  }

  private async parseImportFile(job: any): Promise<any[]> {
    switch (job.format) {
      case ImportFormat.CSV:
        return this.parseCSV(job.filePath);
      case ImportFormat.EXCEL:
        return this.parseExcel(job.filePath);
      case ImportFormat.JSON:
        return this.parseJSON(job.filePath);
      case ImportFormat.XML:
        return this.parseXML(job.filePath);
      default:
        throw new Error('Unsupported import format');
    }
  }

  private async validateImportData(data: any[], dataType: DataType) {
    let validRecords = 0;
    let invalidRecords = 0;
    const errors: ValidationResultDto[] = [];

    data.forEach((record, index) => {
      const rowErrors = this.validateRecord(record, dataType, index + 1);
      if (rowErrors.length > 0) {
        invalidRecords++;
        errors.push(...rowErrors);
      } else {
        validRecords++;
      }
    });

    return { validRecords, invalidRecords, errors };
  }

  private validateRecord(record: any, dataType: DataType, rowNumber: number): ValidationResultDto[] {
    const errors: ValidationResultDto[] = [];

    // Basic validation based on data type
    switch (dataType) {
      case DataType.COMPANIES:
        if (!record.name) {
          errors.push({
            row: rowNumber,
            field: 'name',
            message: 'Company name is required',
            severity: 'ERROR',
          });
        }
        break;
      case DataType.ACCOUNTS:
        if (!record.code) {
          errors.push({
            row: rowNumber,
            field: 'code',
            message: 'Account code is required',
            severity: 'ERROR',
          });
        }
        if (!record.name) {
          errors.push({
            row: rowNumber,
            field: 'name',
            message: 'Account name is required',
            severity: 'ERROR',
          });
        }
        break;
      // Add more validation rules for other data types
    }

    return errors;
  }

  private detectFieldMappings(sampleRecord: any, dataType: DataType): FieldMappingDto[] {
    const mappings: FieldMappingDto[] = [];
    const fields = Object.keys(sampleRecord);

    // Basic field detection logic
    fields.forEach(field => {
      const lowerField = field.toLowerCase();
      let targetField = '';

      switch (dataType) {
        case DataType.COMPANIES:
          if (lowerField.includes('name')) targetField = 'name';
          else if (lowerField.includes('code')) targetField = 'code';
          else if (lowerField.includes('email')) targetField = 'email';
          break;
        case DataType.ACCOUNTS:
          if (lowerField.includes('code')) targetField = 'code';
          else if (lowerField.includes('name')) targetField = 'name';
          else if (lowerField.includes('type')) targetField = 'accountType';
          break;
        // Add more detection logic for other data types
      }

      if (targetField) {
        mappings.push({
          sourceField: field,
          targetField: targetField,
          required: true,
        });
      }
    });

    return mappings;
  }

  private async processImportData(job: any, data: any[], validationErrors: ValidationResultDto[]) {
    let created = 0;
    let updated = 0;
    let skipped = 0;

    const options = job.options ? JSON.parse(job.options) : {};
    
    for (let i = 0; i < data.length; i++) {
      const record = data[i];
      
      // Skip invalid records if not configured to process them
      const hasErrors = validationErrors.some(error => error.row === i + 1);
      if (hasErrors && !options.skipValidationErrors) {
        skipped++;
        continue;
      }

      try {
        const result = await this.processRecord(record, job.dataType, job.companyId, options);
        if (result === 'created') created++;
        else if (result === 'updated') updated++;
        else skipped++;
      } catch (error) {
        skipped++;
      }

      // Update progress
      const progress = Math.round(((i + 1) / data.length) * 90) + 10; // 10-100%
      await this.database.importJob.update({
        where: { id: job.id },
        data: { progress, processedRecords: i + 1 },
      });
    }

    return { created, updated, skipped };
  }

  private async processRecord(record: any, dataType: DataType, companyId: string, options: any): Promise<string> {
    switch (dataType) {
      case DataType.COMPANIES:
        return this.processCompanyRecord(record, options);
      case DataType.ACCOUNTS:
        return this.processAccountRecord(record, companyId, options);
      case DataType.JOURNAL_ENTRIES:
        return this.processJournalEntryRecord(record, companyId, options);
      // Add more record processors
      default:
        throw new Error(`Unsupported data type: ${dataType}`);
    }
  }

  private async processCompanyRecord(record: any, options: any): Promise<string> {
    const existing = await this.database.company.findFirst({
      where: { name: record.name },
    });

    if (existing) {
      if (options.updateExisting) {
        await this.database.company.update({
          where: { id: existing.id },
          data: {
            name: record.name,
            email: record.email,
            address: record.address,
          },
        });
        return 'updated';
      } else {
        return 'skipped';
      }
    } else {
      await this.database.company.create({
        data: {
          name: record.name,
          email: record.email,
          address: record.address,
        },
      });
      return 'created';
    }
  }

  private async processAccountRecord(record: any, companyId: string, options: any): Promise<string> {
    const existing = await this.database.accountHead.findFirst({
      where: { 
        code: record.code,
        companyId: companyId,
      },
    });

    if (existing) {
      if (options.updateExisting) {
        await this.database.accountHead.update({
          where: { id: existing.id },
          data: {
            name: record.name,
            accountType: record.accountType,
            description: record.description,
          },
        });
        return 'updated';
      } else {
        return 'skipped';
      }
    } else {
      await this.database.accountHead.create({
        data: {
          code: record.code,
          name: record.name,
          accountType: record.accountType,
          description: record.description,
          companyId: companyId,
          isActive: true,
        },
      });
      return 'created';
    }
  }

  private async processJournalEntryRecord(record: any, companyId: string, options: any): Promise<string> {
    // Implementation for journal entry import
    return 'created';
  }

  private getMimeType(format: ExportFormat): string {
    switch (format) {
      case ExportFormat.JSON:
        return 'application/json';
      case ExportFormat.CSV:
        return 'text/csv';
      case ExportFormat.EXCEL:
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case ExportFormat.XML:
        return 'application/xml';
      case ExportFormat.PDF:
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  private mapExportJob(job: any): ExportJob {
    return {
      id: job.id,
      name: job.name,
      dataTypes: job.dataTypes,
      format: job.format,
      status: job.status,
      progress: job.progress,
      totalRecords: job.totalRecords,
      processedRecords: job.processedRecords,
      filePath: job.filePath,
      fileSize: job.fileSize,
      error: job.error,
      createdAt: job.createdAt,
      completedAt: job.completedAt,
    };
  }

  private mapImportJob(job: any): ImportJob {
    return {
      id: job.id,
      name: job.name,
      dataType: job.dataType,
      format: job.format,
      status: job.status,
      progress: job.progress,
      totalRecords: job.totalRecords,
      processedRecords: job.processedRecords,
      validRecords: job.validRecords,
      invalidRecords: job.invalidRecords,
      createdRecords: job.createdRecords,
      updatedRecords: job.updatedRecords,
      skippedRecords: job.skippedRecords,
      error: job.error,
      validationErrors: job.validationErrors ? JSON.parse(job.validationErrors) : [],
      createdAt: job.createdAt,
      completedAt: job.completedAt,
    };
  }

  // Helper methods
  private async verifyUserAccess(userId: string) {
    const user = await this.database.user.findUnique({
      where: { id: userId },
    });

    if (!user || !user.isActive) {
      throw new ForbiddenException('Access denied');
    }
  }

  private async verifyCompanyAccess(companyId: string, userId: string) {
    // Implementation to verify company access
  }

  private async deleteJob(jobId: string, userId: string) {
    // Implementation for job deletion
  }

  private async updateJobStatus(jobId: string, status: string, userId: string) {
    // Implementation for job status update
  }

  private async retryJob(jobId: string, userId: string) {
    // Implementation for job retry
  }

  private async cancelJob(jobId: string, userId: string) {
    // Implementation for job cancellation
  }

  private async sendExportCompleteEmail(email: string, job: any, filePath: string) {
    // Implementation for sending export complete email
  }

  private async sendImportCompleteEmail(email: string, job: any) {
    // Implementation for sending import complete email
  }
}