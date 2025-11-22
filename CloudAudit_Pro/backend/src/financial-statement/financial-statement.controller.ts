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
  Response,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiParam,
} from '@nestjs/swagger';
import { Response as ExpressResponse } from 'express';
import { FinancialStatementService } from './financial-statement.service';
import {
  GenerateStatementDto,
  StatementFilterDto,
  ExportStatementDto,
} from './dto/financial-statement.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('Financial Statements')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('financial-statements')
export class FinancialStatementController {
  constructor(private readonly financialStatementService: FinancialStatementService) {}

  @Post('generate')
  @ApiOperation({ summary: 'Generate financial statement' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Financial statement generated successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid parameters or company/period not found',
  })
  async generate(
    @Body() generateStatementDto: GenerateStatementDto,
    @Request() req: any,
  ) {
    return this.financialStatementService.generateStatement(generateStatementDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all financial statements with filtering' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Financial statements retrieved successfully',
  })
  async findAll(@Query() filters: StatementFilterDto, @Request() req: any) {
    return this.financialStatementService.findAll(filters, req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a specific financial statement by ID' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Financial statement retrieved successfully',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Financial statement not found',
  })
  @ApiParam({ name: 'id', description: 'Financial statement ID' })
  async findOne(@Param('id') id: string, @Request() req: any) {
    return this.financialStatementService.findOne(id, req.user.id);
  }

  @Post(':id/export')
  @ApiOperation({ summary: 'Export financial statement in various formats' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Financial statement exported successfully',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Financial statement not found',
  })
  @ApiParam({ name: 'id', description: 'Financial statement ID' })
  async export(
    @Param('id') id: string,
    @Body() exportDto: ExportStatementDto,
    @Request() req: any,
    @Response({ passthrough: true }) res: ExpressResponse,
  ) {
    const result = await this.financialStatementService.exportStatement(id, exportDto, req.user.id);

    // Set appropriate headers based on format
    switch (exportDto.format) {
      case 'JSON':
        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Content-Disposition', `attachment; filename="financial-statement-${id}.json"`);
        break;
      case 'PDF':
        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader('Content-Disposition', `attachment; filename="financial-statement-${id}.pdf"`);
        break;
      case 'EXCEL':
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        res.setHeader('Content-Disposition', `attachment; filename="financial-statement-${id}.xlsx"`);
        break;
      case 'CSV':
        res.setHeader('Content-Type', 'text/csv');
        res.setHeader('Content-Disposition', `attachment; filename="financial-statement-${id}.csv"`);
        break;
      case 'HTML':
        res.setHeader('Content-Type', 'text/html');
        res.setHeader('Content-Disposition', `attachment; filename="financial-statement-${id}.html"`);
        break;
    }

    return result;
  }

  @Get('company/:companyId/income-statement')
  @ApiOperation({ summary: 'Get quick income statement for a company' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Income statement retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  async getIncomeStatement(
    @Param('companyId') companyId: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    const quickGenerateDto: GenerateStatementDto = {
      companyId,
      periodId: periodId || await this.getCurrentPeriodId(companyId),
      statementType: 'INCOME_STATEMENT' as any,
      includeZeroBalances: false,
    };

    return this.financialStatementService.generateStatement(quickGenerateDto, req.user.id);
  }

  @Get('company/:companyId/balance-sheet')
  @ApiOperation({ summary: 'Get quick balance sheet for a company' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Balance sheet retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  async getBalanceSheet(
    @Param('companyId') companyId: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    const quickGenerateDto: GenerateStatementDto = {
      companyId,
      periodId: periodId || await this.getCurrentPeriodId(companyId),
      statementType: 'BALANCE_SHEET' as any,
      includeZeroBalances: false,
    };

    return this.financialStatementService.generateStatement(quickGenerateDto, req.user.id);
  }

  @Get('company/:companyId/cash-flow')
  @ApiOperation({ summary: 'Get cash flow statement for a company' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Cash flow statement retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  async getCashFlowStatement(
    @Param('companyId') companyId: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    const quickGenerateDto: GenerateStatementDto = {
      companyId,
      periodId: periodId || await this.getCurrentPeriodId(companyId),
      statementType: 'CASH_FLOW' as any,
      includeZeroBalances: false,
    };

    return this.financialStatementService.generateStatement(quickGenerateDto, req.user.id);
  }

  @Get('company/:companyId/dashboard')
  @ApiOperation({ summary: 'Get financial dashboard summary for a company' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Financial dashboard retrieved successfully',
  })
  @ApiParam({ name: 'companyId', description: 'Company ID' })
  async getFinancialDashboard(
    @Param('companyId') companyId: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    const currentPeriodId = periodId || await this.getCurrentPeriodId(companyId);

    // Generate key financial statements in parallel
    const [incomeStatement, balanceSheet] = await Promise.all([
      this.financialStatementService.generateStatement({
        companyId,
        periodId: currentPeriodId,
        statementType: 'INCOME_STATEMENT' as any,
        includeZeroBalances: false,
      }, req.user.id),
      this.financialStatementService.generateStatement({
        companyId,
        periodId: currentPeriodId,
        statementType: 'BALANCE_SHEET' as any,
        includeZeroBalances: false,
      }, req.user.id),
    ]);

    // Extract key metrics
    const dashboard = {
      companyId,
      periodId: currentPeriodId,
      generatedAt: new Date(),
      keyMetrics: {
        revenue: incomeStatement.totals.revenue || '0',
        expenses: incomeStatement.totals.expenses || '0',
        netIncome: incomeStatement.totals.netIncome || '0',
        totalAssets: balanceSheet.totals.assets || '0',
        totalLiabilities: balanceSheet.totals.liabilities || '0',
        totalEquity: balanceSheet.totals.equity || '0',
      },
      ratios: {
        profitMargin: this.calculateRatio(incomeStatement.totals.netIncome, incomeStatement.totals.revenue),
        debtToEquity: this.calculateRatio(balanceSheet.totals.liabilities, balanceSheet.totals.equity),
        currentRatio: '1.0', // Would calculate from current assets/liabilities
      },
      statements: {
        incomeStatement,
        balanceSheet,
      },
    };

    return dashboard;
  }

  private async getCurrentPeriodId(companyId: string): Promise<string> {
    // Helper method to get current period
    return 'current-period-id';
  }

  private calculateRatio(numerator: string | undefined, denominator: string | undefined): string {
    if (!numerator || !denominator || denominator === '0') return '0';
    const ratio = parseFloat(numerator) / parseFloat(denominator);
    return (ratio * 100).toFixed(2) + '%';
  }
}