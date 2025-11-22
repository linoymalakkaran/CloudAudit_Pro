import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { 
  GenerateStatementDto, 
  StatementFilterDto, 
  StatementType,
  StatementFormat,
  ExportStatementDto 
} from './dto/financial-statement.dto';
import { Decimal } from '@prisma/client/runtime/library';

export interface StatementLineItem {
  id: string;
  accountId?: string;
  accountCode?: string;
  accountName: string;
  accountType: string;
  amount: string;
  percentage?: string;
  level: number;
  isSubtotal: boolean;
  isTotal: boolean;
  parentId?: string;
  sortOrder: number;
}

export interface FinancialStatement {
  id: string;
  companyId: string;
  companyName: string;
  periodId: string;
  periodName: string;
  statementType: StatementType;
  format: StatementFormat;
  asOfDate?: Date;
  startDate?: Date;
  endDate?: Date;
  generatedAt: Date;
  generatedBy: string;
  lineItems: StatementLineItem[];
  totals: {
    [key: string]: string;
  };
  metadata: {
    currency: string;
    roundingFactor: number;
    includeZeroBalances: boolean;
    includePriorPeriod: boolean;
  };
}

@Injectable()
export class FinancialStatementService {
  constructor(private readonly database: DatabaseService) {}

  async generateStatement(
    generateDto: GenerateStatementDto,
    userId: string,
  ): Promise<FinancialStatement> {
    // Verify user has access to company
    await this.verifyCompanyAccess(generateDto.companyId, userId);

    // Get company and period information
    const [company, period] = await Promise.all([
      this.database.company.findUnique({
        where: { id: generateDto.companyId },
        select: { id: true, name: true, baseCurrency: true },
      }),
      this.database.period.findUnique({
        where: { id: generateDto.periodId },
        select: { id: true, name: true, startDate: true, endDate: true },
      }),
    ]);

    if (!company) {
      throw new NotFoundException('Company not found');
    }

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    // Determine date ranges based on statement type
    const dateRange = this.calculateDateRange(generateDto, period);

    // Generate statement based on type
    let statement: FinancialStatement;
    
    switch (generateDto.statementType) {
      case StatementType.INCOME_STATEMENT:
        statement = await this.generateIncomeStatement(generateDto, company, period, dateRange, userId);
        break;
      case StatementType.BALANCE_SHEET:
        statement = await this.generateBalanceSheet(generateDto, company, period, dateRange, userId);
        break;
      case StatementType.CASH_FLOW:
        statement = await this.generateCashFlowStatement(generateDto, company, period, dateRange, userId);
        break;
      case StatementType.STATEMENT_OF_EQUITY:
        statement = await this.generateEquityStatement(generateDto, company, period, dateRange, userId);
        break;
      default:
        throw new BadRequestException('Unsupported statement type');
    }

    // Save statement for audit trail
    await this.saveStatement(statement, userId);

    return statement;
  }

  async findAll(filters: StatementFilterDto, userId: string) {
    const { page = 1, limit = 20, ...filterOptions } = filters;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filterOptions.companyId) {
      await this.verifyCompanyAccess(filterOptions.companyId, userId);
      where.companyId = filterOptions.companyId;
    } else {
      const userCompanies = await this.getUserCompanies(userId);
      where.companyId = { in: userCompanies.map(c => c.id) };
    }

    if (filterOptions.periodId) where.periodId = filterOptions.periodId;
    if (filterOptions.statementType) where.statementType = filterOptions.statementType;
    if (filterOptions.format) where.format = filterOptions.format;

    if (filterOptions.startDate || filterOptions.endDate) {
      where.generatedAt = {};
      if (filterOptions.startDate) where.generatedAt.gte = new Date(filterOptions.startDate);
      if (filterOptions.endDate) where.generatedAt.lte = new Date(filterOptions.endDate);
    }

    // Since we don't have a financial statement table yet, return mock data structure
    // In real implementation, this would query the saved statements
    return {
      data: [],
      pagination: {
        total: 0,
        page,
        limit,
        totalPages: 0,
      },
    };
  }

  async findOne(id: string, userId: string) {
    // In real implementation, this would fetch from database
    throw new NotFoundException('Statement not found');
  }

  async exportStatement(id: string, exportDto: ExportStatementDto, userId: string) {
    const statement = await this.findOne(id, userId);

    switch (exportDto.format) {
      case 'JSON':
        return this.exportAsJSON(statement, exportDto);
      case 'PDF':
        return this.exportAsPDF(statement, exportDto);
      case 'EXCEL':
        return this.exportAsExcel(statement, exportDto);
      case 'CSV':
        return this.exportAsCSV(statement, exportDto);
      case 'HTML':
        return this.exportAsHTML(statement, exportDto);
      default:
        throw new BadRequestException('Unsupported export format');
    }
  }

  // Statement generation methods
  private async generateIncomeStatement(
    generateDto: GenerateStatementDto,
    company: any,
    period: any,
    dateRange: any,
    userId: string,
  ): Promise<FinancialStatement> {
    const lineItems: StatementLineItem[] = [];
    let sortOrder = 1;

    // Get revenue accounts
    const revenueAccounts = await this.getAccountsByType(generateDto.companyId, ['REVENUE'], dateRange.endDate);
    const revenueTotal = this.calculateAccountGroupTotal(revenueAccounts);

    // Add revenue section
    lineItems.push({
      id: 'revenue_header',
      accountName: 'REVENUE',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    revenueAccounts.forEach(account => {
      if (!generateDto.includeZeroBalances && new Decimal(account.balance).equals(0)) return;
      
      lineItems.push({
        id: account.id,
        accountId: account.id,
        accountCode: account.code,
        accountName: account.name,
        accountType: account.accountType,
        amount: account.balance,
        level: 2,
        isSubtotal: false,
        isTotal: false,
        sortOrder: sortOrder++,
      });
    });

    lineItems.push({
      id: 'total_revenue',
      accountName: 'Total Revenue',
      accountType: 'SUBTOTAL',
      amount: revenueTotal.toString(),
      level: 1,
      isSubtotal: true,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    // Get expense accounts
    const expenseAccounts = await this.getAccountsByType(generateDto.companyId, ['EXPENSE', 'COST_OF_SALES'], dateRange.endDate);
    const expenseTotal = this.calculateAccountGroupTotal(expenseAccounts);

    // Add expense section
    lineItems.push({
      id: 'expense_header',
      accountName: 'EXPENSES',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    expenseAccounts.forEach(account => {
      if (!generateDto.includeZeroBalances && new Decimal(account.balance).equals(0)) return;
      
      lineItems.push({
        id: account.id,
        accountId: account.id,
        accountCode: account.code,
        accountName: account.name,
        accountType: account.accountType,
        amount: account.balance,
        level: 2,
        isSubtotal: false,
        isTotal: false,
        sortOrder: sortOrder++,
      });
    });

    lineItems.push({
      id: 'total_expenses',
      accountName: 'Total Expenses',
      accountType: 'SUBTOTAL',
      amount: expenseTotal.toString(),
      level: 1,
      isSubtotal: true,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    // Calculate net income
    const netIncome = revenueTotal.minus(expenseTotal);

    lineItems.push({
      id: 'net_income',
      accountName: 'Net Income',
      accountType: 'TOTAL',
      amount: netIncome.toString(),
      level: 1,
      isSubtotal: false,
      isTotal: true,
      sortOrder: sortOrder++,
    });

    return {
      id: this.generateStatementId(),
      companyId: company.id,
      companyName: company.name,
      periodId: period.id,
      periodName: period.name,
      statementType: StatementType.INCOME_STATEMENT,
      format: generateDto.format || StatementFormat.STANDARD,
      startDate: dateRange.startDate,
      endDate: dateRange.endDate,
      generatedAt: new Date(),
      generatedBy: userId,
      lineItems,
      totals: {
        revenue: revenueTotal.toString(),
        expenses: expenseTotal.toString(),
        netIncome: netIncome.toString(),
      },
      metadata: {
        currency: company.baseCurrency || 'USD',
        roundingFactor: generateDto.roundAmounts ? 0 : 2,
        includeZeroBalances: generateDto.includeZeroBalances || false,
        includePriorPeriod: generateDto.includePriorPeriod || false,
      },
    };
  }

  private async generateBalanceSheet(
    generateDto: GenerateStatementDto,
    company: any,
    period: any,
    dateRange: any,
    userId: string,
  ): Promise<FinancialStatement> {
    const lineItems: StatementLineItem[] = [];
    let sortOrder = 1;

    // Assets
    const assetAccounts = await this.getAccountsByType(generateDto.companyId, ['ASSET', 'CURRENT_ASSET', 'FIXED_ASSET'], dateRange.endDate);
    const assetTotal = this.calculateAccountGroupTotal(assetAccounts);

    lineItems.push({
      id: 'assets_header',
      accountName: 'ASSETS',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    assetAccounts.forEach(account => {
      if (!generateDto.includeZeroBalances && new Decimal(account.balance).equals(0)) return;
      
      lineItems.push({
        id: account.id,
        accountId: account.id,
        accountCode: account.code,
        accountName: account.name,
        accountType: account.accountType,
        amount: account.balance,
        level: 2,
        isSubtotal: false,
        isTotal: false,
        sortOrder: sortOrder++,
      });
    });

    lineItems.push({
      id: 'total_assets',
      accountName: 'Total Assets',
      accountType: 'SUBTOTAL',
      amount: assetTotal.toString(),
      level: 1,
      isSubtotal: true,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    // Liabilities
    const liabilityAccounts = await this.getAccountsByType(generateDto.companyId, ['LIABILITY', 'CURRENT_LIABILITY', 'LONG_TERM_LIABILITY'], dateRange.endDate);
    const liabilityTotal = this.calculateAccountGroupTotal(liabilityAccounts);

    lineItems.push({
      id: 'liabilities_header',
      accountName: 'LIABILITIES',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    liabilityAccounts.forEach(account => {
      if (!generateDto.includeZeroBalances && new Decimal(account.balance).equals(0)) return;
      
      lineItems.push({
        id: account.id,
        accountId: account.id,
        accountCode: account.code,
        accountName: account.name,
        accountType: account.accountType,
        amount: account.balance,
        level: 2,
        isSubtotal: false,
        isTotal: false,
        sortOrder: sortOrder++,
      });
    });

    // Equity
    const equityAccounts = await this.getAccountsByType(generateDto.companyId, ['EQUITY'], dateRange.endDate);
    const equityTotal = this.calculateAccountGroupTotal(equityAccounts);

    lineItems.push({
      id: 'equity_header',
      accountName: 'EQUITY',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: sortOrder++,
    });

    equityAccounts.forEach(account => {
      if (!generateDto.includeZeroBalances && new Decimal(account.balance).equals(0)) return;
      
      lineItems.push({
        id: account.id,
        accountId: account.id,
        accountCode: account.code,
        accountName: account.name,
        accountType: account.accountType,
        amount: account.balance,
        level: 2,
        isSubtotal: false,
        isTotal: false,
        sortOrder: sortOrder++,
      });
    });

    const totalLiabilitiesAndEquity = liabilityTotal.plus(equityTotal);

    lineItems.push({
      id: 'total_liabilities_equity',
      accountName: 'Total Liabilities and Equity',
      accountType: 'TOTAL',
      amount: totalLiabilitiesAndEquity.toString(),
      level: 1,
      isSubtotal: false,
      isTotal: true,
      sortOrder: sortOrder++,
    });

    return {
      id: this.generateStatementId(),
      companyId: company.id,
      companyName: company.name,
      periodId: period.id,
      periodName: period.name,
      statementType: StatementType.BALANCE_SHEET,
      format: generateDto.format || StatementFormat.STANDARD,
      asOfDate: dateRange.endDate,
      generatedAt: new Date(),
      generatedBy: userId,
      lineItems,
      totals: {
        assets: assetTotal.toString(),
        liabilities: liabilityTotal.toString(),
        equity: equityTotal.toString(),
        totalLiabilitiesAndEquity: totalLiabilitiesAndEquity.toString(),
      },
      metadata: {
        currency: company.baseCurrency || 'USD',
        roundingFactor: generateDto.roundAmounts ? 0 : 2,
        includeZeroBalances: generateDto.includeZeroBalances || false,
        includePriorPeriod: generateDto.includePriorPeriod || false,
      },
    };
  }

  private async generateCashFlowStatement(
    generateDto: GenerateStatementDto,
    company: any,
    period: any,
    dateRange: any,
    userId: string,
  ): Promise<FinancialStatement> {
    // Simplified cash flow statement - would need more complex logic for indirect method
    const lineItems: StatementLineItem[] = [];
    
    // This is a placeholder implementation
    lineItems.push({
      id: 'cash_flow_header',
      accountName: 'CASH FLOW FROM OPERATIONS',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: 1,
    });

    return {
      id: this.generateStatementId(),
      companyId: company.id,
      companyName: company.name,
      periodId: period.id,
      periodName: period.name,
      statementType: StatementType.CASH_FLOW,
      format: generateDto.format || StatementFormat.STANDARD,
      startDate: dateRange.startDate,
      endDate: dateRange.endDate,
      generatedAt: new Date(),
      generatedBy: userId,
      lineItems,
      totals: {},
      metadata: {
        currency: company.baseCurrency || 'USD',
        roundingFactor: generateDto.roundAmounts ? 0 : 2,
        includeZeroBalances: generateDto.includeZeroBalances || false,
        includePriorPeriod: generateDto.includePriorPeriod || false,
      },
    };
  }

  private async generateEquityStatement(
    generateDto: GenerateStatementDto,
    company: any,
    period: any,
    dateRange: any,
    userId: string,
  ): Promise<FinancialStatement> {
    // Simplified equity statement implementation
    const lineItems: StatementLineItem[] = [];
    
    lineItems.push({
      id: 'equity_header',
      accountName: 'STATEMENT OF EQUITY',
      accountType: 'HEADER',
      amount: '',
      level: 1,
      isSubtotal: false,
      isTotal: false,
      sortOrder: 1,
    });

    return {
      id: this.generateStatementId(),
      companyId: company.id,
      companyName: company.name,
      periodId: period.id,
      periodName: period.name,
      statementType: StatementType.STATEMENT_OF_EQUITY,
      format: generateDto.format || StatementFormat.STANDARD,
      startDate: dateRange.startDate,
      endDate: dateRange.endDate,
      generatedAt: new Date(),
      generatedBy: userId,
      lineItems,
      totals: {},
      metadata: {
        currency: company.baseCurrency || 'USD',
        roundingFactor: generateDto.roundAmounts ? 0 : 2,
        includeZeroBalances: generateDto.includeZeroBalances || false,
        includePriorPeriod: generateDto.includePriorPeriod || false,
      },
    };
  }

  // Helper methods
  private calculateDateRange(generateDto: GenerateStatementDto, period: any) {
    if (generateDto.statementType === StatementType.BALANCE_SHEET) {
      return {
        endDate: generateDto.asOfDate ? new Date(generateDto.asOfDate) : period.endDate,
        startDate: period.startDate,
      };
    } else {
      return {
        startDate: generateDto.startDate ? new Date(generateDto.startDate) : period.startDate,
        endDate: generateDto.endDate ? new Date(generateDto.endDate) : period.endDate,
      };
    }
  }

  private async getAccountsByType(companyId: string, accountTypes: string[], asOfDate: Date) {
    // This would integrate with trial balance calculations
    // For now, return mock data structure
    return [];
  }

  private calculateAccountGroupTotal(accounts: any[]): Decimal {
    return accounts.reduce((total, account) => {
      return total.plus(new Decimal(account.balance || 0));
    }, new Decimal(0));
  }

  private generateStatementId(): string {
    return `fs-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }

  private async saveStatement(statement: FinancialStatement, userId: string) {
    // Save statement to database for audit trail
    // Implementation would save to a financial_statements table
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

  // Export methods
  private exportAsJSON(statement: any, exportDto: ExportStatementDto) {
    return {
      data: statement,
      format: 'JSON',
      contentType: 'application/json',
    };
  }

  private exportAsPDF(statement: any, exportDto: ExportStatementDto) {
    return {
      message: 'PDF export functionality to be implemented',
      format: 'PDF',
    };
  }

  private exportAsExcel(statement: any, exportDto: ExportStatementDto) {
    return {
      message: 'Excel export functionality to be implemented',
      format: 'EXCEL',
    };
  }

  private exportAsCSV(statement: any, exportDto: ExportStatementDto) {
    return {
      message: 'CSV export functionality to be implemented',
      format: 'CSV',
    };
  }

  private exportAsHTML(statement: any, exportDto: ExportStatementDto) {
    return {
      message: 'HTML export functionality to be implemented',
      format: 'HTML',
    };
  }
}