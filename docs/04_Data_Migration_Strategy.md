# Data Migration Strategy & Implementation Guide

## Executive Summary

This document outlines the comprehensive strategy for migrating data from the legacy eAuditPro VB6/SQL Server application to the new multi-tenant web platform. The migration approach ensures data integrity, minimal downtime, and seamless transition while supporting the multi-tenant architecture.

## Current System Analysis

### Existing Database Structure

#### Primary Databases
1. **AuditMain**: Core application data
   - Companies, Periods, Account Types, Account Heads
   - Trial Balance data, Journal Entries
   - User management, Procedures
   - System configuration and metadata

2. **AuditDocument**: Document storage
   - Document metadata and file references
   - Document linking to entities
   - Version control information

3. **Backup Databases**: Automated backups
   - AuditMainBackup1, AuditDocumentBackup1
   - AuditMainBackup2, AuditDocumentBackup2

### Key Legacy Tables Analysis

#### Core Business Tables
```sql
-- Legacy schema examples from VB6 application
-- Companies table
CREATE TABLE Companies (
    CompanyID int IDENTITY(1,1) PRIMARY KEY,
    CompanyName nvarchar(255),
    CompanyCode nvarchar(50),
    CompanyShortName nvarchar(100),
    JobCode nvarchar(50),
    StatusID int,
    CompanyAdd1 nvarchar(255),
    CompanyAdd2 nvarchar(255),
    CompanyAdd3 nvarchar(255),
    CompanyPhone nvarchar(50),
    CompanyFax nvarchar(50),
    CompanyEmail nvarchar(255),
    CompanyUrl nvarchar(255),
    ContactPerson nvarchar(255),
    ContPerDesignation nvarchar(100),
    ContPerPhone nvarchar(50),
    ContPerEmail nvarchar(255),
    CurrencyID int,
    CreatedDate datetime,
    CreatedBy int,
    UpdatedDate datetime,
    UpdatedBy int
);

-- Periods table
CREATE TABLE Periods (
    PeriodID int IDENTITY(1,1) PRIMARY KEY,
    CompanyID int,
    PeriodName nvarchar(255),
    PeriodStartDate datetime,
    PeriodEndDate datetime,
    AuditType nvarchar(50),
    StatusID int,
    CreatedDate datetime,
    CreatedBy int
);

-- Account Types
CREATE TABLE AcTypes (
    AcTypeID int IDENTITY(1,1) PRIMARY KEY,
    AcTypeName nvarchar(100),
    AcTypeCode nvarchar(20),
    Category nvarchar(50),
    NormalBalance nvarchar(10),
    StatusID int
);

-- Account Heads
CREATE TABLE AcHeads (
    AcID int IDENTITY(1,1) PRIMARY KEY,
    CompanyID int,
    AcTypeID int,
    AcName nvarchar(255),
    AcCode nvarchar(50),
    ParentAcID int,
    TrialOrder int,
    StatusID int,
    CreatedDate datetime,
    CreatedBy int
);
```

### Data Characteristics & Challenges

#### Data Volume Estimates
- **Companies**: 100-500 per installation
- **Periods**: 3-10 per company (historical data)
- **Account Heads**: 50-200 per company
- **Trial Balance entries**: 50-200 per period
- **Journal Entries**: 10-100 per period
- **Procedures**: 20-100 per company/period
- **Documents**: 100-1000 per company

#### Data Quality Issues
1. **Inconsistent naming conventions**: Mixed case, abbreviations
2. **NULL vs empty string handling**: Inconsistent data representation
3. **Date format variations**: Different date formats across installations
4. **Referential integrity gaps**: Some foreign keys may be invalid
5. **Character encoding**: Legacy encoding issues with special characters

## Migration Architecture

### High-Level Migration Flow

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Legacy VB6    │    │   Migration     │    │  New Multi-     │
│   Application   │───▶│   Pipeline      │───▶│  Tenant System  │
│                 │    │                 │    │                 │
│ • AuditMain DB  │    │ • Extract       │    │ • Tenant        │
│ • AuditDoc DB   │    │ • Transform     │    │   Registry      │
│ • Backup DBs    │    │ • Load          │    │ • Individual    │
└─────────────────┘    │ • Validate      │    │   Tenant DBs    │
                       │ • Monitor       │    │ • File Storage  │
                       └─────────────────┘    └─────────────────┘
```

### Migration Pipeline Components

#### 1. Data Discovery & Assessment
```typescript
interface MigrationAssessment {
  sourceDatabase: DatabaseInfo;
  tableAnalysis: TableAnalysis[];
  dataQualityIssues: DataQualityIssue[];
  migrationComplexity: ComplexityScore;
  estimatedDuration: Duration;
  recommendedStrategy: MigrationStrategy;
}

interface TableAnalysis {
  tableName: string;
  recordCount: number;
  dataSize: number;
  columns: ColumnInfo[];
  relationships: Relationship[];
  dataQualityScore: number;
  migrationPriority: Priority;
}

class MigrationAssessmentService {
  async assessSourceSystem(connectionString: string): Promise<MigrationAssessment> {
    const connection = await this.connectToSource(connectionString);
    
    const assessment: MigrationAssessment = {
      sourceDatabase: await this.analyzeDatabaseInfo(connection),
      tableAnalysis: await this.analyzeAllTables(connection),
      dataQualityIssues: await this.identifyDataQualityIssues(connection),
      migrationComplexity: 'medium',
      estimatedDuration: '2-4 weeks',
      recommendedStrategy: 'phased_migration'
    };

    return assessment;
  }

  private async analyzeAllTables(connection: Connection): Promise<TableAnalysis[]> {
    const tables = await this.getTableList(connection);
    const analyses: TableAnalysis[] = [];

    for (const tableName of tables) {
      const analysis = await this.analyzeTable(connection, tableName);
      analyses.push(analysis);
    }

    return analyses;
  }

  private async analyzeTable(connection: Connection, tableName: string): Promise<TableAnalysis> {
    const [recordCount, columns, relationships] = await Promise.all([
      this.getRecordCount(connection, tableName),
      this.getColumnInfo(connection, tableName),
      this.getRelationships(connection, tableName)
    ]);

    return {
      tableName,
      recordCount,
      dataSize: await this.calculateDataSize(connection, tableName),
      columns,
      relationships,
      dataQualityScore: await this.calculateDataQuality(connection, tableName),
      migrationPriority: this.determinePriority(tableName)
    };
  }
}
```

#### 2. Data Extraction Service
```typescript
interface ExtractionConfig {
  sourceConnection: string;
  targetTenantId: string;
  extractionMode: 'full' | 'incremental';
  batchSize: number;
  parallelism: number;
  filters?: ExtractionFilter[];
}

interface ExtractionFilter {
  tableName: string;
  whereClause?: string;
  dateRange?: DateRange;
  customLogic?: string;
}

class DataExtractionService {
  async extractData(config: ExtractionConfig): Promise<ExtractionResult> {
    const extraction = await this.initializeExtraction(config);
    
    try {
      const tables = await this.getTableExtractionOrder();
      
      for (const table of tables) {
        await this.extractTable(extraction, table, config);
      }

      return await this.finalizeExtraction(extraction);
    } catch (error) {
      await this.handleExtractionError(extraction, error);
      throw error;
    }
  }

  private async extractTable(
    extraction: ExtractionSession, 
    tableName: string, 
    config: ExtractionConfig
  ): Promise<void> {
    const totalRecords = await this.getRecordCount(config.sourceConnection, tableName);
    let offset = 0;
    const batchSize = config.batchSize;

    while (offset < totalRecords) {
      const batch = await this.extractBatch(
        config.sourceConnection, 
        tableName, 
        offset, 
        batchSize
      );

      const transformedBatch = await this.transformBatch(batch, tableName);
      await this.storeBatch(extraction, tableName, transformedBatch);

      offset += batchSize;
      await this.updateProgress(extraction, tableName, offset, totalRecords);
    }
  }

  private async extractBatch(
    connectionString: string,
    tableName: string,
    offset: number,
    batchSize: number
  ): Promise<any[]> {
    const query = `
      SELECT * FROM ${tableName}
      ORDER BY ${this.getPrimaryKey(tableName)}
      OFFSET ${offset} ROWS
      FETCH NEXT ${batchSize} ROWS ONLY
    `;

    return this.executeQuery(connectionString, query);
  }

  private async transformBatch(batch: any[], tableName: string): Promise<any[]> {
    const transformer = this.getTransformer(tableName);
    return Promise.all(batch.map(record => transformer.transform(record)));
  }
}
```

#### 3. Data Transformation Engine
```typescript
interface TransformationRule {
  sourceTable: string;
  targetTable: string;
  fieldMappings: FieldMapping[];
  customTransformations: CustomTransformation[];
  validationRules: ValidationRule[];
}

interface FieldMapping {
  sourceField: string;
  targetField: string;
  dataType: string;
  required: boolean;
  transformation?: FieldTransformation;
}

interface FieldTransformation {
  type: 'rename' | 'convert' | 'split' | 'combine' | 'lookup' | 'custom';
  parameters?: Record<string, any>;
  customFunction?: string;
}

class DataTransformationEngine {
  private transformationRules: Map<string, TransformationRule> = new Map();

  constructor() {
    this.initializeTransformationRules();
  }

  private initializeTransformationRules(): void {
    // Company transformation rule
    this.transformationRules.set('Companies', {
      sourceTable: 'Companies',
      targetTable: 'companies',
      fieldMappings: [
        {
          sourceField: 'CompanyID',
          targetField: 'company_id',
          dataType: 'serial',
          required: true,
          transformation: { type: 'convert', parameters: { fromType: 'int', toType: 'serial' } }
        },
        {
          sourceField: 'CompanyName',
          targetField: 'company_name',
          dataType: 'varchar(255)',
          required: true,
          transformation: { type: 'custom', customFunction: 'cleanCompanyName' }
        },
        {
          sourceField: 'CompanyCode',
          targetField: 'company_code',
          dataType: 'varchar(50)',
          required: true,
          transformation: { type: 'convert', parameters: { toUpperCase: true } }
        },
        // Contact information mapping
        {
          sourceField: 'CompanyAdd1',
          targetField: 'address_line_1',
          dataType: 'varchar(255)',
          required: false
        },
        {
          sourceField: 'CompanyAdd2',
          targetField: 'address_line_2',
          dataType: 'varchar(255)',
          required: false
        },
        {
          sourceField: 'CompanyAdd3',
          targetField: 'address_line_3',
          dataType: 'varchar(255)',
          required: false
        },
        {
          sourceField: 'CompanyPhone',
          targetField: 'phone',
          dataType: 'varchar(50)',
          required: false,
          transformation: { type: 'custom', customFunction: 'formatPhoneNumber' }
        },
        {
          sourceField: 'CompanyEmail',
          targetField: 'email',
          dataType: 'varchar(255)',
          required: false,
          transformation: { type: 'custom', customFunction: 'validateEmail' }
        },
        // Status mapping
        {
          sourceField: 'StatusID',
          targetField: 'status_id',
          dataType: 'integer',
          required: true,
          transformation: { type: 'lookup', parameters: { table: 'status_mapping' } }
        },
        // Metadata fields
        {
          sourceField: 'CreatedDate',
          targetField: 'created_at',
          dataType: 'timestamp',
          required: true,
          transformation: { type: 'convert', parameters: { timezone: 'UTC' } }
        }
      ],
      customTransformations: [
        {
          name: 'generateSlug',
          description: 'Generate URL-friendly slug from company name',
          function: 'generateCompanySlug'
        }
      ],
      validationRules: [
        {
          field: 'company_name',
          rules: ['required', 'minLength:2', 'maxLength:255']
        },
        {
          field: 'company_code',
          rules: ['required', 'unique', 'alphanumeric']
        },
        {
          field: 'email',
          rules: ['email']
        }
      ]
    });

    // Add more transformation rules for other tables...
    this.addPeriodTransformationRule();
    this.addAccountTransformationRules();
    this.addUserTransformationRules();
  }

  async transformRecord(tableName: string, sourceRecord: any): Promise<any> {
    const rule = this.transformationRules.get(tableName);
    if (!rule) {
      throw new Error(`No transformation rule found for table: ${tableName}`);
    }

    const transformedRecord: any = {};

    // Apply field mappings
    for (const mapping of rule.fieldMappings) {
      const sourceValue = sourceRecord[mapping.sourceField];
      let transformedValue = sourceValue;

      if (mapping.transformation) {
        transformedValue = await this.applyFieldTransformation(
          sourceValue, 
          mapping.transformation
        );
      }

      // Apply data type conversion
      transformedValue = this.convertDataType(transformedValue, mapping.dataType);

      transformedRecord[mapping.targetField] = transformedValue;
    }

    // Apply custom transformations
    for (const customTransform of rule.customTransformations) {
      await this.applyCustomTransformation(transformedRecord, customTransform);
    }

    // Validate transformed record
    await this.validateRecord(transformedRecord, rule.validationRules);

    return transformedRecord;
  }

  private async applyFieldTransformation(
    value: any, 
    transformation: FieldTransformation
  ): Promise<any> {
    switch (transformation.type) {
      case 'convert':
        return this.convertValue(value, transformation.parameters);
      
      case 'lookup':
        return this.lookupValue(value, transformation.parameters);
      
      case 'custom':
        return this.applyCustomFunction(value, transformation.customFunction!);
      
      case 'split':
        return this.splitValue(value, transformation.parameters);
      
      case 'combine':
        return this.combineValues(value, transformation.parameters);
      
      default:
        return value;
    }
  }

  private applyCustomFunction(value: any, functionName: string): any {
    switch (functionName) {
      case 'cleanCompanyName':
        return this.cleanCompanyName(value);
      
      case 'formatPhoneNumber':
        return this.formatPhoneNumber(value);
      
      case 'validateEmail':
        return this.validateAndCleanEmail(value);
      
      case 'generateCompanySlug':
        return this.generateSlug(value);
      
      default:
        throw new Error(`Unknown custom function: ${functionName}`);
    }
  }

  private cleanCompanyName(name: string): string {
    if (!name) return '';
    
    return name
      .trim()
      .replace(/\s+/g, ' ') // Replace multiple spaces with single space
      .replace(/[^\w\s&.-]/g, '') // Remove special characters except &, ., -
      .substring(0, 255); // Ensure max length
  }

  private formatPhoneNumber(phone: string): string {
    if (!phone) return '';
    
    // Remove all non-numeric characters
    const cleaned = phone.replace(/\D/g, '');
    
    // Apply basic formatting based on length
    if (cleaned.length === 10) {
      return `(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}`;
    }
    
    return cleaned;
  }

  private validateAndCleanEmail(email: string): string {
    if (!email) return '';
    
    const cleaned = email.trim().toLowerCase();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (emailRegex.test(cleaned)) {
      return cleaned;
    }
    
    return ''; // Return empty string for invalid emails
  }

  private generateSlug(name: string): string {
    if (!name) return '';
    
    return name
      .toLowerCase()
      .trim()
      .replace(/[^\w\s-]/g, '')
      .replace(/[\s_-]+/g, '-')
      .replace(/^-+|-+$/g, '');
  }
}
```

## Multi-Tenant Migration Strategy

### Tenant Provisioning Process

```typescript
interface TenantMigrationRequest {
  sourceDatabaseConnection: string;
  tenantInfo: {
    name: string;
    subdomain: string;
    contactEmail: string;
    subscriptionTier: string;
  };
  migrationOptions: {
    includeDocuments: boolean;
    includeHistoricalData: boolean;
    dataDateCutoff?: Date;
    preserveUserAccounts: boolean;
  };
}

class TenantMigrationOrchestrator {
  async migrateTenant(request: TenantMigrationRequest): Promise<TenantMigrationResult> {
    const migrationId = uuidv4();
    
    try {
      // 1. Create tenant in registry
      const tenant = await this.createTenant(request.tenantInfo);
      
      // 2. Provision tenant database
      await this.provisionTenantDatabase(tenant.id);
      
      // 3. Assess source data
      const assessment = await this.assessSourceData(request.sourceDatabaseConnection);
      
      // 4. Create migration plan
      const plan = await this.createMigrationPlan(assessment, request.migrationOptions);
      
      // 5. Execute migration
      const result = await this.executeMigration(migrationId, tenant.id, plan);
      
      // 6. Validate migration
      await this.validateMigration(tenant.id, result);
      
      // 7. Finalize tenant setup
      await this.finalizeTenantSetup(tenant.id);
      
      return {
        migrationId,
        tenantId: tenant.id,
        status: 'completed',
        summary: result,
        validationResults: await this.getValidationResults(migrationId)
      };
      
    } catch (error) {
      await this.handleMigrationFailure(migrationId, error);
      throw error;
    }
  }

  private async createMigrationPlan(
    assessment: MigrationAssessment, 
    options: any
  ): Promise<MigrationPlan> {
    const plan: MigrationPlan = {
      phases: [],
      estimatedDuration: 0,
      dependencies: new Map(),
      rollbackStrategy: 'snapshot'
    };

    // Phase 1: Master data
    plan.phases.push({
      name: 'Master Data Migration',
      order: 1,
      tables: ['account_types', 'currency_master', 'nations_master'],
      dependencies: [],
      estimatedTime: '30 minutes'
    });

    // Phase 2: Core business entities
    plan.phases.push({
      name: 'Core Business Entities',
      order: 2,
      tables: ['companies', 'users'],
      dependencies: ['Master Data Migration'],
      estimatedTime: '1 hour'
    });

    // Phase 3: Audit structure
    plan.phases.push({
      name: 'Audit Structure',
      order: 3,
      tables: ['periods', 'account_heads', 'procedure_templates'],
      dependencies: ['Core Business Entities'],
      estimatedTime: '2 hours'
    });

    // Phase 4: Transactional data
    plan.phases.push({
      name: 'Transactional Data',
      order: 4,
      tables: ['trial_balance', 'journal_entries', 'procedures'],
      dependencies: ['Audit Structure'],
      estimatedTime: '3 hours'
    });

    // Phase 5: Documents (if requested)
    if (options.includeDocuments) {
      plan.phases.push({
        name: 'Document Migration',
        order: 5,
        tables: ['documents'],
        dependencies: ['Transactional Data'],
        estimatedTime: '4 hours'
      });
    }

    return plan;
  }

  private async executeMigration(
    migrationId: string, 
    tenantId: string, 
    plan: MigrationPlan
  ): Promise<MigrationResult> {
    const result: MigrationResult = {
      migrationId,
      tenantId,
      startTime: new Date(),
      phases: [],
      totalRecordsProcessed: 0,
      totalErrors: 0
    };

    for (const phase of plan.phases) {
      const phaseResult = await this.executePhase(migrationId, tenantId, phase);
      result.phases.push(phaseResult);
      result.totalRecordsProcessed += phaseResult.recordsProcessed;
      result.totalErrors += phaseResult.errors.length;
    }

    result.endTime = new Date();
    result.duration = result.endTime.getTime() - result.startTime.getTime();

    return result;
  }

  private async executePhase(
    migrationId: string, 
    tenantId: string, 
    phase: MigrationPhase
  ): Promise<PhaseResult> {
    const phaseResult: PhaseResult = {
      phaseName: phase.name,
      startTime: new Date(),
      tables: [],
      recordsProcessed: 0,
      errors: []
    };

    for (const tableName of phase.tables) {
      try {
        const tableResult = await this.migrateTable(migrationId, tenantId, tableName);
        phaseResult.tables.push(tableResult);
        phaseResult.recordsProcessed += tableResult.recordsProcessed;
      } catch (error) {
        phaseResult.errors.push({
          table: tableName,
          error: error.message,
          timestamp: new Date()
        });
      }
    }

    phaseResult.endTime = new Date();
    return phaseResult;
  }
}
```

### Data Validation & Quality Assurance

```typescript
interface ValidationResult {
  isValid: boolean;
  errors: ValidationError[];
  warnings: ValidationWarning[];
  statistics: ValidationStatistics;
}

interface ValidationError {
  type: 'referential_integrity' | 'data_type' | 'constraint_violation' | 'business_rule';
  table: string;
  field?: string;
  recordId?: string;
  message: string;
  severity: 'critical' | 'major' | 'minor';
}

class MigrationValidator {
  async validateMigration(tenantId: string): Promise<ValidationResult> {
    const result: ValidationResult = {
      isValid: true,
      errors: [],
      warnings: [],
      statistics: {
        totalRecords: 0,
        validRecords: 0,
        recordsWithWarnings: 0,
        recordsWithErrors: 0
      }
    };

    // 1. Validate referential integrity
    const integrityErrors = await this.validateReferentialIntegrity(tenantId);
    result.errors.push(...integrityErrors);

    // 2. Validate business rules
    const businessRuleErrors = await this.validateBusinessRules(tenantId);
    result.errors.push(...businessRuleErrors);

    // 3. Validate data completeness
    const completenessWarnings = await this.validateDataCompleteness(tenantId);
    result.warnings.push(...completenessWarnings);

    // 4. Generate statistics
    result.statistics = await this.generateValidationStatistics(tenantId);

    // 5. Determine overall validity
    result.isValid = result.errors.filter(e => e.severity === 'critical').length === 0;

    return result;
  }

  private async validateReferentialIntegrity(tenantId: string): Promise<ValidationError[]> {
    const errors: ValidationError[] = [];
    const db = this.getTenantDatabase(tenantId);

    // Check company-period relationships
    const orphanedPeriods = await db.query(`
      SELECT p.period_id, p.company_id 
      FROM periods p 
      LEFT JOIN companies c ON p.company_id = c.company_id 
      WHERE c.company_id IS NULL
    `);

    for (const period of orphanedPeriods.rows) {
      errors.push({
        type: 'referential_integrity',
        table: 'periods',
        recordId: period.period_id,
        message: `Period references non-existent company: ${period.company_id}`,
        severity: 'critical'
      });
    }

    // Check account head hierarchies
    const invalidAccountHierarchies = await db.query(`
      SELECT ah.account_id, ah.parent_account_id 
      FROM account_heads ah 
      LEFT JOIN account_heads parent ON ah.parent_account_id = parent.account_id 
      WHERE ah.parent_account_id IS NOT NULL AND parent.account_id IS NULL
    `);

    for (const account of invalidAccountHierarchies.rows) {
      errors.push({
        type: 'referential_integrity',
        table: 'account_heads',
        recordId: account.account_id,
        message: `Account references non-existent parent: ${account.parent_account_id}`,
        severity: 'major'
      });
    }

    // Check trial balance entries
    const invalidTrialBalanceEntries = await db.query(`
      SELECT tb.trial_balance_id, tb.account_id, tb.company_id, tb.period_id
      FROM trial_balance tb 
      LEFT JOIN account_heads ah ON tb.account_id = ah.account_id AND tb.company_id = ah.company_id
      WHERE ah.account_id IS NULL
    `);

    for (const entry of invalidTrialBalanceEntries.rows) {
      errors.push({
        type: 'referential_integrity',
        table: 'trial_balance',
        recordId: entry.trial_balance_id,
        message: `Trial balance references invalid account: ${entry.account_id} for company: ${entry.company_id}`,
        severity: 'critical'
      });
    }

    return errors;
  }

  private async validateBusinessRules(tenantId: string): Promise<ValidationError[]> {
    const errors: ValidationError[] = [];
    const db = this.getTenantDatabase(tenantId);

    // Validate period date ranges
    const invalidPeriods = await db.query(`
      SELECT period_id, period_start_date, period_end_date 
      FROM periods 
      WHERE period_end_date <= period_start_date
    `);

    for (const period of invalidPeriods.rows) {
      errors.push({
        type: 'business_rule',
        table: 'periods',
        recordId: period.period_id,
        message: `Period end date must be after start date`,
        severity: 'critical'
      });
    }

    // Validate trial balance consistency
    const unbalancedTrialBalance = await db.query(`
      SELECT company_id, period_id, 
             SUM(final_debit) as total_debit, 
             SUM(final_credit) as total_credit
      FROM trial_balance 
      GROUP BY company_id, period_id 
      HAVING ABS(SUM(final_debit) - SUM(final_credit)) > 0.01
    `);

    for (const imbalance of unbalancedTrialBalance.rows) {
      errors.push({
        type: 'business_rule',
        table: 'trial_balance',
        message: `Trial balance is not balanced for company ${imbalance.company_id}, period ${imbalance.period_id}. Difference: ${Math.abs(imbalance.total_debit - imbalance.total_credit)}`,
        severity: 'major'
      });
    }

    // Validate journal entry balance
    const unbalancedJournals = await db.query(`
      SELECT j.journal_id, j.total_debit, j.total_credit,
             SUM(jl.debit_amount) as calculated_debit,
             SUM(jl.credit_amount) as calculated_credit
      FROM journal_entries j
      JOIN journal_lines jl ON j.journal_id = jl.journal_id
      GROUP BY j.journal_id, j.total_debit, j.total_credit
      HAVING ABS(j.total_debit - SUM(jl.debit_amount)) > 0.01 
          OR ABS(j.total_credit - SUM(jl.credit_amount)) > 0.01
          OR ABS(SUM(jl.debit_amount) - SUM(jl.credit_amount)) > 0.01
    `);

    for (const journal of unbalancedJournals.rows) {
      errors.push({
        type: 'business_rule',
        table: 'journal_entries',
        recordId: journal.journal_id,
        message: `Journal entry is not balanced. Header totals don't match line totals or debits don't equal credits`,
        severity: 'critical'
      });
    }

    return errors;
  }
}
```

## Document Migration Strategy

### File System to Cloud Storage Migration

```typescript
interface DocumentMigrationConfig {
  sourceDocumentPath: string;
  targetStorageProvider: 'aws-s3' | 'azure-blob' | 'gcp-storage';
  targetBucket: string;
  encryptionEnabled: boolean;
  compressionEnabled: boolean;
  virusScanEnabled: boolean;
}

class DocumentMigrationService {
  private storageClient: CloudStorageClient;
  private encryptionService: EncryptionService;
  private virusScanService: VirusScanService;

  async migrateDocuments(
    tenantId: string, 
    config: DocumentMigrationConfig
  ): Promise<DocumentMigrationResult> {
    const result: DocumentMigrationResult = {
      totalDocuments: 0,
      migratedDocuments: 0,
      failedDocuments: 0,
      totalSizeBytes: 0,
      migratedSizeBytes: 0,
      failures: []
    };

    // Get document records from database
    const documents = await this.getDocumentRecords(tenantId);
    result.totalDocuments = documents.length;

    for (const document of documents) {
      try {
        await this.migrateDocument(document, config, tenantId);
        result.migratedDocuments++;
        result.migratedSizeBytes += document.file_size_bytes;
      } catch (error) {
        result.failedDocuments++;
        result.failures.push({
          documentId: document.document_id,
          fileName: document.document_name,
          error: error.message
        });
      }
    }

    return result;
  }

  private async migrateDocument(
    document: DocumentRecord, 
    config: DocumentMigrationConfig,
    tenantId: string
  ): Promise<void> {
    // 1. Read source file
    const sourceFilePath = path.join(config.sourceDocumentPath, document.storage_path);
    const fileBuffer = await fs.readFile(sourceFilePath);

    // 2. Virus scan if enabled
    if (config.virusScanEnabled) {
      const scanResult = await this.virusScanService.scan(fileBuffer);
      if (!scanResult.isClean) {
        throw new Error(`Virus detected in file: ${document.document_name}`);
      }
    }

    // 3. Compress if enabled
    let processedBuffer = fileBuffer;
    if (config.compressionEnabled && this.shouldCompress(document.mime_type)) {
      processedBuffer = await this.compressFile(fileBuffer, document.file_extension);
    }

    // 4. Encrypt if enabled
    if (config.encryptionEnabled) {
      processedBuffer = await this.encryptionService.encrypt(processedBuffer, tenantId);
    }

    // 5. Generate target path
    const targetPath = this.generateTargetPath(document, tenantId);

    // 6. Upload to cloud storage
    await this.storageClient.upload({
      bucket: config.targetBucket,
      key: targetPath,
      body: processedBuffer,
      contentType: document.mime_type,
      metadata: {
        originalName: document.original_filename,
        documentId: document.document_id.toString(),
        tenantId: tenantId,
        uploadedAt: new Date().toISOString(),
        encrypted: config.encryptionEnabled.toString(),
        compressed: config.compressionEnabled.toString()
      }
    });

    // 7. Update document record with new storage location
    await this.updateDocumentStorageInfo(document.document_id, {
      storage_provider: config.targetStorageProvider,
      storage_path: targetPath,
      storage_bucket: config.targetBucket,
      file_size_bytes: processedBuffer.length,
      migration_completed_at: new Date()
    });
  }

  private generateTargetPath(document: DocumentRecord, tenantId: string): string {
    const datePath = new Date().toISOString().substring(0, 10).replace(/-/g, '/');
    const fileExtension = document.file_extension || '';
    const fileName = `${document.document_id}${fileExtension}`;
    
    return `tenants/${tenantId}/documents/${datePath}/${fileName}`;
  }

  private shouldCompress(mimeType: string): boolean {
    // Don't compress already compressed formats
    const nonCompressibleTypes = [
      'image/jpeg', 'image/png', 'image/gif',
      'application/zip', 'application/gzip',
      'video/mp4', 'audio/mp3'
    ];

    return !nonCompressibleTypes.includes(mimeType.toLowerCase());
  }
}
```

## Migration Monitoring & Rollback

### Real-time Monitoring System

```typescript
interface MigrationMonitor {
  migrationId: string;
  status: MigrationStatus;
  progress: MigrationProgress;
  performance: PerformanceMetrics;
  errors: MigrationError[];
  warnings: MigrationWarning[];
}

interface MigrationProgress {
  currentPhase: string;
  currentTable: string;
  totalRecords: number;
  processedRecords: number;
  remainingRecords: number;
  progressPercentage: number;
  estimatedTimeRemaining: number;
  recordsPerSecond: number;
}

class MigrationMonitoringService {
  private monitors: Map<string, MigrationMonitor> = new Map();
  private metricsCollector: MetricsCollector;
  private alertingService: AlertingService;

  async startMonitoring(migrationId: string): Promise<void> {
    const monitor: MigrationMonitor = {
      migrationId,
      status: 'running',
      progress: {
        currentPhase: '',
        currentTable: '',
        totalRecords: 0,
        processedRecords: 0,
        remainingRecords: 0,
        progressPercentage: 0,
        estimatedTimeRemaining: 0,
        recordsPerSecond: 0
      },
      performance: {
        cpuUsage: 0,
        memoryUsage: 0,
        diskIoReadMBps: 0,
        diskIoWriteMBps: 0,
        networkIoMBps: 0,
        databaseConnections: 0
      },
      errors: [],
      warnings: []
    };

    this.monitors.set(migrationId, monitor);
    this.startPeriodicMonitoring(migrationId);
  }

  async updateProgress(migrationId: string, update: Partial<MigrationProgress>): Promise<void> {
    const monitor = this.monitors.get(migrationId);
    if (!monitor) return;

    monitor.progress = { ...monitor.progress, ...update };
    monitor.progress.progressPercentage = 
      (monitor.progress.processedRecords / monitor.progress.totalRecords) * 100;

    // Calculate estimated time remaining
    if (monitor.progress.recordsPerSecond > 0) {
      monitor.progress.estimatedTimeRemaining = 
        monitor.progress.remainingRecords / monitor.progress.recordsPerSecond;
    }

    // Check for performance issues
    await this.checkPerformanceThresholds(monitor);
    
    // Emit progress event
    await this.emitProgressEvent(monitor);
  }

  private async checkPerformanceThresholds(monitor: MigrationMonitor): Promise<void> {
    // Check if migration is too slow
    if (monitor.progress.recordsPerSecond < 10) {
      await this.alertingService.sendAlert({
        type: 'performance_warning',
        migrationId: monitor.migrationId,
        message: `Migration performance is below threshold: ${monitor.progress.recordsPerSecond} records/sec`,
        severity: 'warning'
      });
    }

    // Check memory usage
    if (monitor.performance.memoryUsage > 0.8) {
      await this.alertingService.sendAlert({
        type: 'resource_warning',
        migrationId: monitor.migrationId,
        message: `High memory usage detected: ${(monitor.performance.memoryUsage * 100).toFixed(1)}%`,
        severity: 'warning'
      });
    }

    // Check for error rate
    const errorRate = monitor.errors.length / Math.max(monitor.progress.processedRecords, 1);
    if (errorRate > 0.05) { // 5% error rate threshold
      await this.alertingService.sendAlert({
        type: 'error_rate_warning',
        migrationId: monitor.migrationId,
        message: `High error rate detected: ${(errorRate * 100).toFixed(2)}%`,
        severity: 'critical'
      });
    }
  }
}

// Rollback Strategy
interface RollbackPlan {
  migrationId: string;
  tenantId: string;
  rollbackPoints: RollbackPoint[];
  rollbackStrategy: 'snapshot' | 'incremental' | 'script_based';
}

interface RollbackPoint {
  pointId: string;
  timestamp: Date;
  phase: string;
  snapshotLocation?: string;
  rollbackScript?: string;
  affectedTables: string[];
}

class MigrationRollbackService {
  async createRollbackPoint(
    migrationId: string, 
    tenantId: string, 
    phase: string
  ): Promise<RollbackPoint> {
    const pointId = uuidv4();
    const timestamp = new Date();
    
    // Create database snapshot
    const snapshotLocation = await this.createDatabaseSnapshot(tenantId, pointId);
    
    const rollbackPoint: RollbackPoint = {
      pointId,
      timestamp,
      phase,
      snapshotLocation,
      affectedTables: await this.getAffectedTables(phase)
    };

    await this.storeRollbackPoint(migrationId, rollbackPoint);
    
    return rollbackPoint;
  }

  async rollbackToPoint(
    migrationId: string, 
    pointId: string
  ): Promise<RollbackResult> {
    const rollbackPoint = await this.getRollbackPoint(migrationId, pointId);
    if (!rollbackPoint) {
      throw new Error(`Rollback point not found: ${pointId}`);
    }

    try {
      // Stop any ongoing migration processes
      await this.stopMigrationProcess(migrationId);

      // Restore from snapshot
      await this.restoreFromSnapshot(rollbackPoint.snapshotLocation!);

      // Clean up any orphaned data
      await this.cleanupOrphanedData(rollbackPoint.affectedTables);

      // Verify rollback success
      await this.verifyRollbackSuccess(migrationId, rollbackPoint);

      return {
        success: true,
        rolledBackToPoint: pointId,
        rolledBackToPhase: rollbackPoint.phase,
        timestamp: new Date()
      };

    } catch (error) {
      return {
        success: false,
        error: error.message,
        timestamp: new Date()
      };
    }
  }

  private async createDatabaseSnapshot(tenantId: string, pointId: string): Promise<string> {
    const databaseName = `eaudit_tenant_${tenantId}`;
    const snapshotName = `${databaseName}_snapshot_${pointId}`;
    
    // Create database backup/snapshot
    const backupCommand = `pg_dump ${databaseName} > /backups/${snapshotName}.sql`;
    await this.executeSystemCommand(backupCommand);
    
    return `/backups/${snapshotName}.sql`;
  }

  private async restoreFromSnapshot(snapshotLocation: string): Promise<void> {
    const restoreCommand = `psql -f ${snapshotLocation}`;
    await this.executeSystemCommand(restoreCommand);
  }
}
```

## Post-Migration Tasks

### Data Verification & Cleanup

```typescript
class PostMigrationService {
  async executePostMigrationTasks(tenantId: string): Promise<PostMigrationResult> {
    const tasks = [
      'verifyDataIntegrity',
      'optimizeDatabase',
      'setupAuditTriggers',
      'createInitialUsers',
      'configureRetentionPolicies',
      'generateMigrationReport'
    ];

    const results: TaskResult[] = [];

    for (const taskName of tasks) {
      try {
        const result = await this.executeTask(tenantId, taskName);
        results.push({
          task: taskName,
          success: true,
          duration: result.duration,
          details: result.details
        });
      } catch (error) {
        results.push({
          task: taskName,
          success: false,
          error: error.message
        });
      }
    }

    return {
      tenantId,
      completedAt: new Date(),
      tasks: results,
      overallSuccess: results.every(r => r.success)
    };
  }

  private async verifyDataIntegrity(tenantId: string): Promise<TaskResult> {
    const db = this.getTenantDatabase(tenantId);
    
    // Run comprehensive data integrity checks
    const checks = [
      'SELECT COUNT(*) as company_count FROM companies',
      'SELECT COUNT(*) as period_count FROM periods',
      'SELECT COUNT(*) as account_count FROM account_heads',
      'SELECT COUNT(*) as trial_balance_count FROM trial_balance',
      `SELECT 
         SUM(final_debit) - SUM(final_credit) as balance_difference 
       FROM trial_balance 
       GROUP BY company_id, period_id`,
      'SELECT COUNT(*) as orphaned_periods FROM periods p LEFT JOIN companies c ON p.company_id = c.company_id WHERE c.company_id IS NULL'
    ];

    const results = await Promise.all(
      checks.map(query => db.query(query))
    );

    return {
      success: true,
      details: {
        companies: results[0].rows[0].company_count,
        periods: results[1].rows[0].period_count,
        accounts: results[2].rows[0].account_count,
        trialBalanceEntries: results[3].rows[0].trial_balance_count,
        balanceIssues: results[4].rows.filter(r => Math.abs(r.balance_difference) > 0.01).length,
        orphanedRecords: results[5].rows[0].orphaned_periods
      },
      duration: 0
    };
  }

  private async setupAuditTriggers(tenantId: string): Promise<TaskResult> {
    const db = this.getTenantDatabase(tenantId);
    
    // Create audit trigger function
    await db.query(`
      CREATE OR REPLACE FUNCTION audit_trigger_function()
      RETURNS TRIGGER AS $$
      BEGIN
        IF TG_OP = 'INSERT' THEN
          INSERT INTO audit_logs (
            table_name, record_id, action, new_values, 
            user_id, timestamp
          ) VALUES (
            TG_TABLE_NAME, NEW.id::text, 'INSERT', 
            to_jsonb(NEW), current_setting('app.user_id', true)::integer, 
            NOW()
          );
          RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
          INSERT INTO audit_logs (
            table_name, record_id, action, old_values, new_values,
            user_id, timestamp
          ) VALUES (
            TG_TABLE_NAME, NEW.id::text, 'UPDATE',
            to_jsonb(OLD), to_jsonb(NEW),
            current_setting('app.user_id', true)::integer,
            NOW()
          );
          RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
          INSERT INTO audit_logs (
            table_name, record_id, action, old_values,
            user_id, timestamp
          ) VALUES (
            TG_TABLE_NAME, OLD.id::text, 'DELETE',
            to_jsonb(OLD),
            current_setting('app.user_id', true)::integer,
            NOW()
          );
          RETURN OLD;
        END IF;
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;
    `);

    // Create triggers for all auditable tables
    const auditableTables = [
      'companies', 'periods', 'account_heads', 'trial_balance',
      'journal_entries', 'procedures', 'documents', 'users'
    ];

    for (const table of auditableTables) {
      await db.query(`
        DROP TRIGGER IF EXISTS ${table}_audit_trigger ON ${table};
        CREATE TRIGGER ${table}_audit_trigger
          AFTER INSERT OR UPDATE OR DELETE ON ${table}
          FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();
      `);
    }

    return {
      success: true,
      details: { triggersCreated: auditableTables.length },
      duration: 0
    };
  }
}
```

This comprehensive migration strategy ensures a systematic, secure, and reliable transition from the legacy VB6 application to the modern multi-tenant web platform while maintaining data integrity and business continuity.