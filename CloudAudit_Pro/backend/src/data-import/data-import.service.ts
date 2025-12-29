import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateDataImportDto } from './dto/create-data-import.dto';
import { UpdateDataImportDto } from './dto/update-data-import.dto';
import { ImportType, ImportStatus } from '@prisma/client';
import * as csv from 'csv-parser';
import * as xlsx from 'xlsx';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class DataImportService {
  constructor(private readonly database: DatabaseService) {}

  async create(userId: string, tenantId: string, createDto: CreateDataImportDto) {
    return this.database.dataImport.create({
      data: {
        ...createDto,
        tenantId,
        importedBy: userId,
        status: ImportStatus.PENDING,
        totalRecords: 0,
        successfulRecords: 0,
        failedRecords: 0,
        errors: [],
      },
    });
  }

  async findAll(tenantId: string, companyId?: string, importType?: ImportType) {
    return this.database.dataImport.findMany({
      where: {
        tenantId,
        ...(companyId && { companyId }),
        ...(importType && { importType }),
      },
      orderBy: { importedAt: 'desc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const dataImport = await this.database.dataImport.findFirst({
      where: { id, tenantId },
    });

    if (!dataImport) {
      throw new NotFoundException(`Data import with ID ${id} not found`);
    }

    return dataImport;
  }

  async update(id: string, tenantId: string, updateDto: UpdateDataImportDto) {
    await this.findOne(id, tenantId);

    return this.database.dataImport.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string, tenantId: string) {
    const dataImport = await this.findOne(id, tenantId);

    // Delete file if exists
    if (fs.existsSync(dataImport.filePath)) {
      fs.unlinkSync(dataImport.filePath);
    }

    return this.database.dataImport.delete({
      where: { id },
    });
  }

  async validateImport(id: string, tenantId: string) {
    const dataImport = await this.findOne(id, tenantId);

    if (dataImport.status !== ImportStatus.PENDING) {
      throw new BadRequestException('Import is not in PENDING status');
    }

    try {
      const data = await this.parseFile(dataImport.filePath, dataImport.fileName);
      const validationErrors: any[] = [];

      // Validate data based on import type
      for (let i = 0; i < data.length; i++) {
        const row = data[i];
        const rowErrors = await this.validateRow(row, dataImport.importType, dataImport.mapping);
        
        if (rowErrors.length > 0) {
          validationErrors.push({
            row: i + 1,
            errors: rowErrors,
            data: row,
          });
        }
      }

      // Update import with validation results
      await this.database.dataImport.update({
        where: { id },
        data: {
          totalRecords: data.length,
          errors: validationErrors,
          status: validationErrors.length === 0 ? ImportStatus.PENDING : ImportStatus.FAILED,
        },
      });

      return {
        valid: validationErrors.length === 0,
        totalRecords: data.length,
        errorCount: validationErrors.length,
        errors: validationErrors,
      };
    } catch (error) {
      throw new BadRequestException(`Failed to validate import: ${error.message}`);
    }
  }

  async processImport(id: string, tenantId: string, userId: string) {
    const dataImport = await this.findOne(id, tenantId);

    if (dataImport.status !== ImportStatus.PENDING) {
      throw new BadRequestException('Import is not in PENDING status');
    }

    try {
      await this.database.dataImport.update({
        where: { id },
        data: { status: ImportStatus.PROCESSING },
      });

      const data = await this.parseFile(dataImport.filePath, dataImport.fileName);
      const results = await this.importData(data, dataImport, tenantId, userId);

      await this.database.dataImport.update({
        where: { id },
        data: {
          status: results.failedCount > 0 ? ImportStatus.PARTIAL : ImportStatus.COMPLETED,
          successfulRecords: results.successCount,
          failedRecords: results.failedCount,
          errors: results.errors,
          completedAt: new Date(),
          rollbackAvailable: true,
        },
      });

      return results;
    } catch (error) {
      await this.database.dataImport.update({
        where: { id },
        data: { 
          status: ImportStatus.FAILED,
          errors: [{ message: error.message }],
        },
      });
      throw new BadRequestException(`Failed to process import: ${error.message}`);
    }
  }

  async rollbackImport(id: string, tenantId: string) {
    const dataImport = await this.findOne(id, tenantId);

    if (!dataImport.rollbackAvailable) {
      throw new BadRequestException('Rollback is not available for this import');
    }

    try {
      // Implement rollback logic based on import type
      await this.performRollback(dataImport);

      await this.database.dataImport.update({
        where: { id },
        data: {
          rollbackAt: new Date(),
          rollbackAvailable: false,
        },
      });

      return { message: 'Import rolled back successfully' };
    } catch (error) {
      throw new BadRequestException(`Failed to rollback import: ${error.message}`);
    }
  }

  async getErrors(id: string, tenantId: string) {
    const dataImport = await this.findOne(id, tenantId);
    return dataImport.errors || [];
  }

  async downloadErrorsReport(id: string, tenantId: string) {
    const dataImport = await this.findOne(id, tenantId);
    const errors = Array.isArray(dataImport.errors) ? dataImport.errors : [];

    // Generate CSV report
    const csvContent = this.generateErrorCSV(errors);
    const filePath = path.join(process.cwd(), 'temp', `errors-${id}.csv`);
    
    fs.writeFileSync(filePath, csvContent);
    
    return filePath;
  }

  async getTemplate(importType: ImportType) {
    const templates: Record<ImportType, any> = {
      ACCOUNTS: {
        fields: ['accountCode', 'accountName', 'accountType', 'balance', 'currency'],
        sample: [
          { accountCode: '1000', accountName: 'Cash', accountType: 'ASSET', balance: 10000, currency: 'USD' },
        ],
      },
      TRANSACTIONS: {
        fields: ['date', 'accountCode', 'description', 'debit', 'credit', 'reference'],
        sample: [
          { date: '2025-01-01', accountCode: '1000', description: 'Opening Balance', debit: 10000, credit: 0, reference: 'OB001' },
        ],
      },
      FIXED_ASSETS: {
        fields: ['assetName', 'category', 'purchaseDate', 'cost', 'salvageValue', 'usefulLife', 'depreciationMethod'],
        sample: [
          { assetName: 'Vehicle', category: 'VEHICLES', purchaseDate: '2024-01-01', cost: 50000, salvageValue: 5000, usefulLife: 5, depreciationMethod: 'STRAIGHT_LINE' },
        ],
      },
      LIABILITIES: {
        fields: ['liabilityName', 'liabilityType', 'amount', 'currentPortion', 'dueDate'],
        sample: [
          { liabilityName: 'Bank Loan', liabilityType: 'LONG_TERM_DEBT', amount: 100000, currentPortion: 20000, dueDate: '2025-12-31' },
        ],
      },
      EQUITY: {
        fields: ['description', 'equityType', 'amount', 'shares', 'parValue'],
        sample: [
          { description: 'Common Stock', equityType: 'COMMON_STOCK', amount: 100000, shares: 10000, parValue: 10 },
        ],
      },
      DOCUMENTS: {
        fields: ['title', 'fileName', 'category', 'documentType'],
        sample: [
          { title: 'Invoice 001', fileName: 'invoice-001.pdf', category: 'INVOICES', documentType: 'PDF' },
        ],
      },
      USERS: {
        fields: ['email', 'firstName', 'lastName', 'role'],
        sample: [
          { email: 'user@example.com', firstName: 'John', lastName: 'Doe', role: 'AUDITOR' },
        ],
      },
      OPENING_BALANCES: {
        fields: ['accountCode', 'balance', 'date'],
        sample: [
          { accountCode: '1000', balance: 10000, date: '2025-01-01' },
        ],
      },
      BUDGETS: {
        fields: ['accountCode', 'period', 'budgetAmount'],
        sample: [
          { accountCode: '1000', period: '2025-01', budgetAmount: 15000 },
        ],
      },
      CUSTOM: {
        fields: ['field1', 'field2', 'field3'],
        sample: [
          { field1: 'value1', field2: 'value2', field3: 'value3' },
        ],
      },
    };

    return templates[importType] || templates.CUSTOM;
  }

  async getSummary(tenantId: string, companyId?: string) {
    const imports = await this.findAll(tenantId, companyId);

    return {
      totalImports: imports.length,
      completedImports: imports.filter(i => i.status === ImportStatus.COMPLETED).length,
      failedImports: imports.filter(i => i.status === ImportStatus.FAILED).length,
      processingImports: imports.filter(i => i.status === ImportStatus.PROCESSING).length,
      totalRecordsImported: imports.reduce((sum, i) => sum + i.successfulRecords, 0),
      totalRecordsFailed: imports.reduce((sum, i) => sum + i.failedRecords, 0),
    };
  }

  // Private helper methods

  private async parseFile(filePath: string, fileName: string): Promise<any[]> {
    const ext = path.extname(fileName).toLowerCase();

    if (ext === '.csv') {
      return this.parseCSV(filePath);
    } else if (ext === '.xlsx' || ext === '.xls') {
      return this.parseExcel(filePath);
    } else {
      throw new BadRequestException('Unsupported file format');
    }
  }

  private async parseCSV(filePath: string): Promise<any[]> {
    return new Promise((resolve, reject) => {
      const results: any[] = [];
      
      fs.createReadStream(filePath)
        .pipe(csv())
        .on('data', (data) => results.push(data))
        .on('end', () => resolve(results))
        .on('error', (error) => reject(error));
    });
  }

  private parseExcel(filePath: string): any[] {
    const workbook = xlsx.readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const sheet = workbook.Sheets[sheetName];
    
    return xlsx.utils.sheet_to_json(sheet);
  }

  private async validateRow(row: any, importType: ImportType, mapping?: any): Promise<string[]> {
    const errors: string[] = [];

    // Implement validation logic based on import type
    // This is a simplified example
    switch (importType) {
      case ImportType.ACCOUNTS:
        if (!row.accountCode) errors.push('accountCode is required');
        if (!row.accountName) errors.push('accountName is required');
        break;
      case ImportType.TRANSACTIONS:
        if (!row.date) errors.push('date is required');
        if (!row.accountCode) errors.push('accountCode is required');
        break;
      // Add more validation rules for other types
    }

    return errors;
  }

  private async importData(data: any[], dataImport: any, tenantId: string, userId: string) {
    let successCount = 0;
    let failedCount = 0;
    const errors: any[] = [];

    for (let i = 0; i < data.length; i++) {
      try {
        await this.importRow(data[i], dataImport, tenantId, userId);
        successCount++;
      } catch (error) {
        failedCount++;
        errors.push({
          row: i + 1,
          error: error.message,
          data: data[i],
        });
      }
    }

    return { successCount, failedCount, errors };
  }

  private async importRow(row: any, dataImport: any, tenantId: string, userId: string) {
    // Implement actual import logic based on import type
    // This is a placeholder
    switch (dataImport.importType) {
      case ImportType.ACCOUNTS:
        // Import account
        break;
      case ImportType.TRANSACTIONS:
        // Import transaction
        break;
      // Add more cases
    }
  }

  private async performRollback(dataImport: any) {
    // Implement rollback logic
    // Delete all records created by this import
  }

  private generateErrorCSV(errors: any[]): string {
    if (errors.length === 0) return '';

    const headers = ['Row', 'Error', 'Data'];
    const rows = errors.map(e => [
      e.row,
      JSON.stringify(e.errors || e.error),
      JSON.stringify(e.data),
    ]);

    const csvContent = [
      headers.join(','),
      ...rows.map(r => r.join(',')),
    ].join('\n');

    return csvContent;
  }
}
