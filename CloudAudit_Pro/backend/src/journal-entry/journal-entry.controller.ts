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
  HttpStatus,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiParam,
  ApiQuery,
} from '@nestjs/swagger';
import { JournalEntryService } from './journal-entry.service';
import {
  CreateJournalEntryDto,
  UpdateJournalEntryDto,
  JournalEntryFilterDto,
  JournalEntryApprovalDto,
  JournalEntryReviewDto,
} from './dto/journal-entry.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Journal Entries')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('journal-entries')
export class JournalEntryController {
  constructor(private readonly journalEntryService: JournalEntryService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new journal entry' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Journal entry created successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Validation error or journal entry not balanced',
  })
  async create(@Body() createJournalEntryDto: CreateJournalEntryDto, @Request() req: any) {
    return this.journalEntryService.create(createJournalEntryDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all journal entries with filtering and pagination' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entries retrieved successfully',
  })
  async findAll(@Query() filters: JournalEntryFilterDto, @Request() req: any) {
    return this.journalEntryService.findAll(filters, req.user.id);
  }

  @Get('statistics')
  @ApiOperation({ summary: 'Get journal entry statistics' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Statistics retrieved successfully',
  })
  @ApiQuery({ name: 'companyId', required: false, description: 'Filter by company ID' })
  @ApiQuery({ name: 'periodId', required: false, description: 'Filter by period ID' })
  async getStatistics(
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Request() req?: any,
  ) {
    return this.journalEntryService.getStatistics(companyId, periodId, req?.user?.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a specific journal entry by ID' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry retrieved successfully',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async findOne(@Param('id') id: string, @Request() req: any) {
    return this.journalEntryService.findOne(id, req.user.id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update a journal entry (only draft entries)' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry updated successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Validation error or cannot update non-draft entry',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async update(
    @Param('id') id: string,
    @Body() updateJournalEntryDto: UpdateJournalEntryDto,
    @Request() req: any,
  ) {
    return this.journalEntryService.update(id, updateJournalEntryDto, req.user.id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a journal entry (only draft entries)' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry deleted successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Cannot delete non-draft entry',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async remove(@Param('id') id: string, @Request() req: any) {
    return this.journalEntryService.remove(id, req.user.id);
  }

  @Put(':id/submit')
  @ApiOperation({ summary: 'Submit journal entry for review' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry submitted for review successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Cannot submit non-draft entry',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async submitForReview(@Param('id') id: string, @Request() req: any) {
    return this.journalEntryService.submitForReview(id, req.user.id);
  }

  @Put(':id/review')
  @ApiOperation({ summary: 'Review and approve/reject journal entry' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry reviewed successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Cannot review non-pending entry',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async review(
    @Param('id') id: string,
    @Body() reviewDto: JournalEntryReviewDto,
    @Request() req: any,
  ) {
    return this.journalEntryService.review(id, reviewDto.action, reviewDto.reviewNotes, req.user.id);
  }

  @Put(':id/post')
  @ApiOperation({ summary: 'Post journal entry to the ledger' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Journal entry posted successfully',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Cannot post non-approved entry',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Journal entry not found',
  })
  @ApiParam({ name: 'id', description: 'Journal entry ID' })
  async post(@Param('id') id: string, @Request() req: any) {
    return this.journalEntryService.post(id, req.user.id);
  }
}