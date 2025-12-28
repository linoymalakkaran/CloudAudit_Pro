import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Query, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { CurrencyService } from './currency.service';
import { CreateCurrencyDto, UpdateCurrencyDto } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/get-user.decorator';

@ApiTags('Currency')
@Controller('currencies')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class CurrencyController {
  constructor(private readonly currencyService: CurrencyService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new currency' })
  @ApiResponse({ status: 201, description: 'Currency created successfully' })
  @ApiResponse({ status: 409, description: 'Currency code already exists' })
  create(
    @Body() createCurrencyDto: CreateCurrencyDto,
    @GetUser('id') userId: string,
  ) {
    return this.currencyService.create(createCurrencyDto, userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all currencies' })
  @ApiResponse({ status: 200, description: 'Currencies retrieved successfully' })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean, description: 'Filter by active status' })
  findAll(@Query('isActive') isActive?: string) {
    const activeFilter = isActive !== undefined ? isActive === 'true' : undefined;
    return this.currencyService.findAll(activeFilter);
  }

  @Get('base')
  @ApiOperation({ summary: 'Get the base currency' })
  @ApiResponse({ status: 200, description: 'Base currency retrieved successfully' })
  @ApiResponse({ status: 404, description: 'No base currency configured' })
  getBaseCurrency() {
    return this.currencyService.getBaseCurrency();
  }

  @Get('code/:code')
  @ApiOperation({ summary: 'Get currency by code' })
  @ApiResponse({ status: 200, description: 'Currency retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Currency not found' })
  findByCode(@Param('code') code: string) {
    return this.currencyService.findByCode(code);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get currency by ID' })
  @ApiResponse({ status: 200, description: 'Currency retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Currency not found' })
  findOne(@Param('id') id: string) {
    return this.currencyService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a currency' })
  @ApiResponse({ status: 200, description: 'Currency updated successfully' })
  @ApiResponse({ status: 404, description: 'Currency not found' })
  update(
    @Param('id') id: string,
    @Body() updateCurrencyDto: UpdateCurrencyDto,
    @GetUser('id') userId: string,
  ) {
    return this.currencyService.update(id, updateCurrencyDto, userId);
  }

  @Patch(':id/status')
  @ApiOperation({ summary: 'Update currency status (activate/deactivate)' })
  @ApiResponse({ status: 200, description: 'Currency status updated successfully' })
  @ApiResponse({ status: 400, description: 'Cannot deactivate base currency' })
  @ApiResponse({ status: 404, description: 'Currency not found' })
  updateStatus(
    @Param('id') id: string,
    @Body('isActive') isActive: boolean,
    @GetUser('id') userId: string,
  ) {
    return this.currencyService.updateStatus(id, isActive, userId);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete a currency' })
  @ApiResponse({ status: 204, description: 'Currency deleted successfully' })
  @ApiResponse({ status: 400, description: 'Cannot delete currency in use' })
  @ApiResponse({ status: 404, description: 'Currency not found' })
  remove(@Param('id') id: string) {
    return this.currencyService.remove(id);
  }
}
