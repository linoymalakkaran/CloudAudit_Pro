import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../database/prisma.service';
import { TenantService } from '../tenant/tenant.service';
import { ConflictException, UnauthorizedException } from '@nestjs/common';
import * as bcryptjs from 'bcryptjs';

// Mock implementations
const mockPrismaService = {
  user: {
    findUnique: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
  },
  tenant: {
    findUnique: jest.fn(),
    create: jest.fn(),
  },
  company: {
    create: jest.fn(),
  },
  $transaction: jest.fn(),
};

const mockJwtService = {
  signAsync: jest.fn(),
  verifyAsync: jest.fn(),
};

const mockConfigService = {
  get: jest.fn(),
};

const mockTenantService = {
  createTenant: jest.fn(),
  getTenantBySubdomain: jest.fn(),
  generateUniqueSubdomain: jest.fn(),
};

describe('AuthService', () => {
  let service: AuthService;
  let prismaService: PrismaService;
  let jwtService: JwtService;
  let tenantService: TenantService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: PrismaService, useValue: mockPrismaService },
        { provide: JwtService, useValue: mockJwtService },
        { provide: ConfigService, useValue: mockConfigService },
        { provide: TenantService, useValue: mockTenantService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    prismaService = module.get<PrismaService>(PrismaService);
    jwtService = module.get<JwtService>(JwtService);
    tenantService = module.get<TenantService>(TenantService);

    // Reset all mocks
    jest.clearAllMocks();

    // Default config service responses
    mockConfigService.get.mockImplementation((key: string) => {
      const config = {
        JWT_ACCESS_SECRET: 'test-access-secret',
        JWT_REFRESH_SECRET: 'test-refresh-secret',
        JWT_ACCESS_EXPIRES_IN: '15m',
        JWT_REFRESH_EXPIRES_IN: '7d',
      };
      return config[key];
    });
  });

  describe('register', () => {
    it('should successfully register a new user and create tenant', async () => {
      const registerDto = {
        email: 'test@example.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
        companyName: 'Test Company',
      };

      const mockTenant = {
        id: 'tenant-id',
        name: 'Test Company',
        subdomain: 'test-company',
        status: 'ACTIVE',
      };

      const mockUser = {
        id: 'user-id',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        role: 'ADMIN',
        tenantId: 'tenant-id',
      };

      // Mock implementations
      mockPrismaService.user.findUnique.mockResolvedValue(null); // User doesn't exist
      mockTenantService.generateUniqueSubdomain.mockResolvedValue('test-company');
      mockTenantService.createTenant.mockResolvedValue(mockTenant);
      mockPrismaService.$transaction.mockImplementation(async (callback) => {
        return callback(mockPrismaService);
      });
      mockPrismaService.user.create.mockResolvedValue(mockUser);
      mockJwtService.signAsync.mockResolvedValue('mock-token');

      const result = await service.register(registerDto);

      expect(result).toHaveProperty('user');
      expect(result).toHaveProperty('accessToken');
      expect(result).toHaveProperty('refreshToken');
      expect(mockTenantService.createTenant).toHaveBeenCalled();
      expect(mockPrismaService.user.create).toHaveBeenCalled();
    });

    it('should throw ConflictException if user already exists', async () => {
      const registerDto = {
        email: 'test@example.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
        companyName: 'Test Company',
      };

      mockPrismaService.user.findUnique.mockResolvedValue({ id: 'existing-user' });

      await expect(service.register(registerDto)).rejects.toThrow(ConflictException);
    });
  });

  describe('login', () => {
    it('should successfully login with valid credentials', async () => {
      const loginDto = {
        email: 'test@example.com',
        password: 'password123',
      };

      const hashedPassword = await bcryptjs.hash('password123', 10);
      const mockUser = {
        id: 'user-id',
        email: 'test@example.com',
        password: hashedPassword,
        firstName: 'John',
        lastName: 'Doe',
        role: 'ADMIN',
        tenantId: 'tenant-id',
        isActive: true,
        tenant: {
          id: 'tenant-id',
          name: 'Test Company',
          subdomain: 'test-company',
        },
      };

      mockPrismaService.user.findUnique.mockResolvedValue(mockUser);
      mockJwtService.signAsync.mockResolvedValue('mock-token');
      mockPrismaService.user.update.mockResolvedValue(mockUser);

      const result = await service.login(loginDto);

      expect(result).toHaveProperty('user');
      expect(result).toHaveProperty('tenant');
      expect(result).toHaveProperty('accessToken');
      expect(result).toHaveProperty('refreshToken');
    });

    it('should throw UnauthorizedException with invalid credentials', async () => {
      const loginDto = {
        email: 'test@example.com',
        password: 'wrongpassword',
      };

      mockPrismaService.user.findUnique.mockResolvedValue(null);

      await expect(service.login(loginDto)).rejects.toThrow(UnauthorizedException);
    });
  });

  describe('generateTokens', () => {
    it('should generate access and refresh tokens', async () => {
      const userId = 'user-id';
      const tenantId = 'tenant-id';
      const user = {
        id: userId,
        email: 'test@example.com',
        role: 'ADMIN'
      };

      mockJwtService.signAsync
        .mockResolvedValueOnce('access-token')
        .mockResolvedValueOnce('refresh-token');

      // Using reflection to test private method
      const result = await (service as any).generateTokens(user, tenantId);

      expect(result).toHaveProperty('accessToken', 'access-token');
      expect(result).toHaveProperty('refreshToken', 'refresh-token');
      expect(result).toHaveProperty('expiresIn', '15m');
    });
  });
});