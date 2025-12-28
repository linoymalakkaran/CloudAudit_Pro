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
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuditFinalizationService } from './audit-finalization.service';
import { CreateAuditFinalizationDto, UpdateAuditFinalizationDto, FinalizationStatus } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('audit-finalization')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('audit-finalization')
export class AuditFinalizationController {
  constructor(private readonly auditFinalizationService: AuditFinalizationService) {}

  @Post()
  @ApiOperation({ summary: 'Create audit finalization' })
  @ApiResponse({ status: 201, description: 'Audit finalization created successfully' })
  create(@Body() createAuditFinalizationDto: CreateAuditFinalizationDto, @Request() req: any) {
    return this.auditFinalizationService.create(createAuditFinalizationDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all audit finalizations' })
  @ApiResponse({ status: 200, description: 'List of audit finalizations' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: FinalizationStatus,
  ) {
    return this.auditFinalizationService.findAll(companyId, periodId, status);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get audit summary for company and period' })
  @ApiResponse({ status: 200, description: 'Audit summary' })
  getAuditSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.auditFinalizationService.getAuditSummary(companyId, periodId);
  }

  @Get('by-company-period')
  @ApiOperation({ summary: 'Get audit finalization by company and period' })
  @ApiResponse({ status: 200, description: 'Audit finalization details' })
  findByCompanyAndPeriod(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.auditFinalizationService.findByCompanyAndPeriod(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get audit finalization by ID' })
  @ApiResponse({ status: 200, description: 'Audit finalization details' })
  findById(@Param('id') id: string) {
    return this.auditFinalizationService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update audit finalization' })
  @ApiResponse({ status: 200, description: 'Audit finalization updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateAuditFinalizationDto: UpdateAuditFinalizationDto,
    @Request() req: any,
  ) {
    return this.auditFinalizationService.update(id, updateAuditFinalizationDto, req.user.userId);
  }

  @Post(':id/finalize')
  @ApiOperation({ summary: 'Finalize audit' })
  @ApiResponse({ status: 200, description: 'Audit finalized successfully' })
  finalizeAudit(@Param('id') id: string, @Request() req: any) {
    return this.auditFinalizationService.finalizeAudit(id, req.user.userId);
  }

  @Post(':id/issue')
  @ApiOperation({ summary: 'Issue audit report' })
  @ApiResponse({ status: 200, description: 'Audit report issued successfully' })
  issueReport(@Param('id') id: string, @Request() req: any) {
    return this.auditFinalizationService.issueReport(id, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete audit finalization' })
  @ApiResponse({ status: 200, description: 'Audit finalization deleted successfully' })
  delete(@Param('id') id: string) {
    return this.auditFinalizationService.delete(id);
  }
}
