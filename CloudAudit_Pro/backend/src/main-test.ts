import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  console.log('🚀 Starting CloudAudit Pro Backend...');
  
  try {
    const app = await NestFactory.create(AppModule);
    
    // Global validation pipe
    app.useGlobalPipes(new ValidationPipe({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
    }));

    // CORS configuration
    app.enableCors({
      origin: process.env.FRONTEND_URL || 'http://localhost:3000',
      credentials: true,
    });

    // Swagger Documentation (only in development)
    if (process.env.ENABLE_SWAGGER === 'true') {
      const config = new DocumentBuilder()
        .setTitle('CloudAudit Pro API')
        .setDescription('Comprehensive audit management platform API')
        .setVersion('1.0')
        .addBearerAuth()
        .addTag('Authentication', 'User authentication and authorization')
        .addTag('Tenants', 'Multi-tenant management')
        .addTag('Users', 'User management')
        .addTag('Companies', 'Company management')
        .addTag('Periods', 'Audit period management')
        .addTag('Accounts', 'Chart of accounts management')
        .build();

      const document = SwaggerModule.createDocument(app, config);
      SwaggerModule.setup('api', app, document, {
        swaggerOptions: {
          persistAuthorization: true,
        },
      });

      console.log('📚 Swagger documentation available at: http://localhost:3001/api');
    }

    const port = process.env.PORT || 3001;
    await app.listen(port);
    
    console.log('✅ CloudAudit Pro Backend started successfully!');
    console.log(`🌐 Server running on: http://localhost:${port}`);
    console.log('📋 Health check: http://localhost:' + port + '/health');
    
    if (process.env.ENABLE_SWAGGER === 'true') {
      console.log('📖 API Documentation: http://localhost:' + port + '/api');
    }
    
  } catch (error) {
    console.error('❌ Failed to start server:', error.message);
    console.error('📝 Error details:', error);
    process.exit(1);
  }
}

bootstrap();