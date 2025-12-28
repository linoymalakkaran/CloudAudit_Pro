import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateCountryDto } from './dto/create-country.dto';
import { UpdateCountryDto } from './dto/update-country.dto';

@Injectable()
export class CountryService {
  constructor(private db: DatabaseService) {}

  async createCountry(data: CreateCountryDto) {
    const existing = await this.db.country.findUnique({
      where: { code: data.code.toUpperCase() },
    });

    if (existing) {
      throw new BadRequestException(`Country with code ${data.code} already exists`);
    }

    return this.db.country.create({
      data: {
        name: data.name,
        code: data.code.toUpperCase(),
        dialCode: data.dialCode,
        isActive: data.isActive ?? true,
      },
    });
  }

  async findAllCountries(isActive?: boolean) {
    return this.db.country.findMany({
      where: isActive !== undefined ? { isActive } : undefined,
      orderBy: { name: 'asc' },
    });
  }

  async findCountryById(id: string) {
    const country = await this.db.country.findUnique({
      where: { id },
      include: {
        companies: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });

    if (!country) {
      throw new NotFoundException(`Country with ID ${id} not found`);
    }

    return country;
  }

  async findCountryByCode(code: string) {
    const country = await this.db.country.findUnique({
      where: { code: code.toUpperCase() },
    });

    if (!country) {
      throw new NotFoundException(`Country with code ${code} not found`);
    }

    return country;
  }

  async updateCountry(id: string, data: UpdateCountryDto) {
    await this.findCountryById(id);

    if (data.code) {
      const existing = await this.db.country.findFirst({
        where: {
          code: data.code.toUpperCase(),
          id: { not: id },
        },
      });

      if (existing) {
        throw new BadRequestException(`Country with code ${data.code} already exists`);
      }
    }

    return this.db.country.update({
      where: { id },
      data: {
        ...data,
        code: data.code?.toUpperCase(),
      },
    });
  }

  async deleteCountry(id: string) {
    await this.findCountryById(id);

    const companiesCount = await this.db.company.count({
      where: { countryId: id },
    });

    if (companiesCount > 0) {
      throw new BadRequestException(
        `Cannot delete country: ${companiesCount} companies are using this country`,
      );
    }

    return this.db.country.delete({
      where: { id },
    });
  }

  async seedCountries() {
    const countries = [
      { name: 'United States', code: 'US', dialCode: '+1' },
      { name: 'United Kingdom', code: 'GB', dialCode: '+44' },
      { name: 'Canada', code: 'CA', dialCode: '+1' },
      { name: 'Australia', code: 'AU', dialCode: '+61' },
      { name: 'India', code: 'IN', dialCode: '+91' },
      { name: 'Germany', code: 'DE', dialCode: '+49' },
      { name: 'France', code: 'FR', dialCode: '+33' },
      { name: 'Japan', code: 'JP', dialCode: '+81' },
      { name: 'China', code: 'CN', dialCode: '+86' },
      { name: 'Singapore', code: 'SG', dialCode: '+65' },
    ];

    const created = [];
    for (const country of countries) {
      const existing = await this.db.country.findUnique({
        where: { code: country.code },
      });

      if (!existing) {
        const result = await this.db.country.create({ data: country });
        created.push(result);
      }
    }

    return { seeded: created.length, countries: created };
  }
}
