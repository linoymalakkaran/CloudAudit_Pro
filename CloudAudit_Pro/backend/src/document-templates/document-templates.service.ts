import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateDocumentTemplateDto } from './dto/create-document-template.dto';
import { UpdateDocumentTemplateDto } from './dto/update-document-template.dto';
import { GenerateFromTemplateDto } from './dto/generate-from-template.dto';
import { TemplateType } from '@prisma/client';

@Injectable()
export class DocumentTemplatesService {
  constructor(private readonly db: DatabaseService) {}

  async create(userId: string, tenantId: string, createDto: CreateDocumentTemplateDto, file?: Express.Multer.File) {
    const data: any = {
      ...createDto,
      tenantId,
      createdBy: userId,
      updatedBy: userId,
    };

    if (file) {
      data.fileName = file.originalname;
      data.filePath = file.path;
      data.fileSize = file.size;
    }

    return this.db.documentTemplate.create({
      data,
      include: {
        creator: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });
  }

  async findAll(tenantId: string, category?: string, templateType?: TemplateType, isActive?: boolean) {
    return this.db.documentTemplate.findMany({
      where: {
        tenantId,
        ...(category && { category }),
        ...(templateType && { templateType }),
        ...(isActive !== undefined && { isActive }),
      },
      include: {
        creator: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const template = await this.db.documentTemplate.findFirst({
      where: { id, tenantId },
      include: {
        creator: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
        updater: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });

    if (!template) {
      throw new NotFoundException('Template not found');
    }

    return template;
  }

  async findByCategory(category: string, tenantId: string) {
    return this.db.documentTemplate.findMany({
      where: {
        category,
        tenantId,
        isActive: true,
      },
      orderBy: { name: 'asc' },
    });
  }

  async update(id: string, tenantId: string, userId: string, updateDto: UpdateDocumentTemplateDto, file?: Express.Multer.File) {
    const template = await this.db.documentTemplate.findFirst({
      where: { id, tenantId },
    });

    if (!template) {
      throw new NotFoundException('Template not found');
    }

    const data: any = {
      ...updateDto,
      updatedBy: userId,
    };

    if (file) {
      data.fileName = file.originalname;
      data.filePath = file.path;
      data.fileSize = file.size;
    }

    return this.db.documentTemplate.update({
      where: { id },
      data,
      include: {
        updater: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });
  }

  async remove(id: string, tenantId: string) {
    const template = await this.db.documentTemplate.findFirst({
      where: { id, tenantId },
    });

    if (!template) {
      throw new NotFoundException('Template not found');
    }

    await this.db.documentTemplate.delete({ where: { id } });
    return { message: 'Template deleted successfully' };
  }

  async toggleActive(id: string, tenantId: string, userId: string) {
    const template = await this.db.documentTemplate.findFirst({
      where: { id, tenantId },
    });

    if (!template) {
      throw new NotFoundException('Template not found');
    }

    return this.db.documentTemplate.update({
      where: { id },
      data: {
        isActive: !template.isActive,
        updatedBy: userId,
      },
    });
  }

  async generateFromTemplate(id: string, tenantId: string, userId: string, generateDto: GenerateFromTemplateDto) {
    const template = await this.findOne(id, tenantId);

    if (!template.isActive) {
      throw new NotFoundException('Template is not active');
    }

    // Create document from template
    const document = await this.db.document.create({
      data: {
        tenantId,
        companyId: generateDto.companyId,
        periodId: generateDto.periodId,
        name: generateDto.name,
        type: 'OTHER' as any, // Map template type to document type
        status: 'DRAFT' as any,
        uploadedBy: userId,
        // Copy template file info
        originalFilename: template.fileName,
        filePath: template.filePath,
        fileSize: template.fileSize,
      },
    });

    return document;
  }
}
