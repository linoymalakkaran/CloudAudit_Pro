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
import { ReviewPointService } from './review-point.service';
import { CreateReviewPointDto, UpdateReviewPointDto, ReviewPointStatus } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('review-point')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('review-points')
export class ReviewPointController {
  constructor(private readonly reviewPointService: ReviewPointService) {}

  @Post()
  @ApiOperation({ summary: 'Create new review point' })
  @ApiResponse({ status: 201, description: 'Review point created successfully' })
  create(@Body() createReviewPointDto: CreateReviewPointDto, @Request() req: any) {
    return this.reviewPointService.create(createReviewPointDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all review points' })
  @ApiResponse({ status: 200, description: 'List of review points' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: ReviewPointStatus,
    @Query('category') category?: string,
    @Query('assignedTo') assignedTo?: string,
  ) {
    return this.reviewPointService.findAll(companyId, periodId, status, category as any, assignedTo);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get review points summary by status' })
  @ApiResponse({ status: 200, description: 'Review points summary' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.reviewPointService.getSummaryByStatus(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get review point by ID' })
  @ApiResponse({ status: 200, description: 'Review point details' })
  findById(@Param('id') id: string) {
    return this.reviewPointService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update review point' })
  @ApiResponse({ status: 200, description: 'Review point updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateReviewPointDto: UpdateReviewPointDto,
    @Request() req: any,
  ) {
    return this.reviewPointService.update(id, updateReviewPointDto, req.user.userId);
  }

  @Post(':id/clear')
  @ApiOperation({ summary: 'Clear review point' })
  @ApiResponse({ status: 200, description: 'Review point cleared successfully' })
  clear(
    @Param('id') id: string,
    @Body() body: { clearanceNotes: string },
    @Request() req: any,
  ) {
    return this.reviewPointService.clearReviewPoint(id, body.clearanceNotes, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete review point' })
  @ApiResponse({ status: 200, description: 'Review point deleted successfully' })
  delete(@Param('id') id: string) {
    return this.reviewPointService.delete(id);
  }
}
