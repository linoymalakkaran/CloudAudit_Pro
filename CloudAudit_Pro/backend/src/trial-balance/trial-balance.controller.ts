import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
  HttpStatus,
  StreamableFile,
  Response,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiParam,
  ApiQuery,
} from '@nestjs/swagger';
import { Response as ExpressResponse } from 'express';
import { TrialBalanceService } from './trial-balance.service';
import {
  GenerateTrialBalanceDto,
  TrialBalanceFilterDto,
  ExportTrialBalanceDto,
  TrialBalanceValidationDto,
} from './dto/trial-balance.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('Trial Balance')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('trial-balance')
export class TrialBalanceController {
  constructor(private readonly trialBalanceService: TrialBalanceService) {}

  @Post('generate')
  @ApiOperation({ summary: 'Generate trial balance report' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Trial balance generated successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid parameters or company/period not found',
  })
  async generate(
    @Body() generateTrialBalanceDto: GenerateTrialBalanceDto,
    @Request() req: any,
  ) {
    return this.trialBalanceService.generateTrialBalance(generateTrialBalanceDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all trial balance reports with filtering' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Trial balance reports retrieved successfully',
  })
  async findAll(@Query() filters: TrialBalanceFilterDto, @Request() req: any) {
    return this.trialBalanceService.findAll(filters, req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a specific trial balance report by ID' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Trial balance report retrieved successfully',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Trial balance report not found',
  })
  @ApiParam({ name: 'id', description: 'Trial balance report ID' })
  async findOne(@Param('id') id: string, @Request() req: any) {
    return this.trialBalanceService.findOne(id, req.user.id);
  }

  @Post('validate')
  @ApiOperation({ summary: 'Validate trial balance and check for issues' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Trial balance validation completed',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid validation parameters',
  })
  async validate(
    @Body() validationDto: TrialBalanceValidationDto,
    @Request() req: any,
  ) {
    return this.trialBalanceService.validateTrialBalance(validationDto, req.user.id);
  }

  @Post(':id/export')
  @ApiOperation({ summary: 'Export trial balance in various formats' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Trial balance exported successfully',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Trial balance report not found',
  })
  @ApiParam({ name: 'id', description: 'Trial balance report ID' })
  async export(
    @Param('id') id: string,
    @Body() exportDto: ExportTrialBalanceDto,
    @Request() req: any,
    @Response({ passthrough: true }) res: ExpressResponse,
  ) {
    const result = await this.trialBalanceService.exportTrialBalance(id, exportDto, req.user.id);

    // Set appropriate headers based on format
    switch (exportDto.format) {
      case 'JSON':
        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Content-Disposition', `attachment; filename="trial-balance-${id}.json"`);
        break;
      case 'PDF':
        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader('Content-Disposition', `attachment; filename="trial-balance-${id}.pdf"`);
        break;
      case 'EXCEL':
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        res.setHeader('Content-Disposition', `attachment; filename="trial-balance-${id}.xlsx"`);
        break;
      case 'CSV':
        res.setHeader('Content-Type', 'text/csv');
        res.setHeader('Content-Disposition', `attachment; filename="trial-balance-${id}.csv"`);
        break;
    }

    return result;
  }

  @Get('company/:companyId/quick-balance')
  @ApiOperation({ summary: 'Get quick trial balance summary for a company' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Quick balance summary retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  @ApiQuery({ name: 'periodId', required: false, description: 'Period ID (defaults to current period)' })
  async getQuickBalance(
    @Param('companyId') companyId: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    // This would be a simplified version for dashboards
    const quickGenerateDto: GenerateTrialBalanceDto = {
      companyId,
      periodId: periodId || await this.getCurrentPeriodId(companyId),
      includeZeroBalances: false,
      includeInactiveAccounts: false,
      groupByAccountType: true,
    };

    return this.trialBalanceService.generateTrialBalance(quickGenerateDto, req.user.id);
  }

  @Get('company/:companyId/balance-trends')
  @ApiOperation({ summary: 'Get balance trends for key accounts over multiple periods' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Balance trends retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  @ApiQuery({ name: 'periods', required: false, description: 'Number of periods to include', type: Number })
  async getBalanceTrends(
    @Param('companyId') companyId: string,
    @Query('periods') periods: number = 12,
    @Request() req?: any,
  ) {
    // This would return trending data for charts and analytics
    return {
      message: 'Balance trends analysis to be implemented',
      companyId,
      periods,
    };
  }

  private async getCurrentPeriodId(companyId: string): Promise<string> {
    // Helper method to get current period - implementation depends on business logic
    return 'current-period-id';
  }
}