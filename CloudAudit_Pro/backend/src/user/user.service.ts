import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { User, UserRole } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

export interface CreateUserDto {
  email: string;
  password: string;
  firstName: string;
  lastName: string;
  role?: UserRole;
  tenantId: string;
  jobTitle?: string;
  department?: string;
}

export interface UpdateUserDto {
  firstName?: string;
  lastName?: string;
  jobTitle?: string;
  department?: string;
  isActive?: boolean;
}

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async createUser(data: CreateUserDto): Promise<User> {
    const hashedPassword = await bcrypt.hash(data.password, 12);

    return this.prisma.user.create({
      data: {
        email: data.email,
        password: hashedPassword,
        firstName: data.firstName,
        lastName: data.lastName,
        role: data.role || UserRole.USER,
        tenantId: data.tenantId,
        jobTitle: data.jobTitle,
        department: data.department,
        isActive: true,
      },
    });
  }

  async getUserById(id: string, tenantId: string): Promise<User> {
    const user = await this.prisma.user.findUnique({
      where: { 
        id,
        tenantId, // Ensure tenant isolation
      },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    return user;
  }

  async getUsersByTenant(tenantId: string): Promise<User[]> {
    return this.prisma.user.findMany({
      where: { 
        tenantId,
        isActive: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async updateUser(
    id: string, 
    tenantId: string, 
    data: UpdateUserDto,
    requestingUserId: string
  ): Promise<User> {
    // Check if user exists and belongs to tenant
    const user = await this.getUserById(id, tenantId);
    
    // Check permissions (users can only update themselves unless they're admin)
    const requestingUser = await this.getUserById(requestingUserId, tenantId);
    if (requestingUser.id !== id && requestingUser.role !== UserRole.ADMIN) {
      throw new ForbiddenException('Insufficient permissions to update this user');
    }

    return this.prisma.user.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date(),
      },
    });
  }

  async updateUserPassword(
    id: string, 
    tenantId: string, 
    currentPassword: string, 
    newPassword: string
  ): Promise<void> {
    const user = await this.getUserById(id, tenantId);
    
    // Verify current password
    const isValid = await bcrypt.compare(currentPassword, user.password);
    if (!isValid) {
      throw new ForbiddenException('Current password is incorrect');
    }

    // Hash new password
    const hashedNewPassword = await bcrypt.hash(newPassword, 12);

    await this.prisma.user.update({
      where: { id },
      data: { 
        password: hashedNewPassword,
        updatedAt: new Date(),
      },
    });
  }

  async deactivateUser(
    id: string, 
    tenantId: string, 
    requestingUserId: string
  ): Promise<User> {
    // Check permissions - only admins can deactivate users
    const requestingUser = await this.getUserById(requestingUserId, tenantId);
    if (requestingUser.role !== UserRole.ADMIN) {
      throw new ForbiddenException('Only administrators can deactivate users');
    }

    // Prevent deactivating the last admin
    if (requestingUser.id === id) {
      const adminCount = await this.prisma.user.count({
        where: { 
          tenantId,
          role: UserRole.ADMIN,
          isActive: true,
        },
      });

      if (adminCount <= 1) {
        throw new ForbiddenException('Cannot deactivate the last administrator');
      }
    }

    return this.prisma.user.update({
      where: { id },
      data: { 
        isActive: false,
        updatedAt: new Date(),
      },
    });
  }

  async getUserStats(tenantId: string) {
    const [totalUsers, activeUsers, usersByRole] = await Promise.all([
      this.prisma.user.count({
        where: { tenantId },
      }),
      this.prisma.user.count({
        where: { 
          tenantId,
          isActive: true,
        },
      }),
      this.prisma.user.groupBy({
        by: ['role'],
        where: { 
          tenantId,
          isActive: true,
        },
        _count: true,
      }),
    ]);

    return {
      totalUsers,
      activeUsers,
      usersByRole: usersByRole.reduce((acc, item) => {
        acc[item.role] = item._count;
        return acc;
      }, {} as Record<string, number>),
    };
  }

  async searchUsers(tenantId: string, query: string): Promise<User[]> {
    return this.prisma.user.findMany({
      where: {
        tenantId,
        isActive: true,
        OR: [
          { firstName: { contains: query, mode: 'insensitive' } },
          { lastName: { contains: query, mode: 'insensitive' } },
          { email: { contains: query, mode: 'insensitive' } },
          { jobTitle: { contains: query, mode: 'insensitive' } },
          { department: { contains: query, mode: 'insensitive' } },
        ],
      },
      orderBy: { lastName: 'asc' },
    });
  }
}