import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateWorkpaperDto, UpdateWorkpaperDto } from './dto';

@Injectable()
export class WorkpaperService {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    tenantId: string,
    userId: string,
    createDto: CreateWorkpaperDto,
  ) {
    // Verify procedure exists and belongs to tenant
    const procedure = await this.prisma.auditProcedure.findFirst({
      where: { id: createDto.procedureId, tenantId },
    });

    if (!procedure) {
      throw new NotFoundException('Audit procedure not found');
    }

    return this.prisma.workpaper.create({
      data: {
        ...createDto,
        tenantId,
        preparedBy: userId,
      },
      include: {
        procedure: { select: { id: true, name: true, category: true } },
        preparer: { select: { id: true, firstName: true, lastName: true, email: true } },
        _count: { select: { attachments: true } },
      },
    });
  }

  async findAll(tenantId: string, procedureId?: string) {
    const where: any = { tenantId };
    if (procedureId) where.procedureId = procedureId;

    return this.prisma.workpaper.findMany({
      where,
      include: {
        procedure: { select: { id: true, name: true, category: true } },
        preparer: { select: { id: true, firstName: true, lastName: true, email: true } },
        reviewer: { select: { id: true, firstName: true, lastName: true, email: true } },
        _count: { select: { attachments: true } },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(tenantId: string, id: string) {
    const workpaper = await this.prisma.workpaper.findFirst({
      where: { id, tenantId },
      include: {
        procedure: {
          include: {
            company: { select: { name: true, code: true } },
            period: { select: { name: true } },
          },
        },
        preparer: { select: { id: true, firstName: true, lastName: true, email: true } },
        reviewer: { select: { id: true, firstName: true, lastName: true, email: true } },
        attachments: {
          select: {
            id: true,
            name: true,
            originalFilename: true,
            fileExtension: true,
            fileSizeBytes: true,
            uploadedAt: true,
          },
        },
      },
    });

    if (!workpaper) {
      throw new NotFoundException('Workpaper not found');
    }

    return workpaper;
  }

  async update(
    tenantId: string,
    userId: string,
    id: string,
    updateDto: UpdateWorkpaperDto,
  ) {
    const workpaper = await this.prisma.workpaper.findFirst({
      where: { id, tenantId },
    });

    if (!workpaper) {
      throw new NotFoundException('Workpaper not found');
    }

    // Increment version if content changed
    const updates: any = { ...updateDto };
    if (updateDto.content && updateDto.content !== workpaper.content) {
      updates.version = workpaper.version + 1;
    }

    return this.prisma.workpaper.update({
      where: { id },
      data: updates,
      include: {
        preparer: { select: { id: true, firstName: true, lastName: true, email: true } },
        reviewer: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });
  }

  async review(
    tenantId: string,
    userId: string,
    id: string,
    reviewNotes?: string,
  ) {
    const workpaper = await this.prisma.workpaper.findFirst({
      where: { id, tenantId },
    });

    if (!workpaper) {
      throw new NotFoundException('Workpaper not found');
    }

    return this.prisma.workpaper.update({
      where: { id },
      data: {
        reviewedBy: userId,
        reviewedAt: new Date(),
        reviewNotes,
      },
      include: {
        reviewer: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });
  }

  async delete(tenantId: string, id: string) {
    const workpaper = await this.prisma.workpaper.findFirst({
      where: { id, tenantId },
    });

    if (!workpaper) {
      throw new NotFoundException('Workpaper not found');
    }

    return this.prisma.workpaper.delete({
      where: { id },
    });
  }
}
