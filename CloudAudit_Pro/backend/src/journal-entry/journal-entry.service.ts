import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateJournalEntryDto, UpdateJournalEntryDto, JournalEntryFilterDto } from './dto/journal-entry.dto';
import { JournalEntryStatus } from '../stubs/prisma-types';
import { Decimal } from '@prisma/client/runtime/library';

@Injectable()
export class JournalEntryService {
  constructor(private readonly database: DatabaseService) {}

  async create(createJournalEntryDto: CreateJournalEntryDto, userId: string) {
    // Validate that debit and credit amounts are balanced
    this.validateJournalEntryBalance(createJournalEntryDto.lineItems);

    // Verify company and period exist and user has access
    await this.verifyCompanyAccess(createJournalEntryDto.companyId, userId);
    await this.verifyPeriodExists(createJournalEntryDto.periodId, createJournalEntryDto.companyId);

    // Check if entry number already exists for this company and period
    await this.checkEntryNumberUnique(
      createJournalEntryDto.entryNumber,
      createJournalEntryDto.companyId,
      createJournalEntryDto.periodId,
    );

    // Verify all account IDs exist and belong to the company
    await this.verifyAccountsExist(createJournalEntryDto.lineItems.map(item => item.accountId), createJournalEntryDto.companyId);

    return this.database.journalEntry.create({
      data: {
        companyId: createJournalEntryDto.companyId,
        periodId: createJournalEntryDto.periodId,
        entryNumber: createJournalEntryDto.entryNumber,
        entryDate: new Date(createJournalEntryDto.entryDate),
        description: createJournalEntryDto.description,
        notes: createJournalEntryDto.notes,
        entryType: createJournalEntryDto.entryType,
        referenceDocumentId: createJournalEntryDto.referenceDocumentId,
        referenceNumber: createJournalEntryDto.referenceNumber,
        status: JournalEntryStatus.DRAFT,
        createdBy: userId,
        updatedBy: userId,
        lineItems: {
          create: createJournalEntryDto.lineItems.map(item => ({
            accountId: item.accountId,
            description: item.description,
            debitAmount: new Decimal(item.debitAmount),
            creditAmount: new Decimal(item.creditAmount),
            reference: item.reference,
            createdBy: userId,
            updatedBy: userId,
          })),
        },
      },
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
                accountType: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
          },
        },
        company: {
          select: {
            id: true,
            name: true,
          },
        },
        period: {
          select: {
            id: true,
            name: true,
          },
        },
        referenceDocument: {
          select: {
            id: true,
            name: true,
            type: true,
          },
        },
      },
    });
  }

  async findAll(filters: JournalEntryFilterDto, userId: string) {
    const { page = 1, limit = 20, sortBy = 'entryDate', sortOrder = 'desc', ...filterOptions } = filters;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filterOptions.companyId) {
      // Verify user has access to this company
      await this.verifyCompanyAccess(filterOptions.companyId, userId);
      where.companyId = filterOptions.companyId;
    } else {
      // Get all companies the user has access to
      const userCompanies = await this.getUserCompanies(userId);
      where.companyId = { in: userCompanies.map(c => c.id) };
    }

    if (filterOptions.periodId) where.periodId = filterOptions.periodId;
    if (filterOptions.entryType) where.entryType = filterOptions.entryType;
    if (filterOptions.status) where.status = filterOptions.status;

    if (filterOptions.startDate || filterOptions.endDate) {
      where.entryDate = {};
      if (filterOptions.startDate) where.entryDate.gte = new Date(filterOptions.startDate);
      if (filterOptions.endDate) where.entryDate.lte = new Date(filterOptions.endDate);
    }

    if (filterOptions.accountId) {
      where.lineItems = {
        some: {
          accountId: filterOptions.accountId,
        },
      };
    }

    if (filterOptions.search) {
      where.OR = [
        { description: { contains: filterOptions.search, mode: 'insensitive' } },
        { notes: { contains: filterOptions.search, mode: 'insensitive' } },
        { entryNumber: { contains: filterOptions.search, mode: 'insensitive' } },
        { referenceNumber: { contains: filterOptions.search, mode: 'insensitive' } },
      ];
    }

    const [journalEntries, total] = await Promise.all([
      this.database.journalEntry.findMany({
        where,
        skip,
        take: limit,
        orderBy: { [sortBy]: sortOrder },
        include: {
          lineItems: {
            include: {
              account: {
                select: {
                  id: true,
                  name: true,
                  code: true,
                  accountType: {
                    select: {
                      id: true,
                      name: true,
                    },
                  },
                },
              },
            },
          },
          company: {
            select: {
              id: true,
              name: true,
            },
          },
          period: {
            select: {
              id: true,
              name: true,
            },
          },
          referenceDocument: {
            select: {
              id: true,
              name: true,
              type: true,
            },
          },
        },
      }),
      this.database.journalEntry.count({ where }),
    ]);

    return {
      data: journalEntries,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, userId: string) {
    const journalEntry = await this.database.journalEntry.findUnique({
      where: { id },
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
                accountType: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
          },
          orderBy: {
            createdAt: 'asc',
          },
        },
        company: {
          select: {
            id: true,
            name: true,
          },
        },
        period: {
          select: {
            id: true,
            name: true,
          },
        },
        referenceDocument: {
          select: {
            id: true,
            name: true,
            type: true,
          },
        },
        creator: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
        reviewer: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
        approver: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });

    if (!journalEntry) {
      throw new NotFoundException('Journal entry not found');
    }

    // Verify user has access to this company
    await this.verifyCompanyAccess(journalEntry.companyId, userId);

    return journalEntry;
  }

  async update(id: string, updateJournalEntryDto: UpdateJournalEntryDto, userId: string) {
    const existingEntry = await this.findOne(id, userId);

    // Only allow updates to draft entries
    if (existingEntry.status !== JournalEntryStatus.DRAFT) {
      throw new BadRequestException('Can only update draft journal entries');
    }

    // If line items are being updated, validate balance
    if (updateJournalEntryDto.lineItems) {
      this.validateJournalEntryBalance(updateJournalEntryDto.lineItems);
      
      // Verify all account IDs exist and belong to the company
      await this.verifyAccountsExist(
        updateJournalEntryDto.lineItems.map(item => item.accountId),
        existingEntry.companyId,
      );
    }

    // Prepare update data
    const updateData: any = {
      ...updateJournalEntryDto,
      updatedBy: userId,
    };

    if (updateJournalEntryDto.entryDate) {
      updateData.entryDate = new Date(updateJournalEntryDto.entryDate);
    }

    if (updateJournalEntryDto.lineItems) {
      // Delete existing line items and create new ones
      await this.database.journalLineItem.deleteMany({
        where: { journalEntryId: id },
      });

      updateData.lineItems = {
        create: updateJournalEntryDto.lineItems.map(item => ({
          accountId: item.accountId,
          description: item.description,
          debitAmount: new Decimal(item.debitAmount),
          creditAmount: new Decimal(item.creditAmount),
          reference: item.reference,
          createdBy: userId,
          updatedBy: userId,
        })),
      };
    }

    return this.database.journalEntry.update({
      where: { id },
      data: updateData,
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
                accountType: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
          },
        },
        company: {
          select: {
            id: true,
            name: true,
          },
        },
        period: {
          select: {
            id: true,
            name: true,
          },
        },
        referenceDocument: {
          select: {
            id: true,
            name: true,
            type: true,
          },
        },
      },
    });
  }

  async remove(id: string, userId: string) {
    const existingEntry = await this.findOne(id, userId);

    // Only allow deletion of draft entries
    if (existingEntry.status !== JournalEntryStatus.DRAFT) {
      throw new BadRequestException('Can only delete draft journal entries');
    }

    // Delete line items first due to foreign key constraints
    await this.database.journalLineItem.deleteMany({
      where: { journalEntryId: id },
    });

    await this.database.journalEntry.delete({
      where: { id },
    });

    return { message: 'Journal entry deleted successfully' };
  }

  async submitForReview(id: string, userId: string) {
    const existingEntry = await this.findOne(id, userId);

    if (existingEntry.status !== JournalEntryStatus.DRAFT) {
      throw new BadRequestException('Can only submit draft entries for review');
    }

    return this.database.journalEntry.update({
      where: { id },
      data: {
        status: JournalEntryStatus.PENDING,
        updatedBy: userId,
      },
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
              },
            },
          },
        },
      },
    });
  }

  async review(id: string, action: 'approve' | 'reject', reviewNotes: string, userId: string) {
    const existingEntry = await this.findOne(id, userId);

    if (existingEntry.status !== JournalEntryStatus.PENDING) {
      throw new BadRequestException('Can only review pending entries');
    }

    const newStatus = action === 'approve' ? JournalEntryStatus.APPROVED : JournalEntryStatus.REJECTED;

    return this.database.journalEntry.update({
      where: { id },
      data: {
        status: newStatus,
        reviewNotes,
        reviewedBy: userId,
        reviewedAt: new Date(),
        updatedBy: userId,
      },
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
              },
            },
          },
        },
      },
    });
  }

  async post(id: string, userId: string) {
    const existingEntry = await this.findOne(id, userId);

    if (existingEntry.status !== JournalEntryStatus.APPROVED) {
      throw new BadRequestException('Can only post approved entries');
    }

    return this.database.journalEntry.update({
      where: { id },
      data: {
        status: JournalEntryStatus.POSTED,
        postedBy: userId,
        postedAt: new Date(),
        updatedBy: userId,
      },
      include: {
        lineItems: {
          include: {
            account: {
              select: {
                id: true,
                name: true,
                code: true,
              },
            },
          },
        },
      },
    });
  }

  async getStatistics(companyId?: string, periodId?: string, userId?: string) {
    const where: any = {};

    if (companyId) {
      where.companyId = companyId;
    }

    if (periodId) {
      where.periodId = periodId;
    }

    const [
      totalEntries,
      draftEntries,
      pendingEntries,
      approvedEntries,
      postedEntries,
      rejectedEntries,
      totalDebitAmount,
      totalCreditAmount,
    ] = await Promise.all([
      this.database.journalEntry.count({ where }),
      this.database.journalEntry.count({ where: { ...where, status: JournalEntryStatus.DRAFT } }),
      this.database.journalEntry.count({ where: { ...where, status: JournalEntryStatus.PENDING } }),
      this.database.journalEntry.count({ where: { ...where, status: JournalEntryStatus.APPROVED } }),
      this.database.journalEntry.count({ where: { ...where, status: JournalEntryStatus.POSTED } }),
      this.database.journalEntry.count({ where: { ...where, status: JournalEntryStatus.REJECTED } }),
      this.database.journalLineItem.aggregate({
        where: { journalEntry: where },
        _sum: { debitAmount: true },
      }),
      this.database.journalLineItem.aggregate({
        where: { journalEntry: where },
        _sum: { creditAmount: true },
      }),
    ]);

    return {
      totalEntries,
      statusBreakdown: {
        draft: draftEntries,
        pending: pendingEntries,
        approved: approvedEntries,
        posted: postedEntries,
        rejected: rejectedEntries,
      },
      totals: {
        debits: totalDebitAmount._sum.debitAmount?.toString() || '0',
        credits: totalCreditAmount._sum.creditAmount?.toString() || '0',
      },
    };
  }

  // Helper methods
  private validateJournalEntryBalance(lineItems: any[]) {
    let totalDebits = 0;
    let totalCredits = 0;

    for (const item of lineItems) {
      totalDebits += parseFloat(item.debitAmount);
      totalCredits += parseFloat(item.creditAmount);
    }

    // Allow for small floating point differences
    const difference = Math.abs(totalDebits - totalCredits);
    if (difference > 0.01) {
      throw new BadRequestException('Journal entry is not balanced. Debits must equal credits.');
    }

    if (lineItems.length === 0) {
      throw new BadRequestException('Journal entry must have at least one line item');
    }
  }

  private async verifyCompanyAccess(companyId: string, userId: string) {
    const userCompanies = await this.getUserCompanies(userId);
    const hasAccess = userCompanies.some(company => company.id === companyId);
    
    if (!hasAccess) {
      throw new ForbiddenException('Access denied to this company');
    }
  }

  private async verifyPeriodExists(periodId: string, companyId: string) {
    const period = await this.database.period.findFirst({
      where: { id: periodId, companyId },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }
  }

  private async checkEntryNumberUnique(entryNumber: string, companyId: string, periodId: string, excludeId?: string) {
    const existingEntry = await this.database.journalEntry.findFirst({
      where: {
        entryNumber,
        companyId,
        periodId,
        id: excludeId ? { not: excludeId } : undefined,
      },
    });

    if (existingEntry) {
      throw new BadRequestException('Entry number already exists for this company and period');
    }
  }

  private async verifyAccountsExist(accountIds: string[], companyId: string) {
    const accounts = await this.database.accountHead.findMany({
      where: {
        id: { in: accountIds },
        companyId,
      },
      select: { id: true },
    });

    const foundIds = new Set(accounts.map(a => a.id));
    const missingIds = accountIds.filter(id => !foundIds.has(id));

    if (missingIds.length > 0) {
      throw new NotFoundException(`Accounts not found: ${missingIds.join(', ')}`);
    }
  }

  private async getUserCompanies(userId: string) {
    // This is a simplified implementation - in a real system, you'd check user permissions/roles
    return this.database.company.findMany({
      where: {
        // Add your user access logic here
        // For now, assuming user has access to all companies in their tenant
      },
      select: { id: true, name: true },
    });
  }
}