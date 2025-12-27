import {
  Controller,
  Get,
  Post,
  Query,
  Body,
  UseGuards,
  Req,
  Res,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { LedgerService } from './ledger.service';
import { LedgerQueryDto, LedgerExportDto, ExportFormat } from './dto';
import { Response } from 'express';

@ApiTags('Ledger')
@Controller('ledger')
// @UseGuards(JwtAuthGuard) // Uncomment when auth is set up
@ApiBearerAuth()
export class LedgerController {
  constructor(private readonly ledgerService: LedgerService) {}

  @Get()
  @ApiOperation({ summary: 'Get ledger entries for an account' })
  @ApiResponse({ status: 200, description: 'Ledger entries retrieved successfully' })
  async getAccountLedger(@Query() query: LedgerQueryDto) {
    return this.ledgerService.getAccountLedger(query);
  }

  @Post('generate')
  @ApiOperation({ summary: 'Generate ledger entries from a posted journal entry' })
  @ApiResponse({ status: 201, description: 'Ledger entries generated successfully' })
  async generateLedger(
    @Body('journalEntryId') journalEntryId: string,
    @Body('tenantId') tenantId: string,
  ) {
    return this.ledgerService.generateLedgerFromJournal(journalEntryId, tenantId);
  }

  @Post('recalculate')
  @ApiOperation({ summary: 'Recalculate running balances for an account' })
  @ApiResponse({ status: 200, description: 'Running balances recalculated successfully' })
  async recalculateBalances(
    @Body('companyId') companyId: string,
    @Body('periodId') periodId: string,
    @Body('accountId') accountId: string,
  ) {
    return this.ledgerService.recalculateRunningBalances(companyId, periodId, accountId);
  }

  @Get('export')
  @ApiOperation({ summary: 'Export ledger to Excel or CSV' })
  @ApiResponse({ status: 200, description: 'Ledger exported successfully' })
  async exportLedger(
    @Query() query: LedgerExportDto,
    @Res() res: Response,
  ) {
    const buffer = await this.ledgerService.exportLedger(query, query.format);

    if (query.format === ExportFormat.EXCEL) {
      res.setHeader(
        'Content-Type',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      );
      res.setHeader(
        'Content-Disposition',
        `attachment; filename=ledger-${Date.now()}.xlsx`,
      );
    } else if (query.format === ExportFormat.CSV) {
      res.setHeader('Content-Type', 'text/csv');
      res.setHeader(
        'Content-Disposition',
        `attachment; filename=ledger-${Date.now()}.csv`,
      );
    }

    res.send(buffer);
  }
}
