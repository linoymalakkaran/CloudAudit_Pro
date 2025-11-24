import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule } from '@nestjs/config';
import { SuperAdminController } from './super-admin.controller';
import { SuperAdminService } from './super-admin.service';
import { SuperAdminAuthService } from './super-admin-auth.service';
import { SuperAdminGuard } from './super-admin.guard';
import { EmailModule } from '../email/email.module';

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET || 'your-jwt-secret',
      signOptions: { expiresIn: '24h' },
    }),
    ConfigModule,
    EmailModule,
  ],
  controllers: [SuperAdminController],
  providers: [SuperAdminService, SuperAdminAuthService, SuperAdminGuard],
  exports: [SuperAdminService, SuperAdminAuthService, SuperAdminGuard],
})
export class SuperAdminModule {}
