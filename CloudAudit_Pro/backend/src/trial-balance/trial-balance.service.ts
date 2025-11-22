import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { 
  GenerateTrialBalanceDto, 
  TrialBalanceFilterDto, 
  TrialBalanceFormat, 
  ExportTrialBalanceDto,
  TrialBalanceValidationDto 
} from './dto/trial-balance.dto';
import { Decimal } from '@prisma/client/runtime/library';

interface TrialBalanceLineItem {
  accountId: string;
  accountCode: string;
  accountName: string;
  accountType: string;
  accountTypeId: number;
  debitBalance: string;
  creditBalance: string;
  netBalance: string;
  isActive: boolean;
  level: number;
  parentAccountId?: string;
}

export interface TrialBalanceReport {
  id: string;
  companyId: string;
  companyName: string;
  periodId: string;
  periodName: string;
  asOfDate: Date;
  format: TrialBalanceFormat;
  generatedAt: Date;
  generatedBy: string;
  lineItems: TrialBalanceLineItem[];
  summary: {
    totalDebits: string;
    totalCredits: string;
    difference: string;
    isBalanced: boolean;
    accountCount: number;
    activeAccountCount: number;
  };
}

@Injectable()
export class TrialBalanceService {
  constructor(private readonly database: DatabaseService) {}

  async generateTrialBalance(
    generateDto: GenerateTrialBalanceDto,
    userId: string,
  ): Promise<TrialBalanceReport> {
    // Verify user has access to company
    await this.verifyCompanyAccess(generateDto.companyId, userId);

    // Get company and period information
    const [company, period] = await Promise.all([
      this.database.company.findUnique({
        where: { id: generateDto.companyId },
        select: { id: true, name: true },
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

    // Determine as-of date
    const asOfDate = generateDto.asOfDate ? new Date(generateDto.asOfDate) : period.endDate;

    // Build account filter criteria
    const accountWhere: any = {
      companyId: generateDto.companyId,
    };

    if (!generateDto.includeInactiveAccounts) {
      accountWhere.isActive = true;
    }

    if (generateDto.includeTrialBalanceOnly) {
      accountWhere.includeInTrialBalance = true;
    }

    if (generateDto.accountTypeIds && generateDto.accountTypeIds.length > 0) {
      accountWhere.accountTypeId = { in: generateDto.accountTypeIds };
    }

    // Get all relevant accounts
    const accounts = await this.database.accountHead.findMany({
      where: accountWhere,
      include: {
        accountType: {
          select: { id: true, name: true, normalBalance: true },
        },
      },
      orderBy: [
        { accountType: { id: 'asc' } },
        { trialBalanceOrder: 'asc' },
        { code: 'asc' },
        { name: 'asc' },
      ],
    });

    // Calculate balances for each account
    const lineItems: TrialBalanceLineItem[] = [];
    let totalDebits = new Decimal(0);
    let totalCredits = new Decimal(0);

    for (const account of accounts) {
      const balance = await this.calculateAccountBalance(account.id, asOfDate);
      
      // Skip zero balances if requested
      if (!generateDto.includeZeroBalances && balance.netBalance.equals(0)) {
        continue;
      }

      const debitBalance = balance.netBalance.greaterThan(0) ? balance.netBalance : new Decimal(0);
      const creditBalance = balance.netBalance.lessThan(0) ? balance.netBalance.abs() : new Decimal(0);

      totalDebits = totalDebits.plus(debitBalance);
      totalCredits = totalCredits.plus(creditBalance);

      lineItems.push({
        accountId: account.id,
        accountCode: account.code || '',
        accountName: account.name,
        accountType: account.accountType.name,
        accountTypeId: account.accountTypeId,
        debitBalance: debitBalance.toString(),
        creditBalance: creditBalance.toString(),
        netBalance: balance.netBalance.toString(),
        isActive: account.isActive,
        level: account.level,
        parentAccountId: account.parentAccountId,
      });
    }

    // Calculate summary
    const difference = totalDebits.minus(totalCredits);
    const isBalanced = difference.abs().lessThanOrEqualTo(new Decimal('0.01')); // Allow for rounding

    const report: TrialBalanceReport = {
      id: this.generateReportId(),
      companyId: company.id,
      companyName: company.name,
      periodId: period.id,
      periodName: period.name,
      asOfDate,
      format: generateDto.format || TrialBalanceFormat.STANDARD,
      generatedAt: new Date(),
      generatedBy: userId,
      lineItems: generateDto.groupByAccountType ? this.groupLineItemsByAccountType(lineItems) : lineItems,
      summary: {
        totalDebits: totalDebits.toString(),
        totalCredits: totalCredits.toString(),
        difference: difference.toString(),
        isBalanced,
        accountCount: accounts.length,
        activeAccountCount: lineItems.length,
      },
    };

    // Save the trial balance to database for auditing
    await this.saveTrialBalance(report, userId);

    return report;
  }

  async findAll(filters: TrialBalanceFilterDto, userId: string) {
    const { page = 1, limit = 20, ...filterOptions } = filters;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filterOptions.companyId) {
      await this.verifyCompanyAccess(filterOptions.companyId, userId);
      where.companyId = filterOptions.companyId;
    } else {
      // Get all companies the user has access to
      const userCompanies = await this.getUserCompanies(userId);
      where.companyId = { in: userCompanies.map(c => c.id) };
    }

    if (filterOptions.periodId) where.periodId = filterOptions.periodId;
    if (filterOptions.format) where.format = filterOptions.format;

    if (filterOptions.startDate || filterOptions.endDate) {
      where.asOfDate = {};
      if (filterOptions.startDate) where.asOfDate.gte = new Date(filterOptions.startDate);
      if (filterOptions.endDate) where.asOfDate.lte = new Date(filterOptions.endDate);
    }

    const [trialBalances, total] = await Promise.all([
      this.database.trialBalanceEntry.findMany({
        where,
        skip,
        take: limit,
        orderBy: { asOfDate: 'desc' },
        include: {
          company: {
            select: { id: true, name: true },
          },
          period: {
            select: { id: true, name: true },
          },
          accountHead: {
            select: { id: true, name: true, code: true },
          },
        },
      }),
      this.database.trialBalanceEntry.count({ where }),
    ]);

    return {
      data: trialBalances,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, userId: string) {
    const trialBalance = await this.database.trialBalanceEntry.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        accountHead: {
          select: { id: true, name: true, code: true, accountType: true },
        },
      },
    });

    if (!trialBalance) {
      throw new NotFoundException('Trial balance not found');
    }

    // Verify user has access to this company
    await this.verifyCompanyAccess(trialBalance.companyId, userId);

    return trialBalance;
  }

  async validateTrialBalance(validationDto: TrialBalanceValidationDto, userId: string) {
    // Generate current trial balance
    const trialBalance = await this.generateTrialBalance(
      {
        companyId: validationDto.companyId,
        periodId: validationDto.periodId,
        asOfDate: validationDto.asOfDate,
        format: TrialBalanceFormat.STANDARD,
        includeZeroBalances: false,
        includeInactiveAccounts: false,
        groupByAccountType: true,
      },
      userId,
    );

    // Perform validation checks
    const validationResults = {
      isBalanced: trialBalance.summary.isBalanced,
      totalDebits: trialBalance.summary.totalDebits,
      totalCredits: trialBalance.summary.totalCredits,
      difference: trialBalance.summary.difference,
      accountCount: trialBalance.summary.accountCount,
      issues: [],
      warnings: [],
      recommendations: [],
    };

    // Check for balance issues
    if (!trialBalance.summary.isBalanced) {
      validationResults.issues.push({
        type: 'BALANCE_MISMATCH',
        severity: 'HIGH',
        message: `Trial balance does not balance. Difference: ${trialBalance.summary.difference}`,
        suggestion: 'Review journal entries for posting errors or missing transactions',
      });
    }

    // Check for accounts with unusual balances
    for (const lineItem of trialBalance.lineItems) {
      const account = await this.database.accountHead.findUnique({
        where: { id: lineItem.accountId },
        include: { accountType: true },
      });

      if (account) {
        const hasDebitBalance = new Decimal(lineItem.debitBalance).greaterThan(0);
        const hasCreditBalance = new Decimal(lineItem.creditBalance).greaterThan(0);
        const normalBalance = account.accountType.normalBalance;

        if (
          (normalBalance === 'DEBIT' && hasCreditBalance && !hasDebitBalance) ||
          (normalBalance === 'CREDIT' && hasDebitBalance && !hasCreditBalance)
        ) {
          validationResults.warnings.push({
            type: 'UNUSUAL_BALANCE',
            severity: 'MEDIUM',
            account: {
              id: account.id,
              name: account.name,
              code: account.code,
              type: account.accountType.name,
            },
            message: `Account has balance opposite to its normal balance type`,
            suggestion: 'Review transactions for this account to ensure proper classification',
          });
        }
      }
    }

    // Check for missing accounts that should typically appear
    const missingAccountCheck = await this.checkForMissingCriticalAccounts(
      validationDto.companyId,
      trialBalance.lineItems,
    );
    validationResults.recommendations.push(...missingAccountCheck);

    return validationResults;
  }

  async exportTrialBalance(id: string, exportDto: ExportTrialBalanceDto, userId: string) {
    const trialBalance = await this.findOne(id, userId);

    switch (exportDto.format) {
      case 'JSON':
        return this.exportAsJSON(trialBalance, exportDto);
      case 'PDF':
        return this.exportAsPDF(trialBalance, exportDto);
      case 'EXCEL':
        return this.exportAsExcel(trialBalance, exportDto);
      case 'CSV':
        return this.exportAsCSV(trialBalance, exportDto);
      default:
        throw new BadRequestException('Unsupported export format');
    }
  }

  // Helper methods
  private async calculateAccountBalance(accountId: string, asOfDate: Date) {
    // Get all journal line items for this account up to the as-of date
    const lineItems = await this.database.journalLineItem.findMany({
      where: {
        accountId,
        journalEntry: {
          entryDate: { lte: asOfDate },
          status: 'POSTED', // Only include posted entries
        },
      },
      select: {
        debitAmount: true,
        creditAmount: true,
      },
    });

    let totalDebits = new Decimal(0);
    let totalCredits = new Decimal(0);

    for (const item of lineItems) {
      totalDebits = totalDebits.plus(item.debitAmount);
      totalCredits = totalCredits.plus(item.creditAmount);
    }

    const netBalance = totalDebits.minus(totalCredits);

    return {
      totalDebits,
      totalCredits,
      netBalance,
    };
  }

  private groupLineItemsByAccountType(lineItems: TrialBalanceLineItem[]) {
    const grouped = lineItems.reduce((acc, item) => {
      const typeKey = `${item.accountTypeId}-${item.accountType}`;
      if (!acc[typeKey]) {
        acc[typeKey] = [];
      }
      acc[typeKey].push(item);
      return acc;
    }, {});

    // Flatten back to array with type headers
    const result = [];
    Object.keys(grouped).forEach(typeKey => {
      result.push(...grouped[typeKey]);
    });

    return result;
  }

  private async saveTrialBalance(report: TrialBalanceReport, userId: string) {
    // Save each line item as a trial balance entry
    const entries = report.lineItems.map(item => ({
      id: `${report.id}-${item.accountId}`,
      companyId: report.companyId,
      periodId: report.periodId,
      accountId: item.accountId,
      asOfDate: report.asOfDate,
      debitAmount: new Decimal(item.debitBalance),
      creditAmount: new Decimal(item.creditBalance),
      balance: new Decimal(item.netBalance),
      format: report.format,
      generatedBy: userId,
    }));

    // Use batch insert for better performance
    await this.database.trialBalanceEntry.createMany({
      data: entries,
      skipDuplicates: true,
    });
  }

  private generateReportId(): string {
    return `tb-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }

  private async verifyCompanyAccess(companyId: string, userId: string) {
    const userCompanies = await this.getUserCompanies(userId);
    const hasAccess = userCompanies.some(company => company.id === companyId);
    
    if (!hasAccess) {
      throw new ForbiddenException('Access denied to this company');
    }
  }

  private async getUserCompanies(userId: string) {
    // Simplified implementation - in real system, check user permissions
    return this.database.company.findMany({
      select: { id: true, name: true },
    });
  }

  private async checkForMissingCriticalAccounts(companyId: string, lineItems: TrialBalanceLineItem[]) {
    const recommendations = [];
    const accountIds = new Set(lineItems.map(item => item.accountId));

    // Check for typical business accounts that should exist
    const criticalAccountTypes = ['CASH', 'ACCOUNTS_RECEIVABLE', 'ACCOUNTS_PAYABLE', 'REVENUE', 'EXPENSES'];
    
    for (const accountType of criticalAccountTypes) {
      const hasAccount = lineItems.some(item => 
        item.accountType.toUpperCase().includes(accountType)
      );

      if (!hasAccount) {
        recommendations.push({
          type: 'MISSING_ACCOUNT_TYPE',
          severity: 'LOW',
          message: `Consider adding ${accountType} accounts to your chart of accounts`,
          suggestion: 'Review chart of accounts for completeness',
        });
      }
    }

    return recommendations;
  }

  // Export helper methods (simplified implementations)
  private exportAsJSON(trialBalance: any, exportDto: ExportTrialBalanceDto) {
    return {
      data: trialBalance,
      format: 'JSON',
      contentType: 'application/json',
    };
  }

  private exportAsPDF(trialBalance: any, exportDto: ExportTrialBalanceDto) {
    // PDF generation would be implemented here
    return {
      message: 'PDF export functionality to be implemented',
      format: 'PDF',
    };
  }

  private exportAsExcel(trialBalance: any, exportDto: ExportTrialBalanceDto) {
    // Excel generation would be implemented here
    return {
      message: 'Excel export functionality to be implemented',
      format: 'EXCEL',
    };
  }

  private exportAsCSV(trialBalance: any, exportDto: ExportTrialBalanceDto) {
    // CSV generation would be implemented here
    return {
      message: 'CSV export functionality to be implemented',
      format: 'CSV',
    };
  }
}