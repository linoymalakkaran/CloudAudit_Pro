import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateInternalControlDto, UpdateInternalControlDto, ControlEffectiveness } from './dto';
import { ControlType } from '@prisma/client';

@Injectable()
export class InternalControlsService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateInternalControlDto, userId: string) {
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

    // Check if control ID already exists for this company and period
    const existingControl = await this.db.internalControl.findFirst({
      where: {
        companyId: data.companyId,
        periodId: data.periodId,
        controlId: data.controlId,
      },
    });

    if (existingControl) {
      throw new ConflictException(
        `Internal control with ID ${data.controlId} already exists for this company and period`,
      );
    }

    const control = await this.db.internalControl.create({
      data: {
        ...data,
        isKeyControl: data.isKeyControl || false,
        deficiencyIdentified: data.deficiencyIdentified || false,
        controlEffectiveness: data.controlEffectiveness || ControlEffectiveness.NOT_TESTED,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return control;
  }

  async findAll(
    companyId?: string,
    periodId?: string,
    processArea?: string,
    controlType?: ControlType,
    controlEffectiveness?: ControlEffectiveness,
    isKeyControl?: boolean,
    deficiencyIdentified?: boolean,
  ) {
    return this.db.internalControl.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(processArea && { processArea }),
        ...(controlType && { controlType }),
        ...(controlEffectiveness && { controlEffectiveness }),
        ...(isKeyControl !== undefined && { isKeyControl }),
        ...(deficiencyIdentified !== undefined && { deficiencyIdentified }),
      },
      orderBy: [{ processArea: 'asc' }, { controlId: 'asc' }],
    });
  }

  async findById(id: string) {
    const control = await this.db.internalControl.findUnique({
      where: { id },
    });

    if (!control) {
      throw new NotFoundException(`Internal control with ID ${id} not found`);
    }

    return control;
  }

  async update(id: string, data: UpdateInternalControlDto, userId: string) {
    await this.findById(id);

    // If updating control ID, check for duplicates
    if (data.controlId) {
      const control = await this.db.internalControl.findUnique({ where: { id } });
      const existingControl = await this.db.internalControl.findFirst({
        where: {
          companyId: control.companyId,
          periodId: control.periodId,
          controlId: data.controlId,
          id: { not: id },
        },
      });

      if (existingControl) {
        throw new ConflictException(`Control ID ${data.controlId} already exists`);
      }
    }

    return this.db.internalControl.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async delete(id: string) {
    await this.findById(id);

    return this.db.internalControl.delete({
      where: { id },
    });
  }

  async testControl(
    id: string,
    testProcedures: string,
    testResult: string,
    controlEffectiveness: ControlEffectiveness,
    userId: string,
  ) {
    await this.findById(id);

    return this.db.internalControl.update({
      where: { id },
      data: {
        testProcedures,
        testResult,
        controlEffectiveness,
        testPerformedBy: userId,
        testDate: new Date(),
        updatedBy: userId,
      },
    });
  }

  async identifyDeficiency(
    id: string,
    deficiencyDescription: string,
    remediationPlan: string,
    remediationDeadline: Date,
    userId: string,
  ) {
    await this.findById(id);

    return this.db.internalControl.update({
      where: { id },
      data: {
        deficiencyIdentified: true,
        deficiencyDescription,
        remediationPlan,
        remediationDeadline,
        updatedBy: userId,
      },
    });
  }

  async reviewControl(id: string, conclusion: string, userId: string) {
    await this.findById(id);

    return this.db.internalControl.update({
      where: { id },
      data: {
        reviewedBy: userId,
        reviewDate: new Date(),
        conclusion,
        updatedBy: userId,
      },
    });
  }

  async getSummary(companyId: string, periodId: string) {
    const controls = await this.db.internalControl.findMany({
      where: { companyId, periodId },
      select: {
        processArea: true,
        controlType: true,
        controlNature: true,
        controlEffectiveness: true,
        isKeyControl: true,
        deficiencyIdentified: true,
        riskLevel: true,
      },
    });

    const summary = {
      total: controls.length,
      keyControls: controls.filter((c) => c.isKeyControl).length,
      byProcessArea: {} as Record<string, number>,
      byType: {} as Record<string, number>,
      byNature: {} as Record<string, number>,
      byEffectiveness: {} as Record<string, number>,
      byRiskLevel: {} as Record<string, number>,
      totalDeficiencies: controls.filter((c) => c.deficiencyIdentified).length,
      effective: controls.filter((c) => c.controlEffectiveness === ControlEffectiveness.EFFECTIVE)
        .length,
      partiallyEffective: controls.filter(
        (c) => c.controlEffectiveness === ControlEffectiveness.PARTIALLY_EFFECTIVE,
      ).length,
      ineffective: controls.filter(
        (c) => c.controlEffectiveness === ControlEffectiveness.INEFFECTIVE,
      ).length,
      notTested: controls.filter(
        (c) => c.controlEffectiveness === ControlEffectiveness.NOT_TESTED,
      ).length,
    };

    controls.forEach((c) => {
      summary.byProcessArea[c.processArea] = (summary.byProcessArea[c.processArea] || 0) + 1;
      summary.byType[c.controlType] = (summary.byType[c.controlType] || 0) + 1;
      summary.byNature[c.controlNature] = (summary.byNature[c.controlNature] || 0) + 1;
      summary.byEffectiveness[c.controlEffectiveness] =
        (summary.byEffectiveness[c.controlEffectiveness] || 0) + 1;
      if (c.riskLevel) {
        summary.byRiskLevel[c.riskLevel] = (summary.byRiskLevel[c.riskLevel] || 0) + 1;
      }
    });

    return summary;
  }
}
