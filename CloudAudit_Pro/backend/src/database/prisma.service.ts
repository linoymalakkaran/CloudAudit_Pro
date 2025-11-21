import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  constructor(private configService: ConfigService) {
    super({
      datasources: {
        db: {
          url: configService.get<string>('DATABASE_URL'),
        },
      },
      log: configService.get<string>('NODE_ENV') === 'development' ? ['query', 'error'] : ['error'],
    });
  }

  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }

  // Helper method to get tenant-specific database URL
  getTenantDatabaseUrl(tenantId: string): string {
    const baseUrl = this.configService.get<string>('DATABASE_URL');
    if (!baseUrl) {
      throw new Error('DATABASE_URL environment variable is not set');
    }

    // Replace database name with tenant-specific database name
    const url = new URL(baseUrl);
    url.pathname = `/audit_${tenantId}`;
    return url.toString();
  }

  // Create tenant-specific Prisma client
  createTenantClient(tenantId: string): PrismaClient {
    return new PrismaClient({
      datasources: {
        db: {
          url: this.getTenantDatabaseUrl(tenantId),
        },
      },
      log: this.configService.get<string>('NODE_ENV') === 'development' ? ['query', 'error'] : ['error'],
    });
  }

  // Utility method for transactions
  async executeInTransaction<T>(fn: (prisma: PrismaClient) => Promise<T>): Promise<T> {
    return this.$transaction(async (prisma) => {
      return await fn(prisma);
    });
  }

  // Health check method
  async healthCheck(): Promise<boolean> {
    try {
      await this.$queryRaw`SELECT 1`;
      return true;
    } catch (error) {
      console.error('Database health check failed:', error);
      return false;
    }
  }
}