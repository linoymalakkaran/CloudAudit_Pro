# CloudAudit Pro - Quick Demo Setup Guide

This guide helps you quickly set up demo data for client presentations.

## 🚀 Quick Start (3 minutes)

### 1. Prerequisites
Make sure your database is running:
```bash
docker-compose up -d postgres
```

### 2. Seed Demo Data
```bash
cd backend
npm run db:seed:demo
```

This creates:
- ✅ Demo tenant: "Global Audit Partners LLP"
- ✅ 5 demo users with different roles
- ✅ 3 sample companies
- ✅ Complete audit workflow data
- ✅ Financial statements with trial balance
- ✅ Audit procedures and findings

### 3. Login to Demo
```
URL: http://localhost:3000
Subdomain: demo-audit-firm
Email: demo.admin@cloudauditpro.com
Password: Demo@2024!
```

## 👥 Demo User Accounts

| Role | Email | Password | Name |
|------|-------|----------|------|
| Admin | demo.admin@cloudauditpro.com | Demo@2024! | Sarah Anderson |
| Senior Auditor | demo.senior@cloudauditpro.com | Demo@2024! | Michael Chen |
| Staff Auditor | demo.staff@cloudauditpro.com | Demo@2024! | Emily Rodriguez |
| Client User | demo.client@cloudauditpro.com | Demo@2024! | David Thompson |
| Reviewer | demo.reviewer@cloudauditpro.com | Demo@2024! | Jessica Martinez |

## 🏢 Demo Companies

1. **TechVenture Inc.** (Technology)
   - Code: TECHV
   - FY2024 Annual Audit
   - Complete trial balance
   - Multiple audit procedures

2. **Global Manufacturing Ltd.** (Manufacturing)
   - Code: GLOBM
   - FY2024 Annual Audit

3. **Retail Solutions Corp.** (Retail)
   - Code: RETAIL
   - FY2024 Annual Audit

## 📊 What's Included

### Financial Data
- Chart of Accounts (15 main accounts)
- Trial Balance entries totaling $2.7M in assets
- Revenue: $1.55M
- Expenses: $1.35M
- Net Income: $200K

### Audit Work
- 4 Audit Procedures
- 2 Findings (1 open, 1 resolved)
- Complete audit workflow demonstration

## 🧹 Cleanup Demo Data

When you're done with the demo:
```bash
npm run db:cleanup:demo
```

## 🔄 Reset Demo Data

To start fresh:
```bash
npm run db:reset:demo
```

This will:
1. Remove all demo data
2. Re-seed fresh demo data

## 🎯 Demo Scenarios

### Scenario 1: Complete Audit Workflow
1. Login as Senior Auditor (demo.senior@cloudauditpro.com)
2. Navigate to TechVenture Inc.
3. Review FY2024 audit period
4. Check audit procedures (some completed, some in progress)
5. Review findings and recommendations

### Scenario 2: Client Portal
1. Login as Client User (demo.client@cloudauditpro.com)
2. View assigned companies
3. Upload requested documents
4. Review audit findings
5. Track audit progress

### Scenario 3: Quality Review
1. Login as Reviewer (demo.reviewer@cloudauditpro.com)
2. Review completed audit work
3. Check for compliance
4. Approve or request changes

## 📝 Customization

All demo data files are in `backend/prisma/demo-data/`:
- `seed-demo.ts` - Main seeding script
- `cleanup-demo.ts` - Cleanup script
- `README.md` - Full documentation

Edit these files to customize demo data for specific client presentations.

## ⚠️ Important Notes

- All demo data is prefixed with `[DEMO]` for easy identification
- Demo tenant subdomain: `demo-audit-firm`
- Demo data is separate from test data
- Safe to run in development environments
- **DO NOT run in production!**

## 🔍 Troubleshooting

### Error: "Tenant already exists"
The demo has already been seeded. Run cleanup first:
```bash
npm run db:cleanup:demo
npm run db:seed:demo
```

### Error: "Database not found"
Make sure PostgreSQL is running:
```bash
docker-compose up -d postgres
npm run prisma:migrate:dev
npm run db:seed:demo
```

### Error: "Cannot find module"
Install dependencies:
```bash
npm install
npm run db:seed:demo
```

## 💡 Tips

1. **Before client demos**: Always reset demo data for a clean slate
2. **Customize dates**: Edit `seed-demo.ts` to use current dates
3. **Add more data**: Extend the seed file with additional scenarios
4. **Export demo**: Use Prisma Studio to export specific demo records

## 🆘 Support

For questions about demo setup, contact the development team or refer to the main documentation in `docs/`.
