import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';

@ApiTags('System')
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @ApiOperation({ summary: 'API status check' })
  @ApiResponse({ status: 200, description: 'API is running' })
  getHealthCheck() {
    return this.appService.getHealthCheck();
  }

  @Get('health')
  @ApiOperation({ summary: 'Detailed health check' })
  @ApiResponse({ status: 200, description: 'Detailed system health information' })
  getDetailedHealth() {
    return {
      status: 'OK',
      service: 'CloudAudit Pro API',
      version: '1.0.0',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development',
      uptime: process.uptime(),
      memory: {
        used: Math.round(process.memoryUsage().heapUsed / 1024 / 1024),
        total: Math.round(process.memoryUsage().heapTotal / 1024 / 1024),
      },
      features: {
        swagger: process.env.ENABLE_SWAGGER === 'true',
        authentication: true,
        multiTenant: true,
      },
    };
  }
}