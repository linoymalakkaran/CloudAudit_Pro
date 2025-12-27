import { Injectable, NotFoundException, BadRequestException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { EmailService } from '../email/email.service';
import { 
  CreateAuditProcedureDto,
  UpdateAuditProcedureDto,
  ProcedureFilterDto,
  ProcedureReviewDto,
  BulkAssignProceduresDto,
  ProcedureStatus,
  RiskLevel,
  ProcedureType
} from './dto/audit-procedure.dto';

interface ProcedureTemplate {
  id: string;
  name: string;
  description: string;
  procedureType: ProcedureType;
  category: string;
  riskLevel: RiskLevel;
  estimatedHours: number;
  steps: ProcedureStep[];
}

interface ProcedureStep {
  id: string;
  description: string;
  instructions: string;
  stepOrder: number;
  estimatedHours: number;
  isMandatory: boolean;
  requiredEvidence: string;
}

export interface AuditProcedureStats {
  totalProcedures: number;
  statusBreakdown: {
    notStarted: number;
    inProgress: number;
    completed: number;
    onHold: number;
    reviewRequired: number;
  };
  riskBreakdown: {
    low: number;
    medium: number;
    high: number;
    critical: number;
  };
  completionRate: number;
  averageHours: number;
  overdueProcedures: number;
}

@Injectable()
export class AuditProcedureService {
  constructor(
    private readonly database: DatabaseService,
    private readonly emailService: EmailService,
  ) {}

  async create(createAuditProcedureDto: CreateAuditProcedureDto, userId: string) {
    // Verify user has access to company
    await this.verifyCompanyAccess(createAuditProcedureDto.companyId, userId);

    // Verify period exists
    await this.verifyPeriodExists(createAuditProcedureDto.periodId, createAuditProcedureDto.companyId);

    // If account is specified, verify it exists
    if (createAuditProcedureDto.accountId) {
      await this.verifyAccountExists(createAuditProcedureDto.accountId, createAuditProcedureDto.companyId);
    }

    // If assigned to someone, verify user exists
    if (createAuditProcedureDto.assignedTo) {
      await this.verifyUserExists(createAuditProcedureDto.assignedTo);
    }

    return this.database.procedure.create({
      data: {
        companyId: createAuditProcedureDto.companyId,
        periodId: createAuditProcedureDto.periodId,
        templateId: createAuditProcedureDto.templateId,
        accountId: createAuditProcedureDto.accountId,
        name: createAuditProcedureDto.name,
        description: createAuditProcedureDto.description,
        procedureType: createAuditProcedureDto.procedureType,
        assignedTo: createAuditProcedureDto.assignedTo,
        assignedDate: createAuditProcedureDto.assignedTo ? new Date() : null,
        dueDate: createAuditProcedureDto.dueDate ? new Date(createAuditProcedureDto.dueDate) : null,
        estimatedHours: createAuditProcedureDto.estimatedHours,
        status: ProcedureStatus.NOT_STARTED,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, name: true, code: true },
        },
        assignee: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
      },
    });
  }

  async findAll(filters: ProcedureFilterDto, userId: string) {
    const { page = 1, limit = 20, sortBy = 'dueDate', sortOrder = 'asc', ...filterOptions } = filters;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    if (filterOptions.companyId) {
      await this.verifyCompanyAccess(filterOptions.companyId, userId);
      where.companyId = filterOptions.companyId;
    } else {
      const userCompanies = await this.getUserCompanies(userId);
      where.companyId = { in: userCompanies.map(c => c.id) };
    }

    if (filterOptions.periodId) where.periodId = filterOptions.periodId;
    if (filterOptions.procedureType) where.procedureType = filterOptions.procedureType;
    if (filterOptions.status) where.status = filterOptions.status;
    if (filterOptions.assignedTo) where.assignedTo = filterOptions.assignedTo;
    if (filterOptions.accountId) where.accountId = filterOptions.accountId;

    if (filterOptions.dueDateFrom || filterOptions.dueDateTo) {
      where.dueDate = {};
      if (filterOptions.dueDateFrom) where.dueDate.gte = new Date(filterOptions.dueDateFrom);
      if (filterOptions.dueDateTo) where.dueDate.lte = new Date(filterOptions.dueDateTo);
    }

    if (filterOptions.search) {
      where.OR = [
        { name: { contains: filterOptions.search, mode: 'insensitive' } },
        { description: { contains: filterOptions.search, mode: 'insensitive' } },
        { objectives: { contains: filterOptions.search, mode: 'insensitive' } },
      ];
    }

    const [procedures, total] = await Promise.all([
      this.database.procedure.findMany({
        where,
        skip,
        take: limit,
        orderBy: { [sortBy]: sortOrder },
        include: {
          company: {
            select: { id: true, name: true },
          },
          period: {
            select: { id: true, name: true },
          },
          account: {
            select: { id: true, name: true, code: true },
          },
          assignee: {
            select: { id: true, firstName: true, lastName: true, email: true },
          },
          template: {
            select: { id: true, name: true },
          },
        },
      }),
      this.database.procedure.count({ where }),
    ]);

    return {
      data: procedures,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, userId: string) {
    const procedure = await this.database.procedure.findUnique({
      where: { id },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, name: true, code: true, accountType: true },
        },
        assignee: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        template: {
          select: { id: true, name: true, description: true },
        },
        creator: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        reviewer: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        documents: {
          select: { id: true, name: true, type: true, uploadedAt: true },
        },
      },
    });

    if (!procedure) {
      throw new NotFoundException('Audit procedure not found');
    }

    // Verify user has access to this company
    await this.verifyCompanyAccess(procedure.companyId, userId);

    return procedure;
  }

  async update(id: string, updateAuditProcedureDto: UpdateAuditProcedureDto, userId: string) {
    const existingProcedure = await this.findOne(id, userId);

    // Verify user has permission to update (assigned user or supervisor)
    await this.verifyUpdatePermission(existingProcedure, userId);

    // If assigning to someone new, verify user exists
    if (updateAuditProcedureDto.assignedTo && 
        updateAuditProcedureDto.assignedTo !== existingProcedure.assignedTo) {
      await this.verifyUserExists(updateAuditProcedureDto.assignedTo);
    }

    const updateData: any = {
      ...updateAuditProcedureDto,
      updatedBy: userId,
    };

    if (updateAuditProcedureDto.dueDate) {
      updateData.dueDate = new Date(updateAuditProcedureDto.dueDate);
    }

    // Auto-set review status if completed
    if (updateAuditProcedureDto.status === ProcedureStatus.COMPLETED) {
      updateData.reviewStatus = 'NOT_REVIEWED';
    }

    return this.database.procedure.update({
      where: { id },
      data: updateData,
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, name: true, code: true },
        },
        assignee: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
      },
    });
  }

  async remove(id: string, userId: string) {
    const existingProcedure = await this.findOne(id, userId);

    // Only allow deletion if not started or by supervisor
    if (existingProcedure.status !== ProcedureStatus.NOT_STARTED) {
      const userRole = await this.getUserRole(userId);
      if (userRole !== 'ADMIN' && userRole !== 'MANAGER') {
        throw new BadRequestException('Can only delete procedures that have not been started');
      }
    }

    await this.database.procedure.delete({
      where: { id },
    });

    return { message: 'Audit procedure deleted successfully' };
  }

  async review(id: string, reviewDto: ProcedureReviewDto, userId: string) {
    const existingProcedure = await this.findOne(id, userId);

    if (existingProcedure.status !== ProcedureStatus.COMPLETED) {
      throw new BadRequestException('Can only review completed procedures');
    }

    const updateData: any = {
      reviewNotes: reviewDto.reviewNotes,
      reviewedBy: userId,
      reviewedAt: new Date(),
      updatedBy: userId,
    };

    let reviewStatus: string = 'REQUIRES_REVISION';
    switch (reviewDto.action) {
      case 'approve':
        reviewStatus = 'APPROVED';
        updateData.reviewStatus = 'APPROVED';
        updateData.signedOffBy = userId;
        updateData.signedOffDate = new Date();
        break;
      case 'reject':
        reviewStatus = 'REJECTED';
        updateData.reviewStatus = 'REJECTED';
        updateData.status = ProcedureStatus.REVIEW_REQUIRED;
        break;
      case 'return':
        reviewStatus = 'REQUIRES_REVISION';
        updateData.reviewStatus = 'REQUIRES_REVISION';
        updateData.status = ProcedureStatus.IN_PROGRESS;
        break;
    }

    const updatedProcedure = await this.database.procedure.update({
      where: { id },
      data: updateData,
      include: {
        assignee: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        company: {
          select: { id: true, name: true },
        },
      },
    });

    // Send email notification to assignee
    if (updatedProcedure.assignee) {
      try {
        await this.emailService.sendProcedureReviewNotification(
          updatedProcedure.assignee.email,
          `${updatedProcedure.assignee.firstName} ${updatedProcedure.assignee.lastName}`,
          updatedProcedure.name || 'Audit Procedure',
          updatedProcedure.company?.name || 'Unknown Company',
          reviewStatus,
          reviewDto.reviewNotes,
        );
      } catch (error) {
        // Log error but don't fail the review
        console.error('Failed to send review notification email:', error);
      }
    }

    return updatedProcedure;
  }

  async bulkAssign(bulkAssignDto: BulkAssignProceduresDto, userId: string) {
    // Verify all procedures exist and user has access
    const procedures = await Promise.all(
      bulkAssignDto.procedureIds.map(id => this.findOne(id, userId))
    );

    // Verify assignee exists and get user details
    const assignee = await this.database.user.findUnique({
      where: { id: bulkAssignDto.assignedTo },
      select: { id: true, firstName: true, lastName: true, email: true },
    });

    if (!assignee) {
      throw new NotFoundException(`User with ID ${bulkAssignDto.assignedTo} not found`);
    }

    const updateData: any = {
      assignedTo: bulkAssignDto.assignedTo,
      assignedDate: new Date(),
      updatedBy: userId,
    };

    if (bulkAssignDto.dueDate) {
      updateData.dueDate = new Date(bulkAssignDto.dueDate);
    }

    await this.database.procedure.updateMany({
      where: {
        id: { in: bulkAssignDto.procedureIds },
      },
      data: updateData,
    });

    // Send email notification to assignee
    try {
      for (const procedure of procedures) {
        await this.emailService.sendProcedureAssignmentNotification(
          assignee.email,
          `${assignee.firstName} ${assignee.lastName}`,
          procedure.name || 'Audit Procedure',
          procedure.company?.name || 'Unknown Company',
          bulkAssignDto.dueDate ? new Date(bulkAssignDto.dueDate) : undefined,
        );
      }
    } catch (error) {
      // Log error but don't fail the assignment
      console.error('Failed to send assignment notification emails:', error);
    }

    return {
      message: `${bulkAssignDto.procedureIds.length} procedures assigned successfully`,
      assignedTo: bulkAssignDto.assignedTo,
    };
  }

  async getStatistics(companyId?: string, periodId?: string, assignedTo?: string): Promise<AuditProcedureStats> {
    const where: any = {};

    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;
    if (assignedTo) where.assignedTo = assignedTo;

    const [
      totalProcedures,
      statusCounts,
      avgHours,
      overdueProcedures,
    ] = await Promise.all([
      this.database.procedure.count({ where }),
      this.database.procedure.groupBy({
        by: ['status'],
        where,
        _count: true,
      }),
      this.database.procedure.aggregate({
        where: { ...where, actualHours: { not: null } },
        _avg: { actualHours: true },
      }),
      this.database.procedure.count({
        where: {
          ...where,
          dueDate: { lt: new Date() },
          status: { notIn: [ProcedureStatus.COMPLETED, ProcedureStatus.CANCELLED] },
        },
      }),
    ]);

    // Process status counts
    const statusBreakdown = {
      notStarted: 0,
      inProgress: 0,
      completed: 0,
      onHold: 0,
      reviewRequired: 0,
    };

    statusCounts.forEach(item => {
      switch (item.status) {
        case ProcedureStatus.NOT_STARTED:
          statusBreakdown.notStarted = item._count;
          break;
        case ProcedureStatus.IN_PROGRESS:
          statusBreakdown.inProgress = item._count;
          break;
        case ProcedureStatus.COMPLETED:
          statusBreakdown.completed = item._count;
          break;
        case ProcedureStatus.ON_HOLD:
          statusBreakdown.onHold = item._count;
          break;
        case ProcedureStatus.REVIEW_REQUIRED:
          statusBreakdown.reviewRequired = item._count;
          break;
      }
    });

    const completionRate = totalProcedures > 0 
      ? (statusBreakdown.completed / totalProcedures) * 100 
      : 0;

    return {
      totalProcedures,
      statusBreakdown,
      riskBreakdown: {
        low: 0,
        medium: 0, 
        high: 0,
        critical: 0,
      }, // Would be calculated from actual risk data
      completionRate: Math.round(completionRate * 100) / 100,
      averageHours: Number(avgHours._avg.actualHours) || 0,
      overdueProcedures,
    };
  }

  async getTemplates() {
    // This would return standard audit procedure templates
    const templates: ProcedureTemplate[] = [
      {
        id: 'cash-confirmation',
        name: 'Bank Confirmation',
        description: 'Confirm bank balances and terms',
        procedureType: ProcedureType.CONFIRMATION,
        category: 'Cash',
        riskLevel: RiskLevel.HIGH,
        estimatedHours: 2,
        steps: [
          {
            id: 'step-1',
            description: 'Prepare bank confirmation letters',
            instructions: 'Use standard bank confirmation format',
            stepOrder: 1,
            estimatedHours: 0.5,
            isMandatory: true,
            requiredEvidence: 'Bank confirmation letter',
          },
        ],
      },
    ];

    return templates;
  }

  // Helper methods
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

  private async verifyAccountExists(accountId: string, companyId: string) {
    const account = await this.database.accountHead.findFirst({
      where: { id: accountId, companyId },
    });

    if (!account) {
      throw new NotFoundException('Account not found');
    }
  }

  private async verifyUserExists(userId: string) {
    const user = await this.database.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }
  }

  private async verifyUpdatePermission(procedure: any, userId: string) {
    // User can update if they are assigned to it or have supervisor role
    const userRole = await this.getUserRole(userId);
    const isAssignedUser = procedure.assignedTo === userId;
    const isSupervisor = userRole === 'ADMIN' || userRole === 'MANAGER';

    if (!isAssignedUser && !isSupervisor) {
      throw new ForbiddenException('No permission to update this procedure');
    }
  }

  private async getUserRole(userId: string): Promise<string> {
    const user = await this.database.user.findUnique({
      where: { id: userId },
      select: { role: true },
    });

    return user?.role || 'AUDITOR';
  }

  private async getUserCompanies(userId: string) {
    return this.database.company.findMany({
      select: { id: true, name: true },
    });
  }

  async getComments(procedureId: string, userId: string) {
    // Verify user has access to the procedure
    await this.findOne(procedureId, userId);

    return this.database.procedureComment.findMany({
      where: { procedureId },
      include: {
        user: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async addComment(procedureId: string, comment: string, userId: string, tenantId: string) {
    // Verify user has access to the procedure
    await this.findOne(procedureId, userId);

    return this.database.procedureComment.create({
      data: {
        procedureId,
        tenantId,
        userId,
        comment,
      },
      include: {
        user: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
          },
        },
      },
    });
  }
}