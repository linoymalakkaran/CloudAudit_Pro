import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { HealthModule } from './health/health.module';
import { AccountModule } from './account/account.module';
import { CompanyModule } from './company/company.module';
import { PeriodModule } from './period/period.module';
import { AuthModule } from './auth/auth.module';
import { TenantModule } from './tenant/tenant.module';
import { UserModule } from './user/user.module';
import { DocumentModule } from './document/document.module';
import { JournalEntryModule } from './journal-entry/journal-entry.module';
import { TrialBalanceModule } from './trial-balance/trial-balance.module';
import { FinancialStatementModule } from './financial-statement/financial-statement.module';
import { AuditProcedureModule } from './audit-procedure/audit-procedure.module';
import { WorkpaperModule } from './workpaper/workpaper.module';
import { FindingModule } from './finding/finding.module';
import { ProcedureTemplateModule } from './procedure-template/procedure-template.module';
import { ReportsModule } from './reports/reports.module';
import { DashboardModule } from './dashboard/dashboard.module';
import { SystemConfigModule } from './config/config.module';
import { ImportExportModule } from './import-export/import-export.module';
import { AuditTrailModule } from './audit-trail/audit-trail.module';
import { SuperAdminModule } from './super-admin/super-admin.module';
import { EmailModule } from './email/email.module';
import { LedgerModule } from './ledger/ledger.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: ['.env.local', '.env'],
    }),
    DatabaseModule,
    HealthModule,
    AccountModule,
    CompanyModule,
    PeriodModule,
    AuthModule,
    TenantModule,
    DocumentModule,
    AuditProcedureModule,
    WorkpaperModule,
    FindingModule,
    ProcedureTemplateModule,
    ReportsModule,
    SuperAdminModule,
    EmailModule,
    LedgerModule,
  ],
})
export class AppModule {}