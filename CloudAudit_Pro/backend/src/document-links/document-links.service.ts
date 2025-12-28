import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateDocumentLinkDto } from './dto/create-document-link.dto';
import { UpdateDocumentLinkDto } from './dto/update-document-link.dto';
import { LinkedEntityType } from '@prisma/client';

@Injectable()
export class DocumentLinksService {
  constructor(private readonly db: DatabaseService) {}

  async create(userId: string, tenantId: string, createDto: CreateDocumentLinkDto) {
    // Verify document exists and user has access
    const document = await this.db.document.findFirst({
      where: { id: createDto.documentId, tenantId },
    });

    if (!document) {
      throw new NotFoundException('Document not found');
    }

    return this.db.documentLink.create({
      data: {
        ...createDto,
        tenantId,
        createdBy: userId,
      },
      include: {
        document: true,
      },
    });
  }

  async findAll(tenantId: string, documentId?: string, entityType?: LinkedEntityType, entityId?: string) {
    return this.db.documentLink.findMany({
      where: {
        tenantId,
        ...(documentId && { documentId }),
        ...(entityType && { linkedEntityType: entityType }),
        ...(entityId && { linkedEntityId: entityId }),
      },
      include: {
        document: {
          select: {
            id: true,
            name: true,
            type: true,
            fileExtension: true,
          },
        },
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
    const link = await this.db.documentLink.findFirst({
      where: { id, tenantId },
      include: {
        document: true,
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

    if (!link) {
      throw new NotFoundException('Document link not found');
    }

    return link;
  }

  async findByDocument(documentId: string, tenantId: string) {
    return this.db.documentLink.findMany({
      where: { documentId, tenantId },
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

  async findByEntity(entityType: LinkedEntityType, entityId: string, tenantId: string) {
    return this.db.documentLink.findMany({
      where: {
        linkedEntityType: entityType,
        linkedEntityId: entityId,
        tenantId,
      },
      include: {
        document: {
          select: {
            id: true,
            name: true,
            type: true,
            fileExtension: true,
            uploadedAt: true,
          },
        },
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

  async update(id: string, tenantId: string, updateDto: UpdateDocumentLinkDto) {
    const link = await this.db.documentLink.findFirst({
      where: { id, tenantId },
    });

    if (!link) {
      throw new NotFoundException('Document link not found');
    }

    return this.db.documentLink.update({
      where: { id },
      data: updateDto,
      include: {
        document: true,
      },
    });
  }

  async remove(id: string, tenantId: string) {
    const link = await this.db.documentLink.findFirst({
      where: { id, tenantId },
    });

    if (!link) {
      throw new NotFoundException('Document link not found');
    }

    await this.db.documentLink.delete({ where: { id } });
    return { message: 'Document link deleted successfully' };
  }

  async createBulk(userId: string, tenantId: string, links: CreateDocumentLinkDto[]) {
    const createdLinks = await Promise.all(
      links.map(link =>
        this.db.documentLink.create({
          data: {
            ...link,
            tenantId,
            createdBy: userId,
          },
          include: {
            document: true,
          },
        })
      )
    );

    return {
      count: createdLinks.length,
      links: createdLinks,
    };
  }
}
