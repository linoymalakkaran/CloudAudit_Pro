import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { AuthModule } from './auth/auth.module';
import { TenantModule } from './tenant/tenant.module';
import { CompanyModule } from './company/company.module';
import { UserModule } from './user/user.module';
import { PeriodModule } from './period/period.module';
import { AccountModule } from './account/account.module';

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
  ],
})
export class AppModule {}