# Database Seed & Test Cleanup Scripts

## Overview

This directory contains scripts for managing test data and database seeding for the CloudAudit Pro application.

## Available Scripts

### 1. Database Seeding

**Command:**
```bash
cd backend
npm run db:seed
```

**Description:** Seeds the database with essential data:
- Account Types (Asset, Liability, Equity, Revenue, Expense)

**Location:** `backend/prisma/seed.ts`

### 2. Test Data Cleanup

**Command:**
```bash
cd backend
npm run cleanup:test
```

**Description:** Removes all test data from the database including:
- Test tenants (matching patterns: `tenant*`, `*Test*`, `*test*`)
- Test users and tenant users (matching pattern: `*test*`)
- All related data (companies, periods, accounts, ledger entries, etc.)

**Location:** `backend/scripts/cleanup-test-data.ts`

### 3. Prepare for Testing

**Command:**
```bash
cd backend
npm run test:prepare
```

**Description:** Combines cleanup and seeding in one command:
1. Cleans up all test data
2. Re-seeds the database with fresh data

**Use Case:** Run before executing test suites to ensure a clean state

### 4. Cleanup and Test Single Module

**Command:**
```bash
bash scripts/cleanup-and-test.sh <module-number>
```

**Examples:**
```bash
bash scripts/cleanup-and-test.sh 13    # Test ledger module
bash scripts/cleanup-and-test.sh 1     # Test authentication module
```

**Description:** Automates the complete workflow:
1. Cleans up test data
2. Seeds the database
3. Runs the specified test module

### 5. Seed and Test All Modules

**Command:**
```bash
bash scripts/seed-and-test.sh [--clean] [--test]
```

**Options:**
- `--clean`: Clean up test data before seeding
- `--test`: Run all test modules after seeding

**Examples:**
```bash
# Just seed
bash scripts/seed-and-test.sh

# Clean and seed
bash scripts/seed-and-test.sh --clean

# Clean, seed, and test
bash scripts/seed-and-test.sh --clean --test
```

## Workflow Examples

### Running All Tests from Scratch

```bash
# Option 1: Using npm scripts
cd backend
npm run test:prepare
cd ../tests
bash test-suite.sh

# Option 2: Using shell scripts
bash scripts/seed-and-test.sh --clean --test
```

### Running Single Module

```bash
# Clean, seed, and test module 13 (Ledger)
bash scripts/cleanup-and-test.sh 13

# Or manually
cd backend
npm run test:prepare
cd ../tests
bash 13-ledger/ledger-tests.sh
```

### Daily Development Workflow

```bash
# 1. Make code changes
# 2. Clean and test
cd backend
npm run test:prepare
cd ../tests
bash <your-module>/tests.sh
```

## Important Notes

### Test Data Patterns

The cleanup script identifies test data by these patterns:
- **Tenants:** Subdomains containing `tenant` or names containing `Test`/`test`
- **Users:** Emails containing `test` or `Test`

Make sure production data doesn't match these patterns!

### Required Setup

Before running any scripts, ensure:

1. **Docker containers are running:**
   ```bash
   docker-compose up -d
   ```

2. **Database migrations are up to date:**
   ```bash
   cd backend
   npm run prisma:migrate:deploy
   ```

3. **Dependencies are installed:**
   ```bash
   cd backend
   npm install
   ```

### Account Types

The seed script creates these account types (required for account creation):

| ID | Name       | Code | Category     | Normal Balance |
|----|------------|------|--------------|----------------|
| 1  | Asset      | AST  | ASSETS       | DEBIT          |
| 2  | Liability  | LIA  | LIABILITIES  | CREDIT         |
| 3  | Equity     | EQT  | EQUITY       | CREDIT         |
| 4  | Revenue    | REV  | REVENUE      | CREDIT         |
| 5  | Expense    | EXP  | EXPENSES     | DEBIT          |

### Cleanup Safety

The cleanup script:
- ✅ Only deletes data matching test patterns
- ✅ Respects foreign key constraints (deletes in correct order)
- ✅ Uses transactions where applicable
- ⚠️ Does NOT delete account types (seed data)
- ⚠️ Cannot be undone - test data is permanently deleted

## Troubleshooting

### "Account types not found" error

**Solution:** Run the seed script:
```bash
cd backend
npm run db:seed
```

### "Foreign key constraint failed"

**Solution:** This usually means account types weren't seeded. Run:
```bash
cd backend
npm run test:prepare
```

### Tests still using old data

**Solution:** Explicitly clean before testing:
```bash
cd backend
npm run cleanup:test
npm run db:seed
```

## Package.json Scripts Reference

| Script | Command | Purpose |
|--------|---------|---------|
| `db:seed` | `ts-node prisma/seed.ts` | Seed database with essential data |
| `cleanup:test` | `ts-node scripts/cleanup-test-data.ts` | Remove all test data |
| `test:prepare` | `npm run cleanup:test && npm run db:seed` | Clean and seed in one command |

## File Locations

```
CloudAudit_Pro/
├── backend/
│   ├── prisma/
│   │   └── seed.ts                    # Database seeding script
│   ├── scripts/
│   │   └── cleanup-test-data.ts       # Test data cleanup script
│   └── package.json                   # npm scripts
└── scripts/
    ├── cleanup-and-test.sh            # Clean, seed, and test single module
    └── seed-and-test.sh               # Seed and optionally test all modules
```

## Contributing

When adding new seed data:
1. Add the seeding logic to `backend/prisma/seed.ts`
2. Use `upsert` to make seeds idempotent
3. Update this README with the new seed data

When adding new test data patterns:
1. Update `backend/scripts/cleanup-test-data.ts`
2. Follow the cascade deletion order
3. Update this README with the new patterns
