import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiResponse, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { UserPreferencesService } from './user-preferences.service';
import { SetPreferenceDto } from './dto/set-preference.dto';

@ApiTags('user-preferences')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('user-preferences')
export class UserPreferencesController {
  constructor(private readonly userPreferencesService: UserPreferencesService) {}

  @Get()
  @ApiOperation({ summary: 'Get all user preferences' })
  @ApiQuery({ name: 'category', required: false })
  @ApiResponse({ status: 200, description: 'Returns all preferences' })
  findAll(@Request() req, @Query('category') category?: string) {
    const userId = req.user.id;
    return this.userPreferencesService.findAll(userId, category);
  }

  @Post()
  @ApiOperation({ summary: 'Set a user preference' })
  @ApiResponse({ status: 201, description: 'Preference set successfully' })
  set(@Request() req, @Body() setPreferenceDto: SetPreferenceDto) {
    const userId = req.user.id;
    
    // Handle field aliases
    if (setPreferenceDto.key && !setPreferenceDto.preferenceKey) {
      setPreferenceDto.preferenceKey = setPreferenceDto.key;
    }
    if (setPreferenceDto.value !== undefined && setPreferenceDto.preferenceValue === undefined) {
      setPreferenceDto.preferenceValue = setPreferenceDto.value;
    }
    
    return this.userPreferencesService.set(userId, setPreferenceDto);
  }

  @Post('bulk')
  @ApiOperation({ summary: 'Bulk set preferences' })
  @ApiResponse({ status: 201, description: 'Preferences set successfully' })
  bulkSet(@Request() req, @Body() body: any) {
    const userId = req.user.id;
    // Handle both formats: array directly or {preferences: array}
    const preferences = Array.isArray(body) ? body : (body.preferences || []);
    return this.userPreferencesService.bulkSet(userId, preferences);
  }

  @Get('export')
  @ApiOperation({ summary: 'Export all preferences' })
  @ApiResponse({ status: 200, description: 'Returns exported preferences' })
  export(@Request() req) {
    const userId = req.user.id;
    return this.userPreferencesService.export(userId);
  }

  @Post('import')
  @ApiOperation({ summary: 'Import preferences' })
  @ApiResponse({ status: 201, description: 'Preferences imported successfully' })
  import(@Request() req, @Body() preferences: Record<string, any>) {
    const userId = req.user.id;
    return this.userPreferencesService.import(userId, preferences);
  }

  @Post('reset')
  @ApiOperation({ summary: 'Reset preferences to defaults' })
  @ApiResponse({ status: 200, description: 'Preferences reset successfully' })
  resetToDefaults(@Request() req) {
    const userId = req.user.id;
    return this.userPreferencesService.resetToDefaults(userId);
  }

  @Delete('all')
  @ApiOperation({ summary: 'Delete all preferences' })
  @ApiResponse({ status: 200, description: 'All preferences deleted' })
  removeAll(@Request() req) {
    const userId = req.user.id;
    return this.userPreferencesService.removeAll(userId);
  }

  @Get('category/:category')
  @ApiOperation({ summary: 'Get preferences by category' })
  @ApiResponse({ status: 200, description: 'Returns preferences for category' })
  findByCategory(@Request() req, @Param('category') category: string) {
    const userId = req.user.id;
    return this.userPreferencesService.findByCategory(userId, category);
  }

  @Get(':key')
  @ApiOperation({ summary: 'Get specific preference by key' })
  @ApiResponse({ status: 200, description: 'Returns the preference' })
  @ApiResponse({ status: 404, description: 'Preference not found' })
  findOne(@Request() req, @Param('key') key: string) {
    const userId = req.user.id;
    return this.userPreferencesService.findOne(userId, key);
  }

  @Patch(':key')
  @ApiOperation({ summary: 'Update a user preference' })
  @ApiResponse({ status: 200, description: 'Preference updated successfully' })
  update(
    @Request() req,
    @Param('key') key: string,
    @Body() updatePreferenceDto: Partial<SetPreferenceDto>,
  ) {
    const userId = req.user.id;
    
    // Handle field aliases
    if (updatePreferenceDto.value !== undefined && updatePreferenceDto.preferenceValue === undefined) {
      updatePreferenceDto.preferenceValue = updatePreferenceDto.value;
    }
    
    return this.userPreferencesService.update(userId, key, updatePreferenceDto);
  }

  @Delete(':key')
  @ApiOperation({ summary: 'Delete a user preference' })
  @ApiResponse({ status: 200, description: 'Preference deleted successfully' })
  remove(@Request() req, @Param('key') key: string) {
    const userId = req.user.id;
    return this.userPreferencesService.remove(userId, key);
  }
}
