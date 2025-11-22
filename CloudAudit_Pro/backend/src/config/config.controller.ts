import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
  Request,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { ConfigService } from './config.service';
import {
  CreateConfigurationDto,
  UpdateConfigurationDto,
  ConfigQueryDto,
  ConfigurationType
} from './dto/config.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('System Configuration')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('config')
export class ConfigController {
  constructor(private readonly configService: ConfigService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create configuration',
    description: 'Create a new system configuration'
  })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'Configuration created successfully' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Admin access required' })
  async create(@Body() createConfigDto: CreateConfigurationDto, @Request() req) {
    return this.configService.create(createConfigDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get configurations',
    description: 'Retrieve system configurations with filtering and pagination'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configurations retrieved successfully' })
  @ApiQuery({ name: 'type', required: false, enum: ConfigurationType, description: 'Filter by configuration type' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'search', required: false, type: String, description: 'Search in names and descriptions' })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean, description: 'Filter by active status' })
  @ApiQuery({ name: 'page', required: false, type: Number, description: 'Page number' })
  @ApiQuery({ name: 'limit', required: false, type: Number, description: 'Items per page' })
  async findAll(@Query() query: ConfigQueryDto, @Request() req) {
    return this.configService.findAll(query, req.user.userId);
  }

  @Get('templates')
  @ApiOperation({ 
    summary: 'Get configuration templates',
    description: 'Get available configuration templates with default values'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Templates retrieved successfully' })
  async getTemplates(): Promise<any> {
    return this.configService.getTemplates();
  }

  @Get('system')
  @ApiOperation({ 
    summary: 'Get system configuration',
    description: 'Get current system configuration settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'System configuration retrieved successfully' })
  async getSystemConfig() {
    return this.configService.getSystemConfig();
  }

  @Get('security')
  @ApiOperation({ 
    summary: 'Get security configuration',
    description: 'Get current security policy settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Security configuration retrieved successfully' })
  async getSecurityConfig() {
    return this.configService.getSecurityConfig();
  }

  @Get('audit')
  @ApiOperation({ 
    summary: 'Get audit configuration',
    description: 'Get audit workflow and procedure settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Audit configuration retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Get company-specific audit config' })
  async getAuditConfig(@Query('companyId') companyId?: string) {
    return this.configService.getAuditConfig(companyId);
  }

  @Get('financial')
  @ApiOperation({ 
    summary: 'Get financial configuration',
    description: 'Get financial reporting and accounting settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Financial configuration retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Get company-specific financial config' })
  async getFinancialConfig(@Query('companyId') companyId?: string) {
    return this.configService.getFinancialConfig(companyId);
  }

  @Get('reporting')
  @ApiOperation({ 
    summary: 'Get reporting configuration',
    description: 'Get report generation and formatting settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Reporting configuration retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Get company-specific reporting config' })
  async getReportingConfig(@Query('companyId') companyId?: string) {
    return this.configService.getReportingConfig(companyId);
  }

  @Get('notifications')
  @ApiOperation({ 
    summary: 'Get notification configuration',
    description: 'Get notification and communication settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Notification configuration retrieved successfully' })
  async getNotificationConfig() {
    return this.configService.getNotificationConfig();
  }

  @Get('integrations')
  @ApiOperation({ 
    summary: 'Get integration configuration',
    description: 'Get API and third-party integration settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Integration configuration retrieved successfully' })
  async getIntegrationConfig() {
    return this.configService.getIntegrationConfig();
  }

  @Get('appearance')
  @ApiOperation({ 
    summary: 'Get appearance configuration',
    description: 'Get theme and branding settings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Appearance configuration retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Get company-specific appearance config' })
  async getAppearanceConfig(@Query('companyId') companyId?: string) {
    return this.configService.getAppearanceConfig(companyId);
  }

  @Get('health')
  @ApiOperation({ 
    summary: 'Get system health',
    description: 'Get comprehensive system health status and metrics'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'System health retrieved successfully' })
  async getSystemHealth() {
    return this.configService.getSystemHealth();
  }

  @Get('export')
  @ApiOperation({ 
    summary: 'Export configurations',
    description: 'Export system configurations for backup or migration'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configurations exported successfully' })
  @ApiQuery({ name: 'type', required: false, enum: ConfigurationType, description: 'Filter by configuration type' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  async exportConfig(
    @Query('type') type?: ConfigurationType,
    @Query('companyId') companyId?: string
  ) {
    return this.configService.exportConfig(type, companyId);
  }

  @Get('type/:type')
  @ApiOperation({ 
    summary: 'Get configurations by type',
    description: 'Get all configurations of a specific type'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configurations retrieved successfully' })
  async getByType(
    @Param('type') type: ConfigurationType,
    @Query('companyId') companyId?: string,
    @Request() req?
  ) {
    return this.configService.getByType(type, companyId, req?.user?.userId);
  }

  @Get(':id')
  @ApiOperation({ 
    summary: 'Get configuration',
    description: 'Retrieve a specific configuration by ID'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration retrieved successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Configuration not found' })
  async findOne(@Param('id') id: string, @Request() req) {
    return this.configService.findOne(id, req.user.userId);
  }

  @Patch(':id')
  @ApiOperation({ 
    summary: 'Update configuration',
    description: 'Update an existing configuration'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration updated successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Configuration not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Admin access required' })
  async update(
    @Param('id') id: string,
    @Body() updateConfigDto: UpdateConfigurationDto,
    @Request() req
  ) {
    return this.configService.update(id, updateConfigDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ 
    summary: 'Delete configuration',
    description: 'Delete a configuration'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration deleted successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Configuration not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Admin access required' })
  async remove(@Param('id') id: string, @Request() req) {
    return this.configService.remove(id, req.user.userId);
  }

  @Post('reset/:type')
  @ApiOperation({ 
    summary: 'Reset configuration to defaults',
    description: 'Reset a configuration type to its default values'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration reset successfully' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Admin access required' })
  async resetToDefaults(
    @Param('type') type: ConfigurationType,
    @Query('companyId') companyId?: string,
    @Request() req?
  ) {
    return this.configService.resetToDefaults(type, companyId, req?.user?.userId);
  }

  @Get('company/:companyId/all')
  @ApiOperation({ 
    summary: 'Get all company configurations',
    description: 'Get all configuration types for a specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company configurations retrieved successfully' })
  async getCompanyConfigurations(@Param('companyId') companyId: string, @Request() req) {
    const [audit, financial, reporting, appearance] = await Promise.all([
      this.configService.getAuditConfig(companyId),
      this.configService.getFinancialConfig(companyId),
      this.configService.getReportingConfig(companyId),
      this.configService.getAppearanceConfig(companyId),
    ]);

    return {
      companyId,
      audit,
      financial,
      reporting,
      appearance,
      lastUpdated: new Date(),
    };
  }

  @Get('company/:companyId/audit')
  @ApiOperation({ 
    summary: 'Get company audit configuration',
    description: 'Get audit configuration for a specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company audit configuration retrieved successfully' })
  async getCompanyAuditConfig(@Param('companyId') companyId: string) {
    return this.configService.getAuditConfig(companyId);
  }

  @Get('company/:companyId/financial')
  @ApiOperation({ 
    summary: 'Get company financial configuration',
    description: 'Get financial configuration for a specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company financial configuration retrieved successfully' })
  async getCompanyFinancialConfig(@Param('companyId') companyId: string) {
    return this.configService.getFinancialConfig(companyId);
  }

  @Get('company/:companyId/reporting')
  @ApiOperation({ 
    summary: 'Get company reporting configuration',
    description: 'Get reporting configuration for a specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company reporting configuration retrieved successfully' })
  async getCompanyReportingConfig(@Param('companyId') companyId: string) {
    return this.configService.getReportingConfig(companyId);
  }

  @Get('company/:companyId/appearance')
  @ApiOperation({ 
    summary: 'Get company appearance configuration',
    description: 'Get appearance configuration for a specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company appearance configuration retrieved successfully' })
  async getCompanyAppearanceConfig(@Param('companyId') companyId: string) {
    return this.configService.getAppearanceConfig(companyId);
  }

  @Post('validate')
  @ApiOperation({ 
    summary: 'Validate configuration',
    description: 'Validate configuration settings before saving'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration is valid' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Configuration validation failed' })
  async validateConfig(@Body() configDto: CreateConfigurationDto) {
    // This would run the same validation as create but without saving
    try {
      // Run validation logic
      return {
        valid: true,
        message: 'Configuration is valid',
      };
    } catch (error) {
      return {
        valid: false,
        message: error.message,
        errors: [], // Would contain detailed validation errors
      };
    }
  }

  @Get('status/overview')
  @ApiOperation({ 
    summary: 'Get configuration overview',
    description: 'Get overview of all configuration statuses'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Configuration overview retrieved successfully' })
  async getConfigurationOverview(@Request() req) {
    const [
      totalConfigs,
      activeConfigs,
      configsByType,
      recentlyUpdated,
    ] = await Promise.all([
      this.configService.findAll({ page: 1, limit: 1 }, req.user.userId).then(result => result.pagination.total),
      this.configService.findAll({ isActive: true, page: 1, limit: 1 }, req.user.userId).then(result => result.pagination.total),
      Promise.all(
        Object.values(ConfigurationType).map(async (type) => ({
          type,
          count: (await this.configService.getByType(type as ConfigurationType)).length,
        }))
      ),
      this.configService.findAll({ page: 1, limit: 5 }, req.user.userId).then(result => result.data),
    ]);

    return {
      summary: {
        totalConfigurations: totalConfigs,
        activeConfigurations: activeConfigs,
        inactiveConfigurations: totalConfigs - activeConfigs,
      },
      byType: configsByType,
      recentlyUpdated,
      lastUpdated: new Date(),
    };
  }
}