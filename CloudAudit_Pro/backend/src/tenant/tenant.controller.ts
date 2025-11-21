import { Controller, Get, Post, Body, Patch, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { TenantService } from './tenant.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('tenants')
@Controller('tenants')
export class TenantController {
  constructor(private readonly tenantService: TenantService) {}

  @Get('subdomain/:subdomain')
  @ApiOperation({ summary: 'Get tenant by subdomain' })
  @ApiResponse({ 
    status: 200, 
    description: 'Tenant found',
    schema: {
      type: 'object',
      properties: {
        id: { type: 'string' },
        name: { type: 'string' },
        subdomain: { type: 'string' },
        status: { type: 'string' },
        settings: { type: 'object' },
      },
    },
  })
  @ApiResponse({ status: 404, description: 'Tenant not found' })
  async getTenantBySubdomain(@Param('subdomain') subdomain: string) {
    return this.tenantService.getTenantBySubdomain(subdomain);
  }

  @Get(':id/stats')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get tenant statistics' })
  @ApiResponse({ 
    status: 200, 
    description: 'Tenant statistics retrieved',
    schema: {
      type: 'object',
      properties: {
        totalUsers: { type: 'number' },
        activeUsers: { type: 'number' },
        totalCompanies: { type: 'number' },
      },
    },
  })
  async getTenantStats(@Param('id') id: string) {
    return this.tenantService.getTenantStats(id);
  }

  @Patch(':id/settings')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update tenant settings' })
  @ApiResponse({ status: 200, description: 'Settings updated successfully' })
  @ApiResponse({ status: 404, description: 'Tenant not found' })
  async updateSettings(
    @Param('id') id: string,
    @Body() settings: any,
  ) {
    return this.tenantService.updateTenantSettings(id, settings);
  }

  @Post(':id/suspend')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Suspend tenant' })
  @ApiResponse({ status: 200, description: 'Tenant suspended successfully' })
  async suspend(@Param('id') id: string, @Body('reason') reason?: string) {
    return this.tenantService.suspendTenant(id, reason);
  }

  @Post(':id/activate')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Activate tenant' })
  @ApiResponse({ status: 200, description: 'Tenant activated successfully' })
  async activate(@Param('id') id: string) {
    return this.tenantService.activateTenant(id);
  }
}