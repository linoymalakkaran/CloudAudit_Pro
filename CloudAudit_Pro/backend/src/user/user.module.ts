import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { UserManagementService } from './user-management.service';
import { UserManagementController } from './user-management.controller';
import { DatabaseModule } from '../database/database.module';
import { EmailModule } from '../email/email.module';

@Module({
  imports: [DatabaseModule, EmailModule],
  controllers: [UserController, UserManagementController],
  providers: [UserService, UserManagementService],
  exports: [UserService, UserManagementService],
})
export class UserModule {}