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
  Header,
  Res,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { Response } from 'express';
import { ReportsService } from './reports.service';
import {
  CreateReportDto,
  UpdateReportDto,
  ExecuteReportDto,
  ReportQueryDto,
  BulkReportDto,
  ReportType,
  ReportFormat
} from './dto/report.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Reports')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create report template',
    description: 'Create a new report template with filters and configuration'
  })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'Report template created successfully' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Invalid input data' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Access denied' })
  async create(@Body() createReportDto: CreateReportDto, @Request() req) {
    return this.reportsService.create(createReportDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get report templates',
    description: 'Retrieve all report templates with filtering and pagination'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report templates retrieved successfully' })
  @ApiQuery({ name: 'page', required: false, type: Number, description: 'Page number' })
  @ApiQuery({ name: 'limit', required: false, type: Number, description: 'Items per page' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'reportType', required: false, enum: ReportType, description: 'Filter by report type' })
  @ApiQuery({ name: 'search', required: false, type: String, description: 'Search in name and description' })
  async findAll(@Query() query: ReportQueryDto, @Request() req) {
    return this.reportsService.findAll(query, req.user.userId);
  }

  @Get('statistics')
  @ApiOperation({ 
    summary: 'Get reporting statistics',
    description: 'Get comprehensive statistics about report usage and generation'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Statistics retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  async getStatistics(@Query('companyId') companyId?: string) {
    return this.reportsService.getStatistics(companyId);
  }

  @Get('templates')
  @ApiOperation({ 
    summary: 'Get report templates',
    description: 'Get available predefined report templates'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Templates retrieved successfully' })
  async getTemplates(): Promise<any> {
    return this.reportsService.getTemplates();
  }

  @Post('generate')
  @ApiOperation({ 
    summary: 'Generate adhoc report',
    description: 'Generate a report without saving as template'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report generated successfully' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Invalid report parameters' })
  async generateAdhoc(
    @Body() executeDto: ExecuteReportDto & { reportType: ReportType },
    @Request() req,
    @Res() res: Response
  ) {
    const report = await this.reportsService.generateAdhoc(executeDto, req.user.userId);
    
    // Handle different response formats
    if (executeDto.format === ReportFormat.PDF) {
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', `attachment; filename="report.pdf"`);
      return res.send(report);
    } else if (executeDto.format === ReportFormat.EXCEL) {
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', `attachment; filename="report.xlsx"`);
      return res.send(report);
    } else if (executeDto.format === ReportFormat.CSV) {
      res.setHeader('Content-Type', 'text/csv');
      res.setHeader('Content-Disposition', `attachment; filename="report.csv"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Post('bulk-generate')
  @ApiOperation({ 
    summary: 'Generate multiple reports',
    description: 'Generate multiple reports in a single request'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Reports generated successfully' })
  async bulkGenerate(@Body() bulkDto: BulkReportDto, @Request() req): Promise<any> {
    return this.reportsService.bulkGenerate(bulkDto, req.user.userId);
  }

  @Get(':id')
  @ApiOperation({ 
    summary: 'Get report template',
    description: 'Retrieve a specific report template by ID'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report template retrieved successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Report template not found' })
  async findOne(@Param('id') id: string, @Request() req) {
    return this.reportsService.findOne(id, req.user.userId);
  }

  @Patch(':id')
  @ApiOperation({ 
    summary: 'Update report template',
    description: 'Update an existing report template'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report template updated successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Report template not found' })
  async update(
    @Param('id') id: string,
    @Body() updateReportDto: UpdateReportDto,
    @Request() req
  ) {
    return this.reportsService.update(id, updateReportDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ 
    summary: 'Delete report template',
    description: 'Delete a report template'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report template deleted successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Report template not found' })
  async remove(@Param('id') id: string, @Request() req) {
    return this.reportsService.remove(id, req.user.userId);
  }

  @Post(':id/execute')
  @ApiOperation({ 
    summary: 'Execute report template',
    description: 'Execute a saved report template with optional parameter overrides'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Report executed successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'Report template not found' })
  async execute(
    @Param('id') id: string,
    @Body() executeDto: ExecuteReportDto,
    @Request() req,
    @Res() res: Response
  ) {
    const report = await this.reportsService.execute(id, executeDto, req.user.userId);
    
    // Handle different response formats
    if (executeDto.format === ReportFormat.PDF) {
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', `attachment; filename="report-${id}.pdf"`);
      return res.send(report);
    } else if (executeDto.format === ReportFormat.EXCEL) {
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', `attachment; filename="report-${id}.xlsx"`);
      return res.send(report);
    } else if (executeDto.format === ReportFormat.CSV) {
      res.setHeader('Content-Type', 'text/csv');
      res.setHeader('Content-Disposition', `attachment; filename="report-${id}.csv"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Get('financial/:companyId/:periodId/balance-sheet')
  @ApiOperation({ 
    summary: 'Generate Balance Sheet',
    description: 'Generate a Balance Sheet for specific company and period'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Balance Sheet generated successfully' })
  async generateBalanceSheet(
    @Param('companyId') companyId: string,
    @Param('periodId') periodId: string,
    @Query('format') format: ReportFormat = ReportFormat.JSON,
    @Request() req,
    @Res() res: Response
  ) {
    const executeDto: ExecuteReportDto & { reportType: ReportType } = {
      companyId,
      periodId,
      reportType: ReportType.FINANCIAL_POSITION,
      format,
    };

    const report = await this.reportsService.generateAdhoc(executeDto, req.user.userId);

    if (format === ReportFormat.PDF || format === ReportFormat.EXCEL || format === ReportFormat.CSV) {
      const contentType = this.getContentType(format);
      const filename = `balance-sheet-${companyId}-${periodId}.${format.toLowerCase()}`;
      
      res.setHeader('Content-Type', contentType);
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Get('financial/:companyId/:periodId/income-statement')
  @ApiOperation({ 
    summary: 'Generate Income Statement',
    description: 'Generate an Income Statement for specific company and period'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Income Statement generated successfully' })
  async generateIncomeStatement(
    @Param('companyId') companyId: string,
    @Param('periodId') periodId: string,
    @Query('format') format: ReportFormat = ReportFormat.JSON,
    @Request() req,
    @Res() res: Response
  ) {
    const executeDto: ExecuteReportDto & { reportType: ReportType } = {
      companyId,
      periodId,
      reportType: ReportType.INCOME_STATEMENT,
      format,
    };

    const report = await this.reportsService.generateAdhoc(executeDto, req.user.userId);

    if (format === ReportFormat.PDF || format === ReportFormat.EXCEL || format === ReportFormat.CSV) {
      const contentType = this.getContentType(format);
      const filename = `income-statement-${companyId}-${periodId}.${format.toLowerCase()}`;
      
      res.setHeader('Content-Type', contentType);
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Get('financial/:companyId/:periodId/cash-flow')
  @ApiOperation({ 
    summary: 'Generate Cash Flow Statement',
    description: 'Generate a Cash Flow Statement for specific company and period'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Cash Flow Statement generated successfully' })
  async generateCashFlow(
    @Param('companyId') companyId: string,
    @Param('periodId') periodId: string,
    @Query('format') format: ReportFormat = ReportFormat.JSON,
    @Request() req,
    @Res() res: Response
  ) {
    const executeDto: ExecuteReportDto & { reportType: ReportType } = {
      companyId,
      periodId,
      reportType: ReportType.CASH_FLOW,
      format,
    };

    const report = await this.reportsService.generateAdhoc(executeDto, req.user.userId);

    if (format === ReportFormat.PDF || format === ReportFormat.EXCEL || format === ReportFormat.CSV) {
      const contentType = this.getContentType(format);
      const filename = `cash-flow-${companyId}-${periodId}.${format.toLowerCase()}`;
      
      res.setHeader('Content-Type', contentType);
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Get('audit/:companyId/:periodId/summary')
  @ApiOperation({ 
    summary: 'Generate Audit Summary',
    description: 'Generate an Audit Summary report for specific company and period'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Audit Summary generated successfully' })
  async generateAuditSummary(
    @Param('companyId') companyId: string,
    @Param('periodId') periodId: string,
    @Query('format') format: ReportFormat = ReportFormat.JSON,
    @Request() req,
    @Res() res: Response
  ) {
    const executeDto: ExecuteReportDto & { reportType: ReportType } = {
      companyId,
      periodId,
      reportType: ReportType.AUDIT_SUMMARY,
      format,
    };

    const report = await this.reportsService.generateAdhoc(executeDto, req.user.userId);

    if (format === ReportFormat.PDF || format === ReportFormat.EXCEL || format === ReportFormat.CSV) {
      const contentType = this.getContentType(format);
      const filename = `audit-summary-${companyId}-${periodId}.${format.toLowerCase()}`;
      
      res.setHeader('Content-Type', contentType);
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      return res.send(report);
    } else {
      return res.json(report);
    }
  }

  @Get('dashboard/:companyId')
  @ApiOperation({ 
    summary: 'Get reporting dashboard data',
    description: 'Get comprehensive dashboard data for reporting'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Dashboard data retrieved successfully' })
  async getDashboardData(@Param('companyId') companyId: string, @Request() req) {
    const [statistics, templates] = await Promise.all([
      this.reportsService.getStatistics(companyId),
      this.reportsService.getTemplates(),
    ]);

    return {
      statistics,
      availableTemplates: templates.length,
      recentlyUsed: [], // Would be calculated from execution logs
      scheduledReports: [], // Would be fetched from scheduled reports
      lastUpdated: new Date(),
    };
  }

  private getContentType(format: ReportFormat): string {
    switch (format) {
      case ReportFormat.PDF:
        return 'application/pdf';
      case ReportFormat.EXCEL:
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case ReportFormat.CSV:
        return 'text/csv';
      case ReportFormat.HTML:
        return 'text/html';
      default:
        return 'application/json';
    }
  }
}