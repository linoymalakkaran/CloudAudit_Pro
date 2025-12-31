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
  Res,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { DataExportService } from './data-export.service';
import { CreateDataExportDto } from './dto/create-data-export.dto';
import { UpdateDataExportDto } from './dto/update-data-export.dto';
import { ExportType } from '@prisma/client';
import { Response } from 'express';

@ApiTags('data-export')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('data-export')
export class DataExportController {
  constructor(private readonly dataExportService: DataExportService) {}

  @Post()
  @ApiOperation({ summary: 'Create export' })
  create(@Req() req: any, @Body() createDto: CreateDataExportDto) {
    return this.dataExportService.create(req.user.id, req.user.tenantId, createDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all exports' })
  findAll(
    @Req() req: any,
    @Query('companyId') companyId?: string,
    @Query('exportType') exportType?: ExportType,
  ) {
    return this.dataExportService.findAll(req.user.tenantId, companyId, exportType);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get export summary' })
  getSummary(@Req() req: any, @Query('companyId') companyId?: string) {
    return this.dataExportService.getSummary(req.user.tenantId, companyId);
  }

  @Get('types')
  @ApiOperation({ summary: 'Get available export types' })
  getAvailableTypes() {
    return this.dataExportService.getAvailableTypes();
  }

  @Post('quick')
  @ApiOperation({ summary: 'Quick export (create and process)' })
  quickExport(@Req() req: any, @Body() createDto: CreateDataExportDto) {
    return this.dataExportService.quickExport(req.user.tenantId, req.user.id, createDto);
  }

  @Post('schedule')
  @ApiOperation({ summary: 'Schedule export' })
  scheduleExport(@Req() req: any, @Body() body: { export: CreateDataExportDto; schedule: any }) {
    return this.dataExportService.scheduleExport(
      req.user.tenantId,
      req.user.id,
      body.export,
      body.schedule,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get export by ID' })
  findOne(@Param('id') id: string, @Req() req: any) {
    return this.dataExportService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update export' })
  update(@Param('id') id: string, @Req() req: any, @Body() updateDto: UpdateDataExportDto) {
    return this.dataExportService.update(id, req.user.tenantId, updateDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete export' })
  remove(@Param('id') id: string, @Req() req: any) {
    return this.dataExportService.remove(id, req.user.tenantId);
  }

  @Post(':id/process')
  @ApiOperation({ summary: 'Process export' })
  processExport(@Param('id') id: string, @Req() req: any) {
    return this.dataExportService.processExport(id, req.user.tenantId);
  }

  @Get(':id/download')
  @ApiOperation({ summary: 'Download export file' })
  async downloadFile(@Param('id') id: string, @Req() req: any, @Res() res: Response) {
    const filePath = await this.dataExportService.downloadFile(id, req.user.tenantId);
    res.download(filePath);
  }
}
