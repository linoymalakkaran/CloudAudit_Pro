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
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CountryService } from './country.service';
import { CreateCountryDto } from './dto/create-country.dto';
import { UpdateCountryDto } from './dto/update-country.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('country')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('country')
export class CountryController {
  constructor(private readonly countryService: CountryService) {}

  @Post()
  @ApiOperation({ summary: 'Create new country' })
  @ApiResponse({ status: 201, description: 'Country created successfully' })
  createCountry(@Body() createCountryDto: CreateCountryDto) {
    return this.countryService.createCountry(createCountryDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all countries' })
  @ApiResponse({ status: 200, description: 'List of countries' })
  findAllCountries(@Query('isActive') isActive?: string) {
    const isActiveFilter = isActive === 'true' ? true : isActive === 'false' ? false : undefined;
    return this.countryService.findAllCountries(isActiveFilter);
  }

  @Get('seed')
  @ApiOperation({ summary: 'Seed initial country data' })
  @ApiResponse({ status: 200, description: 'Countries seeded successfully' })
  seedCountries() {
    return this.countryService.seedCountries();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get country by ID' })
  @ApiResponse({ status: 200, description: 'Country details' })
  findCountryById(@Param('id') id: string) {
    return this.countryService.findCountryById(id);
  }

  @Get('code/:code')
  @ApiOperation({ summary: 'Get country by code' })
  @ApiResponse({ status: 200, description: 'Country details' })
  findCountryByCode(@Param('code') code: string) {
    return this.countryService.findCountryByCode(code);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update country' })
  @ApiResponse({ status: 200, description: 'Country updated successfully' })
  updateCountry(@Param('id') id: string, @Body() updateCountryDto: UpdateCountryDto) {
    return this.countryService.updateCountry(id, updateCountryDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete country' })
  @ApiResponse({ status: 200, description: 'Country deleted successfully' })
  deleteCountry(@Param('id') id: string) {
    return this.countryService.deleteCountry(id);
  }
}
