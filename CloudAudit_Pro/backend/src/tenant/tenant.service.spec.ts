import { Test, TestingModule } from '@nestjs/testing';
import { TenantService } from './tenant.service';
import { PrismaService } from '../database/prisma.service';
import { ConfigService } from '@nestjs/config';

const mockPrismaService = {
  tenant: {
    findUnique: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
  },
  user: {
    count: jest.fn(),
  },
  company: {
    count: jest.fn(),
  },
};

const mockConfigService = {
  get: jest.fn(),
};

describe('TenantService', () => {
  let service: TenantService;
  let prismaService: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TenantService,
        { provide: PrismaService, useValue: mockPrismaService },
        { provide: ConfigService, useValue: mockConfigService },
      ],
    }).compile();

    service = module.get<TenantService>(TenantService);
    prismaService = module.get<PrismaService>(PrismaService);

    jest.clearAllMocks();
  });

  describe('createTenant', () => {
    it('should create a new tenant successfully', async () => {
      const tenantData = {
        name: 'Test Company',
        subdomain: 'test-company',
        primaryContactEmail: 'contact@test.com',
        primaryContactName: 'John Doe',
      };

      const mockTenant = {
        id: 'tenant-id',
        ...tenantData,
        status: 'ACTIVE',
        settings: expect.any(Object),
        contactInfo: expect.any(Object),
      };

      mockPrismaService.tenant.findUnique.mockResolvedValue(null);
      mockPrismaService.tenant.create.mockResolvedValue(mockTenant);

      const result = await service.createTenant(tenantData);

      expect(result).toEqual(mockTenant);
      expect(mockPrismaService.tenant.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          name: tenantData.name,
          subdomain: tenantData.subdomain,
          status: 'ACTIVE',
        }),
      });
    });

    it('should throw error if subdomain already exists', async () => {
      const tenantData = {
        name: 'Test Company',
        subdomain: 'test-company',
        primaryContactEmail: 'contact@test.com',
        primaryContactName: 'John Doe',
      };

      mockPrismaService.tenant.findUnique.mockResolvedValue({ id: 'existing-tenant' });

      await expect(service.createTenant(tenantData)).rejects.toThrow('Subdomain is already taken');
    });
  });

  describe('generateUniqueSubdomain', () => {
    it('should generate unique subdomain', async () => {
      const baseName = 'Test Company!@#';

      mockPrismaService.tenant.findUnique.mockResolvedValue(null);

      const result = await service.generateUniqueSubdomain(baseName);

      expect(result).toBe('test-company');
      expect(mockPrismaService.tenant.findUnique).toHaveBeenCalledWith({
        where: { subdomain: 'test-company' },
      });
    });

    it('should add counter if subdomain exists', async () => {
      const baseName = 'Test Company';

      mockPrismaService.tenant.findUnique
        .mockResolvedValueOnce({ id: 'existing' }) // First call returns existing
        .mockResolvedValueOnce(null); // Second call returns null

      const result = await service.generateUniqueSubdomain(baseName);

      expect(result).toBe('test-company-1');
    });
  });

  describe('getTenantStats', () => {
    it('should return tenant statistics', async () => {
      const tenantId = 'tenant-id';

      mockPrismaService.user.count
        .mockResolvedValueOnce(10) // Total users
        .mockResolvedValueOnce(5);  // Active users
      mockPrismaService.company.count.mockResolvedValue(2);

      const result = await service.getTenantStats(tenantId);

      expect(result).toEqual({
        totalUsers: 10,
        activeUsers: 5,
        totalCompanies: 2,
      });
    });
  });
});