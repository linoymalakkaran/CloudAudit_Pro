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
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery, ApiConsumes } from '@nestjs/swagger';
import { DocumentTemplatesService } from './document-templates.service';
import { CreateDocumentTemplateDto } from './dto/create-document-template.dto';
import { UpdateDocumentTemplateDto } from './dto/update-document-template.dto';
import { GenerateFromTemplateDto } from './dto/generate-from-template.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { TemplateType } from '@prisma/client';

@ApiTags('document-templates')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('document-templates')
export class DocumentTemplatesController {
  constructor(private readonly documentTemplatesService: DocumentTemplatesService) {}

  @Post()
  @ApiOperation({ summary: 'Create document template' })
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('file'))
  create(@Request() req, @Body() createDto: CreateDocumentTemplateDto, @UploadedFile() file: Express.Multer.File) {
    return this.documentTemplatesService.create(req.user.id, req.user.tenantId, createDto, file);
  }

  @Get()
  @ApiOperation({ summary: 'Get all templates' })
  @ApiQuery({ name: 'category', required: false })
  @ApiQuery({ name: 'templateType', enum: TemplateType, required: false })
  @ApiQuery({ name: 'isActive', required: false, type: Boolean })
  findAll(
    @Request() req,
    @Query('category') category?: string,
    @Query('templateType') templateType?: TemplateType,
    @Query('isActive') isActive?: boolean,
  ) {
    return this.documentTemplatesService.findAll(req.user.tenantId, category, templateType, isActive);
  }

  @Get('category/:category')
  @ApiOperation({ summary: 'Get templates by category' })
  findByCategory(@Request() req, @Param('category') category: string) {
    return this.documentTemplatesService.findByCategory(category, req.user.tenantId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get template by ID' })
  findOne(@Request() req, @Param('id') id: string) {
    return this.documentTemplatesService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update template' })
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('file'))
  update(
    @Request() req,
    @Param('id') id: string,
    @Body() updateDto: UpdateDocumentTemplateDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.documentTemplatesService.update(id, req.user.tenantId, req.user.id, updateDto, file);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete template' })
  remove(@Request() req, @Param('id') id: string) {
    return this.documentTemplatesService.remove(id, req.user.tenantId);
  }

  @Post(':id/activate')
  @ApiOperation({ summary: 'Toggle template active status' })
  toggleActive(@Request() req, @Param('id') id: string) {
    return this.documentTemplatesService.toggleActive(id, req.user.tenantId, req.user.id);
  }

  @Post(':id/generate')
  @ApiOperation({ summary: 'Generate document from template' })
  generateFromTemplate(@Request() req, @Param('id') id: string, @Body() generateDto: GenerateFromTemplateDto) {
    return this.documentTemplatesService.generateFromTemplate(id, req.user.tenantId, req.user.id, generateDto);
  }
}
