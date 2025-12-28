import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateBankDto } from './dto/create-bank.dto';
import { UpdateBankDto } from './dto/update-bank.dto';
import { CreateBankAccountDto } from './dto/create-bank-account.dto';
import { UpdateBankAccountDto } from './dto/update-bank-account.dto';

@Injectable()
export class BankService {
  constructor(private db: DatabaseService) {}

  // Bank methods
  async createBank(data: CreateBankDto, userId: string) {
    const existing = await this.db.bank.findFirst({
      where: { name: data.name },
    });

    if (existing) {
      throw new BadRequestException(`Bank with name "${data.name}" already exists`);
    }

    return this.db.bank.create({
      data: {
        ...data,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async findAllBanks(isActive?: boolean) {
    return this.db.bank.findMany({
      where: isActive !== undefined ? { isActive } : undefined,
      include: {
        country: true,
        currency: true,
      },
      orderBy: { name: 'asc' },
    });
  }

  async findBankById(id: string) {
    const bank = await this.db.bank.findUnique({
      where: { id },
      include: {
        country: true,
        currency: true,
        accounts: {
          include: {
            company: { select: { name: true } },
          },
        },
      },
    });

    if (!bank) {
      throw new NotFoundException(`Bank with ID ${id} not found`);
    }

    return bank;
  }

  async updateBank(id: string, data: UpdateBankDto, userId: string) {
    await this.findBankById(id);

    if (data.name) {
      const existing = await this.db.bank.findFirst({
        where: {
          name: data.name,
          id: { not: id },
        },
      });

      if (existing) {
        throw new BadRequestException(`Bank with name "${data.name}" already exists`);
      }
    }

    return this.db.bank.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
    });
  }

  async deleteBank(id: string) {
    await this.findBankById(id);

    const accountCount = await this.db.bankAccount.count({
      where: { bankId: id },
    });

    if (accountCount > 0) {
      throw new BadRequestException(
        `Cannot delete bank: ${accountCount} accounts are associated with this bank`,
      );
    }

    return this.db.bank.delete({
      where: { id },
    });
  }

  // Bank Account methods
  async createBankAccount(data: CreateBankAccountDto, userId: string) {
    const [company, bank] = await Promise.all([
      this.db.company.findUnique({ where: { id: data.companyId } }),
      this.db.bank.findUnique({ where: { id: data.bankId } }),
    ]);

    if (!company) {
      throw new NotFoundException(`Company with ID ${data.companyId} not found`);
    }
    if (!bank) {
      throw new NotFoundException(`Bank with ID ${data.bankId} not found`);
    }

    const existing = await this.db.bankAccount.findFirst({
      where: {
        companyId: data.companyId,
        accountNumber: data.accountNumber,
      },
    });

    if (existing) {
      throw new BadRequestException(
        `Account number "${data.accountNumber}" already exists for this company`,
      );
    }

    return this.db.bankAccount.create({
      data: {
        ...data,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        bank: true,
        company: { select: { name: true } },
      },
    });
  }

  async findAllBankAccounts(companyId?: string, bankId?: string) {
    return this.db.bankAccount.findMany({
      where: {
        ...(companyId && { companyId }),
        ...(bankId && { bankId }),
      },
      include: {
        bank: true,
        company: { select: { name: true } },
      },
      orderBy: { accountName: 'asc' },
    });
  }

  async findBankAccountById(id: string) {
    const account = await this.db.bankAccount.findUnique({
      where: { id },
      include: {
        bank: true,
        company: { select: { name: true } },
      },
    });

    if (!account) {
      throw new NotFoundException(`Bank account with ID ${id} not found`);
    }

    return account;
  }

  async updateBankAccount(id: string, data: UpdateBankAccountDto, userId: string) {
    await this.findBankAccountById(id);

    if (data.accountNumber && data.companyId) {
      const existing = await this.db.bankAccount.findFirst({
        where: {
          companyId: data.companyId,
          accountNumber: data.accountNumber,
          id: { not: id },
        },
      });

      if (existing) {
        throw new BadRequestException(
          `Account number "${data.accountNumber}" already exists for this company`,
        );
      }
    }

    return this.db.bankAccount.update({
      where: { id },
      data: {
        ...data,
        updatedBy: userId,
      },
      include: {
        bank: true,
        company: { select: { name: true } },
      },
    });
  }

  async deleteBankAccount(id: string) {
    await this.findBankAccountById(id);

    return this.db.bankAccount.delete({
      where: { id },
    });
  }
}
