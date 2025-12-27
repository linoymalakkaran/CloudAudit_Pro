import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiResponse } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FindingService } from './finding.service';
import { CreateFindingDto, UpdateFindingDto, QueryFindingDto } from './dto';

@ApiTags('Findings')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('findings')
export class FindingController {
  constructor(private readonly findingService: FindingService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new finding' })
  @ApiResponse({ status: 201, description: 'Finding created successfully' })
  create(@Request() req, @Body() createDto: CreateFindingDto) {
    return this.findingService.create(
      req.user.tenantId,
      req.user.userId,
      createDto,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all findings with filters' })
  @ApiResponse({ status: 200, description: 'List of findings' })
  findAll(@Request() req, @Query() query: QueryFindingDto) {
    return this.findingService.findAll(req.user.tenantId, query);
  }

  @Get('statistics')
  @ApiOperation({ summary: 'Get finding statistics' })
  @ApiResponse({ status: 200, description: 'Finding statistics' })
  getStatistics(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
  ) {
    return this.findingService.getStatistics(
      req.user.tenantId,
      companyId,
      periodId,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a single finding' })
  @ApiResponse({ status: 200, description: 'Finding details' })
  findOne(@Request() req, @Param('id') id: string) {
    return this.findingService.findOne(req.user.tenantId, id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update a finding' })
  @ApiResponse({ status: 200, description: 'Finding updated successfully' })
  update(
    @Request() req,
    @Param('id') id: string,
    @Body() updateDto: UpdateFindingDto,
  ) {
    return this.findingService.update(
      req.user.tenantId,
      req.user.userId,
      id,
      updateDto,
    );
  }

  @Post(':id/resolve')
  @ApiOperation({ summary: 'Resolve a finding' })
  @ApiResponse({ status: 200, description: 'Finding resolved successfully' })
  resolve(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { managementResponse?: string },
  ) {
    return this.findingService.resolve(
      req.user.tenantId,
      req.user.userId,
      id,
      body.managementResponse,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a finding' })
  @ApiResponse({ status: 200, description: 'Finding deleted successfully' })
  delete(@Request() req, @Param('id') id: string) {
    return this.findingService.delete(req.user.tenantId, id);
  }
}
