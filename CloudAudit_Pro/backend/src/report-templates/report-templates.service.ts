import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateTemplateDto } from './dto/create-template.dto';
import { UpdateTemplateDto } from './dto/update-template.dto';
import { ReportType } from '@prisma/client';

@Injectable()
export class ReportTemplatesService {
  constructor(private prisma: PrismaService) {}

  async create(createTemplateDto: CreateTemplateDto, tenantId: string, userId: string) {
    return this.prisma.reportTemplate.create({
      data: {
        tenantId,
        name: createTemplateDto.name,
        description: createTemplateDto.description,
        reportType: createTemplateDto.reportType,
        category: createTemplateDto.category,
        isStandard: createTemplateDto.isStandard ?? false,
        isActive: createTemplateDto.isActive ?? true,
        templateDefinition: createTemplateDto.templateDefinition || {},
        dataSource: createTemplateDto.dataSource || {},
        formatting: createTemplateDto.formatting,
        parameters: createTemplateDto.parameters,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
      },
    });
  }

  async findAll(tenantId: string, reportType?: ReportType, isActive?: boolean) {
    const where: any = { tenantId };
    if (reportType) where.reportType = reportType;
    if (isActive !== undefined) where.isActive = isActive;

    return this.prisma.reportTemplate.findMany({
      where,
      include: {
        createdByUser: { select: { email: true, firstName: true, lastName: true } },
      },
      orderBy: [{ isStandard: 'desc' }, { createdAt: 'desc' }],
    });
  }

  async findOne(id: string, tenantId: string) {
    const template = await this.prisma.reportTemplate.findFirst({
      where: { id, tenantId },
      include: {
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
        updatedByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
        reports: { take: 5, orderBy: { createdAt: 'desc' } },
      },
    });

    if (!template) {
      throw new NotFoundException(`Template with ID ${id} not found`);
    }

    return template;
  }

  async findByType(tenantId: string, reportType: ReportType) {
    return this.prisma.reportTemplate.findMany({
      where: { tenantId, reportType, isActive: true },
      orderBy: { name: 'asc' },
    });
  }

  async update(id: string, updateTemplateDto: UpdateTemplateDto, tenantId: string, userId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.reportTemplate.update({
      where: { id },
      data: {
        ...updateTemplateDto,
        updatedBy: userId,
      },
    });
  }

  async remove(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.reportTemplate.delete({
      where: { id },
    });
  }

  async duplicate(id: string, tenantId: string, userId: string) {
    const template = await this.findOne(id, tenantId);

    return this.prisma.reportTemplate.create({
      data: {
        tenantId: template.tenantId,
        name: `${template.name} (Copy)`,
        description: template.description,
        reportType: template.reportType,
        category: template.category,
        isStandard: false,
        isActive: template.isActive,
        templateDefinition: template.templateDefinition,
        dataSource: template.dataSource,
        formatting: template.formatting,
        parameters: template.parameters,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async toggleActive(id: string, tenantId: string, userId: string) {
    const template = await this.findOne(id, tenantId);

    return this.prisma.reportTemplate.update({
      where: { id },
      data: {
        isActive: !template.isActive,
        updatedBy: userId,
      },
    });
  }

  async getStandard(tenantId: string) {
    return this.prisma.reportTemplate.findMany({
      where: { tenantId, isStandard: true, isActive: true },
      orderBy: { name: 'asc' },
    });
  }
}
