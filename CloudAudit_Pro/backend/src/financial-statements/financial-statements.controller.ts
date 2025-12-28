import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FinancialStatementsService } from './financial-statements.service';
import { CreateStatementDto } from './dto/create-statement.dto';
import { UpdateStatementDto } from './dto/update-statement.dto';
import { StatementType, StatementStatus } from '@prisma/client';

@ApiTags('financial-statements')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('financial-statements')
export class FinancialStatementsController {
  constructor(private readonly financialStatementsService: FinancialStatementsService) {}

  @Post()
  @ApiOperation({ summary: 'Create financial statement' })
  create(@Body() createStatementDto: CreateStatementDto, @Request() req) {
    return this.financialStatementsService.create(
      createStatementDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all statements' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'periodId', required: false })
  @ApiQuery({ name: 'statementType', required: false, enum: StatementType })
  @ApiQuery({ name: 'status', required: false, enum: StatementStatus })
  findAll(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('statementType') statementType?: StatementType,
    @Query('status') status?: StatementStatus,
  ) {
    return this.financialStatementsService.findAll(
      req.user.tenantId,
      companyId,
      periodId,
      statementType,
      status,
    );
  }

  @Get('comparative')
  @ApiOperation({ summary: 'Get comparative financial statements' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: true })
  @ApiQuery({ name: 'comparisonPeriodId', required: true })
  @ApiQuery({ name: 'statementType', required: true, enum: StatementType })
  getComparative(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId: string,
    @Query('comparisonPeriodId') comparisonPeriodId: string,
    @Query('statementType') statementType: StatementType,
  ) {
    return this.financialStatementsService.getComparative(
      companyId,
      periodId,
      comparisonPeriodId,
      statementType,
      req.user.tenantId,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get statement by ID' })
  findOne(@Param('id') id: string, @Request() req) {
    return this.financialStatementsService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update statement' })
  update(
    @Param('id') id: string,
    @Body() updateStatementDto: UpdateStatementDto,
    @Request() req,
  ) {
    return this.financialStatementsService.update(
      id,
      updateStatementDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete statement' })
  remove(@Param('id') id: string, @Request() req) {
    return this.financialStatementsService.remove(id, req.user.tenantId);
  }

  @Post('generate')
  @ApiOperation({ summary: 'Generate financial statement' })
  @ApiQuery({ name: 'companyId', required: true })
  @ApiQuery({ name: 'periodId', required: true })
  @ApiQuery({ name: 'statementType', required: true, enum: StatementType })
  generate(
    @Request() req,
    @Query('companyId') companyId: string,
    @Query('periodId') periodId: string,
    @Query('statementType') statementType: StatementType,
  ) {
    return this.financialStatementsService.generate(
      companyId,
      periodId,
      statementType,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Post(':id/approve')
  @ApiOperation({ summary: 'Approve statement' })
  approve(@Param('id') id: string, @Request() req) {
    return this.financialStatementsService.approve(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/issue')
  @ApiOperation({ summary: 'Issue statement' })
  issue(@Param('id') id: string, @Request() req) {
    return this.financialStatementsService.issue(id, req.user.tenantId, req.user.sub);
  }

  @Post(':id/notes')
  @ApiOperation({ summary: 'Add notes to statement' })
  addNotes(
    @Param('id') id: string,
    @Body() body: { notes: any[] },
    @Request() req,
  ) {
    return this.financialStatementsService.addNotes(
      id,
      body.notes,
      req.user.tenantId,
      req.user.sub,
    );
  }
}
