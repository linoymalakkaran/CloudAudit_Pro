# CloudAudit Pro - Authentication & User Management

## 🔐 Overview

CloudAudit Pro implements a comprehensive authentication and user management system designed for multi-tenant SaaS architecture. The system ensures secure access, proper user onboarding, and hierarchical role-based permissions across all tenant organizations.

---

## 🚀 Registration Flow

### Company Registration Process

The registration flow is designed to prevent abuse while ensuring legitimate companies can quickly get started.

#### Step 1: Initial Registration Request

**User Journey**:
1. User visits the registration page (`/register`)
2. Fills out company registration form
3. Creates the first admin account details
4. Submits for approval

**Required Information**:
```typescript
interface CompanyRegistrationData {
  // Company Information
  companyName: string;          // Legal company name
  displayName: string;          // Public display name
  businessType: 'AUDIT_FIRM' | 'INTERNAL_AUDIT' | 'ACCOUNTING_FIRM' | 'OTHER';
  registrationNumber?: string;  // Business registration number
  taxId?: string;               // Tax identification number
  
  // Contact Information
  email: string;                // Primary company email
  phone: string;                // Contact phone number
  website?: string;             // Company website
  
  // Address
  address: {
    street: string;
    city: string;
    state: string;
    postalCode: string;
    country: string;
  };
  
  // First Admin User
  adminUser: {
    firstName: string;
    lastName: string;
    email: string;
    password: string;           // Hashed before storage
    phone?: string;
  };
  
  // Additional
  numberOfUsers?: number;       // Expected number of users
  referralSource?: string;      // How they heard about CloudAudit Pro
}
```

**Validation Rules**:
- Company name must be unique across the platform
- Email must be unique and valid format
- Password must meet complexity requirements:
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - At least one special character
- All required fields must be filled

**Backend Processing**:
```typescript
// Registration endpoint
POST /api/auth/register

// Controller logic
async registerCompany(data: CompanyRegistrationData) {
  // 1. Validate input
  await validateRegistrationData(data);
  
  // 2. Check for duplicate company name/email
  const existing = await prisma.company.findFirst({
    where: {
      OR: [
        { name: data.companyName },
        { email: data.email }
      ]
    }
  });
  
  if (existing) {
    throw new Error('Company already exists');
  }
  
  // 3. Hash admin password
  const hashedPassword = await bcrypt.hash(data.adminUser.password, 12);
  
  // 4. Create company with PENDING status
  const company = await prisma.company.create({
    data: {
      name: data.companyName,
      displayName: data.displayName,
      email: data.email,
      phone: data.phone,
      status: 'PENDING',
      businessType: data.businessType,
      address: data.address,
      // Database name will be generated after approval
      users: {
        create: {
          firstName: data.adminUser.firstName,
          lastName: data.adminUser.lastName,
          email: data.adminUser.email,
          password: hashedPassword,
          role: 'ADMIN',
          status: 'PENDING'
        }
      }
    },
    include: { users: true }
  });
  
  // 5. Send confirmation email
  await sendRegistrationConfirmationEmail(company);
  
  // 6. Notify super admins
  await notifySuperAdmins(company);
  
  return {
    success: true,
    message: 'Registration submitted. Awaiting approval.',
    companyId: company.id
  };
}
```

#### Step 2: Super Admin Review

**Super Admin Portal Access**:
- Super admins receive notification of new registration
- Access pending approvals at `/super-admin/approvals`
- View detailed company information
- Make approval decision

**Review Dashboard**:
```typescript
interface PendingApproval {
  id: string;
  companyName: string;
  displayName: string;
  email: string;
  businessType: string;
  submittedDate: Date;
  adminUser: {
    firstName: string;
    lastName: string;
    email: string;
  };
  // Verification status
  emailVerified: boolean;
  phoneVerified: boolean;
  documentsProvided: boolean;
}
```

**Approval Actions**:
1. **Approve**: 
   - Creates tenant database
   - Activates company and admin user
   - Sends welcome email with login credentials
   
2. **Reject**:
   - Records rejection reason
   - Sends notification to registrant
   - Marks company as REJECTED

3. **Request More Information**:
   - Sends email requesting additional details
   - Marks as UNDER_REVIEW

**Approval Process Backend**:
```typescript
// Approval endpoint
POST /api/super-admin/approvals/:companyId/approve

async approveCompany(companyId: string, superAdminId: string) {
  // 1. Get company details
  const company = await prisma.company.findUnique({
    where: { id: companyId },
    include: { users: true }
  });
  
  if (!company || company.status !== 'PENDING') {
    throw new Error('Invalid company or already processed');
  }
  
  // 2. Generate tenant database name
  const dbName = `cloudaudit_${generateSlug(company.name)}_${randomString(6)}`;
  
  // 3. Create tenant database
  await createTenantDatabase(dbName);
  
  // 4. Update company status
  const updatedCompany = await prisma.company.update({
    where: { id: companyId },
    data: {
      status: 'ACTIVE',
      databaseName: dbName,
      approvedAt: new Date(),
      approvedBy: superAdminId
    }
  });
  
  // 5. Activate admin user
  await prisma.user.updateMany({
    where: {
      companyId: companyId,
      role: 'ADMIN'
    },
    data: {
      status: 'ACTIVE'
    }
  });
  
  // 6. Initialize tenant database with schema
  await initializeTenantSchema(dbName);
  
  // 7. Create default data (chart of accounts templates, etc.)
  await seedDefaultData(dbName);
  
  // 8. Send welcome email
  await sendWelcomeEmail(company);
  
  return updatedCompany;
}
```

#### Step 3: Company Activation

**Automatic Setup**:
- Tenant database created
- Default chart of accounts loaded
- Standard templates installed
- Admin account activated
- Welcome email sent with login link

**Welcome Email Contents**:
- Company activation confirmation
- Admin login credentials
- Quick start guide link
- Getting started video
- Support contact information

---

## 🔑 Login System

### JWT Authentication

CloudAudit Pro uses JSON Web Tokens (JWT) for stateless authentication with refresh token rotation.

#### Login Flow

**Login Endpoint**:
```typescript
POST /api/auth/login

interface LoginRequest {
  email: string;
  password: string;
  rememberMe?: boolean;
}

interface LoginResponse {
  success: boolean;
  user: {
    id: string;
    email: string;
    firstName: string;
    lastName: string;
    role: UserRole;
    companyId: string;
    companyName: string;
  };
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
}
```

**Authentication Process**:
```typescript
async login(email: string, password: string, rememberMe: boolean) {
  // 1. Find user by email
  const user = await prisma.user.findUnique({
    where: { email },
    include: {
      company: {
        select: {
          id: true,
          name: true,
          status: true,
          databaseName: true
        }
      }
    }
  });
  
  // 2. Validate user exists and company is active
  if (!user) {
    throw new UnauthorizedException('Invalid credentials');
  }
  
  if (user.status !== 'ACTIVE') {
    throw new UnauthorizedException('Account is not active');
  }
  
  if (user.company.status !== 'ACTIVE') {
    throw new UnauthorizedException('Company account is not active');
  }
  
  // 3. Verify password
  const isPasswordValid = await bcrypt.compare(password, user.password);
  
  if (!isPasswordValid) {
    // Log failed attempt
    await logFailedLoginAttempt(user.id);
    throw new UnauthorizedException('Invalid credentials');
  }
  
  // 4. Check account lockout
  if (user.failedLoginAttempts >= 5) {
    const lockoutUntil = user.lockedUntil;
    if (lockoutUntil && lockoutUntil > new Date()) {
      throw new UnauthorizedException('Account is temporarily locked');
    }
  }
  
  // 5. Generate tokens
  const accessTokenExpiry = rememberMe ? '7d' : '15m';
  const refreshTokenExpiry = rememberMe ? '30d' : '7d';
  
  const accessToken = jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role,
      companyId: user.companyId,
      databaseName: user.company.databaseName
    },
    process.env.JWT_SECRET,
    { expiresIn: accessTokenExpiry }
  );
  
  const refreshToken = jwt.sign(
    {
      userId: user.id,
      tokenVersion: user.tokenVersion
    },
    process.env.JWT_REFRESH_SECRET,
    { expiresIn: refreshTokenExpiry }
  );
  
  // 6. Store refresh token
  await prisma.refreshToken.create({
    data: {
      token: refreshToken,
      userId: user.id,
      expiresAt: new Date(Date.now() + (rememberMe ? 30 : 7) * 24 * 60 * 60 * 1000),
      userAgent: req.headers['user-agent'],
      ipAddress: req.ip
    }
  });
  
  // 7. Reset failed attempts
  await prisma.user.update({
    where: { id: user.id },
    data: {
      failedLoginAttempts: 0,
      lastLoginAt: new Date(),
      lastLoginIp: req.ip
    }
  });
  
  // 8. Log successful login
  await logAuditEvent({
    userId: user.id,
    action: 'LOGIN',
    resourceType: 'USER',
    resourceId: user.id
  });
  
  return {
    success: true,
    user: {
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      role: user.role,
      companyId: user.companyId,
      companyName: user.company.name
    },
    accessToken,
    refreshToken,
    expiresIn: rememberMe ? 604800 : 900
  };
}
```

#### Token Storage

**Frontend Storage Strategy**:
```typescript
// auth.service.ts
class AuthService {
  // Store tokens
  setTokens(accessToken: string, refreshToken: string) {
    // Access token in memory only (for short-lived token)
    this.accessToken = accessToken;
    
    // Refresh token in httpOnly cookie (more secure)
    // Set by backend in Set-Cookie header
    
    // Alternative: localStorage for SPA (less secure but more flexible)
    if (needsLocalStorage) {
      localStorage.setItem('refreshToken', refreshToken);
    }
  }
  
  // Attach token to requests
  getAuthHeaders() {
    return {
      'Authorization': `Bearer ${this.accessToken}`
    };
  }
}
```

#### Token Refresh Mechanism

**Automatic Token Refresh**:
```typescript
// API interceptor
axios.interceptors.response.use(
  response => response,
  async error => {
    const originalRequest = error.config;
    
    // If 401 and not already retrying
    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;
      
      try {
        // Request new access token
        const response = await axios.post('/api/auth/refresh', {
          refreshToken: getRefreshToken()
        });
        
        const { accessToken } = response.data;
        
        // Update stored token
        setAccessToken(accessToken);
        
        // Retry original request
        originalRequest.headers['Authorization'] = `Bearer ${accessToken}`;
        return axios(originalRequest);
      } catch (refreshError) {
        // Refresh failed, logout user
        logout();
        return Promise.reject(refreshError);
      }
    }
    
    return Promise.reject(error);
  }
);
```

**Refresh Endpoint**:
```typescript
POST /api/auth/refresh

async refreshAccessToken(refreshToken: string) {
  // 1. Verify refresh token
  let payload;
  try {
    payload = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);
  } catch (error) {
    throw new UnauthorizedException('Invalid refresh token');
  }
  
  // 2. Check if token exists in database
  const storedToken = await prisma.refreshToken.findUnique({
    where: { token: refreshToken },
    include: { user: { include: { company: true } } }
  });
  
  if (!storedToken || storedToken.expiresAt < new Date()) {
    throw new UnauthorizedException('Refresh token expired');
  }
  
  // 3. Check token version (for forced logout)
  if (storedToken.user.tokenVersion !== payload.tokenVersion) {
    throw new UnauthorizedException('Token has been revoked');
  }
  
  // 4. Generate new access token
  const accessToken = jwt.sign(
    {
      userId: storedToken.user.id,
      email: storedToken.user.email,
      role: storedToken.user.role,
      companyId: storedToken.user.companyId,
      databaseName: storedToken.user.company.databaseName
    },
    process.env.JWT_SECRET,
    { expiresIn: '15m' }
  );
  
  // 5. Optionally rotate refresh token
  const newRefreshToken = jwt.sign(
    {
      userId: storedToken.user.id,
      tokenVersion: storedToken.user.tokenVersion
    },
    process.env.JWT_REFRESH_SECRET,
    { expiresIn: '7d' }
  );
  
  // 6. Update refresh token in database
  await prisma.refreshToken.update({
    where: { id: storedToken.id },
    data: {
      token: newRefreshToken,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
    }
  });
  
  return {
    accessToken,
    refreshToken: newRefreshToken
  };
}
```

#### Logout

**Logout Endpoint**:
```typescript
POST /api/auth/logout

async logout(userId: string, refreshToken: string) {
  // 1. Revoke refresh token
  await prisma.refreshToken.delete({
    where: { token: refreshToken }
  });
  
  // 2. Log audit event
  await logAuditEvent({
    userId,
    action: 'LOGOUT',
    resourceType: 'USER',
    resourceId: userId
  });
  
  return { success: true };
}
```

**Logout All Sessions**:
```typescript
POST /api/auth/logout-all

async logoutAllSessions(userId: string) {
  // 1. Increment token version (invalidates all refresh tokens)
  await prisma.user.update({
    where: { id: userId },
    data: {
      tokenVersion: { increment: 1 }
    }
  });
  
  // 2. Delete all refresh tokens
  await prisma.refreshToken.deleteMany({
    where: { userId }
  });
  
  return { success: true };
}
```

---

## 🔒 Password Management

### Password Requirements

**Complexity Rules**:
- Minimum 8 characters (recommended 12+)
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one number (0-9)
- At least one special character (!@#$%^&*)
- Cannot contain user's name or email
- Cannot be commonly used passwords

**Validation Function**:
```typescript
function validatePassword(password: string, user: User): string[] {
  const errors: string[] = [];
  
  if (password.length < 8) {
    errors.push('Password must be at least 8 characters long');
  }
  
  if (!/[A-Z]/.test(password)) {
    errors.push('Password must contain at least one uppercase letter');
  }
  
  if (!/[a-z]/.test(password)) {
    errors.push('Password must contain at least one lowercase letter');
  }
  
  if (!/[0-9]/.test(password)) {
    errors.push('Password must contain at least one number');
  }
  
  if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
    errors.push('Password must contain at least one special character');
  }
  
  // Check against user info
  const lowerPassword = password.toLowerCase();
  if (lowerPassword.includes(user.firstName.toLowerCase()) ||
      lowerPassword.includes(user.lastName.toLowerCase()) ||
      lowerPassword.includes(user.email.split('@')[0].toLowerCase())) {
    errors.push('Password cannot contain your name or email');
  }
  
  // Check common passwords
  if (COMMON_PASSWORDS.includes(lowerPassword)) {
    errors.push('This password is too common. Please choose a stronger password');
  }
  
  return errors;
}
```

### Password Reset Flow

#### Step 1: Request Password Reset

**Reset Request Form**:
```typescript
POST /api/auth/forgot-password

interface ForgotPasswordRequest {
  email: string;
}

async requestPasswordReset(email: string) {
  // 1. Find user
  const user = await prisma.user.findUnique({
    where: { email },
    include: { company: true }
  });
  
  // Don't reveal if user exists (security)
  if (!user) {
    return { 
      success: true, 
      message: 'If the email exists, a reset link has been sent' 
    };
  }
  
  // 2. Generate reset token
  const resetToken = crypto.randomBytes(32).toString('hex');
  const hashedToken = crypto
    .createHash('sha256')
    .update(resetToken)
    .digest('hex');
  
  // 3. Store reset token
  await prisma.user.update({
    where: { id: user.id },
    data: {
      resetPasswordToken: hashedToken,
      resetPasswordExpires: new Date(Date.now() + 60 * 60 * 1000) // 1 hour
    }
  });
  
  // 4. Send reset email
  const resetUrl = `${process.env.FRONTEND_URL}/reset-password?token=${resetToken}`;
  
  await sendEmail({
    to: user.email,
    subject: 'Password Reset Request - CloudAudit Pro',
    template: 'password-reset',
    data: {
      firstName: user.firstName,
      resetUrl,
      expiresIn: '1 hour',
      companyName: user.company.name
    }
  });
  
  // 5. Log event
  await logAuditEvent({
    userId: user.id,
    action: 'PASSWORD_RESET_REQUESTED',
    resourceType: 'USER',
    resourceId: user.id
  });
  
  return {
    success: true,
    message: 'If the email exists, a reset link has been sent'
  };
}
```

#### Step 2: Reset Password

**Reset Password Form**:
```typescript
POST /api/auth/reset-password

interface ResetPasswordRequest {
  token: string;
  newPassword: string;
}

async resetPassword(token: string, newPassword: string) {
  // 1. Hash the token
  const hashedToken = crypto
    .createHash('sha256')
    .update(token)
    .digest('hex');
  
  // 2. Find user with valid token
  const user = await prisma.user.findFirst({
    where: {
      resetPasswordToken: hashedToken,
      resetPasswordExpires: {
        gt: new Date()
      }
    }
  });
  
  if (!user) {
    throw new BadRequestException('Invalid or expired reset token');
  }
  
  // 3. Validate new password
  const errors = validatePassword(newPassword, user);
  if (errors.length > 0) {
    throw new BadRequestException(errors.join(', '));
  }
  
  // 4. Hash new password
  const hashedPassword = await bcrypt.hash(newPassword, 12);
  
  // 5. Update user
  await prisma.user.update({
    where: { id: user.id },
    data: {
      password: hashedPassword,
      resetPasswordToken: null,
      resetPasswordExpires: null,
      tokenVersion: { increment: 1 }, // Invalidate all sessions
      passwordChangedAt: new Date()
    }
  });
  
  // 6. Revoke all refresh tokens
  await prisma.refreshToken.deleteMany({
    where: { userId: user.id }
  });
  
  // 7. Send confirmation email
  await sendEmail({
    to: user.email,
    subject: 'Password Reset Successful - CloudAudit Pro',
    template: 'password-reset-confirmation',
    data: {
      firstName: user.firstName,
      resetTime: new Date()
    }
  });
  
  // 8. Log event
  await logAuditEvent({
    userId: user.id,
    action: 'PASSWORD_RESET_COMPLETED',
    resourceType: 'USER',
    resourceId: user.id
  });
  
  return {
    success: true,
    message: 'Password has been reset successfully'
  };
}
```

### Change Password

**Change Password (While Logged In)**:
```typescript
POST /api/auth/change-password

interface ChangePasswordRequest {
  currentPassword: string;
  newPassword: string;
}

async changePassword(userId: string, currentPassword: string, newPassword: string) {
  // 1. Get user
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  // 2. Verify current password
  const isValid = await bcrypt.compare(currentPassword, user.password);
  if (!isValid) {
    throw new BadRequestException('Current password is incorrect');
  }
  
  // 3. Validate new password
  const errors = validatePassword(newPassword, user);
  if (errors.length > 0) {
    throw new BadRequestException(errors.join(', '));
  }
  
  // 4. Check if new password is same as old
  const isSame = await bcrypt.compare(newPassword, user.password);
  if (isSame) {
    throw new BadRequestException('New password must be different from current password');
  }
  
  // 5. Hash and update
  const hashedPassword = await bcrypt.hash(newPassword, 12);
  
  await prisma.user.update({
    where: { id: userId },
    data: {
      password: hashedPassword,
      passwordChangedAt: new Date()
    }
  });
  
  // 6. Send notification email
  await sendEmail({
    to: user.email,
    subject: 'Password Changed - CloudAudit Pro',
    template: 'password-change-notification',
    data: {
      firstName: user.firstName,
      changeTime: new Date(),
      ipAddress: req.ip
    }
  });
  
  // 7. Log event
  await logAuditEvent({
    userId: user.id,
    action: 'PASSWORD_CHANGED',
    resourceType: 'USER',
    resourceId: user.id
  });
  
  return {
    success: true,
    message: 'Password changed successfully'
  };
}
```

### Password Security Best Practices

1. **Storage**: Always hash passwords with bcrypt (cost factor 12)
2. **Never Log**: Never log passwords or tokens
3. **HTTPS Only**: Always use HTTPS in production
4. **Rate Limiting**: Implement rate limiting on password endpoints
5. **Account Lockout**: Lock account after 5 failed attempts
6. **Token Expiry**: Short-lived reset tokens (1 hour max)
7. **Session Invalidation**: Force logout on password change
8. **Audit Trail**: Log all password-related events

---

## 👤 User Invitation System

### Invitation Flow

#### Step 1: Admin Invites User

**Invitation Creation**:
```typescript
POST /api/users/invite

interface InviteUserRequest {
  email: string;
  firstName: string;
  lastName: string;
  role: 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
  phone?: string;
  department?: string;
  message?: string; // Optional personalized message
}

async inviteUser(adminId: string, data: InviteUserRequest) {
  // 1. Check admin permissions
  const admin = await prisma.user.findUnique({
    where: { id: adminId },
    include: { company: true }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(admin.role)) {
    throw new ForbiddenException('Only admins and managers can invite users');
  }
  
  // 2. Check if email already exists in company
  const existingUser = await prisma.user.findFirst({
    where: {
      email: data.email,
      companyId: admin.companyId
    }
  });
  
  if (existingUser) {
    throw new BadRequestException('User with this email already exists');
  }
  
  // 3. Check if pending invitation exists
  const existingInvite = await prisma.userInvitation.findFirst({
    where: {
      email: data.email,
      companyId: admin.companyId,
      status: 'PENDING'
    }
  });
  
  if (existingInvite) {
    throw new BadRequestException('Invitation already sent to this email');
  }
  
  // 4. Generate invitation token
  const inviteToken = crypto.randomBytes(32).toString('hex');
  const hashedToken = crypto
    .createHash('sha256')
    .update(inviteToken)
    .digest('hex');
  
  // 5. Create invitation
  const invitation = await prisma.userInvitation.create({
    data: {
      email: data.email,
      firstName: data.firstName,
      lastName: data.lastName,
      role: data.role,
      phone: data.phone,
      department: data.department,
      companyId: admin.companyId,
      invitedBy: adminId,
      token: hashedToken,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
      status: 'PENDING'
    }
  });
  
  // 6. Send invitation email
  const inviteUrl = `${process.env.FRONTEND_URL}/accept-invitation?token=${inviteToken}`;
  
  await sendEmail({
    to: data.email,
    subject: `Invitation to Join ${admin.company.name} on CloudAudit Pro`,
    template: 'user-invitation',
    data: {
      firstName: data.firstName,
      inviterName: `${admin.firstName} ${admin.lastName}`,
      companyName: admin.company.name,
      role: data.role,
      inviteUrl,
      expiresIn: '7 days',
      personalMessage: data.message
    }
  });
  
  // 7. Log event
  await logAuditEvent({
    userId: adminId,
    action: 'USER_INVITED',
    resourceType: 'USER_INVITATION',
    resourceId: invitation.id,
    metadata: { email: data.email, role: data.role }
  });
  
  return {
    success: true,
    invitation: {
      id: invitation.id,
      email: data.email,
      role: data.role,
      expiresAt: invitation.expiresAt
    }
  };
}
```

#### Step 2: User Accepts Invitation

**Acceptance Flow**:
```typescript
GET /api/users/invitation/:token
// Verify token and show invitation details

POST /api/users/accept-invitation

interface AcceptInvitationRequest {
  token: string;
  password: string;
  phone?: string;
  acceptTerms: boolean;
}

async acceptInvitation(data: AcceptInvitationRequest) {
  // 1. Hash token
  const hashedToken = crypto
    .createHash('sha256')
    .update(data.token)
    .digest('hex');
  
  // 2. Find invitation
  const invitation = await prisma.userInvitation.findFirst({
    where: {
      token: hashedToken,
      status: 'PENDING',
      expiresAt: {
        gt: new Date()
      }
    },
    include: {
      company: true,
      invitedByUser: true
    }
  });
  
  if (!invitation) {
    throw new BadRequestException('Invalid or expired invitation');
  }
  
  // 3. Check terms acceptance
  if (!data.acceptTerms) {
    throw new BadRequestException('You must accept the terms and conditions');
  }
  
  // 4. Validate password
  const errors = validatePassword(data.password, {
    firstName: invitation.firstName,
    lastName: invitation.lastName,
    email: invitation.email
  });
  
  if (errors.length > 0) {
    throw new BadRequestException(errors.join(', '));
  }
  
  // 5. Hash password
  const hashedPassword = await bcrypt.hash(data.password, 12);
  
  // 6. Create user account
  const user = await prisma.user.create({
    data: {
      email: invitation.email,
      password: hashedPassword,
      firstName: invitation.firstName,
      lastName: invitation.lastName,
      phone: data.phone || invitation.phone,
      role: invitation.role,
      companyId: invitation.companyId,
      department: invitation.department,
      status: 'ACTIVE',
      emailVerified: true, // Email verified through invitation
      termsAcceptedAt: new Date()
    }
  });
  
  // 7. Update invitation status
  await prisma.userInvitation.update({
    where: { id: invitation.id },
    data: {
      status: 'ACCEPTED',
      acceptedAt: new Date()
    }
  });
  
  // 8. Send welcome email
  await sendEmail({
    to: user.email,
    subject: `Welcome to ${invitation.company.name} - CloudAudit Pro`,
    template: 'welcome-user',
    data: {
      firstName: user.firstName,
      companyName: invitation.company.name,
      role: user.role,
      inviterName: `${invitation.invitedByUser.firstName} ${invitation.invitedByUser.lastName}`
    }
  });
  
  // 9. Notify admin
  await sendEmail({
    to: invitation.invitedByUser.email,
    subject: 'User Invitation Accepted',
    template: 'invitation-accepted',
    data: {
      userName: `${user.firstName} ${user.lastName}`,
      userEmail: user.email
    }
  });
  
  // 10. Log event
  await logAuditEvent({
    userId: user.id,
    action: 'INVITATION_ACCEPTED',
    resourceType: 'USER',
    resourceId: user.id
  });
  
  // 11. Generate login tokens
  const { accessToken, refreshToken } = await generateTokens(user);
  
  return {
    success: true,
    message: 'Account created successfully',
    user: {
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      role: user.role
    },
    accessToken,
    refreshToken
  };
}
```

#### Step 3: Invitation Management

**Resend Invitation**:
```typescript
POST /api/users/invitation/:invitationId/resend

async resendInvitation(invitationId: string, adminId: string) {
  const invitation = await prisma.userInvitation.findUnique({
    where: { id: invitationId },
    include: { company: true }
  });
  
  if (!invitation || invitation.status !== 'PENDING') {
    throw new BadRequestException('Cannot resend this invitation');
  }
  
  // Generate new token
  const inviteToken = crypto.randomBytes(32).toString('hex');
  const hashedToken = crypto.createHash('sha256').update(inviteToken).digest('hex');
  
  // Update invitation
  await prisma.userInvitation.update({
    where: { id: invitationId },
    data: {
      token: hashedToken,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      resentCount: { increment: 1 }
    }
  });
  
  // Send email
  const inviteUrl = `${process.env.FRONTEND_URL}/accept-invitation?token=${inviteToken}`;
  await sendInvitationEmail(invitation.email, inviteUrl, invitation.company.name);
  
  return { success: true };
}
```

**Cancel Invitation**:
```typescript
DELETE /api/users/invitation/:invitationId

async cancelInvitation(invitationId: string, adminId: string) {
  await prisma.userInvitation.update({
    where: { id: invitationId },
    data: {
      status: 'CANCELLED',
      cancelledAt: new Date(),
      cancelledBy: adminId
    }
  });
  
  return { success: true };
}
```

---

## 👤 User Profile Management

### View Profile

**Get User Profile**:
```typescript
GET /api/users/profile

async getProfile(userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId },
    include: {
      company: {
        select: {
          id: true,
          name: true,
          displayName: true
        }
      },
      createdBy: {
        select: {
          firstName: true,
          lastName: true
        }
      }
    }
  });
  
  return {
    id: user.id,
    email: user.email,
    firstName: user.firstName,
    lastName: user.lastName,
    phone: user.phone,
    role: user.role,
    department: user.department,
    status: user.status,
    company: user.company,
    profilePicture: user.profilePicture,
    createdAt: user.createdAt,
    lastLoginAt: user.lastLoginAt,
    emailVerified: user.emailVerified,
    invitedBy: user.createdBy
  };
}
```

### Update Profile

**Update Basic Information**:
```typescript
PATCH /api/users/profile

interface UpdateProfileRequest {
  firstName?: string;
  lastName?: string;
  phone?: string;
  department?: string;
  profilePicture?: string; // URL or base64
}

async updateProfile(userId: string, data: UpdateProfileRequest) {
  // Validate data
  if (data.phone && !isValidPhone(data.phone)) {
    throw new BadRequestException('Invalid phone number');
  }
  
  // Update user
  const updatedUser = await prisma.user.update({
    where: { id: userId },
    data: {
      firstName: data.firstName,
      lastName: data.lastName,
      phone: data.phone,
      department: data.department,
      profilePicture: data.profilePicture
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    action: 'PROFILE_UPDATED',
    resourceType: 'USER',
    resourceId: userId
  });
  
  return updatedUser;
}
```

### Profile Picture Upload

**Upload Profile Picture**:
```typescript
POST /api/users/profile/picture

async uploadProfilePicture(userId: string, file: Express.Multer.File) {
  // 1. Validate file
  if (!file.mimetype.startsWith('image/')) {
    throw new BadRequestException('File must be an image');
  }
  
  if (file.size > 5 * 1024 * 1024) { // 5MB
    throw new BadRequestException('File size must be less than 5MB');
  }
  
  // 2. Upload to storage (S3, Azure Blob, etc.)
  const fileUrl = await uploadToStorage(file, `profile-pictures/${userId}`);
  
  // 3. Update user
  await prisma.user.update({
    where: { id: userId },
    data: { profilePicture: fileUrl }
  });
  
  return { url: fileUrl };
}
```

---

## ✅ Approval Workflow Details

### Company Approval States

```typescript
enum CompanyStatus {
  PENDING = 'PENDING',           // Initial registration
  UNDER_REVIEW = 'UNDER_REVIEW', // Super admin reviewing
  APPROVED = 'APPROVED',         // Deprecated - use ACTIVE
  ACTIVE = 'ACTIVE',             // Approved and activated
  REJECTED = 'REJECTED',         // Application denied
  SUSPENDED = 'SUSPENDED',       // Temporarily disabled
  CANCELLED = 'CANCELLED'        // Company cancelled subscription
}
```

### Approval Workflow

**1. Registration → PENDING**:
- User submits registration
- Company created with PENDING status
- Admin user created with PENDING status
- Super admins notified

**2. PENDING → UNDER_REVIEW**:
- Super admin opens the request
- May request additional information
- Status changed to UNDER_REVIEW

**3. UNDER_REVIEW → ACTIVE** (Approval):
- Super admin approves
- Tenant database created
- Company status → ACTIVE
- Admin user status → ACTIVE
- Welcome emails sent
- Default data seeded

**4. UNDER_REVIEW → REJECTED** (Rejection):
- Super admin rejects with reason
- Company status → REJECTED
- Rejection email sent
- No database created

### Super Admin Review Dashboard

**Dashboard Components**:
```typescript
interface ApprovalDashboard {
  pendingCount: number;
  underReviewCount: number;
  todayRegistrations: number;
  
  pendingApprovals: CompanyApproval[];
  recentApprovals: CompanyApproval[];
  recentRejections: CompanyApproval[];
}

interface CompanyApproval {
  id: string;
  companyName: string;
  email: string;
  businessType: string;
  submittedDate: Date;
  adminInfo: {
    name: string;
    email: string;
    phone: string;
  };
  verificationChecks: {
    emailValid: boolean;
    domainValid: boolean;
    phoneValid: boolean;
  };
  riskScore: 'LOW' | 'MEDIUM' | 'HIGH';
}
```

**Review Actions**:
```typescript
interface ReviewAction {
  action: 'APPROVE' | 'REJECT' | 'REQUEST_INFO';
  reason?: string;
  notes?: string;
  requestedInfo?: string[];
}

POST /api/super-admin/approvals/:companyId/review

async reviewCompanyRegistration(
  companyId: string,
  superAdminId: string,
  action: ReviewAction
) {
  switch (action.action) {
    case 'APPROVE':
      return await approveCompany(companyId, superAdminId);
    
    case 'REJECT':
      return await rejectCompany(companyId, superAdminId, action.reason);
    
    case 'REQUEST_INFO':
      return await requestMoreInfo(companyId, superAdminId, action.requestedInfo);
  }
}
```

---

## 🔍 Best Practices

### Security Best Practices

1. **Authentication**:
   - Use strong JWT secrets (minimum 256-bit)
   - Implement short-lived access tokens (15 minutes)
   - Use refresh token rotation
   - Implement CSRF protection
   - Use httpOnly cookies for refresh tokens

2. **Password Security**:
   - Enforce strong password policies
   - Use bcrypt with cost factor 12+
   - Implement account lockout (5 failed attempts)
   - Never log passwords or tokens
   - Hash password reset tokens

3. **User Management**:
   - Verify email addresses
   - Implement invitation expiry (7 days)
   - Log all authentication events
   - Implement role-based access control
   - Validate all input data

4. **Session Management**:
   - Implement concurrent session limits
   - Force logout on security events
   - Track active sessions
   - Implement device fingerprinting
   - Allow users to revoke sessions

### Common Use Cases

#### Use Case 1: New Company Onboarding
1. User registers company
2. Super admin reviews and approves
3. Welcome email sent with login link
4. Admin logs in and completes setup
5. Admin invites team members
6. Team members accept and create accounts

#### Use Case 2: Password Reset
1. User forgets password
2. Requests reset via email
3. Receives reset link (1-hour expiry)
4. Creates new password
5. All sessions logged out
6. User logs in with new password

#### Use Case 3: Team Member Invitation
1. Admin invites new auditor
2. Auditor receives invitation email
3. Clicks link and creates account
4. Accepts terms and sets password
5. Automatically logged in
6. Admin notified of acceptance

---

## 🛠️ Troubleshooting

### Common Issues

**Issue: "Invalid credentials" on login**
- **Cause**: Incorrect email/password or account not active
- **Solution**: Check email spelling, try password reset, verify account status

**Issue: "Account is temporarily locked"**
- **Cause**: 5+ failed login attempts
- **Solution**: Wait 30 minutes or contact admin to unlock

**Issue: "Invalid or expired reset token"**
- **Cause**: Token older than 1 hour or already used
- **Solution**: Request a new password reset

**Issue: "Invitation already sent to this email"**
- **Cause**: Pending invitation exists
- **Solution**: Resend existing invitation or cancel and create new one

**Issue: "Token has been revoked"**
- **Cause**: Password changed or logout all sessions
- **Solution**: Log in again with new credentials

### Error Codes

```typescript
enum AuthErrorCode {
  INVALID_CREDENTIALS = 'AUTH_001',
  ACCOUNT_LOCKED = 'AUTH_002',
  ACCOUNT_INACTIVE = 'AUTH_003',
  INVALID_TOKEN = 'AUTH_004',
  TOKEN_EXPIRED = 'AUTH_005',
  WEAK_PASSWORD = 'AUTH_006',
  EMAIL_ALREADY_EXISTS = 'AUTH_007',
  INVITATION_EXPIRED = 'AUTH_008',
  COMPANY_PENDING = 'AUTH_009',
  COMPANY_REJECTED = 'AUTH_010'
}
```

---

## 📊 Monitoring & Metrics

### Key Metrics to Track

1. **Authentication Metrics**:
   - Daily/monthly active users
   - Login success rate
   - Failed login attempts
   - Average session duration
   - Token refresh rate

2. **Registration Metrics**:
   - New company registrations
   - Approval rate
   - Time to approval
   - Rejection reasons
   - Invitation acceptance rate

3. **Security Metrics**:
   - Account lockouts
   - Password reset requests
   - Suspicious login attempts
   - Session anomalies
   - Token revocations

---

## 📚 API Reference Summary

### Authentication Endpoints
- `POST /api/auth/register` - Company registration
- `POST /api/auth/login` - User login
- `POST /api/auth/logout` - User logout
- `POST /api/auth/refresh` - Refresh access token
- `POST /api/auth/forgot-password` - Request password reset
- `POST /api/auth/reset-password` - Reset password with token
- `POST /api/auth/change-password` - Change password (authenticated)

### User Management Endpoints
- `GET /api/users/profile` - Get user profile
- `PATCH /api/users/profile` - Update user profile
- `POST /api/users/profile/picture` - Upload profile picture
- `POST /api/users/invite` - Invite new user
- `POST /api/users/accept-invitation` - Accept invitation
- `GET /api/users` - List users (admin)
- `PATCH /api/users/:id` - Update user (admin)
- `DELETE /api/users/:id` - Deactivate user (admin)

### Super Admin Endpoints
- `GET /api/super-admin/approvals` - List pending approvals
- `POST /api/super-admin/approvals/:id/approve` - Approve company
- `POST /api/super-admin/approvals/:id/reject` - Reject company
- `GET /api/super-admin/companies` - List all companies

---

*This documentation is maintained by the CloudAudit Pro development team. Last updated: December 2025.*
