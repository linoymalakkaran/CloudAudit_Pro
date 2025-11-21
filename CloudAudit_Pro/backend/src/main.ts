import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';
import helmet from 'helmet';
import * as compression from 'compression';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get(ConfigService);

  // Security middleware
  app.use(helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        styleSrc: ["'self'", "'unsafe-inline'"],
        scriptSrc: ["'self'"],
        imgSrc: ["'self'", "data:", "https:"],
      },
    },
  }));

  // Compression middleware
  app.use(compression());

  // CORS configuration
  app.enableCors({
    origin: (origin, callback) => {
      // Allow tenant subdomains and development
      const allowedOrigins = [
        /^https:\/\/[\w-]+\.cloudauditpro\.com$/,
        'http://localhost:3001',
        'http://localhost:3000',
      ];

      if (!origin || allowedOrigins.some(pattern => 
        typeof pattern === 'string' ? pattern === origin : pattern.test(origin)
      )) {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    },
    credentials: true,
  });

  // Global validation pipe
  app.useGlobalPipes(new ValidationPipe({
    transform: true,
    whitelist: true,
    forbidNonWhitelisted: true,
  }));

  // API versioning
  app.setGlobalPrefix('api/v1');

  // Swagger documentation
  if (configService.get('NODE_ENV') !== 'production') {
    const config = new DocumentBuilder()
      .setTitle('CloudAudit Pro API')
      .setDescription('Multi-tenant audit management platform API')
      .setVersion('1.0')
      .addBearerAuth()
      .addTag('auth', 'Authentication')
      .addTag('tenants', 'Tenant Management')
      .addTag('companies', 'Company Management')
      .addTag('procedures', 'Audit Procedures')
      .addTag('documents', 'Document Management')
      .addTag('reports', 'Reports & Analytics')
      .build();

    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('api/docs', app, document);
  }

  const port = configService.get('PORT', 3000);
  await app.listen(port);
  
  console.log(`🚀 CloudAudit Pro API is running on: http://localhost:${port}`);
  console.log(`📚 API Documentation: http://localhost:${port}/api/docs`);
}

bootstrap();