import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateLiabilityDto } from './dto/create-liability.dto';
import { UpdateLiabilityDto } from './dto/update-liability.dto';

@Injectable()
export class LiabilityService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateLiabilityDto, userId: string) {
    const [company, period] = await Promise.all([
      this.db.company.findUnique({ where: { id: data.companyId } }),
      this.db.period.findUnique({ where: { id: data.periodId } }),
    ]);

    if (!company) {
      throw new NotFoundException(`Company with ID ${data.companyId} not found`);
    }
    if (!period) {
      throw new NotFoundException(`Period with ID ${data.periodId} not found`);
    }

    // Calculate aging
    const dueDate = new Date(data.dueDate);
    const periodEnd = period.endDate;
    const daysOverdue = this.calculateDaysOverdue(dueDate, periodEnd);
    const agingCategory = this.getAgingCategory(daysOverdue);

    return this.db.liability.create({
      data: {
        companyId: data.companyId,
        periodId: data.periodId,
        creditorName: data.creditorName,
        type: data.type,
        description: data.description,
        amount: data.outstandingBalance,
        openingBalance: data.originalAmount,
        closingBalance: data.outstandingBalance,
        dueDate,
        daysOverdue,
        agingCategory,
        isCurrent: data.isCurrent ?? true,
        reference: data.referenceNumber,
        notes: data.notes,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  async findAll(companyId?: string, periodId?: string, type?: string, isCurrent?: boolean) {
    return this.db.liability.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(type && { type }),
        ...(isCurrent !== undefined && { isCurrent }),
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
      orderBy: [{ dueDate: 'asc' }, { creditorName: 'asc' }],
    });
  }

  async findById(id: string) {
    const liability = await this.db.liability.findUnique({
      where: { id },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });

    if (!liability) {
      throw new NotFoundException(`Liability with ID ${id} not found`);
    }

    return liability;
  }

  async update(id: string, data: UpdateLiabilityDto, userId: string) {
    const liability = await this.findById(id);

    // Recalculate aging if due date changed
    let daysOverdue = liability.daysOverdue;
    let agingCategory = liability.agingCategory;
    if (data.dueDate) {
      const period = await this.db.period.findUnique({ where: { id: liability.periodId } });
      const dueDate = new Date(data.dueDate);
      daysOverdue = this.calculateDaysOverdue(dueDate, period.endDate);
      agingCategory = this.getAgingCategory(daysOverdue);
    }

    return this.db.liability.update({
      where: { id },
      data: {
        ...data,
        dueDate: data.dueDate ? new Date(data.dueDate) : undefined,
        daysOverdue,
        agingCategory,
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  async delete(id: string) {
    await this.findById(id);
    return this.db.liability.delete({ where: { id } });
  }

  async getAgingSummary(companyId: string, periodId: string) {
    const liabilities = await this.db.liability.findMany({
      where: { companyId, periodId },
    });

    const summary = {
      current: 0,
      days30: 0,
      days60: 0,
      days90: 0,
      over90: 0,
      total: 0,
    };

    liabilities.forEach((liability) => {
      const amount = Number(liability.amount);
      summary.total += amount;

      if (liability.daysOverdue <= 0) {
        summary.current += amount;
      } else if (liability.daysOverdue <= 30) {
        summary.days30 += amount;
      } else if (liability.daysOverdue <= 60) {
        summary.days60 += amount;
      } else if (liability.daysOverdue <= 90) {
        summary.days90 += amount;
      } else {
        summary.over90 += amount;
      }
    });

    return summary;
  }

  private calculateDaysOverdue(dueDate: Date, currentDate: Date): number {
    const timeDiff = currentDate.getTime() - dueDate.getTime();
    return Math.floor(timeDiff / (1000 * 3600 * 24));
  }

  private getAgingCategory(daysOverdue: number): string {
    if (daysOverdue <= 0) return 'CURRENT';
    if (daysOverdue <= 30) return '1-30';
    if (daysOverdue <= 60) return '31-60';
    if (daysOverdue <= 90) return '61-90';
    return 'OVER_90';
  }
}
