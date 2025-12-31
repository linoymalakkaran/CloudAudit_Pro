# Demo Data for CloudAudit Pro

This folder contains demo data scripts for showcasing CloudAudit Pro to clients.

## Files

- **`seed-demo.ts`** - Main demo data seeding script
- **`demo-companies.ts`** - Sample company data
- **`demo-users.ts`** - Demo user accounts
- **`demo-audit-data.ts`** - Complete audit workflow data
- **`demo-financial-data.ts`** - Trial balance and financial statements
- **`cleanup-demo.ts`** - Script to remove demo data

## Usage

### Seed Demo Data
```bash
npm run db:seed:demo
```

### Cleanup Demo Data
```bash
npm run db:cleanup:demo
```

### Reset Demo Data (Clean + Seed)
```bash
npm run db:reset:demo
```

## Demo Data Includes

### 1. Tenant & Users
- **Demo Audit Firm** (tenant)
- 5 Users with different roles:
  - Admin (audit manager)
  - Senior Auditor
  - Staff Auditor
  - Client User
  - Reviewer

### 2. Companies (3 Sample Clients)
- **TechVenture Inc.** - Technology company
- **Global Manufacturing Ltd.** - Manufacturing company
- **Retail Solutions Corp.** - Retail company

### 3. Audit Periods
- FY2024 Annual Audits for all companies
- Q1-Q4 2024 Reviews

### 4. Complete Audit Workflow
- Chart of Accounts (50+ accounts)
- Trial Balance data
- 20+ Audit Procedures
- 15+ Workpapers
- 10+ Audit Findings
- 5+ Journal Entries
- Financial Statements

### 5. Documents
- Sample financial statements
- Audit evidence documents
- Client confirmations

### 6. Reports
- Audit summary reports
- Financial statement packages
- Management letters

## Demo Login Credentials

### Admin User
- **Email:** demo.admin@cloudauditpro.com
- **Password:** Demo@2024!

### Senior Auditor
- **Email:** demo.senior@cloudauditpro.com
- **Password:** Demo@2024!

### Staff Auditor
- **Email:** demo.staff@cloudauditpro.com
- **Password:** Demo@2024!

### Client User
- **Email:** demo.client@cloudauditpro.com
- **Password:** Demo@2024!

### Reviewer
- **Email:** demo.reviewer@cloudauditpro.com
- **Password:** Demo@2024!

## Notes

- All demo data is clearly marked with `[DEMO]` prefix
- Demo tenant subdomain: `demo-audit-firm`
- All monetary amounts are realistic but fictional
- Dates are set for fiscal year 2024

## Customization

You can modify the demo data by editing the individual data files in this folder.
