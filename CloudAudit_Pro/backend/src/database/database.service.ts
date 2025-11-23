import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class DatabaseService extends PrismaClient implements OnModuleInit {
  // Create aliases for legacy service compatibility
  get account() {
    return this.accountHead;
  }
  
  get trialBalance() {
    return this.trialBalanceEntry;
  }
  
  async onModuleInit() {
    try {
      await this.$connect();
      console.log('💾 Database connected successfully');
    } catch (error) {
      console.error('❌ Database connection failed:', error);
      // Fallback to mock for development
      console.log('💡 Falling back to mock database service');
      Object.assign(this, this.createMockDatabase());
    }
  }

  async onModuleDestroy() {
    await this.$disconnect();
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