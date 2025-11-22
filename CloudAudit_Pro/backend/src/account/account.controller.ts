import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AccountService, CreateAccountDto, UpdateAccountDto } from './account.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('accounts')
@Controller('accounts')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class AccountController {
  constructor(private readonly accountService: AccountService) {}

  @Post()
  @ApiOperation({ summary: 'Create new account' })
  @ApiResponse({ status: 201, description: 'Account created successfully' })
  @ApiResponse({ status: 400, description: 'Bad request' })
  @ApiResponse({ status: 409, description: 'Account number already exists' })
  async createAccount(@Body() createAccountDto: CreateAccountDto, @Request() req: any) {
    return this.accountService.createAccount({
      ...createAccountDto,
      tenantId: req.user.tenantId,
    });
  }

  @Get('period/:periodId')
  @ApiOperation({ summary: 'Get all accounts for a period' })
  @ApiResponse({ status: 200, description: 'Accounts retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Period not found' })
  async getAccountsByPeriod(@Param('periodId') periodId: string, @Request() req: any) {
    return this.accountService.getAccountsByPeriod(periodId, req.user.tenantId);
  }

  @Get('chart/:periodId')
  @ApiOperation({ summary: 'Get chart of accounts for a period' })
  @ApiResponse({ status: 200, description: 'Chart of accounts retrieved successfully' })
  async getChartOfAccounts(@Param('periodId') periodId: string, @Request() req: any) {
    return this.accountService.getChartOfAccounts(periodId, req.user.tenantId);
  }

  @Get('trial-balance/:periodId')
  @ApiOperation({ summary: 'Get trial balance for a period' })
  @ApiResponse({ 
    status: 200, 
    description: 'Trial balance retrieved successfully',
    schema: {
      type: 'object',
      properties: {
        periodId: { type: 'string' },
        periodName: { type: 'string' },
        accounts: {
          type: 'array',
          items: {
            type: 'object',
            properties: {
              accountId: { type: 'string' },
              accountNumber: { type: 'string' },
              accountName: { type: 'string' },
              accountType: { type: 'string' },
              debitTotal: { type: 'number' },
              creditTotal: { type: 'number' },
              netBalance: { type: 'number' },
              closingBalance: { type: 'number' },
            },
          },
        },
        totals: {
          type: 'object',
          properties: {
            totalDebits: { type: 'number' },
            totalCredits: { type: 'number' },
            totalAssets: { type: 'number' },
            totalLiabilities: { type: 'number' },
            totalEquity: { type: 'number' },
            totalRevenue: { type: 'number' },
            totalExpenses: { type: 'number' },
          },
        },
        isBalanced: { type: 'boolean' },
      },
    },
  })
  async getTrialBalance(@Param('periodId') periodId: string, @Request() req: any) {
    return this.accountService.getTrialBalance(periodId, req.user.tenantId);
  }

  @Post('import/:periodId')
  @ApiOperation({ summary: 'Import chart of accounts for a period' })
  @ApiResponse({ status: 201, description: 'Accounts imported successfully' })
  @ApiResponse({ status: 400, description: 'Import validation failed' })
  async importChartOfAccounts(
    @Param('periodId') periodId: string,
    @Body() accountsData: { accounts: CreateAccountDto[] },
    @Request() req: any,
  ) {
    return this.accountService.importChartOfAccounts(
      periodId,
      req.user.tenantId,
      accountsData.accounts,
    );
  }

  @Get('stats')
  @ApiOperation({ summary: 'Get account statistics' })
  @ApiResponse({ status: 200, description: 'Account statistics retrieved' })
  async getAccountStats(@Request() req: any) {
    return this.accountService.getAccountStats(req.user.tenantId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get account by ID' })
  @ApiResponse({ status: 200, description: 'Account retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Account not found' })
  async getAccountById(@Param('id') id: string, @Request() req: any) {
    return this.accountService.getAccountById(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update account' })
  @ApiResponse({ status: 200, description: 'Account updated successfully' })
  @ApiResponse({ status: 404, description: 'Account not found' })
  @ApiResponse({ status: 409, description: 'Account number conflict' })
  async updateAccount(
    @Param('id') id: string,
    @Body() updateAccountDto: UpdateAccountDto,
    @Request() req: any,
  ) {
    return this.accountService.updateAccount(id, req.user.tenantId, updateAccountDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete account' })
  @ApiResponse({ status: 200, description: 'Account deleted successfully' })
  @ApiResponse({ status: 409, description: 'Cannot delete account with dependencies' })
  async deleteAccount(@Param('id') id: string, @Request() req: any) {
    return this.accountService.deleteAccount(id, req.user.tenantId);
  }
}