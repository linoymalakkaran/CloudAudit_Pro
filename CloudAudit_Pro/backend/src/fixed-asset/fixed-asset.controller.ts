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
import { FixedAssetService } from './fixed-asset.service';
import { CreateFixedAssetDto } from './dto/create-fixed-asset.dto';
import { UpdateFixedAssetDto } from './dto/update-fixed-asset.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('fixed-assets')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('fixed-assets')
export class FixedAssetController {
  constructor(private readonly fixedAssetService: FixedAssetService) {}

  @Post()
  @ApiOperation({ summary: 'Create fixed asset' })
  @ApiResponse({ status: 201, description: 'Fixed asset created successfully' })
  create(@Body() createDto: CreateFixedAssetDto, @Request() req: any) {
    return this.fixedAssetService.create(createDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all fixed assets' })
  @ApiResponse({ status: 200, description: 'List of fixed assets' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('category') category?: string,
  ) {
    return this.fixedAssetService.findAll(companyId, periodId, category);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get fixed assets summary by category' })
  @ApiResponse({ status: 200, description: 'Summary by category' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.fixedAssetService.getSummaryByCategory(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get fixed asset by ID' })
  @ApiResponse({ status: 200, description: 'Fixed asset details' })
  findById(@Param('id') id: string) {
    return this.fixedAssetService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update fixed asset' })
  @ApiResponse({ status: 200, description: 'Fixed asset updated successfully' })
  update(@Param('id') id: string, @Body() updateDto: UpdateFixedAssetDto, @Request() req: any) {
    return this.fixedAssetService.update(id, updateDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete fixed asset' })
  @ApiResponse({ status: 200, description: 'Fixed asset deleted successfully' })
  delete(@Param('id') id: string) {
    return this.fixedAssetService.delete(id);
  }
}
