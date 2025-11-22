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
import { AuditProcedureService } from './audit-procedure.service';
import { 
  CreateAuditProcedureDto,
  UpdateAuditProcedureDto,
  ProcedureFilterDto,
  ProcedureReviewDto,
  BulkAssignProceduresDto,
  ProcedureStatus,
  RiskLevel,
  ProcedureType
} from './dto/audit-procedure.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Audit Procedures')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('audit-procedures')
export class AuditProcedureController {
  constructor(private readonly auditProcedureService: AuditProcedureService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create audit procedure',
    description: 'Create a new audit procedure for a company and period'
  })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'Procedure created successfully' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Invalid input data' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Access denied' })
  async create(@Body() createAuditProcedureDto: CreateAuditProcedureDto, @Request() req) {
    return this.auditProcedureService.create(createAuditProcedureDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get audit procedures',
    description: 'Retrieve audit procedures with filtering, pagination, and sorting'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedures retrieved successfully' })
  @ApiQuery({ name: 'page', required: false, type: Number, description: 'Page number (default: 1)' })
  @ApiQuery({ name: 'limit', required: false, type: Number, description: 'Items per page (default: 20)' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'periodId', required: false, type: String, description: 'Filter by period' })
  @ApiQuery({ name: 'procedureType', required: false, enum: ProcedureType, description: 'Filter by procedure type' })
  @ApiQuery({ name: 'status', required: false, enum: ProcedureStatus, description: 'Filter by status' })
  @ApiQuery({ name: 'assignedTo', required: false, type: String, description: 'Filter by assigned user' })
  @ApiQuery({ name: 'search', required: false, type: String, description: 'Search in name and description' })
  @ApiQuery({ name: 'sortBy', required: false, type: String, description: 'Sort field (default: dueDate)' })
  @ApiQuery({ name: 'sortOrder', required: false, enum: ['asc', 'desc'], description: 'Sort order (default: asc)' })
  async findAll(@Query() filters: ProcedureFilterDto, @Request() req) {
    return this.auditProcedureService.findAll(filters, req.user.userId);
  }

  @Get('statistics')
  @ApiOperation({ 
    summary: 'Get audit procedure statistics',
    description: 'Get comprehensive statistics about audit procedures'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Statistics retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'periodId', required: false, type: String, description: 'Filter by period' })
  @ApiQuery({ name: 'assignedTo', required: false, type: String, description: 'Filter by assigned user' })
  async getStatistics(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('assignedTo') assignedTo?: string,
  ) {
    return this.auditProcedureService.getStatistics(companyId, periodId, assignedTo);
  }

  @Get('templates')
  @ApiOperation({ 
    summary: 'Get procedure templates',
    description: 'Get available audit procedure templates'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Templates retrieved successfully' })
  async getTemplates(): Promise<any> {
    return this.auditProcedureService.getTemplates();
  }

  @Get(':id')
  @ApiOperation({ 
    summary: 'Get audit procedure',
    description: 'Retrieve a specific audit procedure by ID with full details'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure retrieved successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Procedure not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Access denied' })
  async findOne(@Param('id') id: string, @Request() req) {
    return this.auditProcedureService.findOne(id, req.user.userId);
  }

  @Patch(':id')
  @ApiOperation({ 
    summary: 'Update audit procedure',
    description: 'Update an existing audit procedure'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure updated successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Procedure not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Update permission denied' })
  async update(
    @Param('id') id: string,
    @Body() updateAuditProcedureDto: UpdateAuditProcedureDto,
    @Request() req
  ) {
    return this.auditProcedureService.update(id, updateAuditProcedureDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ 
    summary: 'Delete audit procedure',
    description: 'Delete an audit procedure (only if not started or by supervisor)'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure deleted successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Procedure not found' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Cannot delete started procedure' })
  async remove(@Param('id') id: string, @Request() req) {
    return this.auditProcedureService.remove(id, req.user.userId);
  }

  @Post(':id/review')
  @ApiOperation({ 
    summary: 'Review audit procedure',
    description: 'Review and approve/reject a completed audit procedure'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure reviewed successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Procedure not found' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Procedure not ready for review' })
  async review(
    @Param('id') id: string,
    @Body() reviewDto: ProcedureReviewDto,
    @Request() req
  ) {
    return this.auditProcedureService.review(id, reviewDto, req.user.userId);
  }

  @Post('bulk-assign')
  @ApiOperation({ 
    summary: 'Bulk assign procedures',
    description: 'Assign multiple procedures to a user at once'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedures assigned successfully' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Invalid procedure IDs or assignee' })
  async bulkAssign(@Body() bulkAssignDto: BulkAssignProceduresDto, @Request() req) {
    return this.auditProcedureService.bulkAssign(bulkAssignDto, req.user.userId);
  }

  @Post(':id/start')
  @ApiOperation({ 
    summary: 'Start audit procedure',
    description: 'Mark an audit procedure as started and set start date'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure started successfully' })
  async startProcedure(@Param('id') id: string, @Request() req) {
    const updateDto: UpdateAuditProcedureDto = {
      status: ProcedureStatus.IN_PROGRESS,
      startDate: new Date(),
    };
    return this.auditProcedureService.update(id, updateDto, req.user.userId);
  }

  @Post(':id/complete')
  @ApiOperation({ 
    summary: 'Complete audit procedure',
    description: 'Mark an audit procedure as completed'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure completed successfully' })
  async completeProcedure(@Param('id') id: string, @Request() req) {
    const updateDto: UpdateAuditProcedureDto = {
      status: ProcedureStatus.COMPLETED,
      completedDate: new Date(),
    };
    return this.auditProcedureService.update(id, updateDto, req.user.userId);
  }

  @Post(':id/hold')
  @ApiOperation({ 
    summary: 'Put procedure on hold',
    description: 'Put an audit procedure on hold with reason'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Procedure put on hold successfully' })
  async holdProcedure(
    @Param('id') id: string,
    @Body('reason') reason: string,
    @Request() req
  ) {
    const updateDto: UpdateAuditProcedureDto = {
      status: ProcedureStatus.ON_HOLD,
      notes: reason,
    };
    return this.auditProcedureService.update(id, updateDto, req.user.userId);
  }

  @Get('company/:companyId/workload')
  @ApiOperation({ 
    summary: 'Get workload distribution',
    description: 'Get workload distribution for a company across team members'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Workload data retrieved successfully' })
  async getWorkloadDistribution(@Param('companyId') companyId: string, @Request() req) {
    // This would calculate and return workload distribution
    const filters: ProcedureFilterDto = { companyId };
    const procedures = await this.auditProcedureService.findAll(filters, req.user.userId);
    
    // Group by assignee and calculate workload
    const workloadMap = new Map();
    procedures.data.forEach(proc => {
      if (proc.assignee) {
        const key = proc.assignee.id;
        if (!workloadMap.has(key)) {
          workloadMap.set(key, {
            user: proc.assignee,
            totalProcedures: 0,
            estimatedHours: 0,
            completedProcedures: 0,
            overdueProcedures: 0,
          });
        }
        
        const workload = workloadMap.get(key);
        workload.totalProcedures++;
        workload.estimatedHours += proc.estimatedHours || 0;
        
        if (proc.status === ProcedureStatus.COMPLETED) {
          workload.completedProcedures++;
        }
        
        if (proc.dueDate && new Date(proc.dueDate) < new Date() && 
            proc.status !== ProcedureStatus.COMPLETED) {
          workload.overdueProcedures++;
        }
      }
    });

    return Array.from(workloadMap.values());
  }

  @Get('dashboard/:companyId')
  @ApiOperation({ 
    summary: 'Get audit dashboard data',
    description: 'Get comprehensive dashboard data for audit procedures'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Dashboard data retrieved successfully' })
  async getDashboardData(@Param('companyId') companyId: string, @Request() req) {
    const [statistics, workload] = await Promise.all([
      this.auditProcedureService.getStatistics(companyId),
      this.getWorkloadDistribution(companyId, req),
    ]);

    return {
      statistics,
      workload,
      lastUpdated: new Date(),
    };
  }
}