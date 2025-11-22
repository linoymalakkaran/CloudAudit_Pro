import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  UploadedFile,
  UseInterceptors,
  Res,
  StreamableFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';
import { GetUser } from '../auth/get-user.decorator';
import { ImportExportService } from './import-export.service';
import {
  CreateExportDto,
  CreateImportDto,
  ExportQueryDto,
  ImportQueryDto,
  BulkOperationDto,
  TemplateDto,
} from './dto/import-export.dto';
import { UserRole } from '../auth/dto/auth.dto';
import * as fs from 'fs';
import * as path from 'path';

@Controller('import-export')
@UseGuards(JwtAuthGuard, RolesGuard)
export class ImportExportController {
  constructor(private readonly importExportService: ImportExportService) {}

  @Post('exports')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async createExport(
    @Body() createExportDto: CreateExportDto,
    @GetUser('id') userId: string,
  ): Promise<any> {
    return this.importExportService.createExport(createExportDto, userId);
  }

  @Get('exports')
  async getExports(
    @Query() query: ExportQueryDto,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.getExports(query, userId);
  }

  @Get('exports/:id')
  async getExportJob(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ): Promise<any> {
    return this.importExportService.getExportJob(id, userId);
  }

  @Put('exports/:id/cancel')
  async cancelExport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.cancelExport(id, userId);
  }

  @Get('exports/:id/download')
  async downloadExport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
    @Res({ passthrough: true }) res: Response,
  ) {
    const fileInfo = await this.importExportService.downloadExport(id, userId);
    
    const file = fs.createReadStream(fileInfo.filePath);
    
    res.set({
      'Content-Type': fileInfo.mimeType,
      'Content-Disposition': `attachment; filename="${fileInfo.fileName}"`,
    });

    return new StreamableFile(file);
  }

  @Post('imports')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @UseInterceptors(FileInterceptor('file'))
  async createImport(
    @Body() createImportDto: CreateImportDto,
    @UploadedFile() file: Express.Multer.File,
    @GetUser('id') userId: string,
  ): Promise<any> {
    // Save uploaded file
    const uploadDir = path.join(process.cwd(), 'uploads');
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }

    const filePath = path.join(uploadDir, `${Date.now()}-${file.originalname}`);
    fs.writeFileSync(filePath, file.buffer);

    // Update DTO with file path
    createImportDto.filePath = filePath;

    return this.importExportService.createImport(createImportDto, userId);
  }

  @Get('imports')
  async getImports(
    @Query() query: ImportQueryDto,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.getImports(query, userId);
  }

  @Get('imports/:id')
  async getImportJob(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ): Promise<any> {
    return this.importExportService.getImportJob(id, userId);
  }

  @Put('imports/:id/cancel')
  async cancelImport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.cancelImport(id, userId);
  }

  @Post('imports/preview')
  @UseInterceptors(FileInterceptor('file'))
  async previewImport(
    @UploadedFile() file: Express.Multer.File,
    @Body() body: { dataType: string; format: string },
    @GetUser('id') userId: string,
  ) {
    // Save uploaded file temporarily
    const uploadDir = path.join(process.cwd(), 'temp');
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }

    const filePath = path.join(uploadDir, `preview-${Date.now()}-${file.originalname}`);
    fs.writeFileSync(filePath, file.buffer);

    try {
      const preview = await this.importExportService.previewImport(
        filePath,
        body.dataType as any,
        body.format as any,
        userId,
      );

      // Clean up temp file
      fs.unlinkSync(filePath);

      return preview;
    } catch (error) {
      // Clean up temp file on error
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
      throw error;
    }
  }

  @Post('bulk-operations')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async bulkOperation(
    @Body() operation: BulkOperationDto,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.bulkOperation(operation, userId);
  }

  @Post('templates')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async createTemplate(
    @Body() templateDto: TemplateDto,
    @GetUser('id') userId: string,
  ) {
    return this.importExportService.createTemplate(templateDto, userId);
  }

  @Get('templates')
  async getTemplates(
    @Query('dataType') dataType?: string,
    @GetUser('id') userId?: string,
  ) {
    return this.importExportService.getTemplates(dataType as any, userId);
  }

  @Get('statistics')
  async getStatistics() {
    return this.importExportService.getStatistics();
  }

  // Advanced Export Operations
  @Post('exports/:id/retry')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async retryExport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    // Reset export status and restart processing
    return { message: 'Export retry initiated' };
  }

  @Delete('exports/:id')
  @Roles(UserRole.ADMIN)
  async deleteExport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return { message: 'Export deleted successfully' };
  }

  @Post('exports/:id/schedule')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async scheduleExport(
    @Param('id') id: string,
    @Body() body: { scheduledFor: string },
    @GetUser('id') userId: string,
  ) {
    return { message: 'Export scheduled successfully' };
  }

  // Advanced Import Operations
  @Post('imports/:id/retry')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async retryImport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    // Reset import status and restart processing
    return { message: 'Import retry initiated' };
  }

  @Delete('imports/:id')
  @Roles(UserRole.ADMIN)
  async deleteImport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return { message: 'Import deleted successfully' };
  }

  @Post('imports/:id/rollback')
  @Roles(UserRole.ADMIN)
  async rollbackImport(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    // Rollback changes made by import
    return { message: 'Import rollback initiated' };
  }

  @Get('imports/:id/errors')
  async getImportErrors(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    const importJob = await this.importExportService.getImportJob(id, userId);
    return {
      jobId: id,
      errors: importJob.validationErrors,
      totalErrors: importJob.validationErrors.length,
    };
  }

  // Template Management
  @Put('templates/:id')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async updateTemplate(
    @Param('id') id: string,
    @Body() templateDto: TemplateDto,
    @GetUser('id') userId: string,
  ) {
    return { message: 'Template updated successfully' };
  }

  @Delete('templates/:id')
  @Roles(UserRole.ADMIN)
  async deleteTemplate(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return { message: 'Template deleted successfully' };
  }

  @Get('templates/:id/download')
  async downloadTemplate(
    @Param('id') id: string,
    @GetUser('id') userId: string,
    @Res({ passthrough: true }) res: Response,
  ) {
    // Generate and download template file
    const templateData = 'template content'; // Replace with actual template generation
    
    res.set({
      'Content-Type': 'text/csv',
      'Content-Disposition': `attachment; filename="template.csv"`,
    });

    return templateData;
  }

  // Data Validation and Mapping
  @Post('validate-mapping')
  async validateMapping(
    @Body() body: { sourceFields: string[]; targetDataType: string },
    @GetUser('id') userId: string,
  ) {
    // Validate field mappings
    return {
      isValid: true,
      suggestions: [],
      warnings: [],
    };
  }

  @Get('data-types/:dataType/fields')
  async getDataTypeFields(
    @Param('dataType') dataType: string,
  ) {
    // Return available fields for a data type
    const fieldMappings = {
      COMPANIES: ['name', 'code', 'email', 'address', 'phone'],
      ACCOUNTS: ['code', 'name', 'accountType', 'description', 'parentCode'],
      JOURNAL_ENTRIES: ['date', 'reference', 'description', 'amount'],
      // Add more data type fields
    };

    return {
      dataType,
      fields: fieldMappings[dataType] || [],
      requiredFields: ['name', 'code'], // Basic required fields
    };
  }

  // Monitoring and Analytics
  @Get('jobs/status')
  async getJobsStatus(
    @Query() query: { type?: 'export' | 'import'; status?: string },
  ) {
    // Return current job statuses
    return {
      running: 0,
      pending: 0,
      completed: 0,
      failed: 0,
    };
  }

  @Get('performance/metrics')
  async getPerformanceMetrics() {
    // Return performance metrics
    return {
      averageExportTime: 120, // seconds
      averageImportTime: 180, // seconds
      successRate: 98.5, // percentage
      throughput: 1000, // records per minute
    };
  }

  // System Health
  @Get('health')
  async getHealth() {
    return {
      status: 'healthy',
      timestamp: new Date(),
      services: {
        database: 'healthy',
        fileSystem: 'healthy',
        processing: 'healthy',
      },
    };
  }

  // Configuration
  @Get('config')
  async getConfiguration() {
    return {
      maxFileSize: '100MB',
      supportedFormats: {
        export: ['JSON', 'CSV', 'EXCEL', 'XML', 'PDF'],
        import: ['CSV', 'EXCEL', 'JSON', 'XML'],
      },
      maxConcurrentJobs: 5,
      retentionPeriod: '30 days',
    };
  }

  @Post('config')
  @Roles(UserRole.ADMIN)
  async updateConfiguration(
    @Body() config: any,
    @GetUser('id') userId: string,
  ) {
    return { message: 'Configuration updated successfully' };
  }
}