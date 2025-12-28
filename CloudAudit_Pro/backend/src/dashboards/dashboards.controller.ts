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
import { DashboardsService } from './dashboards.service';
import { CreateDashboardDto } from './dto/create-dashboard.dto';
import { UpdateDashboardDto } from './dto/update-dashboard.dto';
import { WidgetDataRequestDto } from './dto/widget-data.dto';

@ApiTags('dashboards')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('dashboards')
export class DashboardsController {
  constructor(private readonly dashboardsService: DashboardsService) {}

  @Post()
  @ApiOperation({ summary: 'Create dashboard' })
  create(@Body() createDashboardDto: CreateDashboardDto, @Request() req) {
    return this.dashboardsService.create(
      createDashboardDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all dashboards' })
  @ApiQuery({ name: 'companyId', required: false })
  findAll(@Request() req, @Query('companyId') companyId?: string) {
    return this.dashboardsService.findAll(
      req.user.tenantId,
      companyId,
      req.user.sub,
    );
  }

  @Get('default')
  @ApiOperation({ summary: 'Get default dashboard' })
  findDefault(@Request() req) {
    return this.dashboardsService.findDefault(req.user.tenantId, req.user.sub);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get dashboard by ID' })
  findOne(@Param('id') id: string, @Request() req) {
    return this.dashboardsService.findOne(id, req.user.tenantId, req.user.sub);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update dashboard' })
  update(
    @Param('id') id: string,
    @Body() updateDashboardDto: UpdateDashboardDto,
    @Request() req,
  ) {
    return this.dashboardsService.update(
      id,
      updateDashboardDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete dashboard' })
  remove(@Param('id') id: string, @Request() req) {
    return this.dashboardsService.remove(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/duplicate')
  @ApiOperation({ summary: 'Duplicate dashboard' })
  duplicate(@Param('id') id: string, @Request() req) {
    return this.dashboardsService.duplicate(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/set-default')
  @ApiOperation({ summary: 'Set as default dashboard' })
  setDefault(@Param('id') id: string, @Request() req) {
    return this.dashboardsService.setDefault(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/share')
  @ApiOperation({ summary: 'Share dashboard with users' })
  share(
    @Param('id') id: string,
    @Body() body: { userIds: string[] },
    @Request() req,
  ) {
    return this.dashboardsService.share(
      id,
      body.userIds,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Post(':id/unshare')
  @ApiOperation({ summary: 'Unshare dashboard from users' })
  unshare(
    @Param('id') id: string,
    @Body() body: { userIds: string[] },
    @Request() req,
  ) {
    return this.dashboardsService.unshare(
      id,
      body.userIds,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Post('widget-data')
  @ApiOperation({ summary: 'Get widget data' })
  getWidgetData(@Body() widgetDataRequest: WidgetDataRequestDto, @Request() req) {
    return this.dashboardsService.getWidgetData(widgetDataRequest, req.user.tenantId);
  }
}
