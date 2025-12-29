import { Injectable, NotFoundException, BadRequestException, ConflictException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateExchangeRateDto, UpdateExchangeRateDto } from './dto';
import { Decimal } from '@prisma/client/runtime/library';

@Injectable()
export class ExchangeRateService {
  constructor(private prisma: DatabaseService) {}

  async create(createExchangeRateDto: CreateExchangeRateDto, userId: string) {
    const { baseCurrencyId, targetCurrencyId, effectiveDate, rate, expiryDate } = createExchangeRateDto;

    // Validate currencies exist
    const baseCurrency = await this.prisma.currency.findUnique({ where: { id: baseCurrencyId } });
    if (!baseCurrency) {
      throw new NotFoundException(`Base currency with ID '${baseCurrencyId}' not found`);
    }

    const targetCurrency = await this.prisma.currency.findUnique({ where: { id: targetCurrencyId } });
    if (!targetCurrency) {
      throw new NotFoundException(`Target currency with ID '${targetCurrencyId}' not found`);
    }

    if (baseCurrencyId === targetCurrencyId) {
      throw new BadRequestException('Base and target currencies must be different');
    }

    // Check for duplicate rate on same date
    const existing = await this.prisma.exchangeRate.findUnique({
      where: {
        baseCurrencyId_targetCurrencyId_effectiveDate: {
          baseCurrencyId,
          targetCurrencyId,
          effectiveDate: new Date(effectiveDate),
        },
      },
    });

    if (existing) {
      throw new ConflictException(
        `Exchange rate for ${baseCurrency.code}/${targetCurrency.code} already exists for date ${effectiveDate}`
      );
    }

    return this.prisma.exchangeRate.create({
      data: {
        baseCurrencyId,
        targetCurrencyId,
        rate: new Decimal(rate),
        effectiveDate: new Date(effectiveDate),
        expiryDate: expiryDate ? new Date(expiryDate) : null,
        source: createExchangeRateDto.source,
        isActive: createExchangeRateDto.isActive ?? true,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        baseCurrency: { select: { code: true, name: true, symbol: true } },
        targetCurrency: { select: { code: true, name: true, symbol: true } },
      },
    });
  }

  async findAll(baseCurrencyId?: string, targetCurrencyId?: string, isActive?: boolean) {
    const where: any = {};
    
    if (baseCurrencyId) where.baseCurrencyId = baseCurrencyId;
    if (targetCurrencyId) where.targetCurrencyId = targetCurrencyId;
    if (isActive !== undefined) where.isActive = isActive;

    return this.prisma.exchangeRate.findMany({
      where,
      orderBy: { effectiveDate: 'desc' },
      include: {
        baseCurrency: { select: { code: true, name: true, symbol: true } },
        targetCurrency: { select: { code: true, name: true, symbol: true } },
      },
    });
  }

  async findOne(id: string) {
    const rate = await this.prisma.exchangeRate.findUnique({
      where: { id },
      include: {
        baseCurrency: true,
        targetCurrency: true,
      },
    });

    if (!rate) {
      throw new NotFoundException(`Exchange rate with ID '${id}' not found`);
    }

    return rate;
  }

  async getLatestRate(fromCurrencyId: string, toCurrencyId: string, asOfDate?: Date) {
    const effectiveDate = asOfDate || new Date();

    const rate = await this.prisma.exchangeRate.findFirst({
      where: {
        baseCurrencyId: fromCurrencyId,
        targetCurrencyId: toCurrencyId,
        effectiveDate: { lte: effectiveDate },
        OR: [
          { expiryDate: null },
          { expiryDate: { gte: effectiveDate } },
        ],
        isActive: true,
      },
      orderBy: { effectiveDate: 'desc' },
      include: {
        baseCurrency: { select: { code: true, name: true, symbol: true } },
        targetCurrency: { select: { code: true, name: true, symbol: true } },
      },
    });

    if (!rate) {
      const baseCurrency = await this.prisma.currency.findUnique({ where: { id: fromCurrencyId } });
      const targetCurrency = await this.prisma.currency.findUnique({ where: { id: toCurrencyId } });
      
      throw new NotFoundException(
        `No exchange rate found for ${baseCurrency?.code || fromCurrencyId}/${targetCurrency?.code || toCurrencyId}`
      );
    }

    return rate;
  }

  async convertAmount(
    amount: number,
    fromCurrencyId: string,
    toCurrencyId: string,
    asOfDate?: Date
  ) {
    if (fromCurrencyId === toCurrencyId) {
      return { amount, convertedAmount: amount, rate: 1, fromCurrency: null, toCurrency: null };
    }

    const rateRecord = await this.getLatestRate(fromCurrencyId, toCurrencyId, asOfDate);
    const convertedAmount = amount * Number(rateRecord.rate);

    return {
      amount,
      convertedAmount,
      rate: Number(rateRecord.rate),
      fromCurrency: rateRecord.baseCurrency,
      toCurrency: rateRecord.targetCurrency,
      effectiveDate: rateRecord.effectiveDate,
    };
  }

  async update(id: string, updateExchangeRateDto: UpdateExchangeRateDto, userId: string) {
    const rate = await this.prisma.exchangeRate.findUnique({ where: { id } });
    if (!rate) {
      throw new NotFoundException(`Exchange rate with ID '${id}' not found`);
    }

    // Check if updating would create a duplicate
    if (updateExchangeRateDto.baseCurrencyId || updateExchangeRateDto.targetCurrencyId || updateExchangeRateDto.effectiveDate) {
      const baseCurrencyId = updateExchangeRateDto.baseCurrencyId || rate.baseCurrencyId;
      const targetCurrencyId = updateExchangeRateDto.targetCurrencyId || rate.targetCurrencyId;
      const effectiveDate = updateExchangeRateDto.effectiveDate 
        ? new Date(updateExchangeRateDto.effectiveDate) 
        : rate.effectiveDate;

      const existing = await this.prisma.exchangeRate.findUnique({
        where: {
          baseCurrencyId_targetCurrencyId_effectiveDate: {
            baseCurrencyId,
            targetCurrencyId,
            effectiveDate,
          },
        },
      });

      if (existing && existing.id !== id) {
        throw new ConflictException('Exchange rate with these parameters already exists');
      }
    }

    return this.prisma.exchangeRate.update({
      where: { id },
      data: {
        ...updateExchangeRateDto,
        rate: updateExchangeRateDto.rate ? new Decimal(updateExchangeRateDto.rate) : undefined,
        effectiveDate: updateExchangeRateDto.effectiveDate ? new Date(updateExchangeRateDto.effectiveDate) : undefined,
        expiryDate: updateExchangeRateDto.expiryDate ? new Date(updateExchangeRateDto.expiryDate) : undefined,
        updatedBy: userId,
      },
      include: {
        baseCurrency: { select: { code: true, name: true, symbol: true } },
        targetCurrency: { select: { code: true, name: true, symbol: true } },
      },
    });
  }

  async remove(id: string) {
    const rate = await this.prisma.exchangeRate.findUnique({ where: { id } });
    if (!rate) {
      throw new NotFoundException(`Exchange rate with ID '${id}' not found`);
    }

    return this.prisma.exchangeRate.delete({ where: { id } });
  }
}
