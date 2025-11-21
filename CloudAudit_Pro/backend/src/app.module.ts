import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { TenantModule } from './tenant/tenant.module';
import { CompaniesModule } from './companies/companies.module';
import { PeriodsModule } from './periods/periods.module';
import { AccountsModule } from './accounts/accounts.module';
import { ProceduresModule } from './procedures/procedures.module';
import { JournalEntriesModule } from './journal-entries/journal-entries.module';
import { DocumentsModule } from './documents/documents.module';
import { ReportsModule } from './reports/reports.module';
import { NotificationsModule } from './notifications/notifications.module';
import { DatabaseModule } from './database/database.module';
import { CommonModule } from './common/common.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: ['.env.local', '.env'],
    }),
    DatabaseModule,
    CommonModule,
    AuthModule,
    TenantModule,
    CompaniesModule,
    PeriodsModule,
    AccountsModule,
    ProceduresModule,
    JournalEntriesModule,
    DocumentsModule,
    ReportsModule,
    NotificationsModule,
  ],
})
export class AppModule {}