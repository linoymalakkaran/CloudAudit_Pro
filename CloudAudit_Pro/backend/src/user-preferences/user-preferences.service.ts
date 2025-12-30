import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SetPreferenceDto } from './dto/set-preference.dto';

@Injectable()
export class UserPreferencesService {
  constructor(private readonly db: DatabaseService) {}

  /**
   * Get all preferences for a user
   */
  async findAll(userId: string, category?: string) {
    const where: any = { userId };

    if (category) {
      where.category = category;
    }

    return this.db.userPreference.findMany({
      where,
      orderBy: {
        preferenceKey: 'asc',
      },
    });
  }

  /**
   * Get a specific preference by key
   */
  async findOne(userId: string, preferenceKey: string) {
    const preference = await this.db.userPreference.findUnique({
      where: {
        userId_preferenceKey: {
          userId,
          preferenceKey,
        },
      },
    });

    if (!preference) {
      throw new NotFoundException(
        `Preference '${preferenceKey}' not found for user`,
      );
    }

    return preference;
  }

  /**
   * Set a user preference (create or update)
   */
  async set(userId: string, dto: SetPreferenceDto) {
    const preferenceKey = dto.preferenceKey || dto.key;
    const preferenceValue = dto.preferenceValue !== undefined ? dto.preferenceValue : dto.value;
    
    return this.db.userPreference.upsert({
      where: {
        userId_preferenceKey: {
          userId,
          preferenceKey,
        },
      },
      update: {
        preferenceValue,
        category: dto.category,
        updatedAt: new Date(),
      },
      create: {
        userId,
        preferenceKey,
        preferenceValue,
        category: dto.category,
      },
    });
  }

  /**
   * Update a user preference
   */
  async update(userId: string, preferenceKey: string, dto: Partial<SetPreferenceDto>) {
    await this.findOne(userId, preferenceKey);

    return this.db.userPreference.update({
      where: {
        userId_preferenceKey: {
          userId,
          preferenceKey,
        },
      },
      data: {
        ...(dto.preferenceValue !== undefined && {
          preferenceValue: dto.preferenceValue,
        }),
        ...(dto.category !== undefined && { category: dto.category }),
        updatedAt: new Date(),
      },
    });
  }

  /**
   * Delete a user preference
   */
  async remove(userId: string, preferenceKey: string) {
    await this.findOne(userId, preferenceKey);

    return this.db.userPreference.delete({
      where: {
        userId_preferenceKey: {
          userId,
          preferenceKey,
        },
      },
    });
  }

  /**
   * Delete all preferences for a user
   */
  async removeAll(userId: string) {
    return this.db.userPreference.deleteMany({
      where: { userId },
    });
  }

  /**
   * Bulk set preferences
   */
  async bulkSet(userId: string, preferences: SetPreferenceDto[]) {
    const operations = preferences.map((pref) => {
      const preferenceKey = pref.preferenceKey || pref.key;
      const preferenceValue = pref.preferenceValue !== undefined ? pref.preferenceValue : pref.value;
      
      return this.db.userPreference.upsert({
        where: {
          userId_preferenceKey: {
            userId,
            preferenceKey,
          },
        },
        update: {
          preferenceValue,
          category: pref.category,
          updatedAt: new Date(),
        },
        create: {
          userId,
          preferenceKey,
          preferenceValue,
          category: pref.category,
        },
      });
    });

    return Promise.all(operations);
  }

  /**
   * Get preferences by category
   */
  async findByCategory(userId: string, category: string) {
    return this.db.userPreference.findMany({
      where: {
        userId,
        category,
      },
      orderBy: {
        preferenceKey: 'asc',
      },
    });
  }

  /**
   * Export all preferences
   */
  async export(userId: string) {
    const preferences = await this.findAll(userId);
    
    return preferences.reduce((acc, pref) => {
      acc[pref.preferenceKey] = {
        value: pref.preferenceValue,
        category: pref.category,
      };
      return acc;
    }, {} as Record<string, any>);
  }

  /**
   * Import preferences
   */
  async import(userId: string, preferences: Record<string, any>) {
    const operations = Object.entries(preferences).map(([key, data]) =>
      this.db.userPreference.upsert({
        where: {
          userId_preferenceKey: {
            userId,
            preferenceKey: key,
          },
        },
        update: {
          preferenceValue: data.value || data,
          category: data.category,
          updatedAt: new Date(),
        },
        create: {
          userId,
          preferenceKey: key,
          preferenceValue: data.value || data,
          category: data.category,
        },
      }),
    );

    return Promise.all(operations);
  }

  /**
   * Reset preferences to defaults
   */
  async resetToDefaults(userId: string) {
    // Delete all existing preferences
    await this.removeAll(userId);

    // Set default preferences
    const defaults: SetPreferenceDto[] = [
      {
        preferenceKey: 'theme',
        preferenceValue: 'light',
        category: 'appearance',
      },
      {
        preferenceKey: 'language',
        preferenceValue: 'en',
        category: 'general',
      },
      {
        preferenceKey: 'timezone',
        preferenceValue: 'UTC',
        category: 'general',
      },
      {
        preferenceKey: 'dateFormat',
        preferenceValue: 'MM/DD/YYYY',
        category: 'formatting',
      },
      {
        preferenceKey: 'notifications.email',
        preferenceValue: true,
        category: 'notifications',
      },
      {
        preferenceKey: 'notifications.inApp',
        preferenceValue: true,
        category: 'notifications',
      },
    ];

    return this.bulkSet(userId, defaults);
  }
}
