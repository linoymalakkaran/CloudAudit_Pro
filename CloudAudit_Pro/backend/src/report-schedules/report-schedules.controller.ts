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
import { ReportSchedulesService } from './report-schedules.service';
import { CreateScheduleDto } from './dto/create-schedule.dto';
import { UpdateScheduleDto } from './dto/update-schedule.dto';

@ApiTags('report-schedules')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('report-schedules')
export class ReportSchedulesController {
  constructor(private readonly reportSchedulesService: ReportSchedulesService) {}

  @Post()
  @ApiOperation({ summary: 'Create report schedule' })
  create(@Body() createScheduleDto: CreateScheduleDto, @Request() req) {
    return this.reportSchedulesService.create(
      createScheduleDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all schedules' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean })
  findAll(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('isActive') isActive?: string,
  ) {
    return this.reportSchedulesService.findAll(
      req.user.tenantId,
      companyId,
      isActive === 'true' ? true : isActive === 'false' ? false : undefined,
    );
  }

  @Get('upcoming')
  @ApiOperation({ summary: 'Get upcoming scheduled reports' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'days', required: false, type: Number })
  getUpcoming(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('days') days?: number,
  ) {
    return this.reportSchedulesService.getUpcoming(
      req.user.tenantId,
      companyId,
      days ? parseInt(days.toString()) : undefined,
    );
  }

  @Get('history')
  @ApiOperation({ summary: 'Get schedule execution history' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  getHistory(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('limit') limit?: number,
  ) {
    return this.reportSchedulesService.getHistory(
      req.user.tenantId,
      companyId,
      limit ? parseInt(limit.toString()) : undefined,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get schedule by ID' })
  findOne(@Param('id') id: string, @Request() req) {
    return this.reportSchedulesService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update schedule' })
  update(
    @Param('id') id: string,
    @Body() updateScheduleDto: UpdateScheduleDto,
    @Request() req,
  ) {
    return this.reportSchedulesService.update(
      id,
      updateScheduleDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete schedule' })
  remove(@Param('id') id: string, @Request() req) {
    return this.reportSchedulesService.remove(id, req.user.tenantId);
  }

  @Post(':id/run-now')
  @ApiOperation({ summary: 'Run schedule immediately' })
  runNow(@Param('id') id: string, @Request() req) {
    return this.reportSchedulesService.runNow(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/toggle-active')
  @ApiOperation({ summary: 'Toggle schedule active status' })
  toggleActive(@Param('id') id: string, @Request() req) {
    return this.reportSchedulesService.toggleActive(id, req.user.tenantId, req.user.sub);
  }
}
