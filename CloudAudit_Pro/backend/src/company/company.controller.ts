import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CompanyService, CreateCompanyDto, UpdateCompanyDto } from './company.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('companies')
@Controller('companies')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class CompanyController {
  constructor(private readonly companyService: CompanyService) {}

  @Post()
  @ApiOperation({ summary: 'Create new company' })
  @ApiResponse({ status: 201, description: 'Company created successfully' })
  @ApiResponse({ status: 400, description: 'Bad request' })
  async createCompany(@Body() createCompanyDto: CreateCompanyDto, @Request() req: any) {
    return this.companyService.createCompany({
      ...createCompanyDto,
      tenantId: req.user.tenantId,
    });
  }

  @Get()
  @ApiOperation({ summary: 'Get all companies for tenant' })
  @ApiResponse({ status: 200, description: 'Companies retrieved successfully' })
  async getCompanies(@Request() req: any) {
    return this.companyService.getCompaniesByTenant(req.user.tenantId);
  }

  @Get('stats')
  @ApiOperation({ summary: 'Get company statistics' })
  @ApiResponse({ status: 200, description: 'Company statistics retrieved' })
  async getCompanyStats(@Request() req: any) {
    return this.companyService.getCompanyStats(req.user.tenantId);
  }

  @Get('search')
  @ApiOperation({ summary: 'Search companies' })
  @ApiResponse({ status: 200, description: 'Search results retrieved' })
  async searchCompanies(@Request() req: any, @Body('query') query: string) {
    return this.companyService.searchCompanies(req.user.tenantId, query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get company by ID' })
  @ApiResponse({ status: 200, description: 'Company retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Company not found' })
  async getCompanyById(@Param('id') id: string, @Request() req: any) {
    return this.companyService.getCompanyById(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update company' })
  @ApiResponse({ status: 200, description: 'Company updated successfully' })
  @ApiResponse({ status: 404, description: 'Company not found' })
  async updateCompany(
    @Param('id') id: string,
    @Body() updateCompanyDto: UpdateCompanyDto,
    @Request() req: any,
  ) {
    return this.companyService.updateCompany(id, req.user.tenantId, updateCompanyDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete company' })
  @ApiResponse({ status: 200, description: 'Company deleted successfully' })
  @ApiResponse({ status: 403, description: 'Cannot delete company with active periods' })
  async deleteCompany(@Param('id') id: string, @Request() req: any) {
    return this.companyService.deleteCompany(id, req.user.tenantId);
  }
}