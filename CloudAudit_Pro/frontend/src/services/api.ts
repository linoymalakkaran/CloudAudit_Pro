import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

// Create axios instance with default config
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
});

// Add auth token to requests
apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor for error handling
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    throw error;
  }
);

// User Management API
export interface InviteUserDto {
  firstName: string;
  lastName: string;
  email: string;
  role: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
  jobTitle?: string;
  department?: string;
  phoneNumber?: string;
  requirePasswordChange?: boolean;
  customMessage?: string;
}

export interface UpdateUserDto {
  firstName?: string;
  lastName?: string;
  email?: string;
  role?: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
  jobTitle?: string;
  department?: string;
  phoneNumber?: string;
  status?: 'ACTIVE' | 'INACTIVE';
}

export interface ApproveUserDto {
  comments?: string;
}

export interface ResetPasswordDto {
  requirePasswordChange?: boolean;
}

export interface BulkUserActionDto {
  action: 'DELETE' | 'ACTIVATE' | 'DEACTIVATE' | 'RESET_PASSWORD';
  userIds: string[];
  comments?: string;
}

export interface TenantUser {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  status: 'INVITED' | 'ACTIVE' | 'INACTIVE' | 'APPROVAL_PENDING';
  invitedAt?: string;
  lastLoginAt?: string;
  jobTitle?: string;
  department?: string;
  phoneNumber?: string;
  isDeleted: boolean;
  requirePasswordChange: boolean;
  invitedBy?: string;
  tenantId: string;
}

export interface UserStats {
  total: number;
  active: number;
  inactive: number;
  pending: number;
  roleDistribution: Record<string, number>;
  recentActivity: {
    newInvitationsThisWeek: number;
  };
}

export interface ApprovalRequest {
  id: string;
  type: 'USER_APPROVAL' | 'USER_INVITATION';
  requestData: any;
  status: 'PENDING' | 'APPROVED' | 'REJECTED';
  submittedAt: string;
  submittedBy: string;
  reviewedAt?: string;
  reviewedBy?: string;
  reviewComments?: string;
  tenantUser?: TenantUser;
}

export const userManagementApi = {
  // Get all users in the tenant
  getUsers: async (): Promise<TenantUser[]> => {
    const response = await apiClient.get('/user-management/users');
    return response.data;
  },

  // Invite a new user
  inviteUser: async (userData: InviteUserDto): Promise<TenantUser> => {
    const response = await apiClient.post('/user-management/invite', userData);
    return response.data;
  },

  // Invite multiple users
  inviteMultipleUsers: async (users: InviteUserDto[]): Promise<TenantUser[]> => {
    const response = await apiClient.post('/user-management/invite-batch', { users });
    return response.data;
  },

  // Update user
  updateUser: async (userId: string, userData: UpdateUserDto): Promise<TenantUser> => {
    const response = await apiClient.put(`/user-management/users/${userId}`, userData);
    return response.data;
  },

  // Delete user
  deleteUser: async (userId: string): Promise<void> => {
    await apiClient.delete(`/user-management/users/${userId}`);
  },

  // Approve user
  approveUser: async (userId: string, approvalData: ApproveUserDto): Promise<TenantUser> => {
    const response = await apiClient.post(`/user-management/users/${userId}/approve`, approvalData);
    return response.data;
  },

  // Reset user password
  resetPassword: async (userId: string, resetData: ResetPasswordDto): Promise<void> => {
    await apiClient.post(`/user-management/users/${userId}/reset-password`, resetData);
  },

  // Bulk user actions
  bulkAction: async (actionData: BulkUserActionDto): Promise<void> => {
    await apiClient.post('/user-management/bulk-action', actionData);
  },

  // Get user statistics
  getUserStats: async (): Promise<UserStats> => {
    const response = await apiClient.get('/user-management/stats');
    return response.data;
  },

  // Get user by ID
  getUser: async (userId: string): Promise<TenantUser> => {
    const response = await apiClient.get(`/user-management/users/${userId}`);
    return response.data;
  },
};

// Super Admin API (for approval requests)
export const superAdminApi = {
  // Get all approval requests
  getApprovalRequests: async (): Promise<ApprovalRequest[]> => {
    const response = await apiClient.get('/super-admin/approval-requests');
    return response.data;
  },

  // Approve a request
  approveRequest: async (requestId: string, comments?: string): Promise<ApprovalRequest> => {
    const response = await apiClient.post(`/super-admin/approval-requests/${requestId}/approve`, {
      comments,
    });
    return response.data;
  },

  // Reject a request
  rejectRequest: async (requestId: string, comments: string): Promise<ApprovalRequest> => {
    const response = await apiClient.post(`/super-admin/approval-requests/${requestId}/reject`, {
      comments,
    });
    return response.data;
  },
};

// Auth API
export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterData {
  companyName: string;
  adminFirstName: string;
  adminLastName: string;
  adminEmail: string;
  password: string;
  industry?: string;
  companySize?: string;
}

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  tenantId: string;
  status: string;
}

export interface AuthResponse {
  access_token: string;
  user: User;
}

export const authApi = {
  // Login
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    const response = await apiClient.post('/auth/login', credentials);
    return response.data;
  },

  // Register
  register: async (registerData: RegisterData): Promise<AuthResponse> => {
    const response = await apiClient.post('/auth/register', registerData);
    return response.data;
  },

  // Get current user
  getCurrentUser: async (): Promise<User> => {
    const response = await apiClient.get('/auth/profile');
    return response.data;
  },

  // Logout
  logout: async (): Promise<void> => {
    await apiClient.post('/auth/logout');
    localStorage.removeItem('token');
  },
};

export default apiClient;