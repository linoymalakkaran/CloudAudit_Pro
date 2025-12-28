import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { PeriodService, CreatePeriodDto, UpdatePeriodDto } from './period.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('periods')
@Controller('periods')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class PeriodController {
  constructor(private readonly periodService: PeriodService) {}

  @Post()
  @ApiOperation({ summary: 'Create new audit period' })
  @ApiResponse({ status: 201, description: 'Period created successfully' })
  @ApiResponse({ status: 400, description: 'Bad request - validation error' })
  @ApiResponse({ status: 409, description: 'Conflict - overlapping period dates' })
  async createPeriod(@Body() createPeriodDto: CreatePeriodDto, @Request() req: any) {
    return this.periodService.createPeriod({
      ...createPeriodDto,
      startDate: new Date(createPeriodDto.startDate),
      endDate: new Date(createPeriodDto.endDate),
      tenantId: req.user.tenantId,
    });
  }

  @Get()
  @ApiOperation({ summary: 'Get all periods for tenant' })
  @ApiResponse({ status: 200, description: 'Periods retrieved successfully' })
  async getAllPeriods(@Request() req: any) {
    return this.periodService.getPeriodsByTenant(req.user.tenantId);
  }

  @Get('company/:companyId')
  @ApiOperation({ summary: 'Get periods by company' })
  @ApiResponse({ status: 200, description: 'Company periods retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Company not found' })
  async getPeriodsByCompany(
    @Param('companyId') companyId: string,
    @Request() req: any,
  ) {
    return this.periodService.getPeriodsByCompany(companyId, req.user.tenantId);
  }

  @Get('stats')
  @ApiOperation({ summary: 'Get period statistics' })
  @ApiResponse({ status: 200, description: 'Period statistics retrieved' })
  async getPeriodStats(@Request() req: any) {
    return this.periodService.getPeriodStats(req.user.tenantId);
  }

  @Get('search')
  @ApiOperation({ summary: 'Search periods' })
  @ApiResponse({ status: 200, description: 'Search results retrieved' })
  async searchPeriods(@Query('q') query: string, @Request() req: any) {
    return this.periodService.searchPeriods(req.user.tenantId, query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get period by ID' })
  @ApiResponse({ status: 200, description: 'Period retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Period not found' })
  async getPeriodById(@Param('id') id: string, @Request() req: any) {
    return this.periodService.getPeriodById(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update period' })
  @ApiResponse({ status: 200, description: 'Period updated successfully' })
  @ApiResponse({ status: 404, description: 'Period not found' })
  @ApiResponse({ status: 409, description: 'Conflict - overlapping dates' })
  async updatePeriod(
    @Param('id') id: string,
    @Body() updatePeriodDto: UpdatePeriodDto,
    @Request() req: any,
  ) {
    const updateData: UpdatePeriodDto = { ...updatePeriodDto };
    if (updatePeriodDto.startDate) {
      updateData.startDate = new Date(updatePeriodDto.startDate);
    }
    if (updatePeriodDto.endDate) {
      updateData.endDate = new Date(updatePeriodDto.endDate);
    }
    return this.periodService.updatePeriod(id, req.user.tenantId, updateData);
  }

  @Post(':id/close')
  @ApiOperation({ summary: 'Close audit period' })
  @ApiResponse({ status: 200, description: 'Period closed successfully' })
  @ApiResponse({ status: 409, description: 'Cannot close - incomplete procedures' })
  async closePeriod(@Param('id') id: string, @Request() req: any) {
    return this.periodService.closePeriod(id, req.user.tenantId);
  }

  @Post(':id/reopen')
  @ApiOperation({ summary: 'Reopen closed period' })
  @ApiResponse({ status: 200, description: 'Period reopened successfully' })
  @ApiResponse({ status: 409, description: 'Only closed periods can be reopened' })
  async reopenPeriod(@Param('id') id: string, @Request() req: any) {
    return this.periodService.reopenPeriod(id, req.user.tenantId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete period' })
  @ApiResponse({ status: 200, description: 'Period deleted successfully' })
  @ApiResponse({ status: 403, description: 'Cannot delete period with data' })
  async deletePeriod(@Param('id') id: string, @Request() req: any) {
    return this.periodService.deletePeriod(id, req.user.tenantId);
  }
}