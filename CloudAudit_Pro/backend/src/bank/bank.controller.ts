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
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { BankService } from './bank.service';
import { CreateBankDto } from './dto/create-bank.dto';
import { UpdateBankDto } from './dto/update-bank.dto';
import { CreateBankAccountDto } from './dto/create-bank-account.dto';
import { UpdateBankAccountDto } from './dto/update-bank-account.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('bank')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('bank')
export class BankController {
  constructor(private readonly bankService: BankService) {}

  // Bank endpoints
  @Post()
  @ApiOperation({ summary: 'Create new bank' })
  @ApiResponse({ status: 201, description: 'Bank created successfully' })
  createBank(@Body() createBankDto: CreateBankDto, @Request() req: any) {
    return this.bankService.createBank(createBankDto, req.user.userId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all banks' })
  @ApiResponse({ status: 200, description: 'List of banks' })
  findAllBanks(@Query('isActive') isActive?: string) {
    const isActiveFilter = isActive === 'true' ? true : isActive === 'false' ? false : undefined;
    return this.bankService.findAllBanks(isActiveFilter);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get bank by ID' })
  @ApiResponse({ status: 200, description: 'Bank details' })
  findBankById(@Param('id') id: string) {
    return this.bankService.findBankById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update bank' })
  @ApiResponse({ status: 200, description: 'Bank updated successfully' })
  updateBank(@Param('id') id: string, @Body() updateBankDto: UpdateBankDto, @Request() req: any) {
    return this.bankService.updateBank(id, updateBankDto, req.user.userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete bank' })
  @ApiResponse({ status: 200, description: 'Bank deleted successfully' })
  deleteBank(@Param('id') id: string) {
    return this.bankService.deleteBank(id);
  }

  // Bank Account endpoints
  @Post('account')
  @ApiOperation({ summary: 'Create new bank account' })
  @ApiResponse({ status: 201, description: 'Bank account created successfully' })
  createBankAccount(@Body() createBankAccountDto: CreateBankAccountDto, @Request() req: any) {
    return this.bankService.createBankAccount(createBankAccountDto, req.user.userId);
  }

  @Get('account')
  @ApiOperation({ summary: 'Get all bank accounts' })
  @ApiResponse({ status: 200, description: 'List of bank accounts' })
  findAllBankAccounts(@Query('companyId') companyId?: string, @Query('bankId') bankId?: string) {
    return this.bankService.findAllBankAccounts(companyId, bankId);
  }

  @Get('account/:id')
  @ApiOperation({ summary: 'Get bank account by ID' })
  @ApiResponse({ status: 200, description: 'Bank account details' })
  findBankAccountById(@Param('id') id: string) {
    return this.bankService.findBankAccountById(id);
  }

  @Patch('account/:id')
  @ApiOperation({ summary: 'Update bank account' })
  @ApiResponse({ status: 200, description: 'Bank account updated successfully' })
  updateBankAccount(
    @Param('id') id: string,
    @Body() updateBankAccountDto: UpdateBankAccountDto,
    @Request() req: any,
  ) {
    return this.bankService.updateBankAccount(id, updateBankAccountDto, req.user.userId);
  }

  @Delete('account/:id')
  @ApiOperation({ summary: 'Delete bank account' })
  @ApiResponse({ status: 200, description: 'Bank account deleted successfully' })
  deleteBankAccount(@Param('id') id: string) {
    return this.bankService.deleteBankAccount(id);
  }
}
