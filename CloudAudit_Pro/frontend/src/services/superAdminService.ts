const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:3001';

class SuperAdminService {
  private getAuthHeaders() {
    const token = localStorage.getItem('superAdminToken');
    return {
      'Content-Type': 'application/json',
      ...(token && { Authorization: `Bearer ${token}` }),
    };
  }

  private async handleResponse(response: Response) {
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({ message: 'Network error' }));
      throw new Error(errorData.message || `HTTP ${response.status}`);
    }
    return response.json();
  }

  async login(credentials: { email: string; password: string }) {
    const response = await fetch(`${API_BASE_URL}/api/super-admin/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(credentials),
    });
    
    return this.handleResponse(response);
  }

  async getDashboard() {
    const response = await fetch(`${API_BASE_URL}/api/super-admin/dashboard`, {
      method: 'GET',
      headers: this.getAuthHeaders(),
    });
    
    return this.handleResponse(response);
  }

  async getAllTenants() {
    const response = await fetch(`${API_BASE_URL}/api/super-admin/tenants`, {
      method: 'GET',
      headers: this.getAuthHeaders(),
    });
    
    return this.handleResponse(response);
  }

  async getPendingTenants() {
    const response = await fetch(`${API_BASE_URL}/api/super-admin/tenants/pending`, {
      method: 'GET',
      headers: this.getAuthHeaders(),
    });
    
    return this.handleResponse(response);
  }

  async approveTenant(
    tenantId: string,
    approval: { status: 'APPROVED' | 'REJECTED'; comments?: string }
  ) {
    const response = await fetch(
      `${API_BASE_URL}/api/super-admin/tenants/${tenantId}/approve`,
      {
        method: 'PATCH',
        headers: this.getAuthHeaders(),
        body: JSON.stringify(approval),
      }
    );
    
    return this.handleResponse(response);
  }

  async getUserRequests(status?: 'pending' | 'all') {
    const queryParam = status ? `?status=${status}` : '';
    const response = await fetch(
      `${API_BASE_URL}/api/super-admin/user-requests${queryParam}`,
      {
        method: 'GET',
        headers: this.getAuthHeaders(),
      }
    );
    
    return this.handleResponse(response);
  }

  async processUserApproval(
    requestId: string,
    approval: { status: 'APPROVED' | 'REJECTED'; comments?: string }
  ) {
    const response = await fetch(
      `${API_BASE_URL}/api/super-admin/user-requests/${requestId}/approve`,
      {
        method: 'PATCH',
        headers: this.getAuthHeaders(),
        body: JSON.stringify(approval),
      }
    );
    
    return this.handleResponse(response);
  }

  async getSystemLogs(limit = 50) {
    const response = await fetch(
      `${API_BASE_URL}/api/super-admin/logs?limit=${limit}`,
      {
        method: 'GET',
        headers: this.getAuthHeaders(),
      }
    );
    
    return this.handleResponse(response);
  }

  async getProfile() {
    const response = await fetch(`${API_BASE_URL}/api/super-admin/profile`, {
      method: 'GET',
      headers: this.getAuthHeaders(),
    });
    
    return this.handleResponse(response);
  }

  isAuthenticated(): boolean {
    const token = localStorage.getItem('superAdminToken');
    const user = localStorage.getItem('superAdminUser');
    return !!(token && user);
  }

  logout(): void {
    localStorage.removeItem('superAdminToken');
    localStorage.removeItem('superAdminUser');
  }
}

export const superAdminService = new SuperAdminService();