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
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ReportTemplatesService } from './report-templates.service';
import { CreateTemplateDto } from './dto/create-template.dto';
import { UpdateTemplateDto } from './dto/update-template.dto';
import { ReportType } from '@prisma/client';

@ApiTags('report-templates')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('report-templates')
export class ReportTemplatesController {
  constructor(private readonly reportTemplatesService: ReportTemplatesService) {}

  @Post()
  @ApiOperation({ summary: 'Create report template' })
  create(@Body() createTemplateDto: CreateTemplateDto, @Request() req) {
    return this.reportTemplatesService.create(
      createTemplateDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all templates' })
  @ApiQuery({ name: 'reportType', required: false, enum: ReportType })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean })
  findAll(
    @Request() req,
    @Query('reportType') reportType?: ReportType,
    @Query('isActive') isActive?: string,
  ) {
    return this.reportTemplatesService.findAll(
      req.user.tenantId,
      reportType,
      isActive === 'true' ? true : isActive === 'false' ? false : undefined,
    );
  }

  @Get('standard')
  @ApiOperation({ summary: 'Get standard templates' })
  getStandard(@Request() req) {
    return this.reportTemplatesService.getStandard(req.user.tenantId);
  }

  @Get('by-type/:type')
  @ApiOperation({ summary: 'Get templates by report type' })
  findByType(@Request() req, @Param('type') type: ReportType) {
    return this.reportTemplatesService.findByType(req.user.tenantId, type);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get template by ID' })
  findOne(@Param('id') id: string, @Request() req) {
    return this.reportTemplatesService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update template' })
  update(
    @Param('id') id: string,
    @Body() updateTemplateDto: UpdateTemplateDto,
    @Request() req,
  ) {
    return this.reportTemplatesService.update(
      id,
      updateTemplateDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete template' })
  remove(@Param('id') id: string, @Request() req) {
    return this.reportTemplatesService.remove(id, req.user.tenantId);
  }

  @Post(':id/duplicate')
  @ApiOperation({ summary: 'Duplicate template' })
  duplicate(@Param('id') id: string, @Request() req) {
    return this.reportTemplatesService.duplicate(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/toggle-active')
  @ApiOperation({ summary: 'Toggle template active status' })
  toggleActive(@Param('id') id: string, @Request() req) {
    return this.reportTemplatesService.toggleActive(id, req.user.tenantId, req.user.sub);
  }
}
