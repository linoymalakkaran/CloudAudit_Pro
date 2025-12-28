import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../../database/prisma.service';

export interface JwtPayload {
  sub: string; // user ID
  email: string;
  tenantId: string;
  role: string;
  iat?: number;
  exp?: number;
}

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    private configService: ConfigService,
    private prisma: PrismaService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: configService.get<string>('JWT_ACCESS_SECRET'),
    });
  }

  async validate(payload: JwtPayload) {
    // Verify user still exists and is active in tenant_users table
    const tenantUser = await this.prisma.tenantUser.findUnique({
      where: { 
        id: payload.sub,
      },
      include: {
        tenant: {
          select: {
            id: true,
            name: true,
            subdomain: true,
            status: true,
          },
        },
      },
    });

    if (!tenantUser || !tenantUser.isActive || !tenantUser.tenant || tenantUser.tenant.status !== 'ACTIVE') {
      return null; // This will trigger 401 Unauthorized
    }

    // Return user object that will be available in request.user
    return {
      id: tenantUser.id,
      email: tenantUser.email,
      firstName: tenantUser.firstName,
      lastName: tenantUser.lastName,
      role: tenantUser.role,
      tenantId: tenantUser.tenantId,
      tenant: tenantUser.tenant,
    };
  }
}