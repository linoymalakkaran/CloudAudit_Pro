import { Injectable, NotFoundException, ForbiddenException, BadRequestException, Logger } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { ConfigService } from '@nestjs/config';
import { EmailService } from '../email/email.service';
import * as bcrypt from 'bcryptjs';
import * as crypto from 'crypto';
import { 
  InviteUserDto, 
  UpdateUserDto, 
  ApproveUserDto, 
  ResetPasswordDto, 
  BulkUserActionDto,
  UserRole,
  UserApprovalStatus 
} from './dto/user-management.dto';

@Injectable()
export class UserManagementService {
  private readonly logger = new Logger(UserManagementService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
    private readonly emailService: EmailService,
  ) {}

  async inviteUser(inviteData: InviteUserDto, tenantId: string, invitedBy: string) {
    try {
      // Check if user already exists in this tenant
      const existingUser = await this.prisma.tenantUser.findFirst({
        where: {
          email: inviteData.email,
          tenantId,
        },
      });

      if (existingUser) {
        throw new BadRequestException('User already exists in this organization');
      }

      // Generate temporary password
      const temporaryPassword = this.generateTemporaryPassword();
      const hashedPassword = await bcrypt.hash(temporaryPassword, 12);

      // Create user invitation
      const user = await this.prisma.tenantUser.create({
        data: {
          email: inviteData.email,
          passwordHash: hashedPassword,
          firstName: inviteData.firstName,
          lastName: inviteData.lastName,
          role: inviteData.role,
          jobTitle: inviteData.jobTitle,
          department: inviteData.department,
          phoneNumber: inviteData.phoneNumber,
          tenantId,
          invitedBy,
          approvalStatus: UserApprovalStatus.PENDING,
          requirePasswordChange: true,
          isActive: false,
          invitedAt: new Date(),
        },
        include: {
          tenant: {
            select: {
              name: true,
            },
          },
        },
      });

      // Create approval request for super admin
      await this.prisma.userApprovalRequest.create({
        data: {
          userId: user.id,
          tenantId,
          requestedBy: invitedBy,
          status: UserApprovalStatus.PENDING,
        },
      });

      // Send invitation email to user
      try {
        await this.emailService.sendWelcomeEmail({
          to: user.email,
          userName: `${user.firstName} ${user.lastName}`,
          tenantName: user.tenant.name,
          role: user.role,
          temporaryPassword,
          loginUrl: `${this.configService.get('FRONTEND_URL')}/login`,
          supportEmail: this.configService.get('SUPPORT_EMAIL') || 'support@cloudauditpro.com',
        });
      } catch (emailError) {
        this.logger.warn('Failed to send invitation email', {
          userId: user.id,
          email: user.email,
          error: emailError.message,
        });
      }

      return {
        success: true,
        message: 'User invitation sent successfully',
        data: {
          id: user.id,
          email: user.email,
          name: `${user.firstName} ${user.lastName}`,
          role: user.role,
          status: user.approvalStatus,
        },
      };
    } catch (error) {
      this.logger.error('Failed to invite user', error.stack);
      throw error;
    }
  }

  async getUsersByTenant(tenantId: string, includeInactive = false) {
    try {
      const users = await this.prisma.tenantUser.findMany({
        where: {
          tenantId,
          ...(includeInactive ? {} : { isActive: true }),
        },
        select: {
          id: true,
          email: true,
          firstName: true,
          lastName: true,
          role: true,
          jobTitle: true,
          department: true,
          phoneNumber: true,
          isActive: true,
          approvalStatus: true,
          lastLoginAt: true,
          createdAt: true,
          invitedAt: true,
          approvedAt: true,
          // Note: audit procedures count will be added when audit system is implemented
        },
        orderBy: { createdAt: 'desc' },
      });

      return {
        success: true,
        data: users,
        total: users.length,
      };
    } catch (error) {
      this.logger.error('Failed to get users by tenant', error.stack);
      throw error;
    }
  }

  async getPendingUsers(tenantId: string) {
    try {
      const pendingUsers = await this.prisma.tenantUser.findMany({
        where: {
          tenantId,
          approvalStatus: UserApprovalStatus.PENDING,
        },
        include: {
          approvalRequests: {
            orderBy: { createdAt: 'desc' },
            take: 1,
          },
        },
        orderBy: { invitedAt: 'desc' },
      });

      return {
        success: true,
        data: pendingUsers,
        total: pendingUsers.length,
      };
    } catch (error) {
      this.logger.error('Failed to get pending users', error.stack);
      throw error;
    }
  }

  async approveUser(userId: string, approvalData: ApproveUserDto, tenantId: string, approvedBy: string) {
    try {
      const user = await this.prisma.tenantUser.findFirst({
        where: { id: userId, tenantId },
        include: {
          tenant: { select: { name: true } },
        },
      });

      if (!user) {
        throw new NotFoundException('User not found');
      }

      await this.prisma.$transaction(async (tx) => {
        // Update user approval status
        await tx.tenantUser.update({
          where: { id: userId },
          data: {
            approvalStatus: approvalData.status,
            isActive: approvalData.status === UserApprovalStatus.APPROVED,
            approvedAt: approvalData.status === UserApprovalStatus.APPROVED ? new Date() : null,
            approvedBy: approvedBy,
          },
        });

        // Update approval request
        await tx.userApprovalRequest.updateMany({
          where: {
            userId,
            status: UserApprovalStatus.PENDING,
          },
          data: {
            status: approvalData.status,
            reviewedBy: approvedBy,
            reviewNotes: approvalData.reviewNotes,
            reviewedAt: new Date(),
          },
        });
      });

      // Send approval notification email
      try {
        await this.emailService.sendUserApprovalNotification({
          to: user.email,
          userName: `${user.firstName} ${user.lastName}`,
          tenantName: user.tenant.name,
          role: user.role,
          status: approvalData.status,
          reviewNotes: approvalData.reviewNotes,
          loginUrl: `${this.configService.get('FRONTEND_URL')}/login`,
          supportEmail: this.configService.get('SUPPORT_EMAIL') || 'support@cloudauditpro.com',
        });
      } catch (emailError) {
        this.logger.warn('Failed to send approval notification email', {
          userId,
          email: user.email,
          error: emailError.message,
        });
      }

      return {
        success: true,
        message: `User ${approvalData.status.toLowerCase()} successfully`,
      };
    } catch (error) {
      this.logger.error('Failed to approve user', error.stack);
      throw error;
    }
  }

  async updateUser(userId: string, updateData: UpdateUserDto, tenantId: string, updatedBy: string) {
    try {
      const user = await this.prisma.tenantUser.findFirst({
        where: { id: userId, tenantId },
      });

      if (!user) {
        throw new NotFoundException('User not found');
      }

      const updatedUser = await this.prisma.tenantUser.update({
        where: { id: userId },
        data: {
          ...updateData,
          updatedAt: new Date(),
        },
        select: {
          id: true,
          email: true,
          firstName: true,
          lastName: true,
          role: true,
          jobTitle: true,
          department: true,
          phoneNumber: true,
          isActive: true,
          updatedAt: true,
        },
      });

      return {
        success: true,
        message: 'User updated successfully',
        data: updatedUser,
      };
    } catch (error) {
      this.logger.error('Failed to update user', error.stack);
      throw error;
    }
  }

  async resetUserPassword(resetData: ResetPasswordDto, tenantId: string, resetBy: string) {
    try {
      const user = await this.prisma.tenantUser.findFirst({
        where: { id: resetData.userId, tenantId },
      });

      if (!user) {
        throw new NotFoundException('User not found');
      }

      const hashedPassword = await bcrypt.hash(resetData.temporaryPassword, 12);

      await this.prisma.tenantUser.update({
        where: { id: resetData.userId },
        data: {
          passwordHash: hashedPassword,
          requirePasswordChange: resetData.requirePasswordChange ?? true,
          passwordResetAt: new Date(),
          passwordResetBy: resetBy,
        },
      });

      return {
        success: true,
        message: 'Password reset successfully',
      };
    } catch (error) {
      this.logger.error('Failed to reset user password', error.stack);
      throw error;
    }
  }

  async bulkUserAction(actionData: BulkUserActionDto, tenantId: string, actionBy: string) {
    try {
      const actionResults = [];

      for (const userId of actionData.userIds) {
        try {
          let result;
          
          switch (actionData.action) {
            case 'activate':
              result = await this.prisma.tenantUser.update({
                where: { id: userId, tenantId },
                data: { isActive: true, updatedAt: new Date() },
                select: { id: true, email: true, firstName: true, lastName: true },
              });
              break;

            case 'deactivate':
              result = await this.prisma.tenantUser.update({
                where: { id: userId, tenantId },
                data: { isActive: false, updatedAt: new Date() },
                select: { id: true, email: true, firstName: true, lastName: true },
              });
              break;

            case 'delete':
              result = await this.prisma.tenantUser.update({
                where: { id: userId, tenantId },
                data: { 
                  isActive: false, 
                  isDeleted: true, 
                  deletedAt: new Date(),
                  deletedBy: actionBy,
                  updatedAt: new Date() 
                },
                select: { id: true, email: true, firstName: true, lastName: true },
              });
              break;

            default:
              throw new BadRequestException(`Invalid action: ${actionData.action}`);
          }

          actionResults.push({
            userId,
            status: 'success',
            user: result,
          });
        } catch (error) {
          actionResults.push({
            userId,
            status: 'failed',
            error: error.message,
          });
        }
      }

      const successCount = actionResults.filter(r => r.status === 'success').length;
      const failCount = actionResults.filter(r => r.status === 'failed').length;

      return {
        success: true,
        message: `Bulk action completed: ${successCount} successful, ${failCount} failed`,
        results: actionResults,
        summary: {
          total: actionData.userIds.length,
          successful: successCount,
          failed: failCount,
        },
      };
    } catch (error) {
      this.logger.error('Failed to perform bulk user action', error.stack);
      throw error;
    }
  }

  async getUserStats(tenantId: string) {
    try {
      const [
        totalUsers,
        activeUsers,
        pendingUsers,
        usersByRole,
        recentInvitations,
      ] = await Promise.all([
        this.prisma.tenantUser.count({
          where: { tenantId, isDeleted: { not: true } },
        }),
        this.prisma.tenantUser.count({
          where: { tenantId, isActive: true, isDeleted: { not: true } },
        }),
        this.prisma.tenantUser.count({
          where: { tenantId, approvalStatus: UserApprovalStatus.PENDING },
        }),
        this.prisma.tenantUser.groupBy({
          by: ['role'],
          where: { tenantId, isActive: true, isDeleted: { not: true } },
          _count: { role: true },
        }),
        this.prisma.tenantUser.count({
          where: {
            tenantId,
            invitedAt: {
              gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000), // Last 7 days
            },
          },
        }),
      ]);

      return {
        success: true,
        data: {
          overview: {
            total: totalUsers,
            active: activeUsers,
            inactive: totalUsers - activeUsers,
            pending: pendingUsers,
          },
          roleDistribution: usersByRole.reduce((acc, item) => {
            acc[item.role] = item._count.role;
            return acc;
          }, {} as Record<string, number>),
          recentActivity: {
            newInvitationsThisWeek: recentInvitations,
          },
        },
      };
    } catch (error) {
      this.logger.error('Failed to get user stats', error.stack);
      throw error;
    }
  }

  private generateTemporaryPassword(): string {
    const length = 12;
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*';
    let password = '';
    
    for (let i = 0; i < length; i++) {
      const randomIndex = crypto.randomInt(0, charset.length);
      password += charset[randomIndex];
    }
    
    return password;
  }
}