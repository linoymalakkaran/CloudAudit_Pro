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
import { InternalControlsService } from './internal-controls.service';
import { CreateInternalControlDto, UpdateInternalControlDto, ControlEffectiveness } from './dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('internal-controls')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('internal-controls')
export class InternalControlsController {
  constructor(private readonly internalControlsService: InternalControlsService) {}

  @Post()
  @ApiOperation({ summary: 'Create new internal control' })
  @ApiResponse({ status: 201, description: 'Internal control created successfully' })
  create(@Body() createInternalControlDto: CreateInternalControlDto, @Request() req: any) {
    return this.internalControlsService.create(createInternalControlDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all internal controls' })
  @ApiResponse({ status: 200, description: 'List of internal controls' })
  findAll(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('processArea') processArea?: string,
    @Query('controlType') controlType?: string,
    @Query('controlEffectiveness') controlEffectiveness?: ControlEffectiveness,
    @Query('isKeyControl') isKeyControl?: string,
    @Query('deficiencyIdentified') deficiencyIdentified?: string,
  ) {
    return this.internalControlsService.findAll(
      companyId,
      periodId,
      processArea,
      controlType as any,
      controlEffectiveness,
      isKeyControl === 'true',
      deficiencyIdentified === 'true',
    );
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get internal controls summary' })
  @ApiResponse({ status: 200, description: 'Internal controls summary' })
  getSummary(@Query('companyId') companyId: string, @Query('periodId') periodId: string) {
    return this.internalControlsService.getSummary(companyId, periodId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get internal control by ID' })
  @ApiResponse({ status: 200, description: 'Internal control details' })
  findById(@Param('id') id: string) {
    return this.internalControlsService.findById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update internal control' })
  @ApiResponse({ status: 200, description: 'Internal control updated successfully' })
  update(
    @Param('id') id: string,
    @Body() updateInternalControlDto: UpdateInternalControlDto,
    @Request() req: any,
  ) {
    return this.internalControlsService.update(id, updateInternalControlDto, req.user.userId);
  }

  @Post(':id/test')
  @ApiOperation({ summary: 'Test internal control' })
  @ApiResponse({ status: 200, description: 'Control tested successfully' })
  testControl(
    @Param('id') id: string,
    @Body()
    body: {
      testProcedures: string;
      testResult: string;
      controlEffectiveness: ControlEffectiveness;
    },
    @Request() req: any,
  ) {
    return this.internalControlsService.testControl(
      id,
      body.testProcedures,
      body.testResult,
      body.controlEffectiveness,
      req.user.userId,
    );
  }

  @Post(':id/deficiency')
  @ApiOperation({ summary: 'Identify control deficiency' })
  @ApiResponse({ status: 200, description: 'Deficiency identified successfully' })
  identifyDeficiency(
    @Param('id') id: string,
    @Body()
    body: {
      deficiencyDescription: string;
      remediationPlan: string;
      remediationDeadline: Date;
    },
    @Request() req: any,
  ) {
    return this.internalControlsService.identifyDeficiency(
      id,
      body.deficiencyDescription,
      body.remediationPlan,
      body.remediationDeadline,
      req.user.userId,
    );
  }

  @Post(':id/review')
  @ApiOperation({ summary: 'Review internal control' })
  @ApiResponse({ status: 200, description: 'Control reviewed successfully' })
  reviewControl(
    @Param('id') id: string,
    @Body() body: { conclusion: string },
    @Request() req: any,
  ) {
    return this.internalControlsService.reviewControl(id, body.conclusion, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete internal control' })
  @ApiResponse({ status: 200, description: 'Internal control deleted successfully' })
  delete(@Param('id') id: string) {
    return this.internalControlsService.delete(id);
  }
}
