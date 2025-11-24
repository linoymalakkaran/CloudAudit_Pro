import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../database/prisma.service';
import * as bcrypt from 'bcryptjs';
import { LoginDto, RegisterDto } from './dto';
import { User } from '@prisma/client';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  async validateUser(email: string, password: string, tenantId?: string): Promise<any> {
    let user: User | null = null;

    if (tenantId) {
      // For tenant-specific authentication
      user = await this.prisma.user.findUnique({
        where: { email },
      });
    } else {
      // For system-wide authentication (tenant users)
      const tenantUser = await this.prisma.tenantUser.findFirst({
        where: { email },
        include: { tenant: true },
      });
      
      if (tenantUser) {
        user = {
          id: tenantUser.id,
          email: tenantUser.email,
          passwordHash: tenantUser.passwordHash,
          firstName: tenantUser.firstName,
          lastName: tenantUser.lastName,
          role: tenantUser.role,
          isActive: tenantUser.isActive,
          createdAt: tenantUser.createdAt,
          updatedAt: tenantUser.createdAt,
        } as any;
        (user as any).tenantId = tenantUser.tenantId;
        (user as any).tenant = tenantUser.tenant;
      }
    }

    if (user && user.isActive && await bcrypt.compare(password, user.passwordHash)) {
      const { passwordHash, ...result } = user;
      return result;
    }
    
    return null;
  }

  async login(loginDto: LoginDto) {
    const { email, password, tenantSubdomain } = loginDto;
    
    let tenantId: string | undefined;
    let tenant: any = null;

    // Resolve tenant if subdomain provided
    if (tenantSubdomain) {
      tenant = await this.prisma.tenant.findUnique({
        where: { subdomain: tenantSubdomain },
      });

      if (!tenant) {
        throw new UnauthorizedException('Invalid tenant subdomain');
      }

      if (tenant.status !== 'ACTIVE') {
        throw new UnauthorizedException('Tenant account is not active');
      }

      tenantId = tenant.id;
    }

    const user = await this.validateUser(email, password, tenantId);
    
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Update last login
    if (tenantId) {
      await this.prisma.user.update({
        where: { id: user.id },
        data: { 
          lastLoginAt: new Date(),
          lastActivityAt: new Date(),
          loginAttempts: 0,
        },
      });
    } else {
      await this.prisma.tenantUser.update({
        where: { id: user.id },
        data: { 
          lastLoginAt: new Date(),
        },
      });
    }

    const tokens = await this.generateTokens(user, tenantId);

    return {
      user: {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        role: user.role,
        tenantId: tenantId || (user as any).tenantId,
      },
      tenant: tenant || (user as any).tenant,
      ...tokens,
    };
  }

  async register(registerDto: RegisterDto) {
    const { email, password, firstName, lastName, companyName, jobTitle, department } = registerDto;
    let { tenantSubdomain } = registerDto;

    try {
      // Check if user already exists in either users or tenant_users table
      const existingUser = await this.prisma.user.findUnique({
        where: { email },
      });

      const existingTenantUser = await this.prisma.tenantUser.findFirst({
        where: { email },
      });

      if (existingUser || existingTenantUser) {
        throw new BadRequestException('User with this email already exists');
      }

      // Hash password
      const saltRounds = 12;
      const passwordHash = await bcrypt.hash(password, saltRounds);

      // If tenantSubdomain is provided, clean it up (remove domain part if present)
      if (tenantSubdomain) {
        tenantSubdomain = tenantSubdomain.split('.')[0].toLowerCase();
      } else {
        // Generate subdomain from company name if not provided
        tenantSubdomain = companyName
          .toLowerCase()
          .replace(/[^a-z0-9]/g, '-')
          .replace(/-+/g, '-')
          .replace(/^-|-$/g, '')
          .substring(0, 30);
      }

      // Check if tenant subdomain already exists
      const existingTenant = await this.prisma.tenant.findUnique({
        where: { subdomain: tenantSubdomain },
      });

      if (existingTenant) {
        throw new BadRequestException('Tenant subdomain already exists. Please choose a different subdomain.');
      }

      // Start transaction to create tenant and tenant user in PENDING status
      const result = await this.prisma.$transaction(async (prisma) => {
        // Create tenant with PENDING status
        const tenant = await prisma.tenant.create({
          data: {
            name: companyName,
            subdomain: tenantSubdomain,
            databaseName: `tenant_${tenantSubdomain}`,
            subscriptionTier: 'trial',
            status: 'PENDING',
            approvalStatus: 'PENDING',
            trialEndsAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days trial
            billingEmail: email,
            contactInfo: {
              email,
              firstName,
              lastName,
            },
          },
        });

        // Create tenant user (organization owner) with PENDING status
        const tenantUser = await prisma.tenantUser.create({
          data: {
            tenantId: tenant.id,
            email,
            passwordHash,
            firstName,
            lastName,
            role: 'ADMIN', // Organization owner
            status: 'PENDING',
            approvalStatus: 'PENDING',
            isActive: false, // Will be activated upon approval
          },
        });

        // Create tenant approval request
        const approvalRequest = await prisma.tenantApprovalRequest.create({
          data: {
            tenantId: tenant.id,
            requestedBy: tenantUser.id,
            status: 'PENDING',
          },
        });

        return { tenant, tenantUser, approvalRequest };
      });

      const { tenant, tenantUser } = result;

      // Return pending status instead of tokens
      return {
        message: 'Registration submitted successfully. Your application is pending approval.',
        status: 'PENDING_APPROVAL',
        tenant: {
          id: tenant.id,
          name: tenant.name,
          subdomain: tenant.subdomain,
          status: tenant.status,
        },
        user: {
          id: tenantUser.id,
          email: tenantUser.email,
          firstName: tenantUser.firstName,
          lastName: tenantUser.lastName,
          status: tenantUser.status,
        },
        estimatedReviewTime: '24-48 hours',
      };
    } catch (error) {
      console.error('Registration error details:', error);
      
      if (error instanceof BadRequestException) {
        throw error;
      }
      
      // Log the full error for debugging
      console.error('Full error stack:', error.stack);
      
      throw new BadRequestException('Failed to create organization. Please try again.');
    }
  }

  async refreshToken(refreshToken: string) {
    try {
      const payload = this.jwtService.verify(refreshToken, {
        secret: this.configService.get<string>('JWT_REFRESH_SECRET'),
      });

      const user = await this.prisma.user.findUnique({
        where: { id: payload.sub },
      });

      if (!user || !user.isActive) {
        throw new UnauthorizedException('User not found or inactive');
      }

      return this.generateTokens(user, payload.tenantId);
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  private async generateTokens(user: any, tenantId?: string) {
    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
      tenantId,
      iat: Math.floor(Date.now() / 1000),
    };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload, {
        secret: this.configService.get<string>('JWT_SECRET'),
        expiresIn: this.configService.get<string>('JWT_EXPIRES_IN', '24h'),
      }),
      this.jwtService.signAsync(payload, {
        secret: this.configService.get<string>('JWT_REFRESH_SECRET'),
        expiresIn: this.configService.get<string>('JWT_REFRESH_EXPIRES_IN', '7d'),
      }),
    ]);

    return {
      accessToken,
      refreshToken,
      expiresIn: this.configService.get<string>('JWT_EXPIRES_IN', '24h'),
    };
  }

  async logout(userId: string) {
    // Update last activity
    await this.prisma.user.update({
      where: { id: userId },
      data: { lastActivityAt: new Date() },
    });

    return { message: 'Logged out successfully' };
  }

  async getUserProfile(userId: string, tenantId?: string) {
    let user: any;

    if (tenantId) {
      user = await this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          id: true,
          email: true,
          firstName: true,
          lastName: true,
          role: true,
          jobTitle: true,
          department: true,
          isActive: true,
          lastLoginAt: true,
          createdAt: true,
        },
      });
    } else {
      const tenantUser = await this.prisma.tenantUser.findUnique({
        where: { id: userId },
        include: { tenant: true },
        // select: similar fields
      });
      
      if (tenantUser) {
        user = {
          id: tenantUser.id,
          email: tenantUser.email,
          firstName: tenantUser.firstName,
          lastName: tenantUser.lastName,
          role: tenantUser.role,
          isActive: tenantUser.isActive,
          lastLoginAt: tenantUser.lastLoginAt,
          createdAt: tenantUser.createdAt,
          tenant: tenantUser.tenant,
        };
      }
    }

    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    return user;
  }
}