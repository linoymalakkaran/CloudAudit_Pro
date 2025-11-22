import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
  UseInterceptors,
  UploadedFile,
  Res,
  ParseUUIDPipe,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiConsumes,
  ApiBody,
  ApiQuery,
} from '@nestjs/swagger';
import { DocumentService } from './document.service';
import { CreateDocumentDto, UpdateDocumentDto, DocumentQueryDto } from './dto/document.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { TenantId } from '../auth/decorators/tenant-id.decorator';

@ApiTags('Documents')
@Controller('documents')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class DocumentController {
  constructor(private readonly documentService: DocumentService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new document with optional file upload' })
  @ApiResponse({ status: 201, description: 'Document created successfully' })
  @ApiResponse({ status: 400, description: 'Invalid input data' })
  @ApiResponse({ status: 404, description: 'Company, period, or account not found' })
  @UseInterceptors(FileInterceptor('file'))
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    description: 'Document data with optional file',
    schema: {
      type: 'object',
      properties: {
        name: { type: 'string' },
        description: { type: 'string' },
        type: { 
          type: 'string',
          enum: [
            'FINANCIAL_STATEMENT', 'TRIAL_BALANCE', 'GENERAL_LEDGER',
            'BANK_STATEMENT', 'INVOICE', 'RECEIPT', 'CONTRACT',
            'CORRESPONDENCE', 'WORKING_PAPER', 'MANAGEMENT_LETTER', 'OTHER'
          ]
        },
        companyId: { type: 'string', format: 'uuid' },
        periodId: { type: 'string', format: 'uuid', nullable: true },
        accountId: { type: 'string', format: 'uuid', nullable: true },
        tags: { type: 'array', items: { type: 'string' } },
        file: { type: 'string', format: 'binary' },
      },
      required: ['name', 'type', 'companyId'],
    },
  })
  async create(
    @Body() createDocumentDto: CreateDocumentDto,
    @UploadedFile() file: Express.Multer.File,
    @TenantId() tenantId: string,
  ) {
    return this.documentService.create(createDocumentDto, tenantId, file);
  }

  @Get()
  @ApiOperation({ summary: 'Get all documents with filtering and pagination' })
  @ApiResponse({ status: 200, description: 'Documents retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: 'string', format: 'uuid' })
  @ApiQuery({ name: 'periodId', required: false, type: 'string', format: 'uuid' })
  @ApiQuery({ name: 'accountId', required: false, type: 'string', format: 'uuid' })
  @ApiQuery({ name: 'type', required: false, enum: ['FINANCIAL_STATEMENT', 'TRIAL_BALANCE', 'GENERAL_LEDGER', 'BANK_STATEMENT', 'INVOICE', 'RECEIPT', 'CONTRACT', 'CORRESPONDENCE', 'WORKING_PAPER', 'MANAGEMENT_LETTER', 'OTHER'] })
  @ApiQuery({ name: 'status', required: false, enum: ['PENDING', 'REVIEWED', 'APPROVED', 'REJECTED'] })
  @ApiQuery({ name: 'search', required: false, type: 'string' })
  @ApiQuery({ name: 'tags', required: false, type: 'array', items: { type: 'string' } })
  @ApiQuery({ name: 'page', required: false, type: 'number', minimum: 1 })
  @ApiQuery({ name: 'limit', required: false, type: 'number', minimum: 1, maximum: 100 })
  async findAll(@Query() query: DocumentQueryDto, @TenantId() tenantId: string) {
    return this.documentService.findAll(query, tenantId);
  }

  @Get('statistics')
  @ApiOperation({ summary: 'Get document statistics' })
  @ApiResponse({ status: 200, description: 'Statistics retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: 'string', format: 'uuid' })
  async getStatistics(
    @Query('companyId') companyId: string,
    @TenantId() tenantId: string,
  ) {
    return this.documentService.getStatistics(tenantId, companyId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a document by ID' })
  @ApiResponse({ status: 200, description: 'Document retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Document not found' })
  async findOne(@Param('id', ParseUUIDPipe) id: string, @TenantId() tenantId: string) {
    return this.documentService.findOne(id, tenantId);
  }

  @Get(':id/download')
  @ApiOperation({ summary: 'Download document file' })
  @ApiResponse({ status: 200, description: 'File downloaded successfully' })
  @ApiResponse({ status: 404, description: 'Document or file not found' })
  @ApiResponse({ status: 400, description: 'Document has no associated file' })
  async downloadFile(
    @Param('id', ParseUUIDPipe) id: string,
    @TenantId() tenantId: string,
    @Res() res: Response,
  ) {
    const fileData = await this.documentService.downloadFile(id, tenantId);
    
    res.set({
      'Content-Type': fileData.mimeType,
      'Content-Disposition': `attachment; filename="${fileData.filename}"`,
    });
    
    res.send(fileData.buffer);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a document' })
  @ApiResponse({ status: 200, description: 'Document updated successfully' })
  @ApiResponse({ status: 404, description: 'Document not found' })
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() updateDocumentDto: UpdateDocumentDto,
    @TenantId() tenantId: string,
  ) {
    return this.documentService.update(id, updateDocumentDto, tenantId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a document' })
  @ApiResponse({ status: 200, description: 'Document deleted successfully' })
  @ApiResponse({ status: 404, description: 'Document not found' })
  async remove(@Param('id', ParseUUIDPipe) id: string, @TenantId() tenantId: string) {
    return this.documentService.remove(id, tenantId);
  }
}