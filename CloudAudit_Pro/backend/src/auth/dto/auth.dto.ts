import { IsEmail, IsNotEmpty, IsString, MinLength, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum UserRole {
  ADMIN = 'ADMIN',
  MANAGER = 'MANAGER',
  SENIOR_AUDITOR = 'SENIOR_AUDITOR',
  AUDITOR = 'AUDITOR',
  INTERN = 'INTERN',
}

export class LoginDto {
  @ApiProperty({
    description: 'User email address',
    example: 'user@company.com',
  })
  @IsEmail({}, { message: 'Please provide a valid email address' })
  @IsNotEmpty({ message: 'Email is required' })
  email: string;

  @ApiProperty({
    description: 'User password',
    example: 'SecurePassword123',
    minLength: 8,
  })
  @IsString()
  @IsNotEmpty({ message: 'Password is required' })
  @MinLength(8, { message: 'Password must be at least 8 characters long' })
  password: string;

  @ApiProperty({
    description: 'Tenant subdomain (optional for initial login)',
    example: 'company-audit',
    required: false,
  })
  @IsOptional()
  @IsString()
  tenantSubdomain?: string;
}

export class RegisterDto {
  @ApiProperty({
    description: 'User email address',
    example: 'user@company.com',
  })
  @IsEmail({}, { message: 'Please provide a valid email address' })
  @IsNotEmpty({ message: 'Email is required' })
  email: string;

  @ApiProperty({
    description: 'User password',
    example: 'SecurePassword123',
    minLength: 8,
  })
  @IsString()
  @IsNotEmpty({ message: 'Password is required' })
  @MinLength(8, { message: 'Password must be at least 8 characters long' })
  password: string;

  @ApiProperty({
    description: 'User first name',
    example: 'John',
  })
  @IsString()
  @IsNotEmpty({ message: 'First name is required' })
  firstName: string;

  @ApiProperty({
    description: 'User last name',
    example: 'Doe',
  })
  @IsString()
  @IsNotEmpty({ message: 'Last name is required' })
  lastName: string;

  @ApiProperty({
    description: 'Company/Organization name',
    example: 'Acme Corporation',
  })
  @IsString()
  @IsNotEmpty({ message: 'Company name is required' })
  companyName: string;

  @ApiProperty({
    description: 'Tenant subdomain (will be auto-generated if not provided)',
    example: 'acme-corp',
    required: false,
  })
  @IsOptional()
  @IsString()
  tenantSubdomain?: string;

  @ApiProperty({
    description: 'Job title',
    example: 'Finance Manager',
    required: false,
  })
  @IsOptional()
  @IsString()
  jobTitle?: string;

  @ApiProperty({
    description: 'Department',
    example: 'Finance',
    required: false,
  })
  @IsOptional()
  @IsString()
  department?: string;
}

export class RefreshTokenDto {
  @ApiProperty({
    description: 'Refresh token',
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  })
  @IsString()
  @IsNotEmpty({ message: 'Refresh token is required' })
  refreshToken: string;
}