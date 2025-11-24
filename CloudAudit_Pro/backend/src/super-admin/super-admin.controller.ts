import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
  UseGuards,
  Request,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { SuperAdminAuthService, SuperAdminLoginDto } from './super-admin-auth.service';
import { SuperAdminService, TenantApprovalDto, UserApprovalDto } from './super-admin.service';
import { SuperAdminGuard } from './super-admin.guard';

@ApiTags('Super Admin')
@Controller('api/super-admin')
export class SuperAdminController {
  private readonly logger = new Logger(SuperAdminController.name);

  constructor(
    private readonly superAdminAuthService: SuperAdminAuthService,
    private readonly superAdminService: SuperAdminService,
  ) {}

  @Post('auth/login')
  @ApiOperation({ summary: 'Super admin login' })
  @ApiResponse({ status: 200, description: 'Login successful' })
  @ApiResponse({ status: 401, description: 'Invalid credentials' })
  async login(@Body() loginDto: SuperAdminLoginDto) {
    try {
      return await this.superAdminAuthService.login(loginDto);
    } catch (error) {
      this.logger.error('Super admin login failed', error.stack);
      throw new HttpException(
        'Login failed',
        HttpStatus.UNAUTHORIZED,
      );
    }
  }

  @Get('dashboard')
  @UseGuards(SuperAdminGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get dashboard statistics' })
  @ApiResponse({ status: 200, description: 'Dashboard data retrieved successfully' })
  async getDashboard() {
    try {
      return await this.superAdminService.getDashboardStats();
    } catch (error) {
      this.logger.error('Failed to fetch dashboard data', error.stack);
      throw new HttpException(
        'Failed to fetch dashboard data',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Get('tenants')
  @UseGuards(SuperAdminGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get all tenants' })
  @ApiResponse({ status: 200, description: 'Tenants retrieved successfully' })
  async getAllTenants(@Query('status') status?: 'pending' | 'all') {
    try {
      if (status === 'pending') {
        return await this.superAdminService.getPendingTenants();
      }
      return await this.superAdminService.getAllTenants();
    } catch (error) {
      this.logger.error('Failed to fetch tenants', error.stack);
      throw new HttpException(
        'Failed to fetch tenants',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Patch('tenants/:tenantId/approve')
  @UseGuards(SuperAdminGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Approve or reject tenant' })
  @ApiResponse({ status: 200, description: 'Tenant approval processed successfully' })
  async approveTenant(
    @Param('tenantId') tenantId: string,
    @Body() approvalDto: Omit<TenantApprovalDto, 'tenantId'>,
    @Request() req,
  ) {
    try {
      const fullApprovalDto: TenantApprovalDto = {
        tenantId,
        ...approvalDto,
      };
      
      return await this.superAdminService.approveTenant(
        fullApprovalDto,
        req.user.id,
      );
    } catch (error) {
      this.logger.error('Failed to process tenant approval', error.stack);
      throw new HttpException(
        'Failed to process tenant approval',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
