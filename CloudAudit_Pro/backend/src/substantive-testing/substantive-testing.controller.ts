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
import { SubstantiveTestingService } from './substantive-testing.service';
import { CreateSubstantiveTestDto, UpdateSubstantiveTestDto, TestStatus } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('substantive-testing')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('substantive-testing')
export class SubstantiveTestingController {
  constructor(private readonly substantiveTestingService: SubstantiveTestingService) {}

  @Post()
  @ApiOperation({ summary: 'Create new substantive test' })
  @ApiResponse({ status: 201, description: 'Substantive test created successfully' })
  create(@Body() createSubstantiveTestDto: CreateSubstantiveTestDto, @Request() req: any) {
    return this.substantiveTestingService.create(createSubstantiveTestDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all substantive tests' })
  @ApiResponse({ status: 200, description: 'List of substantive tests' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: TestStatus,
    @Query('testType') testType?: string,
    @Query('hasException') hasException?: string,
  ) {
    return this.substantiveTestingService.findAll(
      companyId,
      periodId,
      status,
      testType,
      hasException === 'true',
    );
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get substantive testing summary' })
  @ApiResponse({ status: 200, description: 'Substantive testing summary' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.substantiveTestingService.getSummary(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get substantive test by ID' })
  @ApiResponse({ status: 200, description: 'Substantive test details' })
  findById(@Param('id') id: string) {
    return this.substantiveTestingService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update substantive test' })
  @ApiResponse({ status: 200, description: 'Substantive test updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateSubstantiveTestDto: UpdateSubstantiveTestDto,
    @Request() req: any,
  ) {
    return this.substantiveTestingService.update(id, updateSubstantiveTestDto, req.user.userId);
  }

  @Post(':id/complete')
  @ApiOperation({ summary: 'Complete substantive test' })
  @ApiResponse({ status: 200, description: 'Substantive test completed successfully' })
  complete(@Param('id') id: string, @Body() body: { conclusion: string }, @Request() req: any) {
    return this.substantiveTestingService.completeTest(id, body.conclusion, req.user.userId);
  }

  @Post(':id/review')
  @ApiOperation({ summary: 'Review substantive test' })
  @ApiResponse({ status: 200, description: 'Substantive test reviewed successfully' })
  review(
    @Param('id') id: string,
    @Body() body: { reviewComments: string },
    @Request() req: any,
  ) {
    return this.substantiveTestingService.reviewTest(id, body.reviewComments, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete substantive test' })
  @ApiResponse({ status: 200, description: 'Substantive test deleted successfully' })
  delete(@Param('id') id: string) {
    return this.substantiveTestingService.delete(id);
  }
}
