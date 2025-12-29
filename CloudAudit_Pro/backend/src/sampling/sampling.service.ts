import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateSamplingDto, UpdateSamplingDto, SamplingStatus } from './dto';
import { SamplingMethod } from '@prisma/client';

@Injectable()
export class SamplingService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateSamplingDto, userId: string) {
    // Verify company and period exist
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

    // Validate sample size
    if (data.sampleSize > data.populationSize) {
      throw new BadRequestException('Sample size cannot exceed population size');
    }

    // Verify procedure if provided
    if (data.procedureId) {
      const procedure = await this.db.auditProcedure.findUnique({
        where: { id: data.procedureId },
      });
      if (!procedure) {
        throw new NotFoundException(`Procedure with ID ${data.procedureId} not found`);
      }
    }

    // Verify account if provided
    if (data.accountId) {
      const account = await this.db.accountHead.findUnique({
        where: { id: data.accountId },
      });
      if (!account) {
        throw new NotFoundException(`Account with ID ${data.accountId} not found`);
      }
    }

    const sampling = await this.db.sampling.create({
      data: {
        ...data,
        status: data.status || SamplingStatus.PLANNED,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return sampling;
  }

  async findAll(
    companyId?: string,
    periodId?: string,
    status?: SamplingStatus,
    samplingMethod?: SamplingMethod,
  ) {
    return this.db.sampling.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(status && { status }),
        ...(samplingMethod && { samplingMethod }),
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findById(id: string) {
    const sampling = await this.db.sampling.findUnique({
      where: { id },
    });

    if (!sampling) {
      throw new NotFoundException(`Sampling with ID ${id} not found`);
    }

    return sampling;
  }

  async update(id: string, data: UpdateSamplingDto, userId: string) {
    await this.findById(id);

    // Validate sample size if provided
    if (data.sampleSize && data.populationSize && data.sampleSize > data.populationSize) {
      throw new BadRequestException('Sample size cannot exceed population size');
    }

    return this.db.sampling.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async delete(id: string) {
    await this.findById(id);

    return this.db.sampling.delete({
      where: { id },
    });
  }

  async generateRandomSample(
    id: string,
    populationIds: string[],
  ): Promise<{ selectedIds: string[]; interval?: number }> {
    const sampling = await this.findById(id);

    if (populationIds.length !== sampling.populationSize) {
      throw new BadRequestException(
        `Population IDs count (${populationIds.length}) does not match population size (${sampling.populationSize})`,
      );
    }

    const selectedIds: string[] = [];

    switch (sampling.samplingMethod) {
      case 'RANDOM':
        // Simple random sampling
        const shuffled = [...populationIds].sort(() => 0.5 - Math.random());
        selectedIds.push(...shuffled.slice(0, sampling.sampleSize));
        break;

      case 'SYSTEMATIC':
        // Systematic sampling
        const interval = Math.floor(sampling.populationSize / sampling.sampleSize);
        const start = Math.floor(Math.random() * interval);
        for (let i = start; i < populationIds.length && selectedIds.length < sampling.sampleSize; i += interval) {
          selectedIds.push(populationIds[i]);
        }
        return { selectedIds, interval };

      case 'JUDGMENTAL':
      case 'HAPHAZARD':
        // For judgmental/haphazard, just return first N items as placeholder
        selectedIds.push(...populationIds.slice(0, sampling.sampleSize));
        break;

      default:
        throw new BadRequestException(`Sampling method ${sampling.samplingMethod} not implemented`);
    }

    return { selectedIds };
  }

  async calculateSampleSize(
    populationSize: number,
    confidenceLevel: number,
    tolerableError: number,
    expectedError: number,
  ): Promise<number> {
    // Simplified sample size calculation
    // In practice, you'd use more sophisticated formulas based on audit standards
    const z = confidenceLevel === 95 ? 1.96 : confidenceLevel === 99 ? 2.58 : 1.65;
    const p = expectedError / 100;
    const e = tolerableError / 100;

    let n = Math.ceil((z * z * p * (1 - p)) / (e * e));

    // Apply finite population correction if needed
    if (populationSize < 100000) {
      n = Math.ceil((n * populationSize) / (n + populationSize - 1));
    }

    return Math.min(n, populationSize);
  }

  async getSummary(companyId: string, periodId: string) {
    const samplings = await this.db.sampling.findMany({
      where: { companyId, periodId },
      select: { status: true, samplingMethod: true, sampleSize: true, errorsFound: true },
    });

    const summary = {
      total: samplings.length,
      byStatus: {} as Record<string, number>,
      byMethod: {} as Record<string, number>,
      totalSampleSize: samplings.reduce((sum, s) => sum + s.sampleSize, 0),
      totalErrors: samplings.reduce((sum, s) => sum + (s.errorsFound || 0), 0),
      planned: samplings.filter((s) => s.status === SamplingStatus.PLANNED).length,
      inProgress: samplings.filter((s) => s.status === SamplingStatus.IN_PROGRESS).length,
      completed: samplings.filter((s) => s.status === SamplingStatus.COMPLETED).length,
      reviewed: samplings.filter((s) => s.status === SamplingStatus.REVIEWED).length,
    };

    samplings.forEach((s) => {
      summary.byStatus[s.status] = (summary.byStatus[s.status] || 0) + 1;
      summary.byMethod[s.samplingMethod] = (summary.byMethod[s.samplingMethod] || 0) + 1;
    });

    return summary;
  }
}
