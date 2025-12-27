import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateProcedureTemplateDto, UpdateProcedureTemplateDto, QueryProcedureTemplateDto } from './dto';

@Injectable()
export class ProcedureTemplateService {
  constructor(private readonly db: DatabaseService) {}

  async findAll(tenantId: string, query: QueryProcedureTemplateDto) {
    const where: any = { tenantId };

    if (query.category) {
      where.category = query.category;
    }

    if (query.isActive !== undefined) {
      where.isActive = query.isActive;
    }

    if (query.isMandatory !== undefined) {
      where.isMandatory = query.isMandatory;
    }

    if (query.search) {
      where.OR = [
        { name: { contains: query.search, mode: 'insensitive' } },
        { description: { contains: query.search, mode: 'insensitive' } },
        { procedureText: { contains: query.search, mode: 'insensitive' } },
      ];
    }

    return this.db.procedureTemplate.findMany({
      where,
      orderBy: [
        { isMandatory: 'desc' },
        { category: 'asc' },
        { name: 'asc' },
      ],
    });
  }

  async findOne(tenantId: string, id: string) {
    const template = await this.db.procedureTemplate.findFirst({
      where: { id, tenantId },
    });

    if (!template) {
      throw new NotFoundException(`Procedure template with ID ${id} not found`);
    }

    return template;
  }

  async create(tenantId: string, userId: string, dto: CreateProcedureTemplateDto) {
    return this.db.procedureTemplate.create({
      data: {
        ...dto,
        tenantId,
        createdBy: userId,
      },
    });
  }

  async update(tenantId: string, id: string, dto: UpdateProcedureTemplateDto) {
    await this.findOne(tenantId, id); // Ensure it exists

    return this.db.procedureTemplate.update({
      where: { id },
      data: dto,
    });
  }

  async delete(tenantId: string, id: string) {
    await this.findOne(tenantId, id); // Ensure it exists

    return this.db.procedureTemplate.delete({
      where: { id },
    });
  }

  async getStatistics(tenantId: string) {
    const [total, active, mandatory, byCategory] = await Promise.all([
      this.db.procedureTemplate.count({ where: { tenantId } }),
      this.db.procedureTemplate.count({ where: { tenantId, isActive: true } }),
      this.db.procedureTemplate.count({ where: { tenantId, isMandatory: true } }),
      this.db.procedureTemplate.groupBy({
        by: ['category'],
        where: { tenantId },
        _count: true,
      }),
    ]);

    return {
      total,
      active,
      mandatory,
      byCategory: byCategory.map((item) => ({
        category: item.category,
        count: item._count,
      })),
    };
  }
}
