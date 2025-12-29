import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AnalyticsService } from './analytics.service';
import { AnalyticsQueryDto, CreateSnapshotDto, AnalyticsMetric } from './dto/analytics-query.dto';

@ApiTags('analytics')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('analytics')
export class AnalyticsController {
  constructor(private readonly analyticsService: AnalyticsService) {}

  @Get('overview')
  @ApiOperation({ summary: 'Get analytics overview' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: false })
  getOverview(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId?: string,
  ) {
    return this.analyticsService.getOverview(req.user.tenantId, companyId, periodId);
  }

  @Post('query')
  @ApiOperation({ summary: 'Custom analytics query' })
  customQuery(@Body() analyticsQuery: AnalyticsQueryDto, @Request() req) {
    return this.analyticsService.customQuery(analyticsQuery, req.user.tenantId);
  }

  @Get('financial-ratios')
  @ApiOperation({ summary: 'Get financial ratios' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: false })
  financialRatios(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId?: string,
  ) {
    return this.analyticsService.financialRatios(req.user.tenantId, companyId, periodId);
  }

  @Get('trends/:metric')
  @ApiOperation({ summary: 'Get trend analysis for metric' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periods', required: false, type: Number })
  trendAnalysis(
    @Request() req,
    @Param('metric') metric: AnalyticsMetric,
    @Query('companyId') companyId: string,
    @Query('periods') periods?: number,
  ) {
    return this.analyticsService.trendAnalysis(
      req.user.tenantId,
      companyId,
      metric,
      periods ? parseInt(periods.toString()) : undefined,
    );
  }

  @Get('variance')
  @ApiOperation({ summary: 'Get variance analysis' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: true })
  @ApiQuery({ name: 'comparisonPeriodId', required: true })
  varianceAnalysis(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId: string,
    @Query('comparisonPeriodId') comparisonPeriodId: string,
  ) {
    return this.analyticsService.varianceAnalysis(
      req.user.tenantId,
      companyId,
      periodId,
      comparisonPeriodId,
    );
  }

  @Get('aging')
  @ApiOperation({ summary: 'Get aging analysis' })
  @ApiQuery({ name: 'companyId', required: true })
  agingAnalysis(@Request() req, @Query('companyId') companyId: string) {
    return this.analyticsService.agingAnalysis(req.user.tenantId, companyId);
  }

  @Get('materiality')
  @ApiOperation({ summary: 'Calculate materiality thresholds' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: false })
  materialityCalculation(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId?: string,
  ) {
    return this.analyticsService.materialityCalculation(
      req.user.tenantId,
      companyId,
      periodId,
    );
  }

  @Post('snapshots')
  @ApiOperation({ summary: 'Create analytics snapshot' })
  createSnapshot(@Body() createSnapshotDto: CreateSnapshotDto, @Request() req) {
    return this.analyticsService.createSnapshot(
      createSnapshotDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get('snapshots')
  @ApiOperation({ summary: 'Get analytics snapshots' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'periodId', required: false })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  getSnapshots(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('limit') limit?: number,
  ) {
    return this.analyticsService.getSnapshots(
      req.user.tenantId,
      companyId,
      periodId,
      limit ? parseInt(limit.toString()) : undefined,
    );
  }
}
