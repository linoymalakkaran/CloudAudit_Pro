import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateAuditFinalizationDto, UpdateAuditFinalizationDto, FinalizationStatus } from './dto';

@Injectable()
export class AuditFinalizationService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateAuditFinalizationDto, userId: string) {
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

    // Check if finalization already exists for this company/period
    const existing = await this.db.auditFinalization.findFirst({
      where: {
        companyId: data.companyId,
        periodId: data.periodId,
      },
    });

    if (existing) {
      throw new BadRequestException(
        `Audit finalization already exists for company ${company.name} and period ${period.name}`,
      );
    }

    const finalization = await this.db.auditFinalization.create({
      data: {
        ...data,
        status: data.status || FinalizationStatus.DRAFT,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return finalization;
  }

  async findAll(companyId?: string, periodId?: string, status?: FinalizationStatus) {
    return this.db.auditFinalization.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(status && { status }),
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findById(id: string) {
    const finalization = await this.db.auditFinalization.findUnique({
      where: { id },
    });

    if (!finalization) {
      throw new NotFoundException(`Audit finalization with ID ${id} not found`);
    }

    return finalization;
  }

  async findByCompanyAndPeriod(companyId: string, periodId: string) {
    const finalization = await this.db.auditFinalization.findFirst({
      where: {
        companyId,
        periodId,
      },
    });

    if (!finalization) {
      throw new NotFoundException(
        `Audit finalization not found for company ${companyId} and period ${periodId}`,
      );
    }

    return finalization;
  }

  async update(id: string, data: UpdateAuditFinalizationDto, userId: string) {
    const finalization = await this.findById(id);

    if (finalization.isFinalized) {
      throw new BadRequestException('Cannot update a finalized audit');
    }

    return this.db.auditFinalization.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async delete(id: string) {
    const finalization = await this.findById(id);

    if (finalization.isFinalized) {
      throw new BadRequestException('Cannot delete a finalized audit');
    }

    return this.db.auditFinalization.delete({
      where: { id },
    });
  }

  async finalizeAudit(id: string, userId: string) {
    const finalization = await this.findById(id);

    if (finalization.isFinalized) {
      throw new BadRequestException('Audit is already finalized');
    }

    // Verify all required fields are completed
    if (!finalization.opinionType || !finalization.opinionText) {
      throw new BadRequestException('Opinion type and text are required before finalization');
    }

    if (finalization.requiresPartnerApproval && finalization.status !== FinalizationStatus.APPROVED) {
      throw new BadRequestException('Partner approval is required before finalization');
    }

    // Check for open findings
    const openFindings = await this.db.finding.count({
      where: {
        companyId: finalization.companyId,
        periodId: finalization.periodId,
        status: { not: 'CLOSED' },
      },
    });

    if (openFindings > 0) {
      throw new BadRequestException(
        `Cannot finalize audit: ${openFindings} findings are still open`,
      );
    }

    return this.db.auditFinalization.update({
      where: { id },
      data: {
        status: FinalizationStatus.FINALIZED,
        isFinalized: true,
        finalizedBy: userId,
        finalizedAt: new Date(),
        updatedBy: userId,
      },
    });
  }

  async issueReport(id: string, userId: string) {
    const finalization = await this.findById(id);

    if (!finalization.isFinalized) {
      throw new BadRequestException('Audit must be finalized before issuing report');
    }

    return this.db.auditFinalization.update({
      where: { id },
      data: {
        status: FinalizationStatus.ISSUED,
        reportIssueDate: new Date(),
        updatedBy: userId,
      },
    });
  }

  async getAuditSummary(companyId: string, periodId: string) {
    const [finalization, procedures, findings, reviewPoints] = await Promise.all([
      this.db.auditFinalization.findFirst({
        where: { companyId, periodId },
      }),
      this.db.auditProcedure.findMany({
        where: { companyId, periodId },
        select: { status: true },
      }),
      this.db.finding.findMany({
        where: { companyId, periodId },
        select: { status: true, severity: true },
      }),
      this.db.reviewPoint.findMany({
        where: { companyId, periodId },
        select: { status: true },
      }),
    ]);

    const summary = {
      finalization,
      procedures: {
        total: procedures.length,
        completed: procedures.filter((p) => p.status === 'COMPLETED').length,
        inProgress: procedures.filter((p) => p.status === 'IN_PROGRESS').length,
        notStarted: procedures.filter((p) => p.status === 'NOT_STARTED').length,
      },
      findings: {
        total: findings.length,
        open: findings.filter((f) => f.status !== 'CLOSED').length,
        closed: findings.filter((f) => f.status === 'CLOSED').length,
        bySeverity: {
          critical: findings.filter((f) => f.severity === 'CRITICAL').length,
          high: findings.filter((f) => f.severity === 'HIGH').length,
          medium: findings.filter((f) => f.severity === 'MEDIUM').length,
          low: findings.filter((f) => f.severity === 'LOW').length,
        },
      },
      reviewPoints: {
        total: reviewPoints.length,
        outstanding: reviewPoints.filter((r) => r.status === 'OUTSTANDING').length,
        cleared: reviewPoints.filter((r) => r.status === 'CLEARED').length,
      },
    };

    return summary;
  }
}
