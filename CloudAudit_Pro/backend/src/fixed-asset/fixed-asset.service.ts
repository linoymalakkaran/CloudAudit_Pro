import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateFixedAssetDto } from './dto/create-fixed-asset.dto';
import { UpdateFixedAssetDto } from './dto/update-fixed-asset.dto';
import { DepreciationMethod } from '@prisma/client';

@Injectable()
export class FixedAssetService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateFixedAssetDto, userId: string) {
    // Validate company and period
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

    // Calculate initial depreciation
    const depreciationExpense = this.calculateDepreciation(
      data.originalCost,
      data.accumulatedDepreciation || 0,
      data.salvageValue || 0,
      data.usefulLife,
      data.depreciationMethod,
      new Date(data.purchaseDate),
      period.startDate,
      period.endDate,
    );

    return this.db.fixedAsset.create({
      data: {
        ...data,
        purchaseDate: new Date(data.purchaseDate),
        disposalDate: data.disposalDate ? new Date(data.disposalDate) : null,
        accumulatedDepreciation: data.accumulatedDepreciation || 0,
        salvageValue: data.salvageValue || 0,
        depreciationExpense,
        netBookValue: data.originalCost - (data.accumulatedDepreciation || 0) - depreciationExpense,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true, startDate: true, endDate: true } },
      },
    });
  }

  async findAll(companyId?: string, periodId?: string, category?: string) {
    return this.db.fixedAsset.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(category && { category }),
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
      orderBy: [{ category: 'asc' }, { purchaseDate: 'desc' }],
    });
  }

  async findById(id: string) {
    const asset = await this.db.fixedAsset.findUnique({
      where: { id },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true, startDate: true, endDate: true } },
      },
    });

    if (!asset) {
      throw new NotFoundException(`Fixed asset with ID ${id} not found`);
    }

    return asset;
  }

  async update(id: string, data: UpdateFixedAssetDto, userId: string) {
    const asset = await this.findById(id);

    // Recalculate depreciation if relevant fields changed
    let depreciationExpense = asset.depreciationExpense;
    if (
      data.originalCost !== undefined ||
      data.accumulatedDepreciation !== undefined ||
      data.salvageValue !== undefined ||
      data.usefulLife !== undefined ||
      data.depreciationMethod !== undefined
    ) {
      depreciationExpense = this.calculateDepreciation(
        data.originalCost ?? asset.originalCost,
        data.accumulatedDepreciation ?? asset.accumulatedDepreciation,
        data.salvageValue ?? asset.salvageValue,
        data.usefulLife ?? asset.usefulLife,
        data.depreciationMethod ?? asset.depreciationMethod,
        data.purchaseDate ? new Date(data.purchaseDate) : asset.purchaseDate,
        asset.period.startDate,
        asset.period.endDate,
      );
    }

    const originalCost = data.originalCost ?? asset.originalCost;
    const accumulatedDep = data.accumulatedDepreciation ?? asset.accumulatedDepreciation;
    const netBookValue = originalCost - accumulatedDep - depreciationExpense;

    return this.db.fixedAsset.update({
      where: { id },
      data: {
        ...data,
        purchaseDate: data.purchaseDate ? new Date(data.purchaseDate) : undefined,
        disposalDate: data.disposalDate ? new Date(data.disposalDate) : undefined,
        depreciationExpense,
        netBookValue,
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
    return this.db.fixedAsset.delete({ where: { id } });
  }

  async getSummaryByCategory(companyId: string, periodId: string) {
    const assets = await this.db.fixedAsset.findMany({
      where: { companyId, periodId },
    });

    const summary = assets.reduce((acc, asset) => {
      if (!acc[asset.category]) {
        acc[asset.category] = {
          category: asset.category,
          count: 0,
          totalCost: 0,
          totalDepreciation: 0,
          totalNetBookValue: 0,
        };
      }
      acc[asset.category].count++;
      acc[asset.category].totalCost += Number(asset.originalCost);
      acc[asset.category].totalDepreciation += Number(asset.accumulatedDepreciation) + Number(asset.depreciationExpense);
      acc[asset.category].totalNetBookValue += Number(asset.netBookValue);
      return acc;
    }, {} as Record<string, any>);

    return Object.values(summary);
  }

  private calculateDepreciation(
    cost: number,
    accumulatedDep: number,
    salvageValue: number,
    usefulLife: number,
    method: DepreciationMethod,
    purchaseDate: Date,
    periodStart: Date,
    periodEnd: Date,
  ): number {
    const depreciableAmount = cost - salvageValue;
    const monthsInPeriod = this.getMonthsBetween(periodStart, periodEnd);
    const monthsSincePurchase = this.getMonthsBetween(purchaseDate, periodEnd);
    const monthsToDepreciate = Math.min(monthsInPeriod, monthsSincePurchase);

    if (monthsToDepreciate <= 0 || usefulLife <= 0) return 0;

    switch (method) {
      case DepreciationMethod.STRAIGHT_LINE:
        const annualDepreciation = depreciableAmount / usefulLife;
        return (annualDepreciation * monthsToDepreciate) / 12;

      case DepreciationMethod.DECLINING_BALANCE:
        const rate = 2 / usefulLife; // Double declining balance
        const bookValue = cost - accumulatedDep;
        return Math.min(bookValue * rate * (monthsToDepreciate / 12), bookValue - salvageValue);

      case DepreciationMethod.UNITS_OF_PRODUCTION:
        // For units of production, would need additional data
        // Fall back to straight line for now
        return (depreciableAmount / usefulLife * monthsToDepreciate) / 12;

      default:
        return (depreciableAmount / usefulLife * monthsToDepreciate) / 12;
    }
  }

  private getMonthsBetween(start: Date, end: Date): number {
    const startDate = new Date(start);
    const endDate = new Date(end);
    return (
      (endDate.getFullYear() - startDate.getFullYear()) * 12 +
      (endDate.getMonth() - startDate.getMonth()) +
      1
    );
  }
}
