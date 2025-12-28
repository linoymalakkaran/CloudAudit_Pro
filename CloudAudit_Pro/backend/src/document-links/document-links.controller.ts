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
  Request,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { DocumentLinksService } from './document-links.service';
import { CreateDocumentLinkDto } from './dto/create-document-link.dto';
import { UpdateDocumentLinkDto } from './dto/update-document-link.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { LinkedEntityType } from '@prisma/client';

@ApiTags('document-links')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('document-links')
export class DocumentLinksController {
  constructor(private readonly documentLinksService: DocumentLinksService) {}

  @Post()
  @ApiOperation({ summary: 'Create document link' })
  @ApiResponse({ status: 201, description: 'Document link created successfully' })
  create(@Request() req, @Body() createDto: CreateDocumentLinkDto) {
    return this.documentLinksService.create(req.user.id, req.user.tenantId, createDto);
  }

  @Post('bulk')
  @ApiOperation({ summary: 'Create multiple document links' })
  @ApiResponse({ status: 201, description: 'Document links created successfully' })
  createBulk(@Request() req, @Body() links: CreateDocumentLinkDto[]) {
    return this.documentLinksService.createBulk(req.user.id, req.user.tenantId, links);
  }

  @Get()
  @ApiOperation({ summary: 'Get all document links' })
  @ApiQuery({ name: 'documentId', required: false })
  @ApiQuery({ name: 'entityType', enum: LinkedEntityType, required: false })
  @ApiQuery({ name: 'entityId', required: false })
  findAll(
    @Request() req,
    @Query('documentId') documentId?: string,
    @Query('entityType') entityType?: LinkedEntityType,
    @Query('entityId') entityId?: string,
  ) {
    return this.documentLinksService.findAll(req.user.tenantId, documentId, entityType, entityId);
  }

  @Get('document/:documentId')
  @ApiOperation({ summary: 'Get links for a specific document' })
  findByDocument(@Request() req, @Param('documentId') documentId: string) {
    return this.documentLinksService.findByDocument(documentId, req.user.tenantId);
  }

  @Get('entity/:entityType/:entityId')
  @ApiOperation({ summary: 'Get links for a specific entity' })
  findByEntity(
    @Request() req,
    @Param('entityType') entityType: LinkedEntityType,
    @Param('entityId') entityId: string,
  ) {
    return this.documentLinksService.findByEntity(entityType, entityId, req.user.tenantId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get document link by ID' })
  findOne(@Request() req, @Param('id') id: string) {
    return this.documentLinksService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update document link' })
  update(@Request() req, @Param('id') id: string, @Body() updateDto: UpdateDocumentLinkDto) {
    return this.documentLinksService.update(id, req.user.tenantId, updateDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete document link' })
  remove(@Request() req, @Param('id') id: string) {
    return this.documentLinksService.remove(id, req.user.tenantId);
  }
}
