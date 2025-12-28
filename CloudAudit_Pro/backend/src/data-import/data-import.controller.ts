import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Query,
  UploadedFile,
  UseInterceptors,
  Res,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { DataImportService } from './data-import.service';
import { CreateDataImportDto } from './dto/create-data-import.dto';
import { UpdateDataImportDto } from './dto/update-data-import.dto';
import { ImportType } from '@prisma/client';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { Response } from 'express';
import * as fs from 'fs';

@ApiTags('data-import')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('data-import')
export class DataImportController {
  constructor(private readonly dataImportService: DataImportService) {}

  @Post()
  @ApiOperation({ summary: 'Upload file for import' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: { type: 'string', format: 'binary' },
        companyId: { type: 'string' },
        importType: { type: 'string', enum: Object.values(ImportType) },
      },
    },
  })
  @UseInterceptors(
    FileInterceptor('file', {
      storage: diskStorage({
        destination: './uploads/imports',
        filename: (req, file, cb) => {
          const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
          cb(null, `${file.fieldname}-${uniqueSuffix}${extname(file.originalname)}`);
        },
      }),
      fileFilter: (req, file, cb) => {
        if (!file.originalname.match(/\.(csv|xlsx|xls)$/)) {
          return cb(new Error('Only CSV and Excel files are allowed'), false);
        }
        cb(null, true);
      },
    }),
  )
  async uploadFile(
    @Req() req: any,
    @UploadedFile() file: Express.Multer.File,
    @Body('companyId') companyId: string,
    @Body('importType') importType: ImportType,
  ) {
    const createDto: CreateDataImportDto = {
      companyId,
      importType,
      fileName: file.originalname,
      filePath: file.path,
      fileSize: file.size,
    };

    return this.dataImportService.create(req.user.userId, req.user.tenantId, createDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all imports' })
  findAll(
    @Req() req: any,
    @Query('companyId') companyId?: string,
    @Query('importType') importType?: ImportType,
  ) {
    return this.dataImportService.findAll(req.user.tenantId, companyId, importType);
  }

  @Get('summary')
  @ApiOperation({ summary: 'Get import summary' })
  getSummary(@Req() req: any, @Query('companyId') companyId?: string) {
    return this.dataImportService.getSummary(req.user.tenantId, companyId);
  }

  @Get('templates/:type')
  @ApiOperation({ summary: 'Get import template' })
  getTemplate(@Param('type') type: ImportType) {
    return this.dataImportService.getTemplate(type);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get import by ID' })
  findOne(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.findOne(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update import' })
  update(@Param('id') id: string, @Req() req: any, @Body() updateDto: UpdateDataImportDto) {
    return this.dataImportService.update(id, req.user.tenantId, updateDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete import' })
  remove(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.remove(id, req.user.tenantId);
  }

  @Post(':id/validate')
  @ApiOperation({ summary: 'Validate import data' })
  validateImport(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.validateImport(id, req.user.tenantId);
  }

  @Post(':id/process')
  @ApiOperation({ summary: 'Process import' })
  processImport(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.processImport(id, req.user.tenantId, req.user.userId);
  }

  @Post(':id/rollback')
  @ApiOperation({ summary: 'Rollback import' })
  rollbackImport(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.rollbackImport(id, req.user.tenantId);
  }

  @Get(':id/errors')
  @ApiOperation({ summary: 'Get import errors' })
  getErrors(@Param('id') id: string, @Req() req: any) {
    return this.dataImportService.getErrors(id, req.user.tenantId);
  }

  @Get(':id/download-errors')
  @ApiOperation({ summary: 'Download errors CSV' })
  async downloadErrors(@Param('id') id: string, @Req() req: any, @Res() res: Response) {
    const filePath = await this.dataImportService.downloadErrorsReport(id, req.user.tenantId);
    
    res.download(filePath, `errors-${id}.csv`, (err) => {
      if (err) {
        console.error('Error downloading file:', err);
      }
      // Clean up temp file
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
    });
  }
}
