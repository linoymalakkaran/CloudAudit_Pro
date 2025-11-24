import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { ConfigService } from '@nestjs/config';
import { EmailService } from '../email/email.service';

export interface TenantApprovalDto {
  tenantId: string;
  status: 'APPROVED' | 'REJECTED';
  reviewNotes?: string;
}

export interface UserApprovalDto {
  requestId: string;
  status: 'APPROVED' | 'REJECTED';
  reviewNotes?: string;
}

@Injectable()
export class SuperAdminService {
  private readonly logger = new Logger(SuperAdminService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
    private readonly emailService: EmailService,
  ) {}

  async getDashboardStats() {
    try {
      const [
        totalTenants,
        pendingTenants,
        activeTenants,
        totalUsers,
        pendingUserRequests,
      ] = await Promise.all([
        this.prisma.tenant.count(),
        this.prisma.tenant.count({
          where: { status: 'PENDING' },
        }),
        this.prisma.tenant.count({
          where: { status: 'ACTIVE' },
        }),
        this.prisma.tenantUser.count(),
        this.prisma.userApprovalRequest.count({
          where: { status: 'PENDING' },
        }),
      ]);

      return {
        success: true,
        data: {
          tenants: {
            total: totalTenants,
            pending: pendingTenants,
            active: activeTenants,
          },
          users: {
            total: totalUsers,
            pendingRequests: pendingUserRequests,
          },
        },
      };
    } catch (error) {
      this.logger.error('Failed to get dashboard stats', error.stack);
      throw error;
    }
  }

  async getAllTenants() {
    try {
      const tenants = await this.prisma.tenant.findMany({
        select: {
          id: true,
          name: true,
          subdomain: true,
          status: true,
          createdAt: true,
          updatedAt: true,
          _count: {
            select: {
              users: true,
            },
          },
        },
        orderBy: { createdAt: 'desc' },
      });

      return {
        success: true,
        data: tenants,
      };
    } catch (error) {
      this.logger.error('Failed to get all tenants', error.stack);
      throw error;
    }
  }

  async getPendingTenants() {
    try {
      const pendingTenants = await this.prisma.tenant.findMany({
        where: { status: 'PENDING' },
        include: {
          approvalRequests: {
            where: { status: 'PENDING' },
            orderBy: { createdAt: 'desc' },
            take: 1,
          },
        },
        orderBy: { createdAt: 'asc' },
      });

      return {
        success: true,
        data: pendingTenants,
      };
    } catch (error) {
      this.logger.error('Failed to get pending tenants', error.stack);
      throw error;
    }
  }

  async approveTenant(approvalDto: TenantApprovalDto, reviewedBy: string) {
    try {
      const { tenantId, status, reviewNotes } = approvalDto;

      // Get tenant details for email notification
      const tenant = await this.prisma.tenant.findUnique({
        where: { id: tenantId },
        include: {
          users: {
            where: { role: 'ADMIN' },
            take: 1,
          },
        },
      });

      if (!tenant) {
        throw new NotFoundException('Tenant not found');
      }

      await this.prisma.$transaction(async (tx) => {
        await tx.tenant.update({
          where: { id: tenantId },
          data: {
            status: status === 'APPROVED' ? 'ACTIVE' : 'INACTIVE',
            updatedAt: new Date(),
          },
        });

        await tx.tenantApprovalRequest.updateMany({
          where: {
            tenantId,
            status: 'PENDING',
          },
          data: {
            status,
            reviewedBy,
            reviewNotes: reviewNotes || null,
            reviewedAt: new Date(),
          },
        });
      });

      // Send email notification to tenant admin
      if (tenant.users.length > 0) {
        const adminUser = tenant.users[0];
        try {
          await this.emailService.sendTenantApprovalNotification({
            to: adminUser.email,
            tenantName: tenant.name,
            adminName: `${adminUser.firstName} ${adminUser.lastName}`,
            status: status,
            reviewNotes: reviewNotes,
            loginUrl: `${this.configService.get('FRONTEND_URL')}/login`,
            supportEmail: this.configService.get('SUPPORT_EMAIL') || 'support@cloudauditpro.com',
          });
        } catch (emailError) {
          this.logger.warn('Failed to send tenant approval email', {
            tenantId,
            email: adminUser.email,
            error: emailError.message,
          });
        }
      }

      return {
        success: true,
        message: `Tenant ${status.toLowerCase()} successfully`,
      };
    } catch (error) {
      this.logger.error('Failed to approve tenant', error.stack);
      throw error;
    }
  }

  async getAllUserRequests() {
    try {
      const requests = await this.prisma.userApprovalRequest.findMany({
        include: {
          tenant: {
            select: {
              name: true,
            },
          },
          user: {
            select: {
              firstName: true,
              lastName: true,
              email: true,
            },
          },
        },
        orderBy: { createdAt: 'desc' },
      });

      return {
        success: true,
        data: requests,
      };
    } catch (error) {
      this.logger.error('Failed to get user requests', error.stack);
      throw error;
    }
  }

  async getPendingUserRequests() {
    try {
      const requests = await this.prisma.userApprovalRequest.findMany({
        where: { status: 'PENDING' },
        include: {
          tenant: {
            select: {
              name: true,
            },
          },
          user: {
            select: {
              firstName: true,
              lastName: true,
              email: true,
            },
          },
        },
        orderBy: { createdAt: 'asc' },
      });

      return {
        success: true,
        data: requests,
      };
    } catch (error) {
      this.logger.error('Failed to get pending user requests', error.stack);
      throw error;
    }
  }

  async processUserApproval(approvalDto: UserApprovalDto, reviewedBy: string) {
    try {
      const { requestId, status, reviewNotes } = approvalDto;

      const request = await this.prisma.userApprovalRequest.update({
        where: { id: requestId },
        data: {
          status,
          reviewedBy,
          reviewNotes: reviewNotes || null,
          reviewedAt: new Date(),
        },
        include: {
          user: true,
          tenant: {
            select: {
              name: true,
            },
          },
        },
      });

      if (status === 'APPROVED') {
        await this.prisma.tenantUser.update({
          where: { id: request.userId },
          data: {
            approvalStatus: 'APPROVED',
            approvedAt: new Date(),
            isActive: true,
          },
        });
      }

      // Send email notification to user
      try {
        await this.emailService.sendUserApprovalNotification({
          to: request.user.email,
          userName: `${request.user.firstName} ${request.user.lastName}`,
          tenantName: request.tenant.name,
          role: request.user.role,
          status: status,
          reviewNotes: reviewNotes,
          loginUrl: `${this.configService.get('FRONTEND_URL')}/login`,
          supportEmail: this.configService.get('SUPPORT_EMAIL') || 'support@cloudauditpro.com',
        });
      } catch (emailError) {
        this.logger.warn('Failed to send user approval email', {
          requestId,
          email: request.user.email,
          error: emailError.message,
        });
      }

      return {
        success: true,
        message: `User request ${status.toLowerCase()} successfully`,
      };
    } catch (error) {
      this.logger.error('Failed to process user approval', error.stack);
      throw error;
    }
  }

  async getSystemLogs(limit: number = 50) {
    try {
      const logs = await this.prisma.tenant.findMany({
        select: {
          id: true,
          name: true,
          status: true,
          createdAt: true,
          updatedAt: true,
        },
        orderBy: { updatedAt: 'desc' },
        take: limit,
      });

      return {
        success: true,
        data: logs,
      };
    } catch (error) {
      this.logger.error('Failed to get system logs', error.stack);
      throw error;
    }
  }
}
