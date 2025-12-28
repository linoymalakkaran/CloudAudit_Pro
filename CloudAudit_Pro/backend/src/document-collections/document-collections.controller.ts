import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { DocumentCollectionsService } from './document-collections.service';
import { CreateDocumentCollectionDto } from './dto/create-document-collection.dto';
import { UpdateDocumentCollectionDto } from './dto/update-document-collection.dto';
import { CreateCollectionItemDto } from './dto/create-collection-item.dto';
import { UploadCollectionItemDto } from './dto/upload-collection-item.dto';
import { CollectionStatus } from '@prisma/client';

@ApiTags('document-collections')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('document-collections')
export class DocumentCollectionsController {
  constructor(
    private readonly documentCollectionsService: DocumentCollectionsService,
  ) {}

  @Post()
  @ApiOperation({ summary: 'Create document collection' })
  create(
    @Body() createDocumentCollectionDto: CreateDocumentCollectionDto,
    @Request() req,
  ) {
    return this.documentCollectionsService.create(
      createDocumentCollectionDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get()
  @ApiOperation({ summary: 'Get all document collections' })
  @ApiQuery({ name: 'companyId', required: false })
  @ApiQuery({ name: 'periodId', required: false })
  @ApiQuery({ name: 'status', required: false, enum: CollectionStatus })
  @ApiQuery({ name: 'collectionType', required: false })
  findAll(
    @Request() req,
    @Query('companyId') companyId?: string,
    @Query('periodId') periodId?: string,
    @Query('status') status?: CollectionStatus,
    @Query('collectionType') collectionType?: string,
  ) {
    return this.documentCollectionsService.findAll(
      req.user.tenantId,
      companyId,
      periodId,
      status,
      collectionType,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get document collection by ID' })
  findOne(@Param('id') id: string, @Request() req) {
    return this.documentCollectionsService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update document collection' })
  update(
    @Param('id') id: string,
    @Body() updateDocumentCollectionDto: UpdateDocumentCollectionDto,
    @Request() req,
  ) {
    return this.documentCollectionsService.update(
      id,
      updateDocumentCollectionDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete document collection' })
  remove(@Param('id') id: string, @Request() req) {
    return this.documentCollectionsService.remove(id, req.user.tenantId);
  }

  @Post(':id/status')
  @ApiOperation({ summary: 'Update collection status' })
  updateStatus(
    @Param('id') id: string,
    @Body('status') status: CollectionStatus,
    @Request() req,
  ) {
    return this.documentCollectionsService.updateStatus(
      id,
      status,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Get(':id/progress')
  @ApiOperation({ summary: 'Get collection progress' })
  getProgress(@Param('id') id: string, @Request() req) {
    return this.documentCollectionsService.getCollectionProgress(
      id,
      req.user.tenantId,
    );
  }

  // Collection Items
  @Post(':id/items')
  @ApiOperation({ summary: 'Add item to collection' })
  addItem(
    @Param('id') id: string,
    @Body() createCollectionItemDto: CreateCollectionItemDto,
    @Request() req,
  ) {
    return this.documentCollectionsService.addItem(
      id,
      createCollectionItemDto,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Patch('items/:itemId')
  @ApiOperation({ summary: 'Update collection item' })
  updateItem(
    @Param('itemId') itemId: string,
    @Body() data: Partial<CreateCollectionItemDto>,
    @Request() req,
  ) {
    return this.documentCollectionsService.updateItem(
      itemId,
      data,
      req.user.tenantId,
      req.user.sub,
    );
  }

  @Delete('items/:itemId')
  @ApiOperation({ summary: 'Remove item from collection' })
  removeItem(@Param('itemId') itemId: string, @Request() req) {
    return this.documentCollectionsService.removeItem(itemId, req.user.tenantId);
  }

  @Post('items/:itemId/upload')
  @ApiOperation({ summary: 'Upload document for collection item' })
  uploadDocument(
    @Param('itemId') itemId: string,
    @Body() uploadDto: UploadCollectionItemDto,
    @Request() req,
  ) {
    return this.documentCollectionsService.uploadDocument(
      itemId,
      uploadDto.documentId,
      req.user.tenantId,
      req.user.sub,
    );
  }
}
