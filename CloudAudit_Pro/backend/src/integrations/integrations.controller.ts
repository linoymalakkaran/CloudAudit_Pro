import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { IntegrationsService } from './integrations.service';
import { CreateIntegrationDto } from './dto/create-integration.dto';
import { UpdateIntegrationDto } from './dto/update-integration.dto';
import { IntegrationType } from '@prisma/client';

@ApiTags('integrations')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('integrations')
export class IntegrationsController {
  constructor(private readonly integrationsService: IntegrationsService) {}

  @Post()
  @ApiOperation({ summary: 'Create integration' })
  create(@Req() req: any, @Body() createDto: CreateIntegrationDto) {
    return this.integrationsService.create(req.user.userId, req.user.tenantId, createDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all integrations' })
  findAll(@Req() req: any, @Query('type') integrationType?: IntegrationType) {
    return this.integrationsService.findAll(req.user.tenantId, integrationType);
  }

  @Get('active')
  @ApiOperation({ summary: 'Get active integrations' })
  getActiveIntegrations(@Req() req: any) {
    return this.integrationsService.getActiveIntegrations(req.user.tenantId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get integration by ID' })
  findOne(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update integration' })
  update(@Param('id') id: string, @Req() req: any, @Body() updateDto: UpdateIntegrationDto) {
    return this.integrationsService.update(id, req.user.tenantId, req.user.userId, updateDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete integration' })
  remove(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.remove(id, req.user.tenantId);
  }

  @Post(':id/test')
  @ApiOperation({ summary: 'Test integration connection' })
  testConnection(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.testConnection(id, req.user.tenantId);
  }

  @Post(':id/sync')
  @ApiOperation({ summary: 'Sync integration' })
  sync(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.sync(id, req.user.tenantId);
  }

  @Post(':id/enable')
  @ApiOperation({ summary: 'Enable integration' })
  enable(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.enable(id, req.user.tenantId, req.user.userId);
  }

  @Post(':id/disable')
  @ApiOperation({ summary: 'Disable integration' })
  disable(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.disable(id, req.user.tenantId, req.user.userId);
  }

  @Get(':id/logs')
  @ApiOperation({ summary: 'Get integration logs' })
  getLogs(@Param('id') id: string, @Req() req: any, @Query('limit') limit?: number) {
    return this.integrationsService.getLogs(id, req.user.tenantId, limit);
  }

  @Get(':id/stats')
  @ApiOperation({ summary: 'Get integration statistics' })
  getStats(@Param('id') id: string, @Req() req: any) {
    return this.integrationsService.getIntegrationStats(id, req.user.tenantId);
  }
}
