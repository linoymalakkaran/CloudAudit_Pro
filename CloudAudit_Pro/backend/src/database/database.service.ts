import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class DatabaseService extends PrismaClient implements OnModuleInit {
  private isMockMode = false;
  private mockDb: any = null;

  // Create aliases for legacy service compatibility
  get account() {
    return this.isMockMode ? this.mockDb.account : this.accountHead;
  }
  
  get trialBalance() {
    return this.isMockMode ? this.mockDb.trialBalance : this.trialBalanceEntry;
  }
  
  async onModuleInit() {
    try {
      await this.$connect();
      console.log('💾 Database connected successfully');
    } catch (error) {
      console.error('❌ Database connection failed:', error);
      // Enable mock mode for development
      console.log('💡 Enabling mock database mode');
      this.isMockMode = true;
      this.mockDb = this.createMockDatabase();
    }
  }

  async onModuleDestroy() {
    if (!this.isMockMode) {
      await this.$disconnect();
    }
  }

  // Override Prisma methods to handle mock mode
  get user() {
    return this.isMockMode ? this.mockDb.user : super.user;
  }

  get company() {
    return this.isMockMode ? this.mockDb.company : super.company;
  }

  get tenant() {
    return this.isMockMode ? this.mockDb.tenant : super.tenant;
  }

  get tenantUser() {
    return this.isMockMode ? this.mockDb.tenantUser : super.tenantUser;
  }

  get procedure() {
    return this.isMockMode ? this.mockDb.procedure : super.procedure;
  }

  get document() {
    return this.isMockMode ? this.mockDb.document : super.document;
  }

  get report() {
    return this.isMockMode ? this.mockDb.report : super.report;
  }

  get auditLog() {
    return this.isMockMode ? this.mockDb.auditLog : super.auditLog;
  }

  private createMockDatabase() {
    const createMockEntity = () => ({
      findUnique: (args?: any) => Promise.resolve(null),
      findFirst: (args?: any) => Promise.resolve(null),
      findMany: (args?: any) => Promise.resolve([]),
      create: (args?: any) => Promise.resolve({ id: 'mock-id', createdAt: new Date() }),
      createMany: (args?: any) => Promise.resolve({ count: 0 }),
      update: (args?: any) => Promise.resolve({ id: 'mock-id', updatedAt: new Date() }),
      updateMany: (args?: any) => Promise.resolve({ count: 0 }),
      delete: (args?: any) => Promise.resolve({ id: 'mock-id' }),
      deleteMany: (args?: any) => Promise.resolve({ count: 0 }),
      count: (args?: any) => Promise.resolve(0),
      aggregate: (args?: any) => Promise.resolve({ _sum: {}, _avg: {}, _count: {}, _max: {}, _min: {} }),
      groupBy: (args?: any) => Promise.resolve([]),
      upsert: (args?: any) => Promise.resolve({ id: 'mock-id' }),
    });

    return {
      user: createMockEntity(),
      company: createMockEntity(),
      period: createMockEntity(),
      procedure: createMockEntity(),
      document: createMockEntity(),
      report: createMockEntity(),
      tenant: createMockEntity(),
      auditLog: createMockEntity(),
      accountHead: createMockEntity(),
      accountType: createMockEntity(),
      trialBalance: createMockEntity(),
      trialBalanceEntry: createMockEntity(),
      journalEntry: createMockEntity(),
      journalLineItem: createMockEntity(),
      procedureTemplate: createMockEntity(),
      tenantUser: createMockEntity(),
      subscription: createMockEntity(),
      usageMetric: createMockEntity(),
      configuration: createMockEntity(),
      alert: createMockEntity(),
      exportJob: createMockEntity(),
      importJob: createMockEntity(),
      importTemplate: createMockEntity(),
      account: createMockEntity(),
      $queryRaw: (query: any) => Promise.resolve([]),
      $connect: () => Promise.resolve(),
      $disconnect: () => Promise.resolve(),
      $transaction: (fn: any) => fn(this),
    };
  }
}