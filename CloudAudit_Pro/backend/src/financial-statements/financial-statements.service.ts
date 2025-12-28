import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateStatementDto } from './dto/create-statement.dto';
import { UpdateStatementDto } from './dto/update-statement.dto';
import { StatementType, StatementStatus } from '@prisma/client';

@Injectable()
export class FinancialStatementsService {
  constructor(private prisma: PrismaService) {}

  async create(createStatementDto: CreateStatementDto, tenantId: string, userId: string) {
    return this.prisma.financialStatement.create({
      data: {
        ...createStatementDto,
        tenantId,
        status: StatementStatus.DRAFT,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  async findAll(
    tenantId: string,
    companyId?: string,
    periodId?: string,
    statementType?: StatementType,
    status?: StatementStatus,
  ) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;
    if (statementType) where.statementType = statementType;
    if (status) where.status = status;

    return this.prisma.financialStatement.findMany({
      where,
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
        createdByUser: { select: { email: true, firstName: true, lastName: true } },
      },
      orderBy: { statementDate: 'desc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const statement = await this.prisma.financialStatement.findFirst({
      where: { id, tenantId },
      include: {
        company: true,
        period: true,
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
        updatedByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
        approvedByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
      },
    });

    if (!statement) {
      throw new NotFoundException(`Financial statement with ID ${id} not found`);
    }

    return statement;
  }

  async update(id: string, updateStatementDto: UpdateStatementDto, tenantId: string, userId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.financialStatement.update({
      where: { id },
      data: {
        ...updateStatementDto,
        updatedBy: userId,
      },
    });
  }

  async remove(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.financialStatement.delete({
      where: { id },
    });
  }

  async generate(
    companyId: string,
    periodId: string,
    statementType: StatementType,
    tenantId: string,
    userId: string,
  ) {
    // Generate statement data based on type
    const statementData = await this.generateStatementData(
      companyId,
      periodId,
      statementType,
      tenantId,
    );

    return this.prisma.financialStatement.create({
      data: {
        tenantId,
        companyId,
        periodId,
        statementType,
        statementDate: new Date(),
        statementPeriod: `Period ${periodId}`,
        currency: 'USD',
        conversionRate: 1.0,
        status: StatementStatus.DRAFT,
        data: statementData,
        notes: [],
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: true,
        period: true,
      },
    });
  }

  async approve(id: string, tenantId: string, userId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.financialStatement.update({
      where: { id },
      data: {
        status: StatementStatus.APPROVED,
        approvedBy: userId,
        approvedAt: new Date(),
        updatedBy: userId,
      },
    });
  }

  async issue(id: string, tenantId: string, userId: string) {
    const statement = await this.findOne(id, tenantId);

    if (statement.status !== StatementStatus.APPROVED) {
      throw new NotFoundException('Statement must be approved before issuing');
    }

    return this.prisma.financialStatement.update({
      where: { id },
      data: {
        status: StatementStatus.ISSUED,
        issuedAt: new Date(),
        updatedBy: userId,
      },
    });
  }

  async addNotes(id: string, notes: any[], tenantId: string, userId: string) {
    const statement = await this.findOne(id, tenantId);
    const existingNotes = (statement.notes as any[]) || [];

    return this.prisma.financialStatement.update({
      where: { id },
      data: {
        notes: [...existingNotes, ...notes],
        updatedBy: userId,
      },
    });
  }

  async getComparative(
    companyId: string,
    periodId: string,
    comparisonPeriodId: string,
    statementType: StatementType,
    tenantId: string,
  ) {
    const [current, comparison] = await Promise.all([
      this.prisma.financialStatement.findFirst({
        where: { tenantId, companyId, periodId, statementType },
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.financialStatement.findFirst({
        where: { tenantId, companyId, periodId: comparisonPeriodId, statementType },
        orderBy: { createdAt: 'desc' },
      }),
    ]);

    return {
      current,
      comparison,
      variance: this.calculateVariance(current?.data, comparison?.data),
    };
  }

  private async generateStatementData(
    companyId: string,
    periodId: string,
    statementType: StatementType,
    tenantId: string,
  ): Promise<any> {
    switch (statementType) {
      case StatementType.BALANCE_SHEET:
        return this.generateBalanceSheet(companyId, periodId, tenantId);
      case StatementType.INCOME_STATEMENT:
        return this.generateIncomeStatement(companyId, periodId, tenantId);
      case StatementType.CASH_FLOW:
        return this.generateCashFlow(companyId, periodId, tenantId);
      case StatementType.CHANGES_IN_EQUITY:
        return this.generateEquityChanges(companyId, periodId, tenantId);
      default:
        return {};
    }
  }

  private async generateBalanceSheet(companyId: string, periodId: string, tenantId: string) {
    const accounts = await this.prisma.accountHead.findMany({
      where: { tenantId, companyId },
    });

    const assets = accounts.filter(a => a.accountType === 'ASSET');
    const liabilities = accounts.filter(a => a.accountType === 'LIABILITY');
    const equity = accounts.filter(a => a.accountType === 'EQUITY');

    return {
      assets: {
        items: assets.map(a => ({ name: a.accountName, amount: a.currentBalance })),
        total: assets.reduce((sum, a) => sum + Number(a.currentBalance || 0), 0),
      },
      liabilities: {
        items: liabilities.map(a => ({ name: a.accountName, amount: a.currentBalance })),
        total: liabilities.reduce((sum, a) => sum + Number(a.currentBalance || 0), 0),
      },
      equity: {
        items: equity.map(a => ({ name: a.accountName, amount: a.currentBalance })),
        total: equity.reduce((sum, a) => sum + Number(a.currentBalance || 0), 0),
      },
    };
  }

  private async generateIncomeStatement(companyId: string, periodId: string, tenantId: string) {
    const [revenue, expenses] = await Promise.all([
      this.prisma.ledger.aggregate({
        where: {
          tenantId,
          companyId,
          periodId,
          account: { accountType: 'REVENUE' },
        },
        _sum: { creditAmount: true },
      }),
      this.prisma.ledger.aggregate({
        where: {
          tenantId,
          companyId,
          periodId,
          account: { accountType: 'EXPENSE' },
        },
        _sum: { debitAmount: true },
      }),
    ]);

    const totalRevenue = Number(revenue._sum.creditAmount || 0);
    const totalExpenses = Number(expenses._sum.debitAmount || 0);

    return {
      revenue: { total: totalRevenue },
      expenses: { total: totalExpenses },
      netIncome: totalRevenue - totalExpenses,
    };
  }

  private async generateCashFlow(companyId: string, periodId: string, tenantId: string) {
    // Simplified cash flow - would need proper classification
    const cashAccounts = await this.prisma.accountHead.findMany({
      where: {
        tenantId,
        companyId,
        accountType: 'ASSET',
        accountName: { contains: 'cash', mode: 'insensitive' },
      },
    });

    return {
      operating: { total: 0 },
      investing: { total: 0 },
      financing: { total: 0 },
      netChange: 0,
      beginningBalance: 0,
      endingBalance: cashAccounts.reduce((sum, a) => sum + Number(a.currentBalance || 0), 0),
    };
  }

  private async generateEquityChanges(companyId: string, periodId: string, tenantId: string) {
    const equityAccounts = await this.prisma.accountHead.findMany({
      where: { tenantId, companyId, accountType: 'EQUITY' },
    });

    return {
      beginningBalance: 0,
      changes: equityAccounts.map(a => ({
        description: a.accountName,
        amount: a.currentBalance,
      })),
      endingBalance: equityAccounts.reduce((sum, a) => sum + Number(a.currentBalance || 0), 0),
    };
  }

  private calculateVariance(currentData: any, comparisonData: any): any {
    if (!currentData || !comparisonData) return null;

    // Simple variance calculation - would need to be more sophisticated
    return {
      percentChange: 0,
      absoluteChange: 0,
    };
  }
}
