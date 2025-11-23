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
    const { email, password, firstName, lastName, tenantSubdomain } = registerDto;

    // Check if user already exists
    const existingUser = await this.prisma.user.findUnique({
      where: { email },
    });

    if (existingUser) {
      throw new BadRequestException('User with this email already exists');
    }

    // Hash password
    const saltRounds = 12;
    const passwordHash = await bcrypt.hash(password, saltRounds);

    let user: any;
    let tenantId: string | undefined;

    if (tenantSubdomain) {
      // Register as tenant user
      const tenant = await this.prisma.tenant.findUnique({
        where: { subdomain: tenantSubdomain },
      });

      if (!tenant) {
        throw new BadRequestException('Invalid tenant subdomain');
      }

      tenantId = tenant.id;

      user = await this.prisma.user.create({
        data: {
          email,
          passwordHash,
          firstName,
          lastName,
          role: 'AUDITOR', // Default role
          isActive: true,
        },
      });
    } else {
      // Register as system user (for tenant management)
      user = await this.prisma.tenantUser.create({
        data: {
          tenantId: '', // Will be set when creating tenant
          email,
          passwordHash,
          firstName,
          lastName,
          role: 'admin',
          isActive: true,
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
        tenantId,
      },
      ...tokens,
    };
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