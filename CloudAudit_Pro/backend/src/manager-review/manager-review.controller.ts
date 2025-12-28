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
import { ManagerReviewService } from './manager-review.service';
import { CreateManagerReviewDto, UpdateManagerReviewDto, ManagerReviewStatus } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('manager-review')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('manager-reviews')
export class ManagerReviewController {
  constructor(private readonly managerReviewService: ManagerReviewService) {}

  @Post()
  @ApiOperation({ summary: 'Create new manager review' })
  @ApiResponse({ status: 201, description: 'Manager review created successfully' })
  create(@Body() createManagerReviewDto: CreateManagerReviewDto, @Request() req: any) {
    return this.managerReviewService.create(createManagerReviewDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all manager reviews' })
  @ApiResponse({ status: 200, description: 'List of manager reviews' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: ManagerReviewStatus,
    @Query('reviewLevel') reviewLevel?: string,
    @Query('reviewerId') reviewerId?: string,
  ) {
    return this.managerReviewService.findAll(companyId, periodId, status, reviewLevel, reviewerId);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get manager reviews summary by status' })
  @ApiResponse({ status: 200, description: 'Manager reviews summary' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.managerReviewService.getSummaryByStatus(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get manager review by ID' })
  @ApiResponse({ status: 200, description: 'Manager review details' })
  findById(@Param('id') id: string) {
    return this.managerReviewService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update manager review' })
  @ApiResponse({ status: 200, description: 'Manager review updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateManagerReviewDto: UpdateManagerReviewDto,
    @Request() req: any,
  ) {
    return this.managerReviewService.update(id, updateManagerReviewDto, req.user.userId);
  }

  @Post(':id/approve')
  @ApiOperation({ summary: 'Approve manager review' })
  @ApiResponse({ status: 200, description: 'Manager review approved successfully' })
  approve(
    @Param('id') id: string,
    @Body() body: { signOffNotes: string },
    @Request() req: any,
  ) {
    return this.managerReviewService.approveReview(id, body.signOffNotes, req.user.userId);
  }

  @Post(':id/reject')
  @ApiOperation({ summary: 'Reject manager review' })
  @ApiResponse({ status: 200, description: 'Manager review rejected successfully' })
  reject(
    @Param('id') id: string,
    @Body() body: { comments: string },
    @Request() req: any,
  ) {
    return this.managerReviewService.rejectReview(id, body.comments, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete manager review' })
  @ApiResponse({ status: 200, description: 'Manager review deleted successfully' })
  delete(@Param('id') id: string) {
    return this.managerReviewService.delete(id);
  }
}
