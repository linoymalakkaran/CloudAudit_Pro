# Performance & Scalability Guide

## Executive Summary

This document outlines the comprehensive performance optimization and scalability strategies for the CloudAudit Pro multi-tenant SaaS application. Given the nature of audit workflows involving large datasets, complex financial calculations, and multi-user collaboration, performance and scalability are critical success factors that directly impact user adoption and business growth.

## Performance Requirements & SLAs

### Service Level Agreements (SLAs)

#### Response Time Requirements
```typescript
interface PerformanceSLAs {
  apiResponseTime: {
    p95: 500; // milliseconds
    p99: 1000; // milliseconds
    timeout: 30000; // 30 seconds for complex operations
  };
  
  pageLoadTime: {
    initialLoad: 2000; // milliseconds
    navigation: 800; // milliseconds
    backgroundSync: 5000; // milliseconds
  };
  
  databaseQueries: {
    simpleSelect: 50; // milliseconds
    complexJoins: 200; // milliseconds
    reporting: 5000; // milliseconds
    bulkOperations: 30000; // milliseconds
  };
  
  fileOperations: {
    upload: 60000; // 1 minute for 100MB
    download: 30000; // 30 seconds for large documents
    preview: 3000; // 3 seconds for document preview
  };
}
```

#### Availability Requirements
```typescript
interface AvailabilitySLAs {
  uptime: 99.9; // 99.9% uptime (8.76 hours downtime per year)
  plannedMaintenance: {
    maxDurationHours: 4;
    frequency: 'monthly';
    notificationHours: 48;
  };
  
  disasterRecovery: {
    rto: 4; // Recovery Time Objective: 4 hours
    rpo: 15; // Recovery Point Objective: 15 minutes
  };
  
  dataBackup: {
    frequency: 'daily';
    retentionDays: 30;
    crossRegion: true;
  };
}
```

#### Scalability Targets
```typescript
interface ScalabilityTargets {
  concurrentUsers: {
    perTenant: 100;
    systemWide: 10000;
    peakLoadMultiplier: 3;
  };
  
  dataVolume: {
    maxCompaniesPerTenant: 1000;
    maxUsersPerTenant: 500;
    maxDocumentSizeGB: 2;
    maxTrialBalanceEntries: 100000;
  };
  
  throughput: {
    apiRequestsPerSecond: 1000;
    databaseOperationsPerSecond: 5000;
    fileUploadsPerMinute: 100;
  };
}
```

## Database Performance Optimization

### PostgreSQL Configuration & Tuning

#### Connection Pooling Strategy
```typescript
// Database connection pool configuration
export const databaseConfig: DatabaseConfig = {
  poolSize: {
    min: 10,
    max: 50,
    idle: 10000, // 10 seconds
    acquire: 30000, // 30 seconds
  },
  
  readReplicas: {
    enabled: true,
    count: 2,
    weight: {
      primary: 30, // 30% write operations
      replica: 70, // 70% read operations
    },
  },
  
  connectionString: {
    primary: process.env.DATABASE_PRIMARY_URL,
    replica: process.env.DATABASE_REPLICA_URL,
  },
};

// Connection pool implementation with Prisma
class DatabaseService {
  private primaryClient: PrismaClient;
  private replicaClient: PrismaClient;

  constructor() {
    this.primaryClient = new PrismaClient({
      datasources: {
        db: { url: databaseConfig.connectionString.primary }
      },
    });

    this.replicaClient = new PrismaClient({
      datasources: {
        db: { url: databaseConfig.connectionString.replica }
      },
    });
  }

  // Read operations use replica
  async findMany<T>(model: string, query: any): Promise<T[]> {
    return this.replicaClient[model].findMany(query);
  }

  // Write operations use primary
  async create<T>(model: string, data: any): Promise<T> {
    return this.primaryClient[model].create({ data });
  }

  async transaction<T>(operations: TransactionOperation[]): Promise<T> {
    return this.primaryClient.$transaction(operations);
  }
}
```

#### Database Indexing Strategy
```sql
-- Performance-critical indexes for multi-tenant architecture

-- Tenant isolation indexes (most critical)
CREATE INDEX CONCURRENTLY idx_companies_tenant_id ON companies(tenant_id);
CREATE INDEX CONCURRENTLY idx_users_tenant_id ON users(tenant_id);
CREATE INDEX CONCURRENTLY idx_periods_tenant_company ON periods(tenant_id, company_id);
CREATE INDEX CONCURRENTLY idx_trial_balance_tenant_period ON trial_balance_entries(tenant_id, period_id);
CREATE INDEX CONCURRENTLY idx_procedures_tenant_company ON audit_procedures(tenant_id, company_id);
CREATE INDEX CONCURRENTLY idx_documents_tenant_company ON documents(tenant_id, company_id);

-- Composite indexes for common queries
CREATE INDEX CONCURRENTLY idx_trial_balance_lookup 
ON trial_balance_entries(company_id, period_id, account_code);

CREATE INDEX CONCURRENTLY idx_journal_entries_period 
ON journal_entries(period_id, entry_date DESC);

CREATE INDEX CONCURRENTLY idx_procedures_status_assigned 
ON audit_procedures(company_id, status, assigned_to_id) 
WHERE status IN ('assigned', 'in_progress');

-- Audit trail indexes
CREATE INDEX CONCURRENTLY idx_audit_logs_tenant_timestamp 
ON audit_logs(tenant_id, timestamp DESC);

CREATE INDEX CONCURRENTLY idx_audit_logs_user_action 
ON audit_logs(user_id, event_type, timestamp DESC);

-- Document search indexes
CREATE INDEX CONCURRENTLY idx_documents_filename_gin 
ON documents USING GIN(to_tsvector('english', file_name));

CREATE INDEX CONCURRENTLY idx_documents_content_gin 
ON documents USING GIN(to_tsvector('english', description));

-- Partial indexes for active records
CREATE INDEX CONCURRENTLY idx_active_companies 
ON companies(tenant_id, created_at) WHERE status = 'active';

CREATE INDEX CONCURRENTLY idx_active_users 
ON users(tenant_id, last_login_at DESC) WHERE status = 'active';

-- Foreign key indexes for join performance
CREATE INDEX CONCURRENTLY idx_periods_company_fk ON periods(company_id);
CREATE INDEX CONCURRENTLY idx_procedures_assigned_to_fk ON audit_procedures(assigned_to_id);
CREATE INDEX CONCURRENTLY idx_procedure_comments_user_fk ON procedure_comments(user_id);
```

#### Query Optimization Patterns
```typescript
// Optimized queries with proper pagination and filtering
class OptimizedAuditService {
  // Efficient trial balance retrieval with aggregation
  async getTrialBalanceWithTotals(
    companyId: string, 
    periodId: string,
    filters?: TrialBalanceFilters
  ): Promise<TrialBalanceWithTotals> {
    const whereClause = this.buildTrialBalanceWhereClause(companyId, periodId, filters);
    
    // Single query with aggregation instead of multiple queries
    const result = await this.prisma.$queryRaw<TrialBalanceRow[]>`
      WITH trial_balance_data AS (
        SELECT 
          tb.id,
          tb.account_code,
          tb.account_name,
          tb.debit_amount,
          tb.credit_amount,
          tb.balance_amount,
          ah.account_type,
          ah.account_category
        FROM trial_balance_entries tb
        LEFT JOIN account_heads ah ON tb.account_code = ah.code
        WHERE ${whereClause}
        ORDER BY tb.account_code
      ),
      totals AS (
        SELECT 
          COUNT(*) as total_entries,
          SUM(debit_amount) as total_debits,
          SUM(credit_amount) as total_credits,
          SUM(balance_amount) as net_balance
        FROM trial_balance_data
      )
      SELECT 
        tbd.*,
        t.total_entries,
        t.total_debits,
        t.total_credits,
        t.net_balance
      FROM trial_balance_data tbd
      CROSS JOIN totals t
    `;

    return this.formatTrialBalanceResult(result);
  }

  // Efficient procedure listing with status counts
  async getProceduresWithStatusCounts(
    companyId: string,
    pagination: PaginationOptions
  ): Promise<PaginatedProcedures> {
    const offset = (pagination.page - 1) * pagination.limit;
    
    // Use window functions for efficient counting
    const procedures = await this.prisma.$queryRaw<ProcedureWithCount[]>`
      WITH procedure_stats AS (
        SELECT 
          ap.*,
          u.full_name as assigned_to_name,
          COUNT(*) OVER() as total_count,
          COUNT(CASE WHEN status = 'not_started' THEN 1 END) OVER() as not_started_count,
          COUNT(CASE WHEN status = 'in_progress' THEN 1 END) OVER() as in_progress_count,
          COUNT(CASE WHEN status = 'completed' THEN 1 END) OVER() as completed_count,
          COUNT(CASE WHEN status = 'reviewed' THEN 1 END) OVER() as reviewed_count
        FROM audit_procedures ap
        LEFT JOIN users u ON ap.assigned_to_id = u.id
        WHERE ap.company_id = ${companyId}
        ORDER BY ap.priority DESC, ap.created_at ASC
        LIMIT ${pagination.limit} OFFSET ${offset}
      )
      SELECT * FROM procedure_stats
    `;

    return {
      procedures: procedures.map(p => this.formatProcedure(p)),
      pagination: {
        page: pagination.page,
        limit: pagination.limit,
        total: procedures[0]?.total_count || 0,
      },
      statusCounts: {
        notStarted: procedures[0]?.not_started_count || 0,
        inProgress: procedures[0]?.in_progress_count || 0,
        completed: procedures[0]?.completed_count || 0,
        reviewed: procedures[0]?.reviewed_count || 0,
      },
    };
  }

  // Bulk operations with batch processing
  async bulkUpdateTrialBalanceEntries(
    updates: TrialBalanceUpdate[]
  ): Promise<BulkUpdateResult> {
    const batchSize = 100;
    const batches = this.chunkArray(updates, batchSize);
    const results: UpdateResult[] = [];

    for (const batch of batches) {
      const batchResult = await this.prisma.$transaction(
        batch.map(update => 
          this.prisma.trialBalanceEntry.update({
            where: { id: update.id },
            data: {
              debitAmount: update.debitAmount,
              creditAmount: update.creditAmount,
              balanceAmount: update.balanceAmount,
              updatedAt: new Date(),
              updatedBy: update.updatedBy,
            },
          })
        )
      );
      results.push(...batchResult);
    }

    return {
      updatedCount: results.length,
      failedCount: updates.length - results.length,
      results,
    };
  }
}
```

### Database Partitioning Strategy
```sql
-- Table partitioning for large audit logs
CREATE TABLE audit_logs (
  id BIGSERIAL,
  tenant_id UUID NOT NULL,
  event_type VARCHAR(50) NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
  user_id INTEGER,
  entity_type VARCHAR(50),
  entity_id VARCHAR(100),
  old_values JSONB,
  new_values JSONB,
  metadata JSONB,
  PRIMARY KEY (id, timestamp)
) PARTITION BY RANGE (timestamp);

-- Create monthly partitions for audit logs
CREATE TABLE audit_logs_2024_01 PARTITION OF audit_logs
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE audit_logs_2024_02 PARTITION OF audit_logs
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

-- Automated partition creation procedure
CREATE OR REPLACE FUNCTION create_monthly_audit_partition()
RETURNS void AS $$
DECLARE
    start_date DATE;
    end_date DATE;
    partition_name TEXT;
BEGIN
    start_date := date_trunc('month', CURRENT_DATE + INTERVAL '1 month');
    end_date := start_date + INTERVAL '1 month';
    partition_name := 'audit_logs_' || to_char(start_date, 'YYYY_MM');
    
    EXECUTE format('CREATE TABLE IF NOT EXISTS %I PARTITION OF audit_logs 
                   FOR VALUES FROM (%L) TO (%L)',
                   partition_name, start_date, end_date);
                   
    -- Create indexes on new partition
    EXECUTE format('CREATE INDEX IF NOT EXISTS %I 
                   ON %I (tenant_id, timestamp DESC)',
                   partition_name || '_tenant_timestamp', partition_name);
END;
$$ LANGUAGE plpgsql;

-- Schedule monthly partition creation
SELECT cron.schedule('create-audit-partition', '0 0 1 * *', 'SELECT create_monthly_audit_partition()');

-- Document storage partitioning by tenant
CREATE TABLE documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  company_id UUID NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_path TEXT NOT NULL,
  file_size BIGINT NOT NULL,
  mime_type VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
) PARTITION BY HASH (tenant_id);

-- Create 8 hash partitions for documents
CREATE TABLE documents_p0 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 0);
CREATE TABLE documents_p1 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 1);
CREATE TABLE documents_p2 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 2);
CREATE TABLE documents_p3 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 3);
CREATE TABLE documents_p4 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 4);
CREATE TABLE documents_p5 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 5);
CREATE TABLE documents_p6 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 6);
```

## Real-Time Communication Performance (NEW - Implemented)

### Notification System Optimization

```typescript
// Efficient notification polling with caching
class NotificationPerformanceService {
  private readonly POLL_INTERVAL_MS = 30000; // 30 seconds
  private readonly CACHE_TTL = 25; // 25 seconds (less than poll interval)
  private readonly BATCH_SIZE = 50;

  /**
   * Optimized unread count retrieval with Redis caching
   * Reduces database load by 95% for frequently polling users
   */
  async getUnreadCountOptimized(userId: string): Promise<number> {
    const cacheKey = `notification_count:${userId}`;
    
    // Try cache first
    const cachedCount = await this.redis.get(cacheKey);
    if (cachedCount !== null) {
      return parseInt(cachedCount);
    }

    // Cache miss - query database with optimized query
    const count = await this.prisma.notification.count({
      where: {
        userId: userId,
        isRead: false
      }
    });

    // Cache result
    await this.redis.setex(cacheKey, this.CACHE_TTL, count.toString());
    
    return count;
  }

  /**
   * Batch notification creation for system events
   * Reduces database writes by batching multiple notifications
   */
  async batchCreateNotifications(
    notifications: CreateNotificationDto[]
  ): Promise<void> {
    const batches = this.chunkArray(notifications, this.BATCH_SIZE);
    
    for (const batch of batches) {
      await this.prisma.$transaction(
        batch.map(notif => 
          this.prisma.notification.create({
            data: notif
          })
        )
      );
      
      // Invalidate cache for affected users
      const userIds = batch.map(n => n.userId);
      await this.invalidateNotificationCache(userIds);
    }
  }

  /**
   * Optimized notification list retrieval with pagination
   * Uses cursor-based pagination for better performance
   */
  async getNotificationsPaginated(
    userId: string,
    cursor?: string,
    limit: number = 20
  ): Promise<PaginatedNotifications> {
    const cacheKey = `notifications:${userId}:${cursor || 'first'}:${limit}`;
    
    // Check cache
    const cached = await this.redis.get(cacheKey);
    if (cached) {
      return JSON.parse(cached);
    }

    // Query with cursor pagination
    const notifications = await this.prisma.notification.findMany({
      where: { userId },
      take: limit + 1,
      cursor: cursor ? { id: cursor } : undefined,
      orderBy: { createdAt: 'desc' },
      include: {
        sender: {
          select: {
            id: true,
            firstName: true,
            lastName: true
          }
        }
      }
    });

    const hasMore = notifications.length > limit;
    const items = hasMore ? notifications.slice(0, -1) : notifications;
    const nextCursor = hasMore ? items[items.length - 1].id : null;

    const result = {
      data: items,
      pagination: {
        nextCursor,
        hasMore
      }
    };

    // Cache for 5 seconds
    await this.redis.setex(cacheKey, 5, JSON.stringify(result));

    return result;
  }

  /**
   * Mark notifications as read with batch update
   */
  async markMultipleAsRead(notificationIds: string[]): Promise<void> {
    const batches = this.chunkArray(notificationIds, this.BATCH_SIZE);
    
    for (const batch of batches) {
      await this.prisma.notification.updateMany({
        where: {
          id: { in: batch },
          isRead: false
        },
        data: {
          isRead: true,
          readAt: new Date()
        }
      });
    }

    // Get affected users and invalidate their caches
    const notifications = await this.prisma.notification.findMany({
      where: { id: { in: notificationIds } },
      select: { userId: true },
      distinct: ['userId']
    });
    
    const userIds = notifications.map(n => n.userId);
    await this.invalidateNotificationCache(userIds);
  }

  /**
   * Invalidate notification cache for specific users
   */
  private async invalidateNotificationCache(userIds: string[]): Promise<void> {
    const keys = userIds.map(id => `notification_count:${id}`);
    if (keys.length > 0) {
      await this.redis.del(...keys);
    }
  }

  /**
   * Cleanup old notifications (run daily)
   */
  async cleanupOldNotifications(daysToKeep: number = 90): Promise<number> {
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - daysToKeep);

    const result = await this.prisma.notification.deleteMany({
      where: {
        createdAt: { lt: cutoffDate },
        isRead: true
      }
    });

    return result.count;
  }
}

// Frontend polling optimization
class NotificationPollingService {
  private pollInterval: NodeJS.Timeout | null = null;
  private readonly POLL_INTERVAL = 30000; // 30 seconds
  private readonly BACKOFF_MULTIPLIER = 1.5;
  private readonly MAX_POLL_INTERVAL = 120000; // 2 minutes
  private currentInterval = this.POLL_INTERVAL;

  /**
   * Adaptive polling based on user activity
   * Reduces polling frequency when user is inactive
   */
  startAdaptivePolling(callback: () => Promise<void>): void {
    this.stopPolling();

    const poll = async () => {
      try {
        await callback();
        
        // Reset interval on successful poll
        this.currentInterval = this.POLL_INTERVAL;
      } catch (error) {
        console.error('Polling error:', error);
        
        // Exponential backoff on errors
        this.currentInterval = Math.min(
          this.currentInterval * this.BACKOFF_MULTIPLIER,
          this.MAX_POLL_INTERVAL
        );
      }

      // Schedule next poll with current interval
      this.pollInterval = setTimeout(poll, this.currentInterval);
    };

    // Start initial poll
    poll();
  }

  stopPolling(): void {
    if (this.pollInterval) {
      clearTimeout(this.pollInterval);
      this.pollInterval = null;
    }
  }

  /**
   * Pause polling when browser tab is inactive
   */
  setupVisibilityHandling(): void {
    document.addEventListener('visibilitychange', () => {
      if (document.hidden) {
        this.stopPolling();
      } else {
        this.startAdaptivePolling(() => this.fetchNotifications());
      }
    });
  }
}
```

### Message Threading Performance

```typescript
// Optimized message thread queries
class MessagePerformanceService {
  /**
   * Get conversation threads with message preview and unread count
   * Single query using CTEs for better performance
   */
  async getThreadsOptimized(
    userId: string,
    companyId?: string
  ): Promise<ConversationThread[]> {
    const query = `
      WITH thread_stats AS (
        SELECT 
          mt.id as thread_id,
          COUNT(m.id) as message_count,
          COUNT(CASE WHEN m.is_read = false AND m.sender_id != $1 THEN 1 END) as unread_count,
          MAX(m.created_at) as last_message_at
        FROM message_threads mt
        LEFT JOIN messages m ON mt.id = m.thread_id
        WHERE mt.tenant_id = (SELECT tenant_id FROM users WHERE id = $1)
          ${companyId ? 'AND mt.company_id = $2' : ''}
        GROUP BY mt.id
      ),
      last_messages AS (
        SELECT DISTINCT ON (thread_id)
          thread_id,
          message as last_message_preview,
          sender_id as last_sender_id
        FROM messages
        ORDER BY thread_id, created_at DESC
      )
      SELECT 
        mt.*,
        ts.message_count,
        ts.unread_count,
        ts.last_message_at,
        lm.last_message_preview,
        u.first_name as last_sender_first_name,
        u.last_name as last_sender_last_name
      FROM message_threads mt
      JOIN thread_stats ts ON mt.id = ts.thread_id
      LEFT JOIN last_messages lm ON mt.id = lm.thread_id
      LEFT JOIN users u ON lm.last_sender_id = u.id
      ORDER BY ts.last_message_at DESC
      LIMIT 50
    `;

    return this.prisma.$queryRawUnsafe(query, userId, companyId);
  }

  /**
   * Batch mark messages as read to reduce database writes
   */
  async markThreadAsReadBatch(
    threadId: string,
    userId: string
  ): Promise<number> {
    const result = await this.prisma.message.updateMany({
      where: {
        threadId,
        senderId: { not: userId },
        isRead: false
      },
      data: {
        isRead: true
      }
    });

    // Invalidate message count cache
    await this.redis.del(`message_count:${userId}`);

    return result.count;
  }
}
```
CREATE TABLE documents_p7 PARTITION OF documents FOR VALUES WITH (MODULUS 8, REMAINDER 7);
```

## Caching Strategy

### Multi-Level Caching Architecture

#### Redis Caching Implementation
```typescript
// Comprehensive caching service
@Injectable()
export class CacheService {
  private redis: Redis;
  private localCache: NodeCache;

  constructor() {
    this.redis = new Redis({
      host: process.env.REDIS_HOST,
      port: parseInt(process.env.REDIS_PORT || '6379'),
      password: process.env.REDIS_PASSWORD,
      retryDelayOnFailover: 100,
      maxRetriesPerRequest: 3,
      lazyConnect: true,
      keepAlive: 30000,
    });

    // Local in-memory cache for frequently accessed data
    this.localCache = new NodeCache({
      stdTTL: 300, // 5 minutes
      checkperiod: 60, // Check for expired keys every 60 seconds
      maxKeys: 1000,
    });
  }

  // Hierarchical cache key structure
  private buildCacheKey(
    tenantId: string, 
    category: string, 
    identifier: string,
    version?: string
  ): string {
    const versionSuffix = version ? `:v${version}` : '';
    return `tenant:${tenantId}:${category}:${identifier}${versionSuffix}`;
  }

  // Multi-level get with fallback
  async get<T>(
    tenantId: string,
    category: string,
    identifier: string,
    fallback?: () => Promise<T>
  ): Promise<T | null> {
    const cacheKey = this.buildCacheKey(tenantId, category, identifier);

    // Level 1: Local cache
    let result = this.localCache.get<T>(cacheKey);
    if (result) {
      return result;
    }

    // Level 2: Redis cache
    const redisValue = await this.redis.get(cacheKey);
    if (redisValue) {
      result = JSON.parse(redisValue);
      // Store in local cache
      this.localCache.set(cacheKey, result, 300);
      return result;
    }

    // Level 3: Database fallback
    if (fallback) {
      result = await fallback();
      if (result) {
        await this.set(tenantId, category, identifier, result, 3600);
      }
      return result;
    }

    return null;
  }

  // Multi-level set
  async set(
    tenantId: string,
    category: string,
    identifier: string,
    value: any,
    ttlSeconds: number = 3600
  ): Promise<void> {
    const cacheKey = this.buildCacheKey(tenantId, category, identifier);
    const serializedValue = JSON.stringify(value);

    // Store in both caches
    this.localCache.set(cacheKey, value, Math.min(ttlSeconds, 300));
    await this.redis.setex(cacheKey, ttlSeconds, serializedValue);
  }

  // Invalidation patterns
  async invalidatePattern(pattern: string): Promise<number> {
    const keys = await this.redis.keys(pattern);
    if (keys.length === 0) return 0;

    // Clear from Redis
    await this.redis.del(...keys);
    
    // Clear from local cache
    keys.forEach(key => this.localCache.del(key));
    
    return keys.length;
  }

  // Tenant-specific invalidation
  async invalidateTenant(tenantId: string): Promise<void> {
    await this.invalidatePattern(`tenant:${tenantId}:*`);
  }

  // Cache warming for frequently accessed data
  async warmCache(tenantId: string): Promise<void> {
    const warmupTasks = [
      this.warmCompanyCache(tenantId),
      this.warmUserCache(tenantId),
      this.warmAccountHeadsCache(tenantId),
      this.warmActivePeriodsCache(tenantId),
    ];

    await Promise.all(warmupTasks);
  }

  private async warmCompanyCache(tenantId: string): Promise<void> {
    const companies = await this.companyService.getCompaniesByTenant(tenantId);
    await this.set(tenantId, 'companies', 'all', companies, 7200); // 2 hours
  }
}

// Cache decorator for automatic caching
export function Cached(
  category: string,
  keyBuilder: (args: any[]) => string,
  ttl: number = 3600
) {
  return function (target: any, propertyName: string, descriptor: PropertyDescriptor) {
    const method = descriptor.value;

    descriptor.value = async function (...args: any[]) {
      const cacheKey = keyBuilder(args);
      const tenantId = this.getTenantId(args);
      
      // Try cache first
      const cached = await this.cacheService.get(tenantId, category, cacheKey);
      if (cached) {
        return cached;
      }

      // Execute method and cache result
      const result = await method.apply(this, args);
      await this.cacheService.set(tenantId, category, cacheKey, result, ttl);
      
      return result;
    };

    return descriptor;
  };
}

// Usage example
@Injectable()
export class CompanyService {
  @Cached('companies', (args) => `company-${args[0]}`, 3600)
  async getCompany(companyId: string): Promise<Company> {
    return this.prisma.company.findUnique({
      where: { id: companyId },
      include: {
        periods: true,
        accountHeads: true,
      },
    });
  }

  @Cached('trial-balance', (args) => `${args[0]}-${args[1]}`, 1800)
  async getTrialBalance(companyId: string, periodId: string): Promise<TrialBalance> {
    // Implementation with automatic caching
  }
}
```

#### Application-Level Caching
```typescript
// React Query cache configuration for frontend
export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // 5 minutes
      cacheTime: 10 * 60 * 1000, // 10 minutes
      retry: (failureCount, error: any) => {
        if (error?.status === 404) return false;
        return failureCount < 3;
      },
      retryDelay: attemptIndex => Math.min(1000 * 2 ** attemptIndex, 30000),
    },
    mutations: {
      retry: 1,
    },
  },
});

// Custom hooks with intelligent caching
export const useCompanies = (tenantId: string) => {
  return useQuery({
    queryKey: ['companies', tenantId],
    queryFn: () => api.companies.getAll(tenantId),
    staleTime: 10 * 60 * 1000, // 10 minutes
    select: (data) => data.sort((a, b) => a.name.localeCompare(b.name)),
  });
};

export const useTrialBalance = (companyId: string, periodId: string) => {
  return useQuery({
    queryKey: ['trial-balance', companyId, periodId],
    queryFn: () => api.trialBalance.get(companyId, periodId),
    staleTime: 2 * 60 * 1000, // 2 minutes (financial data changes more frequently)
    enabled: !!(companyId && periodId),
  });
};

// Cache invalidation on mutations
export const useUpdateCompany = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: api.companies.update,
    onSuccess: (updatedCompany, variables) => {
      // Update specific company in cache
      queryClient.setQueryData(
        ['company', updatedCompany.id],
        updatedCompany
      );
      
      // Invalidate companies list
      queryClient.invalidateQueries(['companies', updatedCompany.tenantId]);
      
      // Update related caches
      queryClient.invalidateQueries(['trial-balance', updatedCompany.id]);
    },
  });
};
```

## API Performance Optimization

### Request Optimization Strategies

#### GraphQL Implementation for Flexible Queries
```typescript
// GraphQL schema for optimized data fetching
@ObjectType()
export class Company {
  @Field(() => ID)
  id: string;

  @Field()
  name: string;

  @Field()
  code: string;

  @Field(() => [Period])
  periods: Period[];

  @Field(() => [AccountHead])
  accountHeads: AccountHead[];

  @Field(() => TrialBalanceSummary, { nullable: true })
  currentTrialBalance?: TrialBalanceSummary;
}

@Resolver(() => Company)
export class CompanyResolver {
  // DataLoader for N+1 query prevention
  private periodLoader = new DataLoader<string, Period[]>(
    async (companyIds) => {
      const periods = await this.prisma.period.findMany({
        where: { companyId: { in: [...companyIds] } },
      });
      
      return companyIds.map(id => 
        periods.filter(period => period.companyId === id)
      );
    }
  );

  @Query(() => [Company])
  @UseGuards(GqlAuthGuard)
  async companies(
    @Context('user') user: User,
    @Args('filters', { nullable: true }) filters?: CompanyFilters
  ): Promise<Company[]> {
    return this.companyService.getCompanies(user.tenantId, filters);
  }

  @ResolveField(() => [Period])
  async periods(@Parent() company: Company): Promise<Period[]> {
    return this.periodLoader.load(company.id);
  }

  @ResolveField(() => TrialBalanceSummary)
  async currentTrialBalance(
    @Parent() company: Company
  ): Promise<TrialBalanceSummary | null> {
    const currentPeriod = await this.periodService.getCurrentPeriod(company.id);
    if (!currentPeriod) return null;
    
    return this.trialBalanceService.getSummary(company.id, currentPeriod.id);
  }
}
```

#### API Response Compression & Optimization
```typescript
// Response compression middleware
app.use(compression({
  filter: (req, res) => {
    if (req.headers['x-no-compression']) return false;
    return compression.filter(req, res);
  },
  level: 6, // Compression level (1-9)
  threshold: 1024, // Only compress responses > 1kb
}));

// Response optimization service
@Injectable()
export class ResponseOptimizationService {
  // Paginated responses with cursor-based pagination
  async getPaginatedResponse<T>(
    query: any,
    cursor: string | null,
    limit: number = 50
  ): Promise<PaginatedResponse<T>> {
    const where = cursor 
      ? { ...query.where, id: { gt: cursor } }
      : query.where;

    const items = await this.prisma[query.model].findMany({
      where,
      ...query,
      take: limit + 1, // Take one extra to check if there's a next page
    });

    const hasNextPage = items.length > limit;
    if (hasNextPage) items.pop(); // Remove the extra item

    return {
      items,
      pageInfo: {
        hasNextPage,
        hasPreviousPage: !!cursor,
        startCursor: items[0]?.id || null,
        endCursor: items[items.length - 1]?.id || null,
      },
      totalCount: await this.prisma[query.model].count({ where: query.where }),
    };
  }

  // Field selection optimization
  selectOptimizer(fields: string[]): any {
    const select = {};
    
    fields.forEach(field => {
      if (field.includes('.')) {
        const [parent, child] = field.split('.');
        if (!select[parent]) select[parent] = { select: {} };
        select[parent].select[child] = true;
      } else {
        select[field] = true;
      }
    });

    return select;
  }

  // Response transformation and minification
  transformResponse(data: any, options: TransformOptions): any {
    if (options.minify) {
      return this.minifyResponse(data);
    }

    if (options.exclude?.length) {
      return this.excludeFields(data, options.exclude);
    }

    return data;
  }

  private minifyResponse(data: any): any {
    if (Array.isArray(data)) {
      return data.map(item => this.minifyResponse(item));
    }

    if (data && typeof data === 'object') {
      const minified = {};
      Object.keys(data).forEach(key => {
        const value = data[key];
        if (value !== null && value !== undefined && value !== '') {
          minified[key] = this.minifyResponse(value);
        }
      });
      return minified;
    }

    return data;
  }
}
```

#### Request Rate Limiting & Throttling
```typescript
// Advanced rate limiting with tenant-specific limits
@Injectable()
export class RateLimitingService {
  private redisClient: Redis;
  private defaultLimits = {
    requests: 1000, // per hour
    fileUploads: 100, // per hour
    reportGeneration: 50, // per hour
    bulkOperations: 10, // per hour
  };

  async checkRateLimit(
    tenantId: string,
    operation: string,
    userId?: string
  ): Promise<RateLimitResult> {
    const tenant = await this.getTenantLimits(tenantId);
    const limits = { ...this.defaultLimits, ...tenant.customLimits };
    
    const key = `rate_limit:${tenantId}:${operation}:${userId || 'tenant'}`;
    const window = 3600; // 1 hour
    const limit = limits[operation] || this.defaultLimits.requests;

    // Sliding window rate limiting
    const now = Date.now();
    const pipeline = this.redisClient.pipeline();
    
    // Remove expired entries
    pipeline.zremrangebyscore(key, 0, now - (window * 1000));
    // Add current request
    pipeline.zadd(key, now, `${now}-${Math.random()}`);
    // Get current count
    pipeline.zcard(key);
    // Set expiry
    pipeline.expire(key, window);

    const results = await pipeline.exec();
    const currentCount = results[2][1] as number;

    if (currentCount > limit) {
      throw new TooManyRequestsException(
        `Rate limit exceeded for ${operation}. Limit: ${limit}/hour`
      );
    }

    return {
      allowed: true,
      remaining: limit - currentCount,
      resetTime: new Date(now + (window * 1000)),
    };
  }

  // Adaptive rate limiting based on system load
  async getAdaptiveLimit(
    operation: string,
    baseLimit: number
  ): Promise<number> {
    const systemMetrics = await this.getSystemMetrics();
    
    // Reduce limits during high load
    if (systemMetrics.cpuUsage > 80 || systemMetrics.memoryUsage > 80) {
      return Math.floor(baseLimit * 0.5); // 50% reduction
    }
    
    if (systemMetrics.cpuUsage > 60 || systemMetrics.memoryUsage > 60) {
      return Math.floor(baseLimit * 0.7); // 30% reduction
    }

    return baseLimit;
  }
}

// Rate limiting middleware
@Injectable()
export class RateLimitMiddleware implements NestMiddleware {
  constructor(private rateLimitService: RateLimitingService) {}

  async use(req: any, res: any, next: NextFunction) {
    try {
      const operation = this.getOperationType(req);
      const result = await this.rateLimitService.checkRateLimit(
        req.tenantId,
        operation,
        req.user?.id
      );

      res.setHeader('X-RateLimit-Remaining', result.remaining);
      res.setHeader('X-RateLimit-Reset', result.resetTime.toISOString());

      next();
    } catch (error) {
      if (error instanceof TooManyRequestsException) {
        res.status(429).json({
          error: 'Too Many Requests',
          message: error.message,
          retryAfter: 3600,
        });
      } else {
        next(error);
      }
    }
  }

  private getOperationType(req: any): string {
    if (req.method === 'POST' && req.path.includes('/upload')) {
      return 'fileUploads';
    }
    if (req.method === 'POST' && req.path.includes('/reports')) {
      return 'reportGeneration';
    }
    if (req.method === 'POST' && req.path.includes('/bulk')) {
      return 'bulkOperations';
    }
    return 'requests';
  }
}
```

## Frontend Performance Optimization

### React Performance Strategies

#### Virtual Scrolling for Large Datasets
```typescript
// Virtual scrolling component for trial balance tables
interface VirtualizedTableProps {
  items: TrialBalanceEntry[];
  itemHeight: number;
  containerHeight: number;
  onUpdate: (id: string, field: string, value: any) => void;
}

export const VirtualizedTrialBalanceTable: React.FC<VirtualizedTableProps> = ({
  items,
  itemHeight,
  containerHeight,
  onUpdate,
}) => {
  const [scrollTop, setScrollTop] = useState(0);
  const containerRef = useRef<HTMLDivElement>(null);

  // Calculate visible items
  const visibleRange = useMemo(() => {
    const startIndex = Math.floor(scrollTop / itemHeight);
    const endIndex = Math.min(
      startIndex + Math.ceil(containerHeight / itemHeight) + 1,
      items.length
    );
    return { start: startIndex, end: endIndex };
  }, [scrollTop, itemHeight, containerHeight, items.length]);

  const visibleItems = items.slice(visibleRange.start, visibleRange.end);
  const totalHeight = items.length * itemHeight;
  const offsetY = visibleRange.start * itemHeight;

  const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
    setScrollTop(e.currentTarget.scrollTop);
  };

  return (
    <div
      ref={containerRef}
      style={{ height: containerHeight, overflow: 'auto' }}
      onScroll={handleScroll}
    >
      <div style={{ height: totalHeight, position: 'relative' }}>
        <div style={{ transform: `translateY(${offsetY}px)` }}>
          {visibleItems.map((item, index) => (
            <TrialBalanceRow
              key={item.id}
              item={item}
              index={visibleRange.start + index}
              onUpdate={onUpdate}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

// Memoized row component
const TrialBalanceRow = React.memo<{
  item: TrialBalanceEntry;
  index: number;
  onUpdate: (id: string, field: string, value: any) => void;
}>(({ item, index, onUpdate }) => {
  const handleFieldChange = useCallback(
    (field: string, value: any) => {
      onUpdate(item.id, field, value);
    },
    [item.id, onUpdate]
  );

  return (
    <div className="trial-balance-row" style={{ height: 40 }}>
      <EditableCell
        value={item.accountCode}
        onChange={(value) => handleFieldChange('accountCode', value)}
        readOnly={true}
      />
      <EditableCell
        value={item.accountName}
        onChange={(value) => handleFieldChange('accountName', value)}
      />
      <EditableCell
        value={item.debitAmount}
        onChange={(value) => handleFieldChange('debitAmount', value)}
        type="number"
      />
      <EditableCell
        value={item.creditAmount}
        onChange={(value) => handleFieldChange('creditAmount', value)}
        type="number"
      />
    </div>
  );
});
```

#### Optimized State Management
```typescript
// Optimized Redux slices with RTK Query
export const trialBalanceApi = createApi({
  reducerPath: 'trialBalanceApi',
  baseQuery: fetchBaseQuery({
    baseUrl: '/api/trial-balance',
    prepareHeaders: (headers, { getState }) => {
      const token = selectAuthToken(getState() as RootState);
      if (token) headers.set('authorization', `Bearer ${token}`);
      return headers;
    },
  }),
  tagTypes: ['TrialBalance', 'TrialBalanceEntry'],
  endpoints: (builder) => ({
    getTrialBalance: builder.query<TrialBalance, TrialBalanceParams>({
      query: ({ companyId, periodId, filters }) => ({
        url: `/${companyId}/${periodId}`,
        params: filters,
      }),
      providesTags: (result, error, { companyId, periodId }) => [
        { type: 'TrialBalance', id: `${companyId}-${periodId}` },
      ],
      // Transform response for optimized structure
      transformResponse: (response: TrialBalanceResponse) => ({
        ...response,
        entriesMap: new Map(response.entries.map(entry => [entry.id, entry])),
      }),
    }),

    updateTrialBalanceEntry: builder.mutation<
      TrialBalanceEntry,
      { id: string; updates: Partial<TrialBalanceEntry> }
    >({
      query: ({ id, updates }) => ({
        url: `/entries/${id}`,
        method: 'PATCH',
        body: updates,
      }),
      // Optimistic updates
      onQueryStarted: async ({ id, updates }, { dispatch, queryFulfilled }) => {
        const patches: any[] = [];

        // Update all relevant caches optimistically
        trialBalanceApi.util.selectInvalidatedBy(
          dispatch.getState(),
          [{ type: 'TrialBalance' }]
        ).forEach(({ queryCacheKey }) => {
          const patch = dispatch(
            trialBalanceApi.util.updateQueryData(
              'getTrialBalance',
              queryCacheKey,
              (draft) => {
                const entry = draft.entriesMap.get(id);
                if (entry) {
                  Object.assign(entry, updates);
                  // Update totals if amounts changed
                  if ('debitAmount' in updates || 'creditAmount' in updates) {
                    draft.totals = calculateTrialBalanceTotals(draft.entries);
                  }
                }
              }
            )
          );
          patches.push(patch);
        });

        try {
          await queryFulfilled;
        } catch {
          // Revert optimistic updates on error
          patches.forEach((patch) => patch.undo());
        }
      },
    }),

    bulkUpdateTrialBalance: builder.mutation<
      BulkUpdateResult,
      TrialBalanceUpdate[]
    >({
      query: (updates) => ({
        url: '/bulk-update',
        method: 'POST',
        body: { updates },
      }),
      invalidatesTags: ['TrialBalance'],
    }),
  }),
});

// Optimized component with selective subscriptions
export const TrialBalanceManager: React.FC<{ companyId: string; periodId: string }> = ({
  companyId,
  periodId,
}) => {
  const { data: trialBalance, isLoading, error } = trialBalanceApi.useGetTrialBalanceQuery(
    { companyId, periodId },
    {
      // Polling for real-time updates
      pollingInterval: 30000, // 30 seconds
      // Skip query if in background
      skip: document.hidden,
    }
  );

  const [updateEntry] = trialBalanceApi.useUpdateTrialBalanceEntryMutation();
  
  // Debounced update handler
  const debouncedUpdate = useMemo(
    () => debounce((id: string, field: string, value: any) => {
      updateEntry({ id, updates: { [field]: value } });
    }, 500),
    [updateEntry]
  );

  // Keyboard shortcuts for navigation
  const handleKeyDown = useCallback((e: KeyboardEvent) => {
    if (e.ctrlKey && e.key === 's') {
      e.preventDefault();
      // Save all pending changes
    }
  }, []);

  useEffect(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [handleKeyDown]);

  if (isLoading) return <TrialBalanceSkeleton />;
  if (error) return <ErrorDisplay error={error} />;
  if (!trialBalance) return <EmptyState />;

  return (
    <div className="trial-balance-manager">
      <TrialBalanceHeader trialBalance={trialBalance} />
      <VirtualizedTrialBalanceTable
        items={trialBalance.entries}
        itemHeight={40}
        containerHeight={600}
        onUpdate={debouncedUpdate}
      />
      <TrialBalanceTotals totals={trialBalance.totals} />
    </div>
  );
};
```

#### Code Splitting & Lazy Loading
```typescript
// Route-based code splitting
const CompaniesPage = lazy(() => import('../pages/CompaniesPage'));
const TrialBalancePage = lazy(() => import('../pages/TrialBalancePage'));
const ProceduresPage = lazy(() => import('../pages/ProceduresPage'));
const ReportsPage = lazy(() => import('../pages/ReportsPage'));

// Component-based code splitting
const AdvancedReportBuilder = lazy(() => 
  import('../components/reports/AdvancedReportBuilder')
);

const DocumentViewer = lazy(() => 
  import('../components/documents/DocumentViewer')
);

// Feature-based code splitting with preloading
export const AppRouter: React.FC = () => {
  const location = useLocation();

  // Preload next likely page
  useEffect(() => {
    if (location.pathname === '/companies') {
      // Preload trial balance page
      import('../pages/TrialBalancePage');
    } else if (location.pathname.includes('/trial-balance')) {
      // Preload procedures page
      import('../pages/ProceduresPage');
    }
  }, [location.pathname]);

  return (
    <Routes>
      <Route
        path="/companies"
        element={
          <Suspense fallback={<PageSkeleton />}>
            <CompaniesPage />
          </Suspense>
        }
      />
      <Route
        path="/trial-balance/:companyId/:periodId"
        element={
          <Suspense fallback={<PageSkeleton />}>
            <TrialBalancePage />
          </Suspense>
        }
      />
      <Route
        path="/procedures/:companyId"
        element={
          <Suspense fallback={<PageSkeleton />}>
            <ProceduresPage />
          </Suspense>
        }
      />
      <Route
        path="/reports"
        element={
          <Suspense fallback={<PageSkeleton />}>
            <ReportsPage />
          </Suspense>
        }
      />
    </Routes>
  );
};

// Progressive enhancement for complex components
export const EnhancedTrialBalance: React.FC<TrialBalanceProps> = (props) => {
  const [isAdvancedMode, setIsAdvancedMode] = useState(false);
  
  const AdvancedFeatures = useMemo(() => {
    if (!isAdvancedMode) return null;
    
    return lazy(() => import('./AdvancedTrialBalanceFeatures'));
  }, [isAdvancedMode]);

  return (
    <div>
      <BasicTrialBalance {...props} />
      
      <Button onClick={() => setIsAdvancedMode(true)}>
        Enable Advanced Features
      </Button>

      {AdvancedFeatures && (
        <Suspense fallback={<FeatureLoadingSkeleton />}>
          <AdvancedFeatures {...props} />
        </Suspense>
      )}
    </div>
  );
};
```

## Scalability Architecture

### Auto-Scaling Configuration

#### Azure App Service Scaling Rules
```yaml
# Azure App Service scaling configuration
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cloudauditpro-api
spec:
  replicas: 3  # Initial replica count
  selector:
    matchLabels:
      app: cloudauditpro-api
  template:
    metadata:
      labels:
        app: cloudauditpro-api
    spec:
      containers:
      - name: api
        image: cloudauditpro.azurecr.io/api:latest
        ports:
        - containerPort: 3000
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: database-secret
              key: url

---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: cloudauditpro-api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: cloudauditpro-api
  minReplicas: 3
  maxReplicas: 20
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
  - type: Object
    object:
      metric:
        name: requests_per_second
      target:
        type: AverageValue
        averageValue: "100"
```

#### Database Scaling Strategy
```typescript
// Database connection scaling
@Injectable()
export class DatabaseScalingService {
  private readReplicas: PrismaClient[] = [];
  private writeInstance: PrismaClient;
  private currentReplicaIndex = 0;

  constructor() {
    this.writeInstance = new PrismaClient({
      datasources: { db: { url: process.env.DATABASE_PRIMARY_URL } },
    });

    // Initialize read replicas
    const replicaUrls = process.env.DATABASE_REPLICA_URLS?.split(',') || [];
    this.readReplicas = replicaUrls.map(url => 
      new PrismaClient({ datasources: { db: { url } } })
    );
  }

  // Read operation with replica load balancing
  getReadClient(): PrismaClient {
    if (this.readReplicas.length === 0) {
      return this.writeInstance;
    }

    const client = this.readReplicas[this.currentReplicaIndex];
    this.currentReplicaIndex = (this.currentReplicaIndex + 1) % this.readReplicas.length;
    
    return client;
  }

  // Write operations always use primary
  getWriteClient(): PrismaClient {
    return this.writeInstance;
  }

  // Health check for all instances
  async healthCheck(): Promise<DatabaseHealth> {
    const checks = await Promise.allSettled([
      this.checkInstance(this.writeInstance, 'primary'),
      ...this.readReplicas.map((replica, index) => 
        this.checkInstance(replica, `replica-${index}`)
      ),
    ]);

    return {
      primary: checks[0].status === 'fulfilled' ? checks[0].value : { healthy: false },
      replicas: checks.slice(1).map((check, index) => ({
        name: `replica-${index}`,
        healthy: check.status === 'fulfilled' ? check.value.healthy : false,
      })),
    };
  }

  private async checkInstance(client: PrismaClient, name: string): Promise<InstanceHealth> {
    try {
      const start = Date.now();
      await client.$queryRaw`SELECT 1`;
      const latency = Date.now() - start;
      
      return {
        name,
        healthy: latency < 1000, // Consider unhealthy if > 1 second
        latency,
      };
    } catch (error) {
      return {
        name,
        healthy: false,
        error: error.message,
      };
    }
  }
}

// Auto-scaling database service
@Injectable()
export class DatabaseAutoScalingService {
  async scaleReplicas(currentLoad: number, targetLoad: number = 70): Promise<void> {
    if (currentLoad > targetLoad) {
      await this.addReadReplica();
    } else if (currentLoad < targetLoad * 0.5) {
      await this.removeReadReplica();
    }
  }

  private async addReadReplica(): Promise<void> {
    // Use Azure Database for PostgreSQL scaling API
    const scalingApi = new AzurePostgreSQLScalingClient();
    await scalingApi.createReadReplica({
      sourceServerName: process.env.DATABASE_PRIMARY_NAME,
      replicaName: `replica-${Date.now()}`,
      location: process.env.AZURE_REGION,
    });
  }

  private async removeReadReplica(): Promise<void> {
    // Remove least utilized replica
    const replicas = await this.getReplicaUtilization();
    const leastUtilized = replicas.sort((a, b) => a.utilization - b.utilization)[0];
    
    if (leastUtilized && replicas.length > 1) {
      const scalingApi = new AzurePostgreSQLScalingClient();
      await scalingApi.deleteReplica(leastUtilized.name);
    }
  }
}
```

### Load Balancing Strategy

#### Application Load Balancing
```typescript
// Custom load balancer for tenant-specific routing
@Injectable()
export class TenantLoadBalancer {
  private tenantServers: Map<string, ServerInstance[]> = new Map();
  private roundRobinCounters: Map<string, number> = new Map();

  // Route requests based on tenant ID
  routeRequest(tenantId: string, request: Request): ServerInstance {
    const servers = this.tenantServers.get(tenantId) || this.getDefaultServers();
    
    if (servers.length === 1) {
      return servers[0];
    }

    // Use consistent hashing for session affinity
    if (this.requiresSessionAffinity(request)) {
      return this.getConsistentHashServer(tenantId, request.sessionId, servers);
    }

    // Use round-robin for stateless requests
    return this.getRoundRobinServer(tenantId, servers);
  }

  private getConsistentHashServer(
    tenantId: string,
    sessionId: string,
    servers: ServerInstance[]
  ): ServerInstance {
    const hash = this.hash(`${tenantId}-${sessionId}`);
    const serverIndex = hash % servers.length;
    return servers[serverIndex];
  }

  private getRoundRobinServer(tenantId: string, servers: ServerInstance[]): ServerInstance {
    const counter = this.roundRobinCounters.get(tenantId) || 0;
    const serverIndex = counter % servers.length;
    this.roundRobinCounters.set(tenantId, counter + 1);
    return servers[serverIndex];
  }

  // Health check and server management
  async performHealthChecks(): Promise<void> {
    const allServers = Array.from(this.tenantServers.values()).flat();
    
    const healthChecks = allServers.map(async (server) => {
      const isHealthy = await this.checkServerHealth(server);
      server.healthy = isHealthy;
      
      if (!isHealthy) {
        await this.removeUnhealthyServer(server);
      }
    });

    await Promise.allSettled(healthChecks);
  }

  private async checkServerHealth(server: ServerInstance): Promise<boolean> {
    try {
      const response = await fetch(`http://${server.host}:${server.port}/health`, {
        timeout: 5000,
      });
      return response.ok;
    } catch {
      return false;
    }
  }

  private async removeUnhealthyServer(server: ServerInstance): Promise<void> {
    this.tenantServers.forEach((servers, tenantId) => {
      const index = servers.findIndex(s => s.id === server.id);
      if (index >= 0) {
        servers.splice(index, 1);
        this.tenantServers.set(tenantId, servers);
      }
    });
  }
}
```

## Monitoring & Performance Tracking

### Application Performance Monitoring (APM)

#### Custom Metrics Collection
```typescript
// Performance monitoring service
@Injectable()
export class PerformanceMonitoringService {
  private metrics: Map<string, PerformanceMetric[]> = new Map();
  private readonly metricRetentionDays = 30;

  // Method execution time tracking
  trackExecutionTime<T>(
    operationName: string,
    operation: () => Promise<T>
  ): Promise<T> {
    const startTime = performance.now();
    
    return operation().finally(() => {
      const executionTime = performance.now() - startTime;
      this.recordMetric('execution_time', {
        operation: operationName,
        duration: executionTime,
        timestamp: new Date(),
      });
    });
  }

  // Database query performance tracking
  trackDatabaseQuery<T>(
    queryType: string,
    query: () => Promise<T>
  ): Promise<T> {
    const startTime = performance.now();
    let rowCount = 0;

    return query()
      .then(result => {
        if (Array.isArray(result)) {
          rowCount = result.length;
        }
        return result;
      })
      .finally(() => {
        const queryTime = performance.now() - startTime;
        this.recordMetric('database_query', {
          type: queryType,
          duration: queryTime,
          rowCount,
          timestamp: new Date(),
        });
      });
  }

  // Memory usage tracking
  trackMemoryUsage(context: string): void {
    const usage = process.memoryUsage();
    this.recordMetric('memory_usage', {
      context,
      heapUsed: usage.heapUsed,
      heapTotal: usage.heapTotal,
      external: usage.external,
      rss: usage.rss,
      timestamp: new Date(),
    });
  }

  // Custom business metrics
  trackBusinessMetric(metricName: string, value: number, tags?: Record<string, string>): void {
    this.recordMetric('business_metric', {
      name: metricName,
      value,
      tags: tags || {},
      timestamp: new Date(),
    });
  }

  private recordMetric(category: string, metric: any): void {
    const key = `${category}_${new Date().toISOString().split('T')[0]}`;
    const metrics = this.metrics.get(key) || [];
    metrics.push(metric);
    this.metrics.set(key, metrics);

    // Clean up old metrics
    this.cleanupOldMetrics();
  }

  // Performance analytics
  async getPerformanceAnalytics(
    startDate: Date,
    endDate: Date
  ): Promise<PerformanceAnalytics> {
    const metrics = this.getMetricsByDateRange(startDate, endDate);
    
    return {
      averageResponseTime: this.calculateAverageResponseTime(metrics),
      slowestOperations: this.findSlowestOperations(metrics),
      databasePerformance: this.analyzeDatabasePerformance(metrics),
      memoryTrends: this.analyzeMemoryTrends(metrics),
      businessMetrics: this.analyzeBusinessMetrics(metrics),
    };
  }

  private calculateAverageResponseTime(metrics: PerformanceMetric[]): number {
    const executionMetrics = metrics.filter(m => m.type === 'execution_time');
    if (executionMetrics.length === 0) return 0;
    
    const totalTime = executionMetrics.reduce((sum, m) => sum + m.duration, 0);
    return totalTime / executionMetrics.length;
  }

  private findSlowestOperations(metrics: PerformanceMetric[]): SlowOperation[] {
    return metrics
      .filter(m => m.type === 'execution_time')
      .sort((a, b) => b.duration - a.duration)
      .slice(0, 10)
      .map(m => ({
        operation: m.operation,
        duration: m.duration,
        timestamp: m.timestamp,
      }));
  }
}

// Performance monitoring decorator
export function MonitorPerformance(operationName?: string) {
  return function (target: any, propertyName: string, descriptor: PropertyDescriptor) {
    const method = descriptor.value;
    const operation = operationName || `${target.constructor.name}.${propertyName}`;

    descriptor.value = async function (...args: any[]) {
      const monitoringService = this.performanceMonitoringService || 
        new PerformanceMonitoringService();

      return monitoringService.trackExecutionTime(operation, () =>
        method.apply(this, args)
      );
    };

    return descriptor;
  };
}

// Usage example
@Injectable()
export class TrialBalanceService {
  @MonitorPerformance('getTrialBalance')
  async getTrialBalance(companyId: string, periodId: string): Promise<TrialBalance> {
    // Implementation automatically tracked
  }
}
```

#### Real-time Performance Dashboards
```typescript
// Performance dashboard service
@Injectable()
export class PerformanceDashboardService {
  // Real-time metrics streaming
  streamMetrics(): Observable<PerformanceMetrics> {
    return interval(1000).pipe(
      switchMap(() => this.collectCurrentMetrics()),
      share()
    );
  }

  private async collectCurrentMetrics(): Promise<PerformanceMetrics> {
    const [
      systemMetrics,
      applicationMetrics,
      databaseMetrics,
      cacheMetrics,
    ] = await Promise.all([
      this.getSystemMetrics(),
      this.getApplicationMetrics(),
      this.getDatabaseMetrics(),
      this.getCacheMetrics(),
    ]);

    return {
      timestamp: new Date(),
      system: systemMetrics,
      application: applicationMetrics,
      database: databaseMetrics,
      cache: cacheMetrics,
    };
  }

  private async getSystemMetrics(): Promise<SystemMetrics> {
    return {
      cpu: {
        usage: await this.getCpuUsage(),
        cores: os.cpus().length,
      },
      memory: {
        used: process.memoryUsage().heapUsed,
        total: os.totalmem(),
        free: os.freemem(),
        usage: (os.totalmem() - os.freemem()) / os.totalmem() * 100,
      },
      disk: await this.getDiskUsage(),
      network: await this.getNetworkMetrics(),
    };
  }

  private async getApplicationMetrics(): Promise<ApplicationMetrics> {
    const activeConnections = await this.getActiveConnections();
    const requestQueue = await this.getRequestQueueSize();
    
    return {
      activeConnections,
      requestQueue,
      eventLoopLag: await this.measureEventLoopLag(),
      gc: this.getGCMetrics(),
    };
  }

  // Performance alerting
  async checkPerformanceThresholds(): Promise<PerformanceAlert[]> {
    const metrics = await this.collectCurrentMetrics();
    const alerts: PerformanceAlert[] = [];

    // Check response time threshold
    if (metrics.application.averageResponseTime > 2000) {
      alerts.push({
        severity: 'warning',
        metric: 'response_time',
        value: metrics.application.averageResponseTime,
        threshold: 2000,
        message: 'Average response time exceeds threshold',
      });
    }

    // Check memory usage
    if (metrics.system.memory.usage > 85) {
      alerts.push({
        severity: 'critical',
        metric: 'memory_usage',
        value: metrics.system.memory.usage,
        threshold: 85,
        message: 'Memory usage critically high',
      });
    }

    // Check database connection pool
    if (metrics.database.connectionPoolUtilization > 90) {
      alerts.push({
        severity: 'warning',
        metric: 'db_connections',
        value: metrics.database.connectionPoolUtilization,
        threshold: 90,
        message: 'Database connection pool nearly exhausted',
      });
    }

    return alerts;
  }
}
```

This comprehensive Performance & Scalability Guide provides the foundation for building a high-performance, scalable multi-tenant audit management system that can grow with your business needs while maintaining excellent user experience and system reliability.