import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { UserService, CreateUserDto, UpdateUserDto } from './user.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('users')
@Controller('users')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @ApiOperation({ summary: 'Create new user' })
  @ApiResponse({ status: 201, description: 'User created successfully' })
  @ApiResponse({ status: 400, description: 'Bad request' })
  @ApiResponse({ status: 403, description: 'Forbidden - Admin role required' })
  async createUser(@Body() createUserDto: CreateUserDto, @Request() req: any) {
    return this.userService.createUser({
      ...createUserDto,
      tenantId: req.user.tenantId,
    });
  }

  @Get()
  @ApiOperation({ summary: 'Get all users for tenant' })
  @ApiResponse({ status: 200, description: 'Users retrieved successfully' })
  async getUsers(@Request() req: any) {
    return this.userService.getUsersByTenant(req.user.tenantId);
  }

  @Get('me')
  @ApiOperation({ summary: 'Get current user profile' })
  @ApiResponse({ status: 200, description: 'User profile retrieved successfully' })
  async getCurrentUser(@Request() req: any) {
    return this.userService.getUserById(req.user.id, req.user.tenantId);
  }

  @Get('stats')
  @ApiOperation({ summary: 'Get user statistics' })
  @ApiResponse({ status: 200, description: 'User statistics retrieved' })
  async getUserStats(@Request() req: any) {
    return this.userService.getUserStats(req.user.tenantId);
  }

  @Get('search')
  @ApiOperation({ summary: 'Search users' })
  @ApiResponse({ status: 200, description: 'Search results retrieved' })
  async searchUsers(@Request() req: any, @Body('query') query: string) {
    return this.userService.searchUsers(req.user.tenantId, query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get user by ID' })
  @ApiResponse({ status: 200, description: 'User retrieved successfully' })
  @ApiResponse({ status: 404, description: 'User not found' })
  async getUserById(@Param('id') id: string, @Request() req: any) {
    return this.userService.getUserById(id, req.user.tenantId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update user' })
  @ApiResponse({ status: 200, description: 'User updated successfully' })
  @ApiResponse({ status: 403, description: 'Forbidden - Insufficient permissions' })
  @ApiResponse({ status: 404, description: 'User not found' })
  async updateUser(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
    @Request() req: any,
  ) {
    return this.userService.updateUser(
      id,
      req.user.tenantId,
      updateUserDto,
      req.user.id,
    );
  }

  @Patch(':id/password')
  @ApiOperation({ summary: 'Update user password' })
  @ApiResponse({ status: 200, description: 'Password updated successfully' })
  @ApiResponse({ status: 403, description: 'Current password is incorrect' })
  async updatePassword(
    @Param('id') id: string,
    @Body() passwordDto: { currentPassword: string; newPassword: string },
    @Request() req: any,
  ) {
    await this.userService.updateUserPassword(
      id,
      req.user.tenantId,
      passwordDto.currentPassword,
      passwordDto.newPassword,
    );
    return { message: 'Password updated successfully' };
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Deactivate user' })
  @ApiResponse({ status: 200, description: 'User deactivated successfully' })
  @ApiResponse({ status: 403, description: 'Forbidden - Admin role required' })
  async deactivateUser(@Param('id') id: string, @Request() req: any) {
    return this.userService.deactivateUser(id, req.user.tenantId, req.user.id);
  }
}