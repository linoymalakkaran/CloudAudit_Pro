import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateSubstantiveTestDto, UpdateSubstantiveTestDto, TestStatus } from './dto';
import { TestType } from '@prisma/client';

@Injectable()
export class SubstantiveTestingService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateSubstantiveTestDto, userId: string) {
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

    // Verify sampling if provided
    if (data.samplingId) {
      const sampling = await this.db.sampling.findUnique({
        where: { id: data.samplingId },
      });
      if (!sampling) {
        throw new NotFoundException(`Sampling with ID ${data.samplingId} not found`);
      }
    }

    const test = await this.db.substantiveTest.create({
      data: {
        ...data,
        status: data.status || TestStatus.PLANNED,
        hasException: data.hasException || false,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return test;
  }

  async findAll(
    companyId?: string,
    periodId?: string,
    status?: TestStatus,
    testType?: TestType,
    hasException?: boolean,
  ) {
    return this.db.substantiveTest.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(status && { status }),
        ...(testType && { testType }),
        ...(hasException !== undefined && { hasException }),
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findById(id: string) {
    const test = await this.db.substantiveTest.findUnique({
      where: { id },
    });

    if (!test) {
      throw new NotFoundException(`Substantive test with ID ${id} not found`);
    }

    return test;
  }

  async update(id: string, data: UpdateSubstantiveTestDto, userId: string) {
    await this.findById(id);

    return this.db.substantiveTest.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async delete(id: string) {
    await this.findById(id);

    return this.db.substantiveTest.delete({
      where: { id },
    });
  }

  async completeTest(id: string, conclusion: string, userId: string) {
    await this.findById(id);

    return this.db.substantiveTest.update({
      where: { id },
      data: {
        status: TestStatus.COMPLETED,
        conclusion,
        performedBy: userId,
        testDate: new Date(),
        updatedBy: userId,
      },
    });
  }

  async reviewTest(id: string, reviewComments: string, userId: string) {
    await this.findById(id);

    return this.db.substantiveTest.update({
      where: { id },
      data: {
        status: TestStatus.REVIEWED,
        reviewedBy: userId,
        reviewDate: new Date(),
        conclusion: reviewComments,
        updatedBy: userId,
      },
    });
  }

  async getSummary(companyId: string, periodId: string) {
    const tests = await this.db.substantiveTest.findMany({
      where: { companyId, periodId },
      select: {
        status: true,
        testType: true,
        hasException: true,
        exceptionSeverity: true,
        transactionAmount: true,
        exceptionAmount: true,
      },
    });

    const summary = {
      total: tests.length,
      byStatus: {} as Record<string, number>,
      byType: {} as Record<string, number>,
      totalExceptions: tests.filter((t) => t.hasException).length,
      bySeverity: {} as Record<string, number>,
      totalTransactionAmount: tests.reduce((sum, t) => sum + (t.transactionAmount || 0), 0),
      totalExceptionAmount: tests.reduce((sum, t) => sum + (t.exceptionAmount || 0), 0),
      planned: tests.filter((t) => t.status === TestStatus.PLANNED).length,
      inProgress: tests.filter((t) => t.status === TestStatus.IN_PROGRESS).length,
      completed: tests.filter((t) => t.status === TestStatus.COMPLETED).length,
      reviewed: tests.filter((t) => t.status === TestStatus.REVIEWED).length,
      exceptionNoted: tests.filter((t) => t.status === TestStatus.EXCEPTION_NOTED).length,
    };

    tests.forEach((t) => {
      summary.byStatus[t.status] = (summary.byStatus[t.status] || 0) + 1;
      summary.byType[t.testType] = (summary.byType[t.testType] || 0) + 1;
      if (t.exceptionSeverity) {
        summary.bySeverity[t.exceptionSeverity] = (summary.bySeverity[t.exceptionSeverity] || 0) + 1;
      }
    });

    return summary;
  }
}
