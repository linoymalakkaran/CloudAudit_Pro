import { 
  Controller, 
  Get, 
  Post, 
  Put, 
  Patch, 
  Delete, 
  Body, 
  Param, 
  Query, 
  UseGuards, 
  Request,
  HttpStatus,
  ForbiddenException 
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { UserManagementService } from './user-management.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { 
  InviteUserDto, 
  UpdateUserDto, 
  ApproveUserDto, 
  ResetPasswordDto, 
  BulkUserActionDto,
  UserRole 
} from './dto/user-management.dto';

@ApiTags('user-management')
@Controller('user-management')
@UseGuards(JwtAuthGuard, RolesGuard)
@ApiBearerAuth()
export class UserManagementController {
  constructor(private readonly userManagementService: UserManagementService) {}

  @Post('invite')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Invite new user to organization' })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'User invitation sent successfully' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'User already exists or invalid data' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Insufficient permissions' })
  async inviteUser(@Body() inviteUserDto: InviteUserDto, @Request() req: any) {
    return this.userManagementService.inviteUser(
      inviteUserDto,
      req.user.tenantId,
      req.user.id
    );
  }

  @Get('users')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Get all users in organization' })
  @ApiQuery({ name: 'includeInactive', required: false, type: Boolean })
  @ApiResponse({ status: HttpStatus.OK, description: 'Users retrieved successfully' })
  async getUsers(
    @Request() req: any,
    @Query('includeInactive') includeInactive: boolean = false
  ) {
    return this.userManagementService.getUsersByTenant(req.user.tenantId, includeInactive);
  }

  @Get('users/pending')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Get pending user approvals' })
  @ApiResponse({ status: HttpStatus.OK, description: 'Pending users retrieved successfully' })
  async getPendingUsers(@Request() req: any) {
    return this.userManagementService.getPendingUsers(req.user.tenantId);
  }

  @Get('users/stats')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Get user statistics for organization' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User statistics retrieved successfully' })
  async getUserStats(@Request() req: any) {
    return this.userManagementService.getUserStats(req.user.tenantId);
  }

  @Patch('users/:userId/approve')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Approve or reject user access request' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User approval processed successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'User not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Insufficient permissions' })
  async approveUser(
    @Param('userId') userId: string,
    @Body() approveUserDto: ApproveUserDto,
    @Request() req: any
  ) {
    return this.userManagementService.approveUser(
      userId,
      approveUserDto,
      req.user.tenantId,
      req.user.id
    );
  }

  @Put('users/:userId')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Update user information' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User updated successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'User not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Insufficient permissions' })
  async updateUser(
    @Param('userId') userId: string,
    @Body() updateUserDto: UpdateUserDto,
    @Request() req: any
  ) {
    // Additional permission check: managers can only update non-admin users
    if (req.user.role === UserRole.MANAGER && updateUserDto.role === UserRole.ADMIN) {
      throw new ForbiddenException('Managers cannot assign admin roles');
    }

    return this.userManagementService.updateUser(
      userId,
      updateUserDto,
      req.user.tenantId,
      req.user.id
    );
  }

  @Patch('users/:userId/reset-password')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Reset user password' })
  @ApiResponse({ status: HttpStatus.OK, description: 'Password reset successfully' })
  @ApiResponse({ status: HttpStatus.NOT_FOUND, description: 'User not found' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Insufficient permissions' })
  async resetPassword(
    @Param('userId') userId: string,
    @Body() resetPasswordDto: ResetPasswordDto,
    @Request() req: any
  ) {
    return this.userManagementService.resetUserPassword(
      { ...resetPasswordDto, userId },
      req.user.tenantId,
      req.user.id
    );
  }

  @Patch('users/:userId/activate')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Activate user account' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User activated successfully' })
  async activateUser(@Param('userId') userId: string, @Request() req: any) {
    return this.userManagementService.updateUser(
      userId,
      { isActive: true },
      req.user.tenantId,
      req.user.id
    );
  }

  @Patch('users/:userId/deactivate')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Deactivate user account' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User deactivated successfully' })
  async deactivateUser(@Param('userId') userId: string, @Request() req: any) {
    return this.userManagementService.updateUser(
      userId,
      { isActive: false },
      req.user.tenantId,
      req.user.id
    );
  }

  @Post('users/bulk-action')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Perform bulk actions on multiple users' })
  @ApiResponse({ status: HttpStatus.OK, description: 'Bulk action completed' })
  @ApiResponse({ status: HttpStatus.BAD_REQUEST, description: 'Invalid action or user IDs' })
  async bulkUserAction(@Body() bulkActionDto: BulkUserActionDto, @Request() req: any) {
    return this.userManagementService.bulkUserAction(
      bulkActionDto,
      req.user.tenantId,
      req.user.id
    );
  }

  @Get('roles')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Get available user roles' })
  @ApiResponse({ status: HttpStatus.OK, description: 'User roles retrieved successfully' })
  async getAvailableRoles(@Request() req: any) {
    const roles = Object.values(UserRole).map(role => ({
      value: role,
      label: role.replace('_', ' ').toLowerCase().replace(/\b\w/g, l => l.toUpperCase()),
      description: this.getRoleDescription(role),
    }));

    // Managers cannot assign admin roles
    const filteredRoles = req.user.role === UserRole.MANAGER 
      ? roles.filter(role => role.value !== UserRole.ADMIN)
      : roles;

    return {
      success: true,
      data: filteredRoles,
    };
  }

  @Get('permissions/:role')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Get role permissions' })
  @ApiResponse({ status: HttpStatus.OK, description: 'Role permissions retrieved successfully' })
  async getPermissionsForRole(@Param('role') role: UserRole) {
    const permissions = this.getRolePermissions(role);
    
    return {
      success: true,
      data: {
        role,
        permissions,
      },
    };
  }

  private getRoleDescription(role: UserRole): string {
    const descriptions = {
      [UserRole.ADMIN]: 'Full access to all features and user management',
      [UserRole.MANAGER]: 'Can manage team members and oversee audit processes',
      [UserRole.SENIOR_AUDITOR]: 'Experienced auditor with advanced permissions',
      [UserRole.AUDITOR]: 'Standard auditor with basic audit permissions',
      [UserRole.INTERN]: 'Limited access for training and learning purposes',
    };

    return descriptions[role] || 'No description available';
  }

  private getRolePermissions(role: UserRole): string[] {
    const permissionMap = {
      [UserRole.ADMIN]: [
        'manage_users',
        'manage_roles',
        'view_all_audits',
        'create_audits',
        'edit_audits',
        'delete_audits',
        'generate_reports',
        'manage_settings',
        'view_analytics',
      ],
      [UserRole.MANAGER]: [
        'invite_users',
        'view_team_audits',
        'create_audits',
        'edit_team_audits',
        'assign_tasks',
        'view_team_reports',
        'manage_team_settings',
      ],
      [UserRole.SENIOR_AUDITOR]: [
        'view_assigned_audits',
        'create_audits',
        'edit_assigned_audits',
        'mentor_juniors',
        'review_procedures',
        'generate_audit_reports',
      ],
      [UserRole.AUDITOR]: [
        'view_assigned_audits',
        'edit_assigned_procedures',
        'document_findings',
        'submit_procedures',
      ],
      [UserRole.INTERN]: [
        'view_assigned_procedures',
        'document_observations',
        'submit_for_review',
      ],
    };

    return permissionMap[role] || [];
  }
}