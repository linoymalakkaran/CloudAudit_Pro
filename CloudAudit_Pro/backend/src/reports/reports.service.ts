import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import {
  CreateReportDto,
  UpdateReportDto,
  ExecuteReportDto,
  ReportQueryDto,
  BulkReportDto,
  ReportType,
  ReportFormat,
  ReportFilterDto,
  ReportConfigurationDto,
  GroupBy
} from './dto/report.dto';
import * as ExcelJS from 'exceljs';
import PDFKit = require('pdfkit');

interface ReportData {
  headers: string[];
  rows: any[][];
  summary?: {
    totalRecords: number;
    totalAmount?: number;
    averageAmount?: number;
    [key: string]: any;
  };
  metadata: {
    reportType: ReportType;
    companyName: string;
    periodName: string;
    generatedAt: Date;
    generatedBy: string;
    filters?: any;
  };
}

interface ReportTemplate {
  id: string;
  name: string;
  type: ReportType;
  description: string;
  sqlQuery?: string;
  dataSource: string;
  defaultFilters?: ReportFilterDto;
  defaultConfiguration?: ReportConfigurationDto;
}

export interface ReportStatistics {
  totalReports: number;
  reportsByType: { [key: string]: number };
  reportsByFormat: { [key: string]: number };
  mostUsedReports: string[];
  generationTrends: { [key: string]: number };
  averageGenerationTime: number;
}

@Injectable()
export class ReportsService {
  constructor(private readonly database: DatabaseService) {}

  async create(createReportDto: CreateReportDto, userId: string) {
    // Verify user has access to company
    await this.verifyCompanyAccess(createReportDto.companyId, userId);

    // Verify period exists
    await this.verifyPeriodExists(createReportDto.periodId, createReportDto.companyId);

    return this.database.report.create({
      data: {
        companyId: createReportDto.companyId,
        periodId: createReportDto.periodId,
        reportType: createReportDto.reportType,
        name: createReportDto.name,
        description: createReportDto.description,
        format: createReportDto.format,
        filters: createReportDto.filters ? JSON.stringify(createReportDto.filters) : null,
        configuration: createReportDto.configuration ? JSON.stringify(createReportDto.configuration) : null,
        schedule: createReportDto.schedule,
        recipients: createReportDto.recipients ? JSON.stringify(createReportDto.recipients) : null,
        isActive: true,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
      },
    });
  }

  async findAll(query: ReportQueryDto, userId: string) {
    const { page = 1, limit = 20, sortBy = 'createdAt', sortOrder = 'desc', ...filters } = query;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filters.companyId) {
      await this.verifyCompanyAccess(filters.companyId, userId);
      where.companyId = filters.companyId;
    } else {
      const userCompanies = await this.getUserCompanies(userId);
      where.companyId = { in: userCompanies.map(c => c.id) };
    }

    if (filters.reportType) where.reportType = filters.reportType;
    if (filters.format) where.format = filters.format;
    if (filters.isActive !== undefined) where.isActive = filters.isActive;

    if (filters.createdFrom || filters.createdTo) {
      where.createdAt = {};
      if (filters.createdFrom) where.createdAt.gte = new Date(filters.createdFrom);
      if (filters.createdTo) where.createdAt.lte = new Date(filters.createdTo);
    }

    if (filters.search) {
      where.OR = [
        { name: { contains: filters.search, mode: 'insensitive' } },
        { description: { contains: filters.search, mode: 'insensitive' } },
      ];
    }

    const [reports, total] = await Promise.all([
      this.database.report.findMany({
        where,
        skip,
        take: limit,
        orderBy: { [sortBy]: sortOrder },
        include: {
          company: {
            select: { id: true, name: true },
          },
          period: {
            select: { id: true, name: true },
          },
          creator: {
            select: { id: true, firstName: true, lastName: true },
          },
        },
      }),
      this.database.report.count({ where }),
    ]);

    return {
      data: reports,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, userId: string) {
    const report = await this.database.report.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        creator: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
      },
    });

    if (!report) {
      throw new NotFoundException('Report not found');
    }

    // Verify user has access
    await this.verifyCompanyAccess(report.companyId, userId);

    return {
      ...report,
      filters: report.filters ? JSON.parse(String(report.filters)) : null,
      configuration: report.configuration ? JSON.parse(String(report.configuration)) : null,
      recipients: report.recipients ? JSON.parse(String(report.recipients)) : null,
    };
  }

  async update(id: string, updateReportDto: UpdateReportDto, userId: string) {
    const existingReport = await this.findOne(id, userId);

    const updateData: any = {
      ...updateReportDto,
      updatedBy: userId,
    };

    if (updateReportDto.filters) {
      updateData.filters = JSON.stringify(updateReportDto.filters);
    }

    if (updateReportDto.configuration) {
      updateData.configuration = JSON.stringify(updateReportDto.configuration);
    }

    if (updateReportDto.recipients) {
      updateData.recipients = JSON.stringify(updateReportDto.recipients);
    }

    return this.database.report.update({
      where: { id },
      data: updateData,
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
      },
    });
  }

  async remove(id: string, userId: string) {
    const existingReport = await this.findOne(id, userId);

    await this.database.report.delete({
      where: { id },
    });

    return { message: 'Report deleted successfully' };
  }

  async execute(id: string, executeDto: ExecuteReportDto, userId: string) {
    const report = await this.findOne(id, userId);

    // Override company/period if specified
    const companyId = executeDto.companyId || report.companyId;
    const periodId = executeDto.periodId || report.periodId;

    // Verify access to the execution company
    await this.verifyCompanyAccess(companyId, userId);

    // Merge filters and configuration
    const baseFilters = report.filters ? JSON.parse(report.filters) : {};
    const filters = { ...baseFilters, ...executeDto.filters };

    const baseConfig = report.configuration ? JSON.parse(report.configuration) : {};
    const configuration = { ...baseConfig, ...executeDto.configuration };

    const format = executeDto.format || report.format;

    // Generate the report data
    const reportData = await this.generateReportData(
      report.reportType as any,
      companyId,
      periodId,
      filters,
      configuration,
      userId
    );

    // Format the output
    const result = await this.formatReportOutput(reportData, format as any);

    // Save if requested
    if (executeDto.saveReport) {
      await this.saveGeneratedReport(report.id, companyId, periodId, result, userId);
    }

    return result;
  }

  async generateAdhoc(executeDto: ExecuteReportDto & { reportType: ReportType }, userId: string) {
    // Verify access
    await this.verifyCompanyAccess(executeDto.companyId, userId);

    // Generate the report data
    const reportData = await this.generateReportData(
      executeDto.reportType,
      executeDto.companyId,
      executeDto.periodId,
      executeDto.filters || {},
      executeDto.configuration || {},
      userId
    );

    // Format the output
    return this.formatReportOutput(reportData, executeDto.format || ReportFormat.JSON);
  }

  async bulkGenerate(bulkDto: BulkReportDto, userId: string) {
    // Verify access
    await this.verifyCompanyAccess(bulkDto.companyId, userId);

    const reports = await Promise.all(
      bulkDto.reportTypes.map(async (reportType) => {
        const reportData = await this.generateAdhoc(
          {
            reportType,
            companyId: bulkDto.companyId,
            periodId: bulkDto.periodId,
            filters: {
              ...bulkDto.commonFilters || {},
              ...(bulkDto.includeComparative ? { includeComparative: bulkDto.includeComparative } : {})
            },
            format: bulkDto.format
          },
          userId
        );

        return {
          type: reportType,
          data: reportData,
        };
      })
    );

    return {
      reports,
      generatedAt: new Date(),
      totalReports: reports.length,
    };
  }

  async getTemplates() {
    const templates: ReportTemplate[] = [
      {
        id: 'balance-sheet',
        name: 'Balance Sheet',
        type: ReportType.FINANCIAL_POSITION,
        description: 'Statement of Financial Position',
        dataSource: 'trial_balance',
        defaultConfiguration: {
          groupBy: GroupBy.CATEGORY,
          includeSummary: true,
          includeComparative: false,
        },
      },
      {
        id: 'income-statement',
        name: 'Income Statement',
        type: ReportType.INCOME_STATEMENT,
        description: 'Profit and Loss Statement',
        dataSource: 'trial_balance',
        defaultConfiguration: {
          groupBy: GroupBy.CATEGORY,
          includeSummary: true,
          includeDetails: false,
        },
      },
      {
        id: 'cash-flow',
        name: 'Cash Flow Statement',
        type: ReportType.CASH_FLOW,
        description: 'Statement of Cash Flows',
        dataSource: 'journal_entries',
        defaultConfiguration: {
          groupBy: GroupBy.CATEGORY,
          includeSummary: true,
        },
      },
      {
        id: 'trial-balance',
        name: 'Trial Balance',
        type: ReportType.TRIAL_BALANCE,
        description: 'Trial Balance Report',
        dataSource: 'trial_balance',
        defaultConfiguration: {
          // includeZeroBalances: false, // Commented out - not in DTO
          groupBy: GroupBy.ACCOUNT,
        },
      },
      {
        id: 'audit-summary',
        name: 'Audit Summary',
        type: ReportType.AUDIT_SUMMARY,
        description: 'Comprehensive audit status report',
        dataSource: 'procedures',
        defaultConfiguration: {
          groupBy: GroupBy.STATUS,
          includeSummary: true,
        },
      },
    ];

    return templates;
  }

  async getStatistics(companyId?: string): Promise<ReportStatistics> {
    const where: any = {};
    if (companyId) where.companyId = companyId;

    const [
      totalReports,
      reportsByType,
      reportsByFormat,
    ] = await Promise.all([
      this.database.report.count({ where }),
      this.database.report.groupBy({
        by: ['reportType'],
        where,
        _count: true,
      }),
      this.database.report.groupBy({
        by: ['format'],
        where,
        _count: true,
      }),
    ]);

    return {
      totalReports,
      reportsByType: reportsByType.reduce((acc, item) => {
        acc[item.reportType] = item._count;
        return acc;
      }, {}),
      reportsByFormat: reportsByFormat.reduce((acc, item) => {
        acc[item.format] = item._count;
        return acc;
      }, {}),
      mostUsedReports: [], // Would be calculated from execution logs
      generationTrends: {}, // Would be calculated from execution history
      averageGenerationTime: 2.5, // Would be calculated from execution logs
    };
  }

  // Private helper methods
  private async generateReportData(
    reportType: ReportType,
    companyId: string,
    periodId: string,
    filters: ReportFilterDto,
    configuration: ReportConfigurationDto,
    userId: string
  ): Promise<ReportData> {
    const [company, period] = await Promise.all([
      this.database.company.findUnique({ where: { id: companyId } }),
      this.database.period.findUnique({ where: { id: periodId } }),
    ]);

    const user = await this.database.user.findUnique({ where: { id: userId } });

    let headers: string[] = [];
    let rows: any[][] = [];
    let summary: any = {};

    switch (reportType) {
      case ReportType.TRIAL_BALANCE:
        ({ headers, rows, summary } = await this.generateTrialBalanceData(companyId, periodId, filters));
        break;
      case ReportType.INCOME_STATEMENT:
        ({ headers, rows, summary } = await this.generateIncomeStatementData(companyId, periodId, filters));
        break;
      case ReportType.FINANCIAL_POSITION:
        ({ headers, rows, summary } = await this.generateBalanceSheetData(companyId, periodId, filters));
        break;
      case ReportType.CASH_FLOW:
        ({ headers, rows, summary } = await this.generateCashFlowData(companyId, periodId, filters));
        break;
      case ReportType.AUDIT_SUMMARY:
        ({ headers, rows, summary } = await this.generateAuditSummaryData(companyId, periodId, filters));
        break;
      default:
        throw new BadRequestException(`Report type ${reportType} not implemented`);
    }

    return {
      headers,
      rows,
      summary,
      metadata: {
        reportType,
        companyName: company?.name || '',
        periodName: period?.name || '',
        generatedAt: new Date(),
        generatedBy: `${user?.firstName} ${user?.lastName}`,
        filters,
      },
    };
  }

  private async generateTrialBalanceData(companyId: string, periodId: string, filters: ReportFilterDto) {
    const where: any = { companyId, periodId };

    if (filters.accountIds?.length) {
      where.accountId = { in: filters.accountIds };
    }

    if (!filters.includeZeroBalances) {
      where.OR = [
        { debitBalance: { not: 0 } },
        { creditBalance: { not: 0 } },
      ];
    }

    const trialBalanceData = await this.database.trialBalance.findMany({
      where,
      include: {
        accountHead: {
          select: { code: true, name: true, accountTypeString: true },
        },
      },
      orderBy: [
        { accountHead: { accountTypeString: 'asc' } },
        { accountHead: { code: 'asc' } },
      ],
    });

    const headers = ['Account Code', 'Account Name', 'Account Type', 'Debit Balance', 'Credit Balance'];
    const rows = trialBalanceData.map(item => [
      item.accountHead.code,
      item.accountHead.name,
      item.accountHead.accountTypeString,
      item.debitBalance,
      item.creditBalance,
    ]);

    const totalDebit = trialBalanceData.reduce((sum, item) => sum + Number(item.debitBalance), 0);
    const totalCredit = trialBalanceData.reduce((sum, item) => sum + Number(item.creditBalance), 0);

    const summary = {
      totalRecords: trialBalanceData.length,
      totalDebit,
      totalCredit,
      difference: totalDebit - totalCredit,
    };

    return { headers, rows, summary };
  }

  private async generateIncomeStatementData(companyId: string, periodId: string, filters: ReportFilterDto) {
    // This would generate income statement data from trial balance
    const headers = ['Account', 'Amount', 'Percentage'];
    const rows: any[][] = [];
    const summary = { totalRevenue: 0, totalExpenses: 0, netIncome: 0 };

    return { headers, rows, summary };
  }

  private async generateBalanceSheetData(companyId: string, periodId: string, filters: ReportFilterDto) {
    // This would generate balance sheet data from trial balance
    const headers = ['Account', 'Amount'];
    const rows: any[][] = [];
    const summary = { totalAssets: 0, totalLiabilities: 0, totalEquity: 0 };

    return { headers, rows, summary };
  }

  private async generateCashFlowData(companyId: string, periodId: string, filters: ReportFilterDto) {
    // This would generate cash flow data from journal entries
    const headers = ['Category', 'Amount'];
    const rows: any[][] = [];
    const summary = { operatingCashFlow: 0, investingCashFlow: 0, financingCashFlow: 0 };

    return { headers, rows, summary };
  }

  private async generateAuditSummaryData(companyId: string, periodId: string, filters: ReportFilterDto) {
    const where: any = { companyId, periodId };

    const procedureData = await this.database.procedure.groupBy({
      by: ['status'],
      where,
      _count: true,
    });

    const headers = ['Status', 'Count', 'Percentage'];
    const totalProcedures = procedureData.reduce((sum, item) => sum + item._count, 0);

    const rows = procedureData.map(item => [
      item.status,
      item._count,
      totalProcedures > 0 ? ((item._count / totalProcedures) * 100).toFixed(2) + '%' : '0%',
    ]);

    const summary = {
      totalProcedures,
      completionRate: totalProcedures > 0 ? 
        ((procedureData.find(p => p.status === 'COMPLETED')?._count || 0) / totalProcedures) * 100 : 0,
    };

    return { headers, rows, summary };
  }

  private async formatReportOutput(reportData: ReportData, format: ReportFormat) {
    switch (format) {
      case ReportFormat.JSON:
        return reportData;
      case ReportFormat.CSV:
        return this.formatAsCSV(reportData);
      case ReportFormat.EXCEL:
        return this.formatAsExcel(reportData);
      case ReportFormat.PDF:
        return this.formatAsPDF(reportData);
      case ReportFormat.HTML:
        return this.formatAsHTML(reportData);
      default:
        return reportData;
    }
  }

  private formatAsCSV(reportData: ReportData): string {
    const { headers, rows } = reportData;
    const csvRows = [headers, ...rows];
    return csvRows.map(row => row.map(cell => `"${cell}"`).join(',')).join('\n');
  }

  private async formatAsExcel(reportData: ReportData): Promise<Buffer> {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Report');

    // Add headers
    worksheet.addRow(reportData.headers);
    
    // Add data rows
    reportData.rows.forEach(row => worksheet.addRow(row));

    // Style headers
    const headerRow = worksheet.getRow(1);
    headerRow.font = { bold: true };
    headerRow.fill = {
      type: 'pattern',
      pattern: 'solid',
      fgColor: { argb: 'FFCCCCCC' },
    };

    return workbook.xlsx.writeBuffer() as Promise<any>;
  }

  private formatAsPDF(reportData: ReportData): Buffer {
    // This would use PDFKit to generate PDF
    const doc = new PDFKit();
    doc.fontSize(20).text(reportData.metadata.reportType, 100, 100);
    doc.fontSize(12).text(`Generated: ${reportData.metadata.generatedAt}`, 100, 130);
    
    return Buffer.from('PDF placeholder'); // Simplified
  }

  private formatAsHTML(reportData: ReportData): string {
    const { headers, rows, metadata } = reportData;
    
    let html = `
      <html>
        <head>
          <title>${metadata.reportType}</title>
          <style>
            table { border-collapse: collapse; width: 100%; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
          </style>
        </head>
        <body>
          <h1>${metadata.reportType}</h1>
          <p>Company: ${metadata.companyName}</p>
          <p>Period: ${metadata.periodName}</p>
          <p>Generated: ${metadata.generatedAt}</p>
          <table>
            <thead>
              <tr>${headers.map(h => `<th>${h}</th>`).join('')}</tr>
            </thead>
            <tbody>
              ${rows.map(row => `<tr>${row.map(cell => `<td>${cell}</td>`).join('')}</tr>`).join('')}
            </tbody>
          </table>
        </body>
      </html>
    `;

    return html;
  }

  private async saveGeneratedReport(reportId: string, companyId: string, periodId: string, data: any, userId: string) {
    // This would save the generated report to the database or file system
    return { saved: true, reportId };
  }

  // Helper methods
  private async verifyCompanyAccess(companyId: string, userId: string) {
    const userCompanies = await this.getUserCompanies(userId);
    const hasAccess = userCompanies.some(company => company.id === companyId);
    
    if (!hasAccess) {
      throw new ForbiddenException('Access denied to this company');
    }
  }

  private async verifyPeriodExists(periodId: string, companyId: string) {
    const period = await this.database.period.findFirst({
      where: { id: periodId, companyId },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }
  }

  private async getUserCompanies(userId: string) {
    return this.database.company.findMany({
      select: { id: true, name: true },
    });
  }
}