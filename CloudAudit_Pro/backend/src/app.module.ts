import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { AuthModule } from './auth/auth.module';
import { TenantModule } from './tenant/tenant.module';
import { CompanyModule } from './company/company.module';
import { UserModule } from './user/user.module';
import { PeriodModule } from './period/period.module';
import { AccountModule } from './account/account.module';
import { DocumentModule } from './document/document.module';
import { JournalEntryModule } from './journal-entry/journal-entry.module';
import { TrialBalanceModule } from './trial-balance/trial-balance.module';
import { FinancialStatementModule } from './financial-statement/financial-statement.module';
import { AuditProcedureModule } from './audit-procedure/audit-procedure.module';
import { ReportsModule } from './reports/reports.module';
import { DashboardModule } from './dashboard/dashboard.module';
import { SystemConfigModule } from './config/config.module';
import { ImportExportModule } from './import-export/import-export.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: ['.env.local', '.env'],
    }),
    DatabaseModule,
    AuthModule,
    TenantModule,
    CompanyModule,
    UserModule,
    PeriodModule,
    AccountModule,
    DocumentModule,
    JournalEntryModule,
    TrialBalanceModule,
    FinancialStatementModule,
    AuditProcedureModule,
    ReportsModule,
    DashboardModule,
    SystemConfigModule,
    ImportExportModule,
  ],
})
export class AppModule {}