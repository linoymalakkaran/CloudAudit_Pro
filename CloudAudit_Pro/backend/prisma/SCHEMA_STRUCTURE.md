# CloudAudit Pro - Database Schema Structure

This document outlines the logical organization of our Prisma schema for better maintainability and understanding.

## Schema Sections

### 1. Configuration (Lines ~1-20)
- Prisma generator and datasource configuration
- Database connection setup

### 2. Multi-Tenant Management (Lines ~25-150)
- `Tenant` - Core tenant model for SaaS architecture
- `TenantUser` - Tenant-specific user accounts
- `Subscription` - Subscription management
- `UsageMetric` - Resource usage tracking

### 3. Core Business Models (Lines ~155-250)
- `Company` - Client companies being audited
- `Period` - Audit periods and fiscal years
- Core business entity relationships

### 4. Chart of Accounts & Financial Models (Lines ~255-450)
- `AccountType` - Asset, liability, equity, etc.
- `AccountHead` - Individual chart of accounts entries
- `TrialBalanceEntry` - Trial balance data
- `JournalEntry` - Journal entry header
- `JournalLineItem` - Journal entry line items

### 5. Audit Procedures & Workflow (Lines ~455-550)
- `ProcedureTemplate` - Reusable procedure templates
- `Procedure` - Individual audit procedures
- Workflow and assignment management

### 6. Document Management (Lines ~555-650)
- `Document` - File storage and metadata
- Document versioning and access control
- File classification and security

### 7. User Management & Security (Lines ~655-750)
- `User` - System users
- Authentication and authorization
- User preferences and session management

### 8. Data Import/Export & Jobs (Lines ~755-850)
- `ImportJob` - Data import background jobs
- `ExportJob` - Data export and reporting jobs
- Job status tracking and error handling

### 9. Reporting & Configuration (Lines ~855-950)
- `Report` - Generated reports
- `Configuration` - System and company settings
- `ImportTemplate` - Import mapping templates
- `AuditLog` - System audit trail

### 10. Enum Definitions (Lines ~955-end)
- All enumerated types used throughout the system
- Status values, categories, and classifications

## Schema Relationships Overview

### Core Entity Hierarchy
```
Tenant
├── Company
│   ├── Period
│   ├── AccountHead
│   ├── JournalEntry
│   ├── TrialBalanceEntry
│   ├── Document
│   └── Report
└── User
```

### Key Relationships
- **Tenant Isolation**: All major entities link to Tenant for multi-tenancy
- **Company Scoping**: Business data scoped to specific companies
- **Period Association**: Financial data linked to audit periods
- **Account Hierarchy**: Chart of accounts with parent/child relationships
- **Document Linking**: Documents can link to companies, periods, accounts, procedures

## Common Error Patterns Being Fixed

1. **String vs Relation Conflicts**: Services expecting strings but schema defines relations
2. **Missing Field Aliases**: Services using different field names than schema
3. **Enum Value Mismatches**: DTOs using different enum values than schema
4. **Required vs Optional Fields**: Mismatch between service expectations and schema requirements

## Maintenance Guidelines

1. **Adding New Models**: Place in appropriate logical section
2. **Field Changes**: Consider impact on existing services
3. **Relationship Changes**: Update all affected models and services
4. **Enum Additions**: Add to enum section, check DTO compatibility
5. **Breaking Changes**: Plan migration strategy for existing data

## Current Status
- ✅ Schema structure organized and documented  
- 🔄 Fixing 111 TypeScript compilation errors
- 📋 Need to address service-schema alignment issues
- 🎯 Target: Zero compilation errors for clean server startup