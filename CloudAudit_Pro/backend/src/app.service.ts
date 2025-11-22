import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHealthCheck() {
    return {
      status: 'OK',
      service: 'CloudAudit Pro API',
      message: 'Service is running properly',
      timestamp: new Date().toISOString(),
    };
  }
}