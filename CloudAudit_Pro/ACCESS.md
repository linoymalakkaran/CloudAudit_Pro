# CloudAudit Pro - Access Guide

## Application URLs

### Frontend Application
- **Development URL:** http://localhost:5174/
- **Production URL:** (To be configured)

### Backend API
- **Development URL:** http://localhost:3000/
- **Production URL:** (To be configured)

## Default Access Credentials

### Super Admin Portal
- **URL:** http://localhost:5174/super-admin/login
- **Default Username:** `super.admin@cloudaudit.pro`
- **Default Password:** `SuperAdmin123!`
- **Role:** SUPER_ADMIN
- **Access Level:** Full system control, tenant approval, global user management

### Company Admin Portal
- **URL:** http://localhost:5174/admin/dashboard
- **Default Username:** `admin@company.com`
- **Default Password:** `Admin123!`
- **Role:** ADMIN
- **Access Level:** Company-wide user management, approvals, reports

### Standard User Portal
- **URL:** http://localhost:5174/login
- **Default Username:** `user@company.com`
- **Default Password:** `User123!`
- **Role:** AUDITOR
- **Access Level:** Standard audit functions

## Application Flow & User Management

### 1. Tenant Registration Flow
1. **Company Registration:** http://localhost:5174/register
   - New companies register for the platform
   - Status: PENDING approval by Super Admin
   
2. **Super Admin Approval:**
   - Super Admin reviews tenant requests at: http://localhost:5174/super-admin/pending-approvals
   - Approve/Reject tenant applications
   - Send approval/rejection emails

3. **Company Admin Setup:**
   - Once approved, company admin receives setup email
   - Complete company profile and settings

### 2. User Management Within Company

#### Company Admin Functions:
- **User Dashboard:** http://localhost:5174/admin/dashboard
- **User Management:** http://localhost:5174/admin/users
- **Invite New Users:** http://localhost:5174/admin/users/invite
- **Pending Approvals:** http://localhost:5174/admin/users/pending

#### User Invitation Process:
1. Company Admin invites users via email
2. Users receive invitation email with setup link
3. Users complete profile setup
4. Automatic role assignment based on invitation

## Web URLs by Function

### Authentication & Access
- **Login:** http://localhost:5174/login
- **Register:** http://localhost:5174/register
- **Forgot Password:** http://localhost:5174/forgot-password
- **Reset Password:** http://localhost:5174/reset-password

### Super Admin Portal
- **Dashboard:** http://localhost:5174/super-admin/dashboard
- **Tenant Management:** http://localhost:5174/super-admin/tenants
- **Pending Tenant Approvals:** http://localhost:5174/super-admin/pending-approvals
- **System Settings:** http://localhost:5174/super-admin/settings

### Company Admin Portal
- **Admin Dashboard:** http://localhost:5174/admin/dashboard
- **User Management:** http://localhost:5174/admin/users
- **Invite Users:** http://localhost:5174/admin/users/invite
- **User Approvals:** http://localhost:5174/admin/users/pending
- **User Roles:** http://localhost:5174/admin/users/roles
- **Company Settings:** http://localhost:5174/admin/settings

### Audit Functions
- **Dashboard:** http://localhost:5174/dashboard
- **Documents:** http://localhost:5174/documents
- **Reports:** http://localhost:5174/reports
- **Analytics:** http://localhost:5174/analytics
- **Client Management:** http://localhost:5174/clients

### API Endpoints

#### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - Tenant registration
- `POST /api/auth/logout` - User logout
- `POST /api/auth/refresh` - Token refresh

#### Super Admin APIs
- `GET /api/super-admin/tenants` - List all tenants
- `PUT /api/super-admin/tenants/:id/approve` - Approve tenant
- `PUT /api/super-admin/tenants/:id/reject` - Reject tenant
- `GET /api/super-admin/dashboard` - Dashboard stats

#### User Management APIs
- `GET /api/users` - List company users
- `POST /api/users/invite` - Invite new user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user
- `POST /api/users/bulk-invite` - Bulk invite users
- `GET /api/users/stats` - User statistics

#### Email Notifications
- User invitation emails
- Tenant approval/rejection emails
- Password reset emails
- Welcome emails

## Role-Based Access Control

### SUPER_ADMIN
- Full system access
- Tenant management
- Global user oversight
- System configuration

### ADMIN (Company Admin)
- Company-wide user management
- User invitation and approval
- Company settings
- Reports and analytics

### MANAGER
- Team user management
- Limited admin functions
- Reports access

### SENIOR_AUDITOR
- Advanced audit functions
- Review and approve work
- Generate reports

### AUDITOR
- Standard audit functions
- Document management
- Basic reporting

### INTERN
- Limited audit access
- Learning mode
- Supervised functions

## Development Environment

### Prerequisites
- Node.js 18+
- PostgreSQL
- npm/yarn

### Starting the Application
```bash
# Backend
cd backend
npm install
npm run start:dev

# Frontend  
cd frontend
npm install
npm run dev
```

### Database Setup
```bash
# Install dependencies
npm install

# Run Prisma migrations
npx prisma migrate dev

# Generate Prisma client
npx prisma generate

# Seed database (optional)
npm run seed
```

## Production Deployment

### Environment Variables
```env
# Database
DATABASE_URL=postgresql://username:password@host:port/database

# JWT
JWT_SECRET=your-jwt-secret
JWT_EXPIRES_IN=7d

# Email
MAIL_HOST=smtp.your-provider.com
MAIL_PORT=587
MAIL_USER=your-email@domain.com
MAIL_PASS=your-password

# Frontend
REACT_APP_API_URL=https://api.your-domain.com
```

### Build Commands
```bash
# Backend build
npm run build

# Frontend build
npm run build
```

## Support & Documentation

- **Technical Documentation:** `/docs` folder
- **API Documentation:** Available at `/api/docs` when backend is running
- **User Guide:** Available in the application help section

## Security Notes

- Change all default passwords before production deployment
- Configure proper CORS settings
- Use HTTPS in production
- Implement proper rate limiting
- Regular security audits recommended

---

**Last Updated:** $(date)
**Version:** 1.0.0
**Environment:** Development