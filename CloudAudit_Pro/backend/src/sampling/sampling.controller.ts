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
import { SamplingService } from './sampling.service';
import { CreateSamplingDto, UpdateSamplingDto, SamplingStatus } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('sampling')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('sampling')
export class SamplingController {
  constructor(private readonly samplingService: SamplingService) {}

  @Post()
  @ApiOperation({ summary: 'Create new sampling plan' })
  @ApiResponse({ status: 201, description: 'Sampling plan created successfully' })
  create(@Body() createSamplingDto: CreateSamplingDto, @Request() req: any) {
    return this.samplingService.create(createSamplingDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all sampling plans' })
  @ApiResponse({ status: 200, description: 'List of sampling plans' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: SamplingStatus,
    @Query('samplingMethod') samplingMethod?: string,
  ) {
    return this.samplingService.findAll(companyId, periodId, status, samplingMethod);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get sampling summary' })
  @ApiResponse({ status: 200, description: 'Sampling summary' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.samplingService.getSummary(companyId, periodId);
  }

  @Get('calculate-sample-size')
  @ApiOperation({ summary: 'Calculate recommended sample size' })
  @ApiResponse({ status: 200, description: 'Calculated sample size' })
  calculateSampleSize(
    @Query('populationSize') populationSize: number,
    @Query('confidenceLevel') confidenceLevel: number,
    @Query('tolerableError') tolerableError: number,
    @Query('expectedError') expectedError: number,
  ) {
    return this.samplingService.calculateSampleSize(
      +populationSize,
      +confidenceLevel,
      +tolerableError,
      +expectedError,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get sampling plan by ID' })
  @ApiResponse({ status: 200, description: 'Sampling plan details' })
  findById(@Param('id') id: string) {
    return this.samplingService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update sampling plan' })
  @ApiResponse({ status: 200, description: 'Sampling plan updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateSamplingDto: UpdateSamplingDto,
    @Request() req: any,
  ) {
    return this.samplingService.update(id, updateSamplingDto, req.user.userId);
  }

  @Post(':id/generate-sample')
  @ApiOperation({ summary: 'Generate random sample selection' })
  @ApiResponse({ status: 200, description: 'Sample selection generated' })
  generateSample(@Param('id') id: string, @Body() body: { populationIds: string[] }) {
    return this.samplingService.generateRandomSample(id, body.populationIds);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete sampling plan' })
  @ApiResponse({ status: 200, description: 'Sampling plan deleted successfully' })
  delete(@Param('id') id: string) {
    return this.samplingService.delete(id);
  }
}
