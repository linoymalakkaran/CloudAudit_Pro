import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateDocumentCollectionDto } from './dto/create-document-collection.dto';
import { UpdateDocumentCollectionDto } from './dto/update-document-collection.dto';
import { CreateCollectionItemDto } from './dto/create-collection-item.dto';
import { CollectionStatus, DocumentItemStatus } from '@prisma/client';

@Injectable()
export class DocumentCollectionsService {
  constructor(private prisma: PrismaService) {}

  async create(
    createDocumentCollectionDto: CreateDocumentCollectionDto,
    tenantId: string,
    userId: string,
  ) {
    return this.prisma.documentCollection.create({
      data: {
        ...createDocumentCollectionDto,
        tenantId,
        status: CollectionStatus.DRAFT,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: true,
        period: true,
        creator: { select: { id: true, email: true, name: true } },
        assignedToUser: { select: { id: true, email: true, name: true } },
      },
    });
  }

  async findAll(
    tenantId: string,
    companyId?: string,
    periodId?: string,
    status?: CollectionStatus,
    collectionType?: string,
  ) {
    const where: any = { tenantId };
    
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;
    if (status) where.status = status;
    if (collectionType) where.collectionType = collectionType;

    return this.prisma.documentCollection.findMany({
      where,
      include: {
        company: true,
        period: true,
        creator: { select: { id: true, email: true, name: true } },
        assignedToUser: { select: { id: true, email: true, name: true } },
        items: {
          include: {
            document: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string, tenantId: string) {
    const collection = await this.prisma.documentCollection.findFirst({
      where: { id, tenantId },
      include: {
        company: true,
        period: true,
        creator: { select: { id: true, email: true, name: true } },
        updater: { select: { id: true, email: true, name: true } },
        assignedToUser: { select: { id: true, email: true, name: true } },
        items: {
          include: {
            document: true,
            uploadedByUser: { select: { id: true, email: true, name: true } },
          },
          orderBy: { createdAt: 'asc' },
        },
      },
    });

    if (!collection) {
      throw new NotFoundException(`Document collection with ID ${id} not found`);
    }

    return collection;
  }

  async update(
    id: string,
    updateDocumentCollectionDto: UpdateDocumentCollectionDto,
    tenantId: string,
    userId: string,
  ) {
    await this.findOne(id, tenantId);

    return this.prisma.documentCollection.update({
      where: { id },
      data: {
        ...updateDocumentCollectionDto,
        updatedBy: userId,
      },
      include: {
        company: true,
        period: true,
        creator: { select: { id: true, email: true, name: true } },
        updater: { select: { id: true, email: true, name: true } },
        assignedToUser: { select: { id: true, email: true, name: true } },
      },
    });
  }

  async remove(id: string, tenantId: string) {
    await this.findOne(id, tenantId);

    return this.prisma.documentCollection.delete({
      where: { id },
    });
  }

  async updateStatus(
    id: string,
    status: CollectionStatus,
    tenantId: string,
    userId: string,
  ) {
    await this.findOne(id, tenantId);

    const updateData: any = {
      status,
      updatedBy: userId,
    };

    if (status === CollectionStatus.SENT) {
      updateData.sentDate = new Date();
    } else if (status === CollectionStatus.COMPLETED) {
      updateData.completedDate = new Date();
    }

    return this.prisma.documentCollection.update({
      where: { id },
      data: updateData,
      include: {
        company: true,
        period: true,
        items: { include: { document: true } },
      },
    });
  }

  // Collection Items Management
  async addItem(
    collectionId: string,
    createCollectionItemDto: CreateCollectionItemDto,
    tenantId: string,
    userId: string,
  ) {
    await this.findOne(collectionId, tenantId);

    return this.prisma.documentCollectionItem.create({
      data: {
        collectionId,
        ...createCollectionItemDto,
        status: DocumentItemStatus.PENDING,
        tenantId,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        document: true,
      },
    });
  }

  async updateItem(
    itemId: string,
    data: Partial<CreateCollectionItemDto>,
    tenantId: string,
    userId: string,
  ) {
    const item = await this.prisma.documentCollectionItem.findFirst({
      where: { id: itemId, tenantId },
    });

    if (!item) {
      throw new NotFoundException(`Collection item with ID ${itemId} not found`);
    }

    return this.prisma.documentCollectionItem.update({
      where: { id: itemId },
      data: {
        ...data,
        updatedBy: userId,
      },
      include: {
        document: true,
      },
    });
  }

  async removeItem(itemId: string, tenantId: string) {
    const item = await this.prisma.documentCollectionItem.findFirst({
      where: { id: itemId, tenantId },
    });

    if (!item) {
      throw new NotFoundException(`Collection item with ID ${itemId} not found`);
    }

    return this.prisma.documentCollectionItem.delete({
      where: { id: itemId },
    });
  }

  async uploadDocument(
    itemId: string,
    documentId: string,
    tenantId: string,
    userId: string,
  ) {
    const item = await this.prisma.documentCollectionItem.findFirst({
      where: { id: itemId, tenantId },
    });

    if (!item) {
      throw new NotFoundException(`Collection item with ID ${itemId} not found`);
    }

    return this.prisma.documentCollectionItem.update({
      where: { id: itemId },
      data: {
        documentId,
        uploadedBy: userId,
        uploadedAt: new Date(),
        status: DocumentItemStatus.UPLOADED,
        updatedBy: userId,
      },
      include: {
        document: true,
        uploadedByUser: { select: { id: true, email: true, name: true } },
      },
    });
  }

  async getCollectionProgress(id: string, tenantId: string) {
    const collection = await this.findOne(id, tenantId);
    
    const totalItems = collection.items.length;
    const uploadedItems = collection.items.filter(
      item => item.status === DocumentItemStatus.UPLOADED || 
              item.status === DocumentItemStatus.APPROVED
    ).length;
    const approvedItems = collection.items.filter(
      item => item.status === DocumentItemStatus.APPROVED
    ).length;

    return {
      collectionId: id,
      totalItems,
      uploadedItems,
      approvedItems,
      percentComplete: totalItems > 0 ? Math.round((uploadedItems / totalItems) * 100) : 0,
      status: collection.status,
    };
  }
}
