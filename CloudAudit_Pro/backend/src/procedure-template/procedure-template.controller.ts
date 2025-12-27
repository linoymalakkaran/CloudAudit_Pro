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
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ProcedureTemplateService } from './procedure-template.service';
import { CreateProcedureTemplateDto, UpdateProcedureTemplateDto, QueryProcedureTemplateDto } from './dto';

@Controller('procedure-templates')
@UseGuards(JwtAuthGuard)
export class ProcedureTemplateController {
  constructor(private readonly templateService: ProcedureTemplateService) {}

  @Get()
  async findAll(@Request() req, @Query() query: QueryProcedureTemplateDto) {
    return this.templateService.findAll(req.user.tenantId, query);
  }

  @Get('statistics')
  async getStatistics(@Request() req) {
    return this.templateService.getStatistics(req.user.tenantId);
  }

  @Get(':id')
  async findOne(@Request() req, @Param('id') id: string) {
    return this.templateService.findOne(req.user.tenantId, id);
  }

  @Post()
  async create(@Request() req, @Body() dto: CreateProcedureTemplateDto) {
    return this.templateService.create(req.user.tenantId, req.user.sub, dto);
  }

  @Put(':id')
  async update(
    @Request() req,
    @Param('id') id: string,
    @Body() dto: UpdateProcedureTemplateDto,
  ) {
    return this.templateService.update(req.user.tenantId, id, dto);
  }

  @Delete(':id')
  async delete(@Request() req, @Param('id') id: string) {
    return this.templateService.delete(req.user.tenantId, id);
  }
}
