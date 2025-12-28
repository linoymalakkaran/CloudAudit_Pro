import { Injectable, NotFoundException, ConflictException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCurrencyDto, UpdateCurrencyDto } from './dto';

@Injectable()
export class CurrencyService {
  constructor(private prisma: PrismaService) {}

  async create(createCurrencyDto: CreateCurrencyDto, userId: string) {
    // Check if currency code already exists
    const existing = await this.prisma.currency.findUnique({
      where: { code: createCurrencyDto.code.toUpperCase() },
    });

    if (existing) {
      throw new ConflictException(`Currency with code '${createCurrencyDto.code}' already exists`);
    }

    // If setting as base currency, remove base currency flag from others
    if (createCurrencyDto.isBaseCurrency) {
      await this.prisma.currency.updateMany({
        where: { isBaseCurrency: true },
        data: { isBaseCurrency: false },
      });
    }

    return this.prisma.currency.create({
      data: {
        ...createCurrencyDto,
        code: createCurrencyDto.code.toUpperCase(),
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async findAll(isActive?: boolean) {
    const where = isActive !== undefined ? { isActive } : {};
    
    return this.prisma.currency.findMany({
      where,
      orderBy: [
        { isBaseCurrency: 'desc' },
        { displayOrder: 'asc' },
        { code: 'asc' },
      ],
      include: {
        exchangeRatesFrom: {
          where: { isActive: true },
          take: 5,
          orderBy: { effectiveDate: 'desc' },
        },
        _count: {
          select: {
            companies: true,
            banks: true,
          },
        },
      },
    });
  }

  async findOne(id: string) {
    const currency = await this.prisma.currency.findUnique({
      where: { id },
      include: {
        exchangeRatesFrom: {
          where: { isActive: true },
          orderBy: { effectiveDate: 'desc' },
          include: {
            targetCurrency: {
              select: { code: true, name: true, symbol: true },
            },
          },
        },
        exchangeRatesTo: {
          where: { isActive: true },
          orderBy: { effectiveDate: 'desc' },
          include: {
            baseCurrency: {
              select: { code: true, name: true, symbol: true },
            },
          },
        },
        companies: {
          select: { id: true, name: true, code: true },
        },
        banks: {
          select: { id: true, name: true, code: true },
        },
      },
    });

    if (!currency) {
      throw new NotFoundException(`Currency with ID '${id}' not found`);
    }

    return currency;
  }

  async findByCode(code: string) {
    const currency = await this.prisma.currency.findUnique({
      where: { code: code.toUpperCase() },
    });

    if (!currency) {
      throw new NotFoundException(`Currency with code '${code}' not found`);
    }

    return currency;
  }

  async update(id: string, updateCurrencyDto: UpdateCurrencyDto, userId: string) {
    // Check if currency exists
    const currency = await this.prisma.currency.findUnique({ where: { id } });
    if (!currency) {
      throw new NotFoundException(`Currency with ID '${id}' not found`);
    }

    // Check if code is being changed and if new code already exists
    if (updateCurrencyDto.code && updateCurrencyDto.code !== currency.code) {
      const existing = await this.prisma.currency.findUnique({
        where: { code: updateCurrencyDto.code.toUpperCase() },
      });
      if (existing) {
        throw new ConflictException(`Currency with code '${updateCurrencyDto.code}' already exists`);
      }
    }

    // If setting as base currency, remove base currency flag from others
    if (updateCurrencyDto.isBaseCurrency) {
      await this.prisma.currency.updateMany({
        where: { 
          isBaseCurrency: true,
          NOT: { id },
        },
        data: { isBaseCurrency: false },
      });
    }

    return this.prisma.currency.update({
      where: { id },
      data: {
        ...updateCurrencyDto,
        code: updateCurrencyDto.code?.toUpperCase(),
        updatedBy: userId,
      },
    });
  }

  async updateStatus(id: string, isActive: boolean, userId: string) {
    const currency = await this.prisma.currency.findUnique({ where: { id } });
    if (!currency) {
      throw new NotFoundException(`Currency with ID '${id}' not found`);
    }

    // Prevent deactivating base currency
    if (!isActive && currency.isBaseCurrency) {
      throw new BadRequestException('Cannot deactivate the base currency');
    }

    return this.prisma.currency.update({
      where: { id },
      data: {
        isActive,
        updatedBy: userId,
      },
    });
  }

  async remove(id: string) {
    const currency = await this.prisma.currency.findUnique({
      where: { id },
      include: {
        _count: {
          select: {
            companies: true,
            banks: true,
            exchangeRatesFrom: true,
            exchangeRatesTo: true,
          },
        },
      },
    });

    if (!currency) {
      throw new NotFoundException(`Currency with ID '${id}' not found`);
    }

    // Prevent deleting base currency
    if (currency.isBaseCurrency) {
      throw new BadRequestException('Cannot delete the base currency');
    }

    // Check if currency is in use
    const usageCount = 
      currency._count.companies +
      currency._count.banks +
      currency._count.exchangeRatesFrom +
      currency._count.exchangeRatesTo;

    if (usageCount > 0) {
      throw new BadRequestException(
        `Cannot delete currency. It is referenced by ${usageCount} record(s). Consider deactivating instead.`
      );
    }

    return this.prisma.currency.delete({ where: { id } });
  }

  async getBaseCurrency() {
    const baseCurrency = await this.prisma.currency.findFirst({
      where: { isBaseCurrency: true, isActive: true },
    });

    if (!baseCurrency) {
      throw new NotFoundException('No base currency is configured');
    }

    return baseCurrency;
  }
}
