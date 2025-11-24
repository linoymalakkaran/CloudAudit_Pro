import { Injectable, UnauthorizedException, Logger } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../database/prisma.service';
import * as bcrypt from 'bcryptjs';

export interface SuperAdminLoginDto {
  email: string;
  password: string;
}

@Injectable()
export class SuperAdminAuthService {
  private readonly logger = new Logger(SuperAdminAuthService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  async login(loginDto: SuperAdminLoginDto) {
    const { email, password } = loginDto;
    
    try {
      const superAdmin = await this.prisma.superAdmin.findUnique({
        where: { email },
      });

      if (!superAdmin || !superAdmin.isActive) {
        throw new UnauthorizedException('Invalid credentials or account disabled');
      }

      const isPasswordValid = await bcrypt.compare(password, superAdmin.passwordHash);
      if (!isPasswordValid) {
        throw new UnauthorizedException('Invalid credentials');
      }

      await this.prisma.superAdmin.update({
        where: { id: superAdmin.id },
        data: { lastLoginAt: new Date() },
      });

      const token = await this.generateToken(superAdmin);

      return {
        user: {
          id: superAdmin.id,
          email: superAdmin.email,
          firstName: superAdmin.firstName,
          lastName: superAdmin.lastName,
          role: superAdmin.role,
        },
        accessToken: token,
        tokenType: 'Bearer',
      };
    } catch (error) {
      this.logger.error('Super admin login failed', error.stack);
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      throw new UnauthorizedException('Login failed');
    }
  }

  async validateToken(token: string) {
    try {
      const payload = this.jwtService.verify(token, {
        secret: this.configService.get<string>('JWT_SECRET'),
      });

      if (payload.role !== 'SUPER_ADMIN') {
        throw new UnauthorizedException('Invalid token scope');
      }

      const superAdmin = await this.prisma.superAdmin.findUnique({
        where: { id: payload.sub },
      });

      if (!superAdmin || !superAdmin.isActive) {
        throw new UnauthorizedException('User not found or inactive');
      }

      return {
        id: superAdmin.id,
        email: superAdmin.email,
        firstName: superAdmin.firstName,
        lastName: superAdmin.lastName,
        role: superAdmin.role,
      };
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
  }

  private async generateToken(superAdmin: any): Promise<string> {
    const payload = {
      sub: superAdmin.id,
      email: superAdmin.email,
      role: 'SUPER_ADMIN',
      scope: 'super-admin',
      iat: Math.floor(Date.now() / 1000),
    };

    return this.jwtService.signAsync(payload, {
      secret: this.configService.get<string>('JWT_SECRET'),
      expiresIn: this.configService.get<string>('JWT_EXPIRES_IN', '24h'),
    });
  }
}
