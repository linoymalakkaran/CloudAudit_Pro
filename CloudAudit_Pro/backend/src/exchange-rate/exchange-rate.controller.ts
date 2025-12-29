import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Query, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { ExchangeRateService } from './exchange-rate.service';
import { CreateExchangeRateDto, UpdateExchangeRateDto } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';

@ApiTags('Exchange Rates')
@Controller('exchange-rates')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ExchangeRateController {
  constructor(private readonly exchangeRateService: ExchangeRateService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new exchange rate' })
  @ApiResponse({ status: 201, description: 'Exchange rate created successfully' })
  @ApiResponse({ status: 409, description: 'Exchange rate already exists for this date' })
  create(
    @Body() createExchangeRateDto: CreateExchangeRateDto,
    @GetUser('id') userId: string,
  ) {
    return this.exchangeRateService.create(createExchangeRateDto, userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all exchange rates' })
  @ApiResponse({ status: 200, description: 'Exchange rates retrieved successfully' })
  @ApiQuery({ name: 'baseCurrencyId', required: false, description: 'Filter by base currency ID' })
  @ApiQuery({ name: 'targetCurrencyId', required: false, description: 'Filter by target currency ID' })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean, description: 'Filter by active status' })
  findAll(
    @Query('baseCurrencyId') baseCurrencyId?: string,
    @Query('targetCurrencyId') targetCurrencyId?: string,
    @Query('isActive') isActive?: string,
  ) {
    const activeFilter = isActive !== undefined ? isActive === 'true' : undefined;
    return this.exchangeRateService.findAll(baseCurrencyId, targetCurrencyId, activeFilter);
  }

  @Get('latest')
  @ApiOperation({ summary: 'Get latest exchange rate between two currencies' })
  @ApiResponse({ status: 200, description: 'Latest rate retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Exchange rate not found' })
  @ApiQuery({ name: 'from', required: true, description: 'From currency ID' })
  @ApiQuery({ name: 'to', required: true, description: 'To currency ID' })
  @ApiQuery({ name: 'asOfDate', required: false, description: 'As of date (ISO format)' })
  getLatestRate(
    @Query('from') from: string,
    @Query('to') to: string,
    @Query('asOfDate') asOfDate?: string,
  ) {
    const date = asOfDate ? new Date(asOfDate) : undefined;
    return this.exchangeRateService.getLatestRate(from, to, date);
  }

  @Get('convert')
  @ApiOperation({ summary: 'Convert amount between currencies' })
  @ApiResponse({ status: 200, description: 'Amount converted successfully' })
  @ApiResponse({ status: 404, description: 'Exchange rate not found' })
  @ApiQuery({ name: 'amount', required: true, type: Number, description: 'Amount to convert' })
  @ApiQuery({ name: 'from', required: true, description: 'From currency ID' })
  @ApiQuery({ name: 'to', required: true, description: 'To currency ID' })
  @ApiQuery({ name: 'asOfDate', required: false, description: 'As of date (ISO format)' })
  async convertAmount(
    @Query('amount') amount: string,
    @Query('from') from: string,
    @Query('to') to: string,
    @Query('asOfDate') asOfDate?: string,
  ) {
    const date = asOfDate ? new Date(asOfDate) : undefined;
    return this.exchangeRateService.convertAmount(Number(amount), from, to, date);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get exchange rate by ID' })
  @ApiResponse({ status: 200, description: 'Exchange rate retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Exchange rate not found' })
  findOne(@Param('id') id: string) {
    return this.exchangeRateService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update an exchange rate' })
  @ApiResponse({ status: 200, description: 'Exchange rate updated successfully' })
  @ApiResponse({ status: 404, description: 'Exchange rate not found' })
  update(
    @Param('id') id: string,
    @Body() updateExchangeRateDto: UpdateExchangeRateDto,
    @GetUser('id') userId: string,
  ) {
    return this.exchangeRateService.update(id, updateExchangeRateDto, userId);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete an exchange rate' })
  @ApiResponse({ status: 204, description: 'Exchange rate deleted successfully' })
  @ApiResponse({ status: 404, description: 'Exchange rate not found' })
  remove(@Param('id') id: string) {
    return this.exchangeRateService.remove(id);
  }
}
