import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';

export interface CreateAccountDto {
  accountNumber: string;
  accountName: string;
  accountType: 'ASSET' | 'LIABILITY' | 'EQUITY' | 'REVENUE' | 'EXPENSE';
  subType?: string;
  parentAccountId?: string;
  description?: string;
  isActive?: boolean;
  periodId: string;
  tenantId: string;
}

export interface UpdateAccountDto {
  accountNumber?: string;
  accountName?: string;
  accountType?: 'ASSET' | 'LIABILITY' | 'EQUITY' | 'REVENUE' | 'EXPENSE';
  subType?: string;
  parentAccountId?: string;
  description?: string;
  isActive?: boolean;
}

export interface AccountBalance {
  accountId: string;
  debitBalance: number;
  creditBalance: number;
  netBalance: number;
}

@Injectable()
export class AccountService {
  constructor(private prisma: PrismaService) {}

  async createAccount(data: CreateAccountDto) {
    // Validate period exists and belongs to tenant
    const period = await this.prisma.period.findUnique({
      where: { 
        id: data.periodId,
        tenantId: data.tenantId,
      },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    // Check if account number already exists in this period
    const existingAccount = await this.prisma.account.findFirst({
      where: {
        accountNumber: data.accountNumber,
        periodId: data.periodId,
        isActive: true,
      },
    });

    if (existingAccount) {
      throw new ConflictException('Account number already exists in this period');
    }

    // If parent account is specified, validate it
    if (data.parentAccountId) {
      const parentAccount = await this.prisma.account.findUnique({
        where: {
          id: data.parentAccountId,
          periodId: data.periodId,
          tenantId: data.tenantId,
        },
      });

      if (!parentAccount) {
        throw new NotFoundException('Parent account not found');
      }
    }

    return this.prisma.account.create({
      data: {
        accountNumber: data.accountNumber,
        accountName: data.accountName,
        accountType: data.accountType,
        subType: data.subType,
        parentAccountId: data.parentAccountId,
        description: data.description,
        isActive: data.isActive ?? true,
        periodId: data.periodId,
        tenantId: data.tenantId,
        openingBalance: 0,
        currentBalance: 0,
      },
    });
  }

  async getAccountsByPeriod(periodId: string, tenantId: string) {
    // Verify period belongs to tenant
    const period = await this.prisma.period.findUnique({
      where: { 
        id: periodId,
        tenantId,
      },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    return this.prisma.account.findMany({
      where: {
        periodId,
        tenantId,
        isActive: true,
      },
      orderBy: { accountNumber: 'asc' },
      include: {
        parentAccount: {
          select: { accountNumber: true, accountName: true },
        },
        subAccounts: {
          where: { isActive: true },
          select: { id: true, accountNumber: true, accountName: true },
        },
        _count: {
          select: {
            journalEntries: true,
            subAccounts: true,
          },
        },
      },
    });
  }

  async getAccountById(id: string, tenantId: string) {
    const account = await this.prisma.account.findUnique({
      where: {
        id,
        tenantId,
      },
      include: {
        period: {
          select: { name: true, startDate: true, endDate: true },
        },
        parentAccount: true,
        subAccounts: {
          where: { isActive: true },
        },
        journalEntries: {
          orderBy: { createdAt: 'desc' },
          take: 10, // Latest 10 entries
        },
        _count: {
          select: {
            journalEntries: true,
            subAccounts: true,
          },
        },
      },
    });

    if (!account) {
      throw new NotFoundException('Account not found');
    }

    return account;
  }

  async updateAccount(id: string, tenantId: string, data: UpdateAccountDto) {
    const account = await this.getAccountById(id, tenantId);

    // If updating account number, check for conflicts
    if (data.accountNumber && data.accountNumber !== account.accountNumber) {
      const existingAccount = await this.prisma.account.findFirst({
        where: {
          accountNumber: data.accountNumber,
          periodId: account.periodId,
          id: { not: id },
          isActive: true,
        },
      });

      if (existingAccount) {
        throw new ConflictException('Account number already exists in this period');
      }
    }

    // If updating parent account, validate it
    if (data.parentAccountId) {
      const parentAccount = await this.prisma.account.findUnique({
        where: {
          id: data.parentAccountId,
          periodId: account.periodId,
          tenantId,
        },
      });

      if (!parentAccount) {
        throw new NotFoundException('Parent account not found');
      }

      // Prevent circular reference
      if (data.parentAccountId === id) {
        throw new ConflictException('Account cannot be its own parent');
      }
    }

    return this.prisma.account.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date(),
      },
    });
  }

  async deleteAccount(id: string, tenantId: string) {
    const account = await this.getAccountById(id, tenantId);

    // Check if account has sub-accounts
    if (account._count.subAccounts > 0) {
      throw new ConflictException('Cannot delete account with sub-accounts');
    }

    // Check if account has journal entries
    if (account._count.journalEntries > 0) {
      throw new ConflictException('Cannot delete account with journal entries');
    }

    return this.prisma.account.update({
      where: { id },
      data: {
        isActive: false,
        updatedAt: new Date(),
      },
    });
  }

  async getChartOfAccounts(periodId: string, tenantId: string) {
    const accounts = await this.getAccountsByPeriod(periodId, tenantId);
    
    // Organize accounts by type and hierarchy
    const accountTypes = {
      ASSET: [],
      LIABILITY: [],
      EQUITY: [],
      REVENUE: [],
      EXPENSE: [],
    };

    const accountMap = new Map();
    accounts.forEach(account => {
      accountMap.set(account.id, { ...account, children: [] });
    });

    // Build hierarchy
    accounts.forEach(account => {
      if (account.parentAccountId) {
        const parent = accountMap.get(account.parentAccountId);
        if (parent) {
          parent.children.push(accountMap.get(account.id));
        }
      } else {
        accountTypes[account.accountType].push(accountMap.get(account.id));
      }
    });

    return accountTypes;
  }

  async getTrialBalance(periodId: string, tenantId: string) {
    // Verify period belongs to tenant
    const period = await this.prisma.period.findUnique({
      where: { 
        id: periodId,
        tenantId,
      },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    const accounts = await this.prisma.account.findMany({
      where: {
        periodId,
        tenantId,
        isActive: true,
      },
      orderBy: { accountNumber: 'asc' },
    });

    // Calculate balances for each account
    const trialBalanceData = await Promise.all(
      accounts.map(async (account) => {
        const journalEntries = await this.prisma.journalEntry.findMany({
          where: {
            accountId: account.id,
            periodId,
            tenantId,
          },
        });

        let debitTotal = 0;
        let creditTotal = 0;

        journalEntries.forEach(entry => {
          if (entry.entryType === 'DEBIT') {
            debitTotal += entry.amount;
          } else {
            creditTotal += entry.amount;
          }
        });

        const netBalance = debitTotal - creditTotal;

        return {
          accountId: account.id,
          accountNumber: account.accountNumber,
          accountName: account.accountName,
          accountType: account.accountType,
          openingBalance: account.openingBalance,
          debitTotal,
          creditTotal,
          netBalance,
          closingBalance: account.openingBalance + netBalance,
        };
      })
    );

    // Calculate totals
    const totals = trialBalanceData.reduce(
      (acc, account) => ({
        totalDebits: acc.totalDebits + account.debitTotal,
        totalCredits: acc.totalCredits + account.creditTotal,
        totalAssets: acc.totalAssets + (account.accountType === 'ASSET' ? account.closingBalance : 0),
        totalLiabilities: acc.totalLiabilities + (account.accountType === 'LIABILITY' ? account.closingBalance : 0),
        totalEquity: acc.totalEquity + (account.accountType === 'EQUITY' ? account.closingBalance : 0),
        totalRevenue: acc.totalRevenue + (account.accountType === 'REVENUE' ? account.closingBalance : 0),
        totalExpenses: acc.totalExpenses + (account.accountType === 'EXPENSE' ? account.closingBalance : 0),
      }),
      {
        totalDebits: 0,
        totalCredits: 0,
        totalAssets: 0,
        totalLiabilities: 0,
        totalEquity: 0,
        totalRevenue: 0,
        totalExpenses: 0,
      }
    );

    return {
      periodId,
      periodName: period.name,
      accounts: trialBalanceData,
      totals,
      isBalanced: Math.abs(totals.totalDebits - totals.totalCredits) < 0.01,
    };
  }

  async importChartOfAccounts(periodId: string, tenantId: string, accounts: CreateAccountDto[]) {
    // Verify period belongs to tenant
    const period = await this.prisma.period.findUnique({
      where: { 
        id: periodId,
        tenantId,
      },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    // Use transaction to ensure atomicity
    return this.prisma.$transaction(async (prisma) => {
      const createdAccounts = [];

      for (const accountData of accounts) {
        const account = await prisma.account.create({
          data: {
            ...accountData,
            periodId,
            tenantId,
            isActive: true,
            openingBalance: 0,
            currentBalance: 0,
          },
        });
        createdAccounts.push(account);
      }

      return createdAccounts;
    });
  }

  async getAccountStats(tenantId: string) {
    const [totalAccounts, accountsByType, activeAccounts] = await Promise.all([
      this.prisma.account.count({
        where: { tenantId },
      }),
      this.prisma.account.groupBy({
        by: ['accountType'],
        where: { 
          tenantId,
          isActive: true,
        },
        _count: true,
      }),
      this.prisma.account.count({
        where: { 
          tenantId,
          isActive: true,
        },
      }),
    ]);

    return {
      totalAccounts,
      activeAccounts,
      accountsByType: accountsByType.reduce((acc, item) => {
        acc[item.accountType] = item._count;
        return acc;
      }, {} as Record<string, number>),
    };
  }
}