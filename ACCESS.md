# CloudAudit Pro - Access Guide

## Quick Start - Running the Application

### Prerequisites
- PostgreSQL database running on localhost:5432
- Node.js and npm installed
- Git repository cloned

### Backend Setup
```bash
# Navigate to backend directory
cd CloudAudit_Pro/backend

# Install dependencies (if not done)
npm install

# Setup environment variables
# Ensure .env file exists with:
# DATABASE_URL="postgresql://cloudaudit:cloudaudit_dev_password@localhost:5432/cloudaudit_pro"
# JWT_SECRET=dev-jwt-access-secret-key-for-development-only-min-32-chars-long

# Initialize database
npx prisma db push

# Start backend server
npm run start:dev
```
**Backend runs on:** `http://localhost:3001`

### Frontend Setup
```bash
# Navigate to frontend directory
cd CloudAudit_Pro/frontend

# Install dependencies (if not done)
npm install

# Start frontend development server
npm run dev
```
**Frontend runs on:** `http://localhost:5173`

---

## Portal URLs & Access

### 🌐 Main Application Portal
**URL:** `http://localhost:5173`
- **Purpose:** Main entry point for all users
- **Access:** Public (authentication required)
- **Features:**
  - User registration and login
  - Role-based redirection
  - Multi-tenant organization setup

---

## 👨‍💼 Admin Portal
**Access Level:** ADMIN role only
**Default Landing:** `http://localhost:5173/admin`

### Admin Dashboard
**URL:** `http://localhost:5173/admin`
- **Purpose:** Administrative overview and management
- **Who Can Access:** ADMIN users only
- **Functionalities:**
  - System-wide statistics and metrics
  - Quick access to all admin functions
  - Recent activity monitoring
  - Tenant/organization health overview

### Company Management
**URL:** `http://localhost:5173/admin/companies`
- **Purpose:** Manage audit client companies
- **Who Can Access:** ADMIN, MANAGER
- **Functionalities:**
  - Add new client companies
  - Edit company information
  - View company audit status
  - Manage company-specific settings
  - Assign audit teams to companies

### User Management
**URL:** `http://localhost:5173/admin/users`
- **Purpose:** Manage team members and user accounts
- **Who Can Access:** ADMIN, MANAGER
- **Functionalities:**
  - Add new team members
  - Assign and modify user roles
  - Activate/deactivate user accounts
  - View user activity and login history
  - Manage user permissions

---

## 🏢 Client Portal
**Access Level:** All authenticated users (view differs by role)
**Default Landing:** `http://localhost:5173/client`

### Client Dashboard
**URL:** `http://localhost:5173/client`
- **Purpose:** Client-focused audit progress tracking
- **Who Can Access:** All roles (filtered by assigned companies)
- **Functionalities:**
  - View audit progress for assigned companies
  - Track procedure completion status
  - Monitor outstanding requirements
  - Access audit schedules and timelines
  - View audit findings and recommendations

---

## 👨‍🔬 Auditor Portal
**Access Level:** SENIOR_AUDITOR, AUDITOR, INTERN
**Default Landing:** `http://localhost:5173/auditor`

### Auditor Dashboard
**URL:** `http://localhost:5173/auditor`
- **Purpose:** Auditor workload and assignment management
- **Who Can Access:** SENIOR_AUDITOR, AUDITOR, INTERN
- **Functionalities:**
  - View assigned procedures and tasks
  - Track workload and deadlines
  - Quick action buttons for common tasks
  - Schedule overview and calendar
  - Performance metrics

### Audit Procedures
**URL:** `http://localhost:5173/auditor/procedures`
- **Purpose:** Manage and execute audit procedures
- **Who Can Access:** SENIOR_AUDITOR, AUDITOR, INTERN
- **Functionalities:**
  - Create new audit procedures
  - Assign procedures to team members
  - Track procedure completion status
  - Mark procedures as complete
  - Add notes and working papers

---

## 📊 Shared Features (All Portals)

### Documents Management
**URL:** `http://localhost:5173/documents`
- **Purpose:** Document storage and management
- **Who Can Access:** All authenticated users
- **Functionalities:**
  - Upload audit documents
  - Organize documents by category and company
  - Download and share documents
  - Version control and document history
  - Search and filter documents

### Reports & Analytics
**URL:** `http://localhost:5173/reports`
- **Purpose:** Generate and manage audit reports
- **Who Can Access:** All authenticated users (permissions vary)
- **Functionalities:**
  - Generate various audit report types
  - Custom report templates
  - Export reports in multiple formats
  - Schedule automated reports
  - Report sharing and distribution

### Financial Statements
**URL:** `http://localhost:5173/financial-statements`
- **Purpose:** Financial statement review and analysis
- **Who Can Access:** ADMIN, MANAGER, SENIOR_AUDITOR
- **Functionalities:**
  - Upload client financial statements
  - Analytical review procedures
  - Compare periods and benchmarks
  - Flag unusual variances
  - Link to audit procedures

### Settings & Configuration
**URL:** `http://localhost:5173/settings`
- **Purpose:** User and system configuration
- **Who Can Access:** All authenticated users (scope varies)
- **Functionalities:**
  - Personal profile management
  - Company/tenant settings (ADMIN only)
  - Notification preferences
  - Security settings
  - System configurations

---

## 🔐 User Roles & Access Levels

### ADMIN
- **Full Access:** All portals and functionalities
- **Primary Portals:** Admin Portal, Company Management, User Management
- **Capabilities:**
  - Manage organizations and tenants
  - Create and manage user accounts
  - Configure system settings
  - Access all audit data across companies
  - Generate system-wide reports

### MANAGER
- **Access:** Admin Portal (limited), Client Portal, Auditor Portal
- **Primary Portals:** Admin Portal, Client Portal
- **Capabilities:**
  - Manage assigned companies
  - Oversee team performance
  - Review and approve procedures
  - Assign tasks and deadlines
  - Generate management reports

### SENIOR_AUDITOR
- **Access:** Client Portal, Auditor Portal, Advanced Features
- **Primary Portals:** Auditor Portal, Client Portal
- **Capabilities:**
  - Lead audit engagements
  - Review junior staff work
  - Create complex audit procedures
  - Access sensitive financial data
  - Sign off on completed procedures

### AUDITOR
- **Access:** Client Portal, Auditor Portal, Standard Features
- **Primary Portals:** Auditor Portal, Client Portal
- **Capabilities:**
  - Execute assigned audit procedures
  - Upload and manage documents
  - Complete routine audit tasks
  - Generate standard reports
  - Collaborate with team members

### INTERN
- **Access:** Limited Client Portal, Basic Auditor Portal
- **Primary Portals:** Auditor Portal (restricted)
- **Capabilities:**
  - View assigned basic procedures
  - Upload documents (with approval)
  - Access training materials
  - Complete simple audit tasks
  - Limited report access

---

## 🔧 API Endpoints

### Authentication APIs
- **Base URL:** `http://localhost:3001/api/auth`
- **Endpoints:**
  - `POST /register` - User/tenant registration
  - `POST /login` - User authentication
  - `POST /logout` - User logout
  - `GET /profile` - Get user profile

### Health Check
- **URL:** `http://localhost:3001/api/health` - Backend health status

### API Documentation
- **URL:** `http://localhost:3001/api/docs` - Swagger API documentation

---

## 🚀 Registration Process

### New Organization Setup
1. **Access:** `http://localhost:5173/register`
2. **Process:**
   - Step 1: Personal Information (Name, Email, Password)
   - Step 2: Company Setup (Company Name, Subdomain)
   - Step 3: Review and Submit
3. **Result:** 
   - Creates new tenant/organization
   - First user becomes ADMIN
   - Automatic login after registration

### Adding Team Members
1. **Access:** Admin Portal → User Management
2. **Process:**
   - Admin creates new user accounts
   - Assigns appropriate roles
   - Users receive login credentials
   - Role-based access automatically applied

---

## 🔄 Navigation Flow

### After Login Redirection
- **ADMIN:** → Admin Dashboard (`/admin`)
- **MANAGER:** → Admin Dashboard (`/admin`) or Client Portal (`/client`)
- **SENIOR_AUDITOR:** → Auditor Portal (`/auditor`)
- **AUDITOR:** → Auditor Portal (`/auditor`)
- **INTERN:** → Auditor Portal (`/auditor`) with limited access

### Menu Navigation
- **Top Navigation:** Role-based menu items
- **Sidebar:** Quick access to frequently used features
- **User Menu:** Profile settings, logout, role information

---

## 🛠️ Troubleshooting

### Common Issues
1. **Frontend not accessible:** Ensure frontend server is running on port 5173
2. **API errors:** Verify backend server is running on port 3001
3. **Database errors:** Check PostgreSQL connection and database exists
4. **Registration fails:** Ensure subdomain doesn't already exist

### Port Conflicts
- **Frontend Default:** 5173 (may auto-increment to 5174, 5175, etc.)
- **Backend Fixed:** 3001
- **Database:** 5432 (PostgreSQL)

### Environment Setup
Ensure `.env` file in backend contains:
```
DATABASE_URL="postgresql://cloudaudit:cloudaudit_dev_password@localhost:5432/cloudaudit_pro"
JWT_SECRET=dev-jwt-access-secret-key-for-development-only-min-32-chars-long
```

---

## 📞 Support

For technical issues or questions:
1. Check console logs (F12 in browser)
2. Verify backend health: `http://localhost:3001/api/health`
3. Review API documentation: `http://localhost:3001/api/docs`
4. Ensure all services are running and accessible

---

*Last Updated: November 24, 2025*