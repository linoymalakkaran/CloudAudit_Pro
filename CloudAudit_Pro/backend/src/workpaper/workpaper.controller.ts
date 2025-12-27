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
import { WorkpaperService } from './workpaper.service';
import { CreateWorkpaperDto, UpdateWorkpaperDto } from './dto';

@ApiTags('Workpapers')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('workpapers')
export class WorkpaperController {
  constructor(private readonly workpaperService: WorkpaperService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new workpaper' })
  @ApiResponse({ status: 201, description: 'Workpaper created successfully' })
  create(@Request() req, @Body() createDto: CreateWorkpaperDto) {
    return this.workpaperService.create(
      req.user.tenantId,
      req.user.userId,
      createDto,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all workpapers' })
  @ApiResponse({ status: 200, description: 'List of workpapers' })
  findAll(@Request() req, @Query('procedureId') procedureId?: string) {
    return this.workpaperService.findAll(req.user.tenantId, procedureId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a single workpaper' })
  @ApiResponse({ status: 200, description: 'Workpaper details' })
  findOne(@Request() req, @Param('id') id: string) {
    return this.workpaperService.findOne(req.user.tenantId, id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update a workpaper' })
  @ApiResponse({ status: 200, description: 'Workpaper updated successfully' })
  update(
    @Request() req,
    @Param('id') id: string,
    @Body() updateDto: UpdateWorkpaperDto,
  ) {
    return this.workpaperService.update(
      req.user.tenantId,
      req.user.userId,
      id,
      updateDto,
    );
  }

  @Post(':id/review')
  @ApiOperation({ summary: 'Review a workpaper' })
  @ApiResponse({ status: 200, description: 'Workpaper reviewed successfully' })
  review(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { reviewNotes?: string },
  ) {
    return this.workpaperService.review(
      req.user.tenantId,
      req.user.userId,
      id,
      body.reviewNotes,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a workpaper' })
  @ApiResponse({ status: 200, description: 'Workpaper deleted successfully' })
  delete(@Request() req, @Param('id') id: string) {
    return this.workpaperService.delete(req.user.tenantId, id);
  }
}
