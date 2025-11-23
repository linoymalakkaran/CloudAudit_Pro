import { Injectable, NotFoundException, BadRequestException, Logger } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateDocumentDto, UpdateDocumentDto, DocumentQueryDto } from './dto/document.dto';
import * as path from 'path';
import * as fs from 'fs/promises';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class DocumentService {
  private readonly logger = new Logger(DocumentService.name);
  private readonly uploadsDir = process.env.UPLOADS_DIR || './uploads';

  constructor(private prisma: PrismaService) {
    this.ensureUploadsDirectory();
  }

  private async ensureUploadsDirectory() {
    try {
      await fs.access(this.uploadsDir);
    } catch {
      await fs.mkdir(this.uploadsDir, { recursive: true });
      this.logger.log(`Created uploads directory: ${this.uploadsDir}`);
    }
  }

  async create(createDocumentDto: CreateDocumentDto, tenantId: string, file?: Express.Multer.File) {
    // Validate that company belongs to tenant
    const company = await this.prisma.company.findFirst({
      where: {
        id: createDocumentDto.companyId,
        tenantId,
      },
    });

    if (!company) {
      throw new NotFoundException('Company not found or does not belong to your organization');
    }

    // Validate period if provided
    if (createDocumentDto.periodId) {
      const period = await this.prisma.period.findFirst({
        where: {
          id: createDocumentDto.periodId,
          companyId: createDocumentDto.companyId,
        },
      });

      if (!period) {
        throw new NotFoundException('Period not found or does not belong to the specified company');
      }
    }

    // Validate account if provided
    if (createDocumentDto.accountId) {
      const account = await this.prisma.account.findFirst({
        where: {
          id: createDocumentDto.accountId,
          companyId: createDocumentDto.companyId,
        },
      });

      if (!account) {
        throw new NotFoundException('Account not found or does not belong to the specified company');
      }
    }

    let filePath: string | null = null;
    let fileSize: number | null = null;
    let mimeType: string | null = null;
    let originalName: string | null = null;

    // Handle file upload if provided
    if (file) {
      const fileExtension = path.extname(file.originalname);
      const fileName = `${uuidv4()}${fileExtension}`;
      filePath = path.join(this.uploadsDir, fileName);
      
      await fs.writeFile(filePath, file.buffer);
      
      fileSize = file.size;
      mimeType = file.mimetype;
      originalName = file.originalname;

      this.logger.log(`File uploaded: ${fileName} (${fileSize} bytes)`);
    }

    const document = await this.prisma.document.create({
      data: {
        name: createDocumentDto.name,
        description: createDocumentDto.description,
        type: createDocumentDto.type,
        companyId: createDocumentDto.companyId,
        periodId: createDocumentDto.periodId,
        accountId: createDocumentDto.accountId,
        tenantId,
        filePath,
        fileSize,
        mimeType,
        originalFilename: originalName,
        uploadedBy: 'system', // Default uploader
        tags: createDocumentDto.tags || [],
        status: 'PENDING',
      },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, accountNumber: true, name: true },
        },
        uploader: {
          select: { id: true, email: true, firstName: true, lastName: true },
        },
      },
    });

    this.logger.log(`Document created: ${document.id} for company ${company.name}`);
    return document;
  }

  async findAll(query: DocumentQueryDto, tenantId: string) {
    const {
      companyId,
      periodId,
      accountId,
      type,
      status,
      search,
      tags,
      page = 1,
      limit = 20,
    } = query;

    const skip = (page - 1) * limit;

    const where: any = { tenantId };

    // Company filter (ensure it belongs to tenant)
    if (companyId) {
      const company = await this.prisma.company.findFirst({
        where: { id: companyId, tenantId },
      });

      if (!company) {
        throw new NotFoundException('Company not found or does not belong to your organization');
      }

      where.companyId = companyId;
    }

    // Additional filters
    if (periodId) where.periodId = periodId;
    if (accountId) where.accountId = accountId;
    if (type) where.type = type;
    if (status) where.status = status;

    // Search functionality
    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
        { originalName: { contains: search, mode: 'insensitive' } },
      ];
    }

    // Tags filter
    if (tags && tags.length > 0) {
      where.tags = {
        hasEvery: tags,
      };
    }

    const [documents, total] = await Promise.all([
      this.prisma.document.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          company: {
            select: { id: true, name: true },
          },
          period: {
            select: { id: true, name: true },
          },
          account: {
            select: { id: true, accountNumber: true, name: true },
          },
          uploader: {
            select: { id: true, email: true, firstName: true, lastName: true },
          },
        },
      }),
      this.prisma.document.count({ where }),
    ]);

    return {
      data: documents,
      pagination: {
        total,
        page,
        limit,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string, tenantId: string) {
    const document = await this.prisma.document.findFirst({
      where: { id, tenantId },
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, accountNumber: true, name: true },
        },
        uploader: {
          select: { id: true, email: true, firstName: true, lastName: true },
        },
      },
    });

    if (!document) {
      throw new NotFoundException('Document not found');
    }

    return document;
  }

  async update(id: string, updateDocumentDto: UpdateDocumentDto, tenantId: string) {
    const existingDocument = await this.findOne(id, tenantId);

    const document = await this.prisma.document.update({
      where: { id },
      data: updateDocumentDto,
      include: {
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true },
        },
        account: {
          select: { id: true, accountNumber: true, name: true },
        },
        uploader: {
          select: { id: true, email: true, firstName: true, lastName: true },
        },
      },
    });

    this.logger.log(`Document updated: ${id}`);
    return document;
  }

  async remove(id: string, tenantId: string) {
    const document = await this.findOne(id, tenantId);

    // Delete physical file if exists
    if (document.filePath) {
      try {
        await fs.unlink(document.filePath);
        this.logger.log(`File deleted: ${document.filePath}`);
      } catch (error) {
        this.logger.warn(`Failed to delete file: ${document.filePath}`, error);
      }
    }

    await this.prisma.document.delete({
      where: { id },
    });

    this.logger.log(`Document deleted: ${id}`);
    return { message: 'Document deleted successfully' };
  }

  async downloadFile(id: string, tenantId: string) {
    const document = await this.findOne(id, tenantId);

    if (!document.filePath) {
      throw new BadRequestException('Document has no associated file');
    }

    try {
      const fileBuffer = await fs.readFile(document.filePath);
      return {
        buffer: fileBuffer,
        filename: document.originalFilename || `document_${id}`,
        mimeType: document.mimeType || 'application/octet-stream',
      };
    } catch (error) {
      this.logger.error(`Failed to read file: ${document.filePath}`, error);
      throw new NotFoundException('File not found on disk');
    }
  }

  async getStatistics(tenantId: string, companyId?: string) {
    const where: any = { tenantId };
    if (companyId) {
      // Validate company belongs to tenant
      const company = await this.prisma.company.findFirst({
        where: { id: companyId, tenantId },
      });

      if (!company) {
        throw new NotFoundException('Company not found or does not belong to your organization');
      }

      where.companyId = companyId;
    }

    const [
      totalDocuments,
      documentsByType,
      documentsByStatus,
      recentDocuments
    ] = await Promise.all([
      this.prisma.document.count({ where }),
      this.prisma.document.groupBy({
        by: ['type'],
        where,
        _count: true,
      }),
      this.prisma.document.groupBy({
        by: ['status'],
        where,
        _count: true,
      }),
      this.prisma.document.findMany({
        where,
        take: 10,
        orderBy: { createdAt: 'desc' },
        select: {
          id: true,
          name: true,
          type: true,
          status: true,
          createdAt: true,
          company: { select: { name: true } },
        },
      }),
    ]);

    return {
      totalDocuments,
      documentsByType: documentsByType.reduce((acc, item) => {
        acc[item.type] = item._count;
        return acc;
      }, {}),
      documentsByStatus: documentsByStatus.reduce((acc, item) => {
        acc[item.status] = item._count;
        return acc;
      }, {}),
      recentDocuments,
    };
  }
}