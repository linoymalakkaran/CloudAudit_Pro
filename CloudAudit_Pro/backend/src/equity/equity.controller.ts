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
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { EquityService } from './equity.service';
import { CreateEquityDto } from './dto/create-equity.dto';
import { UpdateEquityDto } from './dto/update-equity.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('equity')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('equity')
export class EquityController {
  constructor(private readonly equityService: EquityService) {}

  @Post()
  @ApiOperation({ summary: 'Create equity entry' })
  @ApiResponse({ status: 201, description: 'Equity created successfully' })
  create(@Body() createDto: CreateEquityDto, @Request() req: any) {
    return this.equityService.create(createDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all equity entries' })
  @ApiResponse({ status: 200, description: 'List of equity entries' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('type') type?: string,
  ) {
    return this.equityService.findAll(companyId, periodId, type);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get equity summary by type' })
  @ApiResponse({ status: 200, description: 'Summary by type' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.equityService.getSummaryByType(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get equity by ID' })
  @ApiResponse({ status: 200, description: 'Equity details' })
  findById(@Param('id') id: string) {
    return this.equityService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update equity' })
  @ApiResponse({ status: 200, description: 'Equity updated successfully' })
  update(@Param('id') id: string, @Body() updateDto: UpdateEquityDto, @Request() req: any) {
    return this.equityService.update(id, updateDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete equity' })
  @ApiResponse({ status: 200, description: 'Equity deleted successfully' })
  delete(@Param('id') id: string) {
    return this.equityService.delete(id);
  }
}
