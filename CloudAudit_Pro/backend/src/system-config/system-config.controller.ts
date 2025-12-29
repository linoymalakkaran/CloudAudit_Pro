import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiResponse, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { SystemConfigService } from './system-config.service';
import { CreateConfigDto } from './dto/create-config.dto';
import { UpdateConfigDto } from './dto/update-config.dto';
import { ConfigCategory } from '@prisma/client';

@ApiTags('system-config')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('system-config')
export class SystemConfigController {
  constructor(private readonly systemConfigService: SystemConfigService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new system configuration' })
  @ApiResponse({ status: 201, description: 'Configuration created successfully' })
  @ApiResponse({ status: 400, description: 'Configuration key already exists' })
  create(@Request() req, @Body() createConfigDto: CreateConfigDto) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.systemConfigService.create(tenantId, userId, createConfigDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all system configurations' })
  @ApiQuery({ name: 'category', enum: ConfigCategory, required: false })
  @ApiResponse({ status: 200, description: 'Returns all configurations' })
  findAll(@Request() req, @Query('category') category?: ConfigCategory) {
    const tenantId = req.user.tenantId;
    return this.systemConfigService.findAll(tenantId, category);
  }

  @Get('category/:category')
  @ApiOperation({ summary: 'Get configurations by category' })
  @ApiResponse({ status: 200, description: 'Returns configurations for the category' })
  findByCategory(@Request() req, @Param('category') category: ConfigCategory) {
    const tenantId = req.user.tenantId;
    return this.systemConfigService.findByCategory(tenantId, category);
  }

  @Get('export')
  @ApiOperation({ summary: 'Export all configurations' })
  @ApiResponse({ status: 200, description: 'Returns all configurations for export' })
  exportConfigs(@Request() req) {
    const tenantId = req.user.tenantId;
    return this.systemConfigService.exportConfigs(tenantId);
  }

  @Post('import')
  @ApiOperation({ summary: 'Import configurations' })
  @ApiResponse({ status: 201, description: 'Configurations imported successfully' })
  importConfigs(@Request() req, @Body() configs: CreateConfigDto[]) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.systemConfigService.importConfigs(tenantId, userId, configs);
  }

  @Post('bulk-update')
  @ApiOperation({ summary: 'Bulk update configurations' })
  @ApiResponse({ status: 200, description: 'Configurations updated successfully' })
  bulkUpdate(@Request() req, @Body() configs: UpdateConfigDto[]) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.systemConfigService.bulkUpdate(tenantId, userId, configs);
  }

  @Post('reset')
  @ApiOperation({ summary: 'Reset configurations to defaults' })
  @ApiResponse({ status: 200, description: 'Configurations reset successfully' })
  resetToDefaults(@Request() req) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.systemConfigService.resetToDefaults(tenantId, userId);
  }

  @Get(':key')
  @ApiOperation({ summary: 'Get configuration by key' })
  @ApiResponse({ status: 200, description: 'Returns the configuration' })
  @ApiResponse({ status: 404, description: 'Configuration not found' })
  findOne(@Param('key') key: string) {
    return this.systemConfigService.findOne(key);
  }

  @Patch(':key')
  @ApiOperation({ summary: 'Update a configuration' })
  @ApiResponse({ status: 200, description: 'Configuration updated successfully' })
  @ApiResponse({ status: 404, description: 'Configuration not found' })
  update(
    @Request() req,
    @Param('key') key: string,
    @Body() updateConfigDto: UpdateConfigDto,
  ) {
    const userId = req.user.userId;
    return this.systemConfigService.update(key, userId, updateConfigDto);
  }

  @Delete(':key')
  @ApiOperation({ summary: 'Delete a configuration' })
  @ApiResponse({ status: 200, description: 'Configuration deleted successfully' })
  @ApiResponse({ status: 404, description: 'Configuration not found' })
  remove(@Param('key') key: string) {
    return this.systemConfigService.remove(key);
  }
}
