import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateScheduleDto } from './dto/create-schedule.dto';
import { UpdateScheduleDto } from './dto/update-schedule.dto';
import { ScheduleFrequency } from '@prisma/client';

@Injectable()
export class ReportSchedulesService {
  constructor(private prisma: PrismaService) {}

  async create(createScheduleDto: CreateScheduleDto, tenantId: string, userId: string) {
    // Validate that either reportId or reportTemplateId is provided
    if (!createScheduleDto.reportId && !createScheduleDto.reportTemplateId) {
      throw new BadRequestException('Either reportId or reportTemplateId must be provided');
    }

    const nextRunAt = this.calculateNextRun(
      createScheduleDto.frequency,
      createScheduleDto.scheduleTime,
    );

    return this.prisma.reportSchedule.create({
      data: {
        tenantId,
        reportId: createScheduleDto.reportId,
        reportTemplateId: createScheduleDto.reportTemplateId,
        companyId: createScheduleDto.companyId,
        periodId: createScheduleDto.periodId,
        frequency: createScheduleDto.frequency,
        scheduleTime: createScheduleDto.scheduleTime || '00:00',
        timezone: createScheduleDto.timezone || 'UTC',
        isActive: createScheduleDto.isActive ?? true,
        parameters: createScheduleDto.parameters,
        filters: createScheduleDto.filters,
        recipients: createScheduleDto.recipients || [],
        emailSubject: createScheduleDto.emailSubject,
        emailBody: createScheduleDto.emailBody,
        nextRunAt,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        report: { select: { name: true, reportType: true } },
        template: { select: { name: true, reportType: true } },
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  async findAll(tenantId: string, companyId?: string, isActive?: boolean) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (isActive !== undefined) where.isActive = isActive;

    return this.prisma.reportSchedule.findMany({
      where,
      include: {
        report: { select: { name: true, reportType: true } },
        template: { select: { name: true, reportType: true } },
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
      orderBy: { nextRunAt: 'asc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const schedule = await this.prisma.reportSchedule.findFirst({
      where: { id, tenantId },
      include: {
        report: true,
        template: true,
        company: true,
        period: true,
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
        updatedByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
      },
    });

    if (!schedule) {
      throw new NotFoundException(`Schedule with ID ${id} not found`);
    }

    return schedule;
  }

  async update(id: string, updateScheduleDto: UpdateScheduleDto, tenantId: string, userId: string) {
    await this.findOne(id, tenantId);

    let nextRunAt: Date | undefined;
    if (updateScheduleDto.frequency || updateScheduleDto.scheduleTime) {
      const schedule = await this.prisma.reportSchedule.findUnique({ where: { id } });
      nextRunAt = this.calculateNextRun(
        updateScheduleDto.frequency || schedule.frequency,
        updateScheduleDto.scheduleTime || schedule.scheduleTime,
      );
    }

    return this.prisma.reportSchedule.update({
      where: { id },
      data: {
        ...updateScheduleDto,
        ...(nextRunAt && { nextRunAt }),
        updatedBy: userId,
      },
    });
  }

  async remove(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.reportSchedule.delete({
      where: { id },
    });
  }

  async runNow(id: string, tenantId: string, userId: string) {
    const schedule = await this.findOne(id, tenantId);

    // Update last run and calculate next run
    const now = new Date();
    const nextRunAt = this.calculateNextRun(schedule.frequency, schedule.scheduleTime);

    await this.prisma.reportSchedule.update({
      where: { id },
      data: {
        lastRunAt: now,
        nextRunAt,
      },
    });

    // TODO: Trigger actual report generation
    // This would call the reports service to generate the report

    return {
      message: 'Report generation triggered',
      lastRunAt: now,
      nextRunAt,
    };
  }

  async toggleActive(id: string, tenantId: string, userId: string) {
    const schedule = await this.findOne(id, tenantId);

    return this.prisma.reportSchedule.update({
      where: { id },
      data: {
        isActive: !schedule.isActive,
        updatedBy: userId,
      },
    });
  }

  async getUpcoming(tenantId: string, companyId?: string, days: number = 7) {
    const where: any = { tenantId, isActive: true };
    if (companyId) where.companyId = companyId;

    const futureDate = new Date();
    futureDate.setDate(futureDate.getDate() + days);

    return this.prisma.reportSchedule.findMany({
      where: {
        ...where,
        nextRunAt: {
          lte: futureDate,
          gte: new Date(),
        },
      },
      include: {
        report: { select: { name: true, reportType: true } },
        template: { select: { name: true, reportType: true } },
        company: { select: { name: true } },
      },
      orderBy: { nextRunAt: 'asc' },
    });
  }

  async getHistory(tenantId: string, companyId?: string, limit: number = 50) {
    const where: any = { tenantId, lastRunAt: { not: null } };
    if (companyId) where.companyId = companyId;

    return this.prisma.reportSchedule.findMany({
      where,
      take: limit,
      include: {
        report: { select: { name: true, reportType: true } },
        template: { select: { name: true, reportType: true } },
        company: { select: { name: true } },
      },
      orderBy: { lastRunAt: 'desc' },
    });
  }

  private calculateNextRun(frequency: ScheduleFrequency, scheduleTime?: string): Date {
    const now = new Date();
    const nextRun = new Date(now);

    // Parse schedule time if provided (HH:MM format)
    let hours = 0;
    let minutes = 0;
    if (scheduleTime) {
      const [h, m] = scheduleTime.split(':').map(Number);
      hours = h;
      minutes = m;
    }

    switch (frequency) {
      case ScheduleFrequency.DAILY:
        nextRun.setDate(nextRun.getDate() + 1);
        nextRun.setHours(hours, minutes, 0, 0);
        break;
      case ScheduleFrequency.WEEKLY:
        nextRun.setDate(nextRun.getDate() + 7);
        nextRun.setHours(hours, minutes, 0, 0);
        break;
      case ScheduleFrequency.MONTHLY:
        nextRun.setMonth(nextRun.getMonth() + 1);
        nextRun.setHours(hours, minutes, 0, 0);
        break;
      case ScheduleFrequency.QUARTERLY:
        nextRun.setMonth(nextRun.getMonth() + 3);
        nextRun.setHours(hours, minutes, 0, 0);
        break;
      case ScheduleFrequency.ANNUALLY:
        nextRun.setFullYear(nextRun.getFullYear() + 1);
        nextRun.setHours(hours, minutes, 0, 0);
        break;
      case ScheduleFrequency.ON_DEMAND:
        // Don't schedule automatic runs for on-demand
        return null;
      default:
        nextRun.setDate(nextRun.getDate() + 1);
    }

    return nextRun;
  }
}
