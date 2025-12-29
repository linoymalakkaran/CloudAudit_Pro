import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateEquityDto } from './dto/create-equity.dto';
import { UpdateEquityDto } from './dto/update-equity.dto';

@Injectable()
export class EquityService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateEquityDto, userId: string) {
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

    // Calculate movement
    const movement = (data.additions || 0) - (data.reductions || 0);

    return this.db.equity.create({
      data: {
        companyId: data.companyId,
        periodId: data.periodId,
        type: data.type,
        description: data.description,
        openingBalance: data.openingBalance,
        additions: data.additions || 0,
        reductions: data.reductions || 0,
        movement,
        closingBalance: data.closingBalance,
        transactionDate: data.transactionDate ? new Date(data.transactionDate) : null,
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

  async findAll(companyId?: string, periodId?: string, type?: string) {
    return this.db.equity.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(type && { type }),
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
      orderBy: [{ type: 'asc' }, { transactionDate: 'desc' }],
    });
  }

  async findById(id: string) {
    const equity = await this.db.equity.findUnique({
      where: { id },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });

    if (!equity) {
      throw new NotFoundException(`Equity with ID ${id} not found`);
    }

    return equity;
  }

  async update(id: string, data: UpdateEquityDto, userId: string) {
    await this.findById(id);

    // Recalculate movement
    const movement =
      (data.additions !== undefined ? data.additions : 0) -
      (data.reductions !== undefined ? data.reductions : 0);

    return this.db.equity.update({
      where: { id },
      data: {
        ...data,
        transactionDate: data.transactionDate ? new Date(data.transactionDate) : undefined,
        movement,
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
    return this.db.equity.delete({ where: { id } });
  }

  async getSummaryByType(companyId: string, periodId: string) {
    const equities = await this.db.equity.findMany({
      where: { companyId, periodId },
    });

    const summary = equities.reduce((acc, equity) => {
      if (!acc[equity.type]) {
        acc[equity.type] = {
          type: equity.type,
          totalOpening: 0,
          totalAdditions: 0,
          totalReductions: 0,
          totalClosing: 0,
          totalMovement: 0,
        };
      }
      acc[equity.type].totalOpening += Number(equity.openingBalance);
      acc[equity.type].totalAdditions += Number(equity.additions);
      acc[equity.type].totalReductions += Number(equity.reductions);
      acc[equity.type].totalClosing += Number(equity.closingBalance);
      acc[equity.type].totalMovement += Number(equity.movement);
      return acc;
    }, {} as Record<string, any>);

    return Object.values(summary);
  }
}
