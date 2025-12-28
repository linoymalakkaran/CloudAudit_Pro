import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateReviewPointDto, UpdateReviewPointDto, ReviewPointStatus } from './dto';

@Injectable()
export class ReviewPointService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateReviewPointDto, userId: string) {
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

    // Generate review number
    const count = await this.db.reviewPoint.count({
      where: {
        companyId: data.companyId,
        periodId: data.periodId,
      },
    });

    const reviewNumber = `REV-${period.name}-${(count + 1).toString().padStart(4, '0')}`;

    const reviewPoint = await this.db.reviewPoint.create({
      data: {
        ...data,
        reviewNumber,
        status: data.status || ReviewPointStatus.OUTSTANDING,
        raisedBy: userId,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return reviewPoint;
  }

  async findAll(
    companyId?: string,
    periodId?: string,
    status?: ReviewPointStatus,
    category?: string,
    assignedTo?: string,
  ) {
    return this.db.reviewPoint.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(status && { status }),
        ...(category && { category }),
        ...(assignedTo && { assignedTo }),
      },
      orderBy: [{ priority: 'desc' }, { raisedAt: 'desc' }],
    });
  }

  async findById(id: string) {
    const reviewPoint = await this.db.reviewPoint.findUnique({
      where: { id },
    });

    if (!reviewPoint) {
      throw new NotFoundException(`Review point with ID ${id} not found`);
    }

    return reviewPoint;
  }

  async update(id: string, data: UpdateReviewPointDto, userId: string) {
    await this.findById(id);

    return this.db.reviewPoint.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
        ...(data.assignedTo && { assignedAt: new Date() }),
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
        procedure: { select: { name: true, code: true } },
        account: { select: { name: true, code: true } },
        raisedByUser: { select: { firstName: true, lastName: true } },
        assignedToUser: { select: { firstName: true, lastName: true } },
      },
    });
  }

  async clearReviewPoint(id: string, clearanceNotes: string, userId: string) {
    await this.findById(id);

    return this.db.reviewPoint.update({
      where: { id },
      data: {
        status: ReviewPointStatus.CLEARED,
        clearanceNotes,
        clearedBy: userId,
        clearedAt: new Date(),
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
        raisedByUser: { select: { firstName: true, lastName: true } },
        clearedByUser: { select: { firstName: true, lastName: true } },
      },
    });
  }

  as  select: {
        status: true,
        priority: true,
      },
    });

    const summary = {
      total: reviews.length,
      byStatus: {} as Record<string, number>,
      byPriority: {} as Record<string, number>,
      outstanding: reviews.filter((r) => r.status === ReviewPointStatus.OUTSTANDING).length,
      inProgress: reviews.filter((r) => r.status === ReviewPointStatus.IN_PROGRESS).length,
      pendingClearance: reviews.filter((r) => r.status === ReviewPointStatus.PENDING_CLEARANCE).length,
      cleared: reviews.filter((r) => r.status === ReviewPointStatus.CLEARED).length,
      carriedForward: reviews.filter((r) => r.status === ReviewPointStatus.CARRIED_FORWARD).length,
    };

    reviews.forEach((review) => {
      summary.byStatus[review.status] = (summary.byStatus[review.status] || 0) + 1;
      summary.byPriority[review.priority] = (summary.byPriority[review.priority] || 0) + 1;
    });

    return summary;
  }
}
