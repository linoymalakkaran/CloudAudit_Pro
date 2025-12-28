import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateManagerReviewDto, UpdateManagerReviewDto, ManagerReviewStatus } from './dto';

@Injectable()
export class ManagerReviewService {
  constructor(private db: DatabaseService) {}

  async create(data: CreateManagerReviewDto, userId: string) {
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

    // Verify reviewer exists
    const reviewer = await this.db.user.findUnique({
      where: { id: data.reviewerId },
    });

    if (!reviewer) {
      throw new NotFoundException(`Reviewer with ID ${data.reviewerId} not found`);
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

    const managerReview = await this.db.managerReview.create({
      data: {
        ...data,
        status: data.status || ManagerReviewStatus.NOT_STARTED,
        tenantId: company.tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
    });

    return managerReview;
  }

  async findAll(
    companyId?: string,
    periodId?: string,
    status?: ManagerReviewStatus,
    reviewLevel?: string,
    reviewerId?: string,
  ) {
    return this.db.managerReview.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(periodId && { periodId }),
        ...(status && { status }),
        ...(reviewLevel && { reviewLevel }),
        ...(reviewerId && { reviewerId }),
      },
      orderBy: [{ dueDate: 'asc' }, { createdAt: 'desc' }],
    });
  }

  async findById(id: string) {
    const managerReview = await this.db.managerReview.findUnique({
      where: { id },
    });

    if (!managerReview) {
      throw new NotFoundException(`Manager review with ID ${id} not found`);
    }

    return managerReview;
  }

  async update(id: string, data: UpdateManagerReviewDto, userId: string) {
    await this.findById(id);

    return this.db.managerReview.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async delete(id: string) {
    await this.findById(id);

    return this.db.managerReview.delete({
      where: { id },
    });
  }

  async approveReview(id: string, signOffNotes: string, userId: string) {
    await this.findById(id);

    return this.db.managerReview.update({
      where: { id },
      data: {
        status: ManagerReviewStatus.APPROVED,
        isSignedOff: true,
        signOffNotes,
        signedOffBy: userId,
        signedOffAt: new Date(),
        completedAt: new Date(),
        updatedBy: userId,
      },
    });
  }

  async rejectReview(id: string, comments: string, userId: string) {
    await this.findById(id);

    return this.db.managerReview.update({
      where: { id },
      data: {
        status: ManagerReviewStatus.REJECTED,
        comments,
        updatedBy: userId,
      },
    });
  }

  async getSummaryByStatus(companyId: string, periodId: string) {
    const reviews = await this.db.managerReview.findMany({
      where: {
        companyId,
        periodId,
      },
      select: {
        status: true,
        reviewLevel: true,
      },
    });

    const summary = {
      total: reviews.length,
      byStatus: {} as Record<string, number>,
      byLevel: {} as Record<string, number>,
      notStarted: reviews.filter((r) => r.status === ManagerReviewStatus.NOT_STARTED).length,
      inProgress: reviews.filter((r) => r.status === ManagerReviewStatus.IN_PROGRESS).length,
      completed: reviews.filter((r) => r.status === ManagerReviewStatus.COMPLETED).length,
      approved: reviews.filter((r) => r.status === ManagerReviewStatus.APPROVED).length,
      rejected: reviews.filter((r) => r.status === ManagerReviewStatus.REJECTED).length,
    };

    reviews.forEach((review) => {
      summary.byStatus[review.status] = (summary.byStatus[review.status] || 0) + 1;
      summary.byLevel[review.reviewLevel] = (summary.byLevel[review.reviewLevel] || 0) + 1;
    });

    return summary;
  }
}
