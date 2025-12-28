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
import { CurrencyModule } from './currency/currency.module';
import { ExchangeRateModule } from './exchange-rate/exchange-rate.module';
import { BankModule } from './bank/bank.module';
import { CountryModule } from './country/country.module';
import { FixedAssetModule } from './fixed-asset/fixed-asset.module';
import { LiabilityModule } from './liability/liability.module';
import { EquityModule } from './equity/equity.module';
import { ReviewPointModule } from './review-point/review-point.module';
import { ManagerReviewModule } from './manager-review/manager-review.module';
import { AuditFinalizationModule } from './audit-finalization/audit-finalization.module';
import { SamplingModule } from './sampling/sampling.module';
import { SubstantiveTestingModule } from './substantive-testing/substantive-testing.module';
import { InternalControlsModule } from './internal-controls/internal-controls.module';

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
    UserModule,
    DocumentModule,
    AuditProcedureModule,
    WorkpaperModule,
    FindingModule,
    JournalEntryModule,
    TrialBalanceModule,
    FinancialStatementModule,
    ProcedureTemplateModule,
    ReportsModule,
    CurrencyModule,
    ExchangeRateModule,
    BankModule,
    CountryModule,
    FixedAssetModule,
    LiabilityModule,
    EquityModule,
    ReviewPointModule,
    ManagerReviewModule,
    AuditFinalizationModule,
    SamplingModule,
    SubstantiveTestingModule,
    InternalControlsModule,
    DashboardModule,
    SystemConfigModule,
    ImportExportModule,
    SuperAdminModule,
    EmailModule,
    LedgerModule,
  ],
})
export class AppModule {}