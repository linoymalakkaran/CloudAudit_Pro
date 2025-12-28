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
import { LiabilityService } from './liability.service';
import { CreateLiabilityDto } from './dto/create-liability.dto';
import { UpdateLiabilityDto } from './dto/update-liability.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('liabilities')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('liabilities')
export class LiabilityController {
  constructor(private readonly liabilityService: LiabilityService) {}

  @Post()
  @ApiOperation({ summary: 'Create liability' })
  @ApiResponse({ status: 201, description: 'Liability created successfully' })
  create(@Body() createDto: CreateLiabilityDto, @Request() req: any) {
    return this.liabilityService.create(createDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all liabilities' })
  @ApiResponse({ status: 200, description: 'List of liabilities' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('type') type?: string,
    @Query('isCurrent') isCurrent?: string,
  ) {
    const isCurrentFilter = isCurrent === 'true' ? true : isCurrent === 'false' ? false : undefined;
    return this.liabilityService.findAll(companyId, periodId, type, isCurrentFilter);
  }

  @Get('aging-summary')
  @ApiOperation({ summary: 'Get aging summary' })
  @ApiResponse({ status: 200, description: 'Aging summary' })
  getAgingSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.liabilityService.getAgingSummary(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get liability by ID' })
  @ApiResponse({ status: 200, description: 'Liability details' })
  findById(@Param('id') id: string) {
    return this.liabilityService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update liability' })
  @ApiResponse({ status: 200, description: 'Liability updated successfully' })
  update(@Param('id') id: string, @Body() updateDto: UpdateLiabilityDto, @Request() req: any) {
    return this.liabilityService.update(id, updateDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete liability' })
  @ApiResponse({ status: 200, description: 'Liability deleted successfully' })
  delete(@Param('id') id: string) {
    return this.liabilityService.delete(id);
  }
}
