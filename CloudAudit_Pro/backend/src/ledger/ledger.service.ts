import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { LedgerQueryDto, ExportFormat } from './dto';
import { Prisma } from '@prisma/client';
import * as ExcelJS from 'exceljs';

@Injectable()
export class LedgerService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Generate ledger entries from journal entries
   * This should be called whenever a journal entry is posted
   */
  async generateLedgerFromJournal(journalEntryId: string, tenantId: string) {
    // Get the journal entry with line items
    const journalEntry = await this.prisma.journalEntry.findUnique({
      where: { id: journalEntryId },
      include: {
        lineItems: {
          orderBy: { lineNumber: 'asc' },
        },
      },
    });

    if (!journalEntry) {
      throw new NotFoundException(`Journal entry ${journalEntryId} not found`);
    }

    if (!journalEntry.isPosted) {
      throw new BadRequestException('Journal entry must be posted before generating ledger entries');
    }

    // Create ledger entries for each line item
    const ledgerEntries = [];
    
    for (const lineItem of journalEntry.lineItems) {
      // Get the next sequence number for this account
      const lastEntry = await this.prisma.ledger.findFirst({
        where: {
          companyId: journalEntry.companyId,
          periodId: journalEntry.periodId,
          accountId: lineItem.accountId,
        },
        orderBy: { sequenceNumber: 'desc' },
      });

      const sequenceNumber = lastEntry ? lastEntry.sequenceNumber + 1 : 1;

      // Calculate running balance
      const previousBalance = lastEntry ? lastEntry.runningBalance : 0;
      const debitAmount = lineItem.debitAmount;
      const creditAmount = lineItem.creditAmount;
      
      // Get account type to determine balance calculation
      const account = await this.prisma.accountHead.findUnique({
        where: { id: lineItem.accountId },
        include: { accountType: true },
      });

      let runningBalance = Number(previousBalance);
      
      // Calculate running balance based on account type
      if (account.accountType.normalBalance === 'DEBIT') {
        runningBalance = Number(previousBalance) + Number(debitAmount) - Number(creditAmount);
      } else {
        runningBalance = Number(previousBalance) - Number(debitAmount) + Number(creditAmount);
      }

      const ledgerEntry = await this.prisma.ledger.create({
        data: {
          companyId: journalEntry.companyId,
          periodId: journalEntry.periodId,
          accountId: lineItem.accountId,
          journalEntryId: journalEntry.id,
          lineItemId: lineItem.id,
          tenantId,
          transactionDate: journalEntry.entryDate,
          journalNumber: journalEntry.journalNumber,
          description: lineItem.description || journalEntry.description,
          reference: lineItem.reference || journalEntry.referenceNumber,
          debitAmount,
          creditAmount,
          runningBalance,
          sequenceNumber,
          createdBy: journalEntry.postedBy,
        },
      });

      ledgerEntries.push(ledgerEntry);
    }

    return ledgerEntries;
  }

  /**
   * Get ledger entries for an account
   */
  async getAccountLedger(query: LedgerQueryDto) {
    const { companyId, periodId, accountId, startDate, endDate } = query;

    // Build where clause
    const where: Prisma.LedgerWhereInput = {
      companyId,
      periodId,
      accountId,
    };

    if (startDate || endDate) {
      where.transactionDate = {};
      if (startDate) {
        where.transactionDate.gte = new Date(startDate);
      }
      if (endDate) {
        where.transactionDate.lte = new Date(endDate);
      }
    }

    // Get ledger entries
    const entries = await this.prisma.ledger.findMany({
      where,
      include: {
        account: {
          include: {
            accountType: true,
          },
        },
        journalEntry: true,
      },
      orderBy: [
        { transactionDate: 'asc' },
        { sequenceNumber: 'asc' },
      ],
    });

    // Get opening balance
    let openingBalance = 0;
    if (startDate) {
      const previousEntries = await this.prisma.ledger.findMany({
        where: {
          companyId,
          periodId,
          accountId,
          transactionDate: {
            lt: new Date(startDate),
          },
        },
        orderBy: { sequenceNumber: 'desc' },
        take: 1,
      });

      if (previousEntries.length > 0) {
        openingBalance = Number(previousEntries[0].runningBalance);
      }
    } else {
      // Get account's opening balance
      const account = await this.prisma.accountHead.findUnique({
        where: { id: accountId },
      });
      openingBalance = Number(account.openingBalance);
    }

    return {
      openingBalance,
      entries,
      closingBalance: entries.length > 0 ? Number(entries[entries.length - 1].runningBalance) : openingBalance,
    };
  }

  /**
   * Recalculate running balances for an account
   * Useful after data corrections or imports
   */
  async recalculateRunningBalances(companyId: string, periodId: string, accountId: string) {
    // Get all ledger entries for the account
    const entries = await this.prisma.ledger.findMany({
      where: {
        companyId,
        periodId,
        accountId,
      },
      include: {
        account: {
          include: {
            accountType: true,
          },
        },
      },
      orderBy: [
        { transactionDate: 'asc' },
        { sequenceNumber: 'asc' },
      ],
    });

    if (entries.length === 0) {
      return { updated: 0 };
    }

    // Get account opening balance
    const account = entries[0].account;
    const normalBalance = account.accountType.normalBalance;
    let runningBalance = Number(account.openingBalance);

    // Update each entry
    const updates = [];
    for (const entry of entries) {
      const debit = Number(entry.debitAmount);
      const credit = Number(entry.creditAmount);

      if (normalBalance === 'DEBIT') {
        runningBalance = runningBalance + debit - credit;
      } else {
        runningBalance = runningBalance - debit + credit;
      }

      updates.push(
        this.prisma.ledger.update({
          where: { id: entry.id },
          data: { runningBalance },
        })
      );
    }

    await Promise.all(updates);

    return { updated: updates.length };
  }

  /**
   * Export ledger to Excel
   */
  async exportLedger(query: LedgerQueryDto, format: ExportFormat) {
    const ledgerData = await this.getAccountLedger(query);
    
    if (format === ExportFormat.EXCEL) {
      return this.exportToExcel(ledgerData, query);
    } else if (format === ExportFormat.CSV) {
      return this.exportToCSV(ledgerData);
    }
    
    throw new BadRequestException(`Export format ${format} not supported yet`);
  }

  private async exportToExcel(ledgerData: any, query: LedgerQueryDto) {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Ledger');

    // Get account details
    const account = await this.prisma.accountHead.findUnique({
      where: { id: query.accountId },
      include: { accountType: true },
    });

    // Header
    worksheet.mergeCells('A1:G1');
    worksheet.getCell('A1').value = `General Ledger - ${account.name} (${account.code})`;
    worksheet.getCell('A1').font = { bold: true, size: 14 };
    worksheet.getCell('A1').alignment = { horizontal: 'center' };

    // Add period info
    worksheet.mergeCells('A2:G2');
    const period = await this.prisma.period.findUnique({
      where: { id: query.periodId },
    });
    worksheet.getCell('A2').value = `Period: ${period.name}`;
    worksheet.getCell('A2').alignment = { horizontal: 'center' };

    // Column headers
    worksheet.addRow([]);
    const headerRow = worksheet.addRow([
      'Date',
      'Journal No.',
      'Description',
      'Reference',
      'Debit',
      'Credit',
      'Balance',
    ]);
    
    headerRow.font = { bold: true };
    headerRow.alignment = { horizontal: 'center' };
    
    // Add opening balance
    worksheet.addRow([
      '',
      '',
      'Opening Balance',
      '',
      '',
      '',
      ledgerData.openingBalance.toFixed(2),
    ]);

    // Add entries
    for (const entry of ledgerData.entries) {
      worksheet.addRow([
        new Date(entry.transactionDate).toLocaleDateString(),
        entry.journalNumber,
        entry.description,
        entry.reference,
        Number(entry.debitAmount) > 0 ? Number(entry.debitAmount).toFixed(2) : '',
        Number(entry.creditAmount) > 0 ? Number(entry.creditAmount).toFixed(2) : '',
        Number(entry.runningBalance).toFixed(2),
      ]);
    }

    // Add closing balance
    const closingRow = worksheet.addRow([
      '',
      '',
      'Closing Balance',
      '',
      '',
      '',
      ledgerData.closingBalance.toFixed(2),
    ]);
    closingRow.font = { bold: true };

    // Format columns
    worksheet.columns = [
      { width: 15 },  // Date
      { width: 15 },  // Journal No.
      { width: 30 },  // Description
      { width: 15 },  // Reference
      { width: 15 },  // Debit
      { width: 15 },  // Credit
      { width: 15 },  // Balance
    ];

    // Generate buffer
    const buffer = await workbook.xlsx.writeBuffer();
    return buffer;
  }

  private exportToCSV(ledgerData: any) {
    const rows = [];
    rows.push(['Date', 'Journal No.', 'Description', 'Reference', 'Debit', 'Credit', 'Balance']);
    rows.push(['', '', 'Opening Balance', '', '', '', ledgerData.openingBalance.toFixed(2)]);
    
    for (const entry of ledgerData.entries) {
      rows.push([
        new Date(entry.transactionDate).toLocaleDateString(),
        entry.journalNumber,
        entry.description,
        entry.reference,
        Number(entry.debitAmount) > 0 ? Number(entry.debitAmount).toFixed(2) : '',
        Number(entry.creditAmount) > 0 ? Number(entry.creditAmount).toFixed(2) : '',
        Number(entry.runningBalance).toFixed(2),
      ]);
    }
    
    rows.push(['', '', 'Closing Balance', '', '', '', ledgerData.closingBalance.toFixed(2)]);
    
    return rows.map(row => row.join(',')).join('\n');
  }

  /**
   * Delete ledger entries for a journal entry
   * Called when a journal entry is unposted or deleted
   */
  async deleteLedgerEntries(journalEntryId: string) {
    const deleted = await this.prisma.ledger.deleteMany({
      where: { journalEntryId },
    });

    return { deleted: deleted.count };
  }
}
