# CloudAudit Pro - Architecture & Technical Foundation

## 🏗️ System Architecture Overview

CloudAudit Pro follows a modern, three-tier architecture with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                       │
│                                                              │
│  React 18 SPA + Material-UI + PWA                           │
│  • Admin Portal  • User Interface  • Client Portal          │
│  • Dashboards   • Kanban Board    • Calendar Views          │
└──────────────────────┬──────────────────────────────────────┘
                       │ HTTPS/REST API
                       │ (JWT Authentication)
┌──────────────────────▼──────────────────────────────────────┐
│                     APPLICATION LAYER                        │
│                                                              │
│  NestJS Backend + TypeScript                                │
│  • REST API Controllers  • Business Logic Services          │
│  • Authentication       • Authorization (RBAC)              │
│  • Email Service        • File Upload                       │
│  • Validation          • Error Handling                     │
└──────────────────────┬──────────────────────────────────────┘
                       │ Prisma ORM
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                      DATA LAYER                              │
│                                                              │
│  PostgreSQL 15 + Redis Cache                                │
│  • Multi-Tenant Databases                                   │
│  • Relational Data Models                                   │
│  • ACID Transactions                                        │
│  • Full-Text Search                                         │
└─────────────────────────────────────────────────────────────┘
```

---

## 🏢 Multi-Tenant Architecture

### Database-Per-Tenant Model

CloudAudit Pro implements a **database-per-tenant** architecture for complete data isolation:

```
┌─────────────────────────────────────────────────────────┐
│                   Application Layer                      │
│              (Shared NestJS Backend)                     │
└────┬────────────┬────────────┬───────────────────┬──────┘
     │            │            │                   │
     ▼            ▼            ▼                   ▼
┌─────────┐  ┌─────────┐  ┌─────────┐       ┌─────────┐
│  DB:    │  │  DB:    │  │  DB:    │  ...  │  DB:    │
│ Tenant1 │  │ Tenant2 │  │ Tenant3 │       │ TenantN │
└─────────┘  └─────────┘  └─────────┘       └─────────┘
```

### Why Database-Per-Tenant?

1. **Complete Data Isolation**
   - No risk of cross-tenant data leaks
   - Regulatory compliance (GDPR, SOC 2)
   - Customer confidence

2. **Performance**
   - Each tenant has dedicated resources
   - No "noisy neighbor" problems
   - Independent scaling

3. **Customization**
   - Tenant-specific migrations
   - Custom schema extensions
   - Independent backup/restore

4. **Security**
   - Database-level isolation
   - Separate encryption keys
   - Individual access controls

### Tenant Resolution Flow

```typescript
// 1. User logs in → JWT token includes tenantId
// 2. API request → Extract tenantId from JWT
// 3. Tenant Middleware → Switch database connection
// 4. Service Layer → Operate on tenant-specific database
// 5. Response → Return data from correct tenant
```

### Implementation Details

**Prisma Schema**: Single schema definition
```prisma
// schema.prisma
model Company {
  id   String @id @default(cuid())
  name String
  // ... all tenant-specific data
}
```

**Database Connection Switching**:
```typescript
// Database URL per tenant
DATABASE_URL_TENANT_1 = "postgresql://..."
DATABASE_URL_TENANT_2 = "postgresql://..."
```

**Tenant Context**:
```typescript
@Injectable()
export class TenantService {
  async getTenantDatabase(tenantId: string) {
    // Returns Prisma client for specific tenant
  }
}
```

---

## 🔐 Authentication & Authorization Flow

### Authentication Architecture

```
┌──────────┐           ┌──────────┐          ┌──────────┐
│  User    │  Login    │  Auth    │  Verify  │   JWT    │
│          ├──────────►│ Service  ├─────────►│  Token   │
│ (Client) │           │ (NestJS) │          │ (Issued) │
└────┬─────┘           └──────────┘          └────┬─────┘
     │                                            │
     │  Subsequent Requests (with JWT)            │
     └───────────────────────────────────────────┘
```

### JWT Token Structure

```json
{
  "sub": "user-id",
  "email": "user@example.com",
  "role": "AUDITOR",
  "tenantId": "tenant-123",
  "iat": 1640000000,
  "exp": 1640086400
}
```

### Authorization Layers

1. **Route Guards** (Controller level)
   ```typescript
   @UseGuards(JwtAuthGuard)
   @Controller('procedures')
   ```

2. **Role Guards** (RBAC)
   ```typescript
   @Roles('ADMIN', 'MANAGER')
   @UseGuards(JwtAuthGuard, RolesGuard)
   ```

3. **Resource Guards** (Ownership)
   ```typescript
   // Check if user owns/can access resource
   if (procedure.assignedTo !== user.id) {
     throw new ForbiddenException();
   }
   ```

### Security Features

- ✅ Password hashing (bcrypt, salt rounds: 10)
- ✅ JWT access tokens (15 min expiry)
- ✅ JWT refresh tokens (7 days expiry)
- ✅ HTTPS enforced in production
- ✅ CORS configuration
- ✅ Rate limiting (coming soon)
- ✅ SQL injection prevention (Prisma)
- ✅ XSS protection (React sanitization)
- ✅ CSRF protection (SameSite cookies)

---

## 📊 Database Design & Structure

### Core Database Models

**30+ Prisma Models** organized into logical groups:

#### 1. Authentication & Users
- `SuperAdmin` - Platform administrators
- `User` - Tenant users with roles
- `TenantApprovalRequest` - Company approval workflow

#### 2. Multi-Tenancy
- `Tenant` - Tenant configuration (planned)
- Database-per-tenant isolation

#### 3. Company & Structure
- `Company` - Client companies
- `Period` - Audit periods/fiscal years
- `Account` - Chart of accounts
- `AccountHead` - Account groupings
- `AccountType` - Account classifications

#### 4. Financial Data
- `TrialBalance` - Trial balance entries
- `JournalEntry` - Adjusting entries
- `JournalEntryLine` - Journal entry details
- `GeneralLedger` - General ledger entries

#### 5. Audit Management
- `AuditProcedure` - Audit procedures
- `ProcedureTemplate` - Reusable templates
- `Workpaper` - Audit workpapers
- `Finding` - Audit findings
- `Comment` - Collaboration comments

#### 6. Reporting
- `FinancialStatement` - Generated statements
- `Report` - Custom reports
- `Dashboard` - Dashboard configurations

#### 7. Documents
- `Document` - File metadata
- `DocumentLink` - Links to procedures/findings

#### 8. System
- `AuditTrail` - Activity logging
- `SystemConfig` - System settings
- `Notification` - User notifications

### Key Relationships

```
Company ─┬─► Period ─┬─► AuditProcedure ─┬─► Workpaper
         │           │                    └─► Finding
         │           ├─► TrialBalance
         │           ├─► JournalEntry
         │           └─► FinancialStatement
         │
         └─► Account ─► AccountHead
                     └─► AccountType

User ─┬─► AuditProcedure (assignedTo)
      ├─► Comment (author)
      └─► AuditTrail (user)
```

### Database Constraints

- **Foreign Keys**: Enforce referential integrity
- **Unique Constraints**: Prevent duplicates
- **Check Constraints**: Data validation
- **Cascade Deletes**: Controlled via Prisma
- **Indexes**: Performance optimization on:
  - Foreign keys
  - Search fields (name, code, email)
  - Date ranges (dueDate, createdAt)

---

## 🔌 API Structure

### REST API Design

**Base URL**: `/api/v1/`

**Authentication**: Bearer token in Authorization header
```
Authorization: Bearer <jwt-token>
```

### API Modules

#### 1. Authentication (`/auth`)
- `POST /login` - User login
- `POST /register` - Company registration
- `POST /refresh` - Refresh tokens
- `POST /logout` - User logout
- `POST /forgot-password` - Password reset request
- `POST /reset-password` - Password reset

#### 2. Users (`/users`, `/user-management`)
- `GET /users` - List users
- `GET /users/:id` - Get user
- `POST /users` - Create user
- `PATCH /users/:id` - Update user
- `DELETE /users/:id` - Delete user
- `POST /user-management/invite` - Invite user

#### 3. Companies (`/companies`)
- `GET /companies` - List companies
- `GET /companies/:id` - Get company
- `POST /companies` - Create company
- `PATCH /companies/:id` - Update company
- `DELETE /companies/:id` - Delete company

#### 4. Periods (`/periods`)
- `GET /periods` - List periods
- `GET /periods/:id` - Get period
- `POST /periods` - Create period
- `PATCH /periods/:id` - Update period
- `DELETE /periods/:id` - Delete period

#### 5. Accounts (`/accounts`)
- `GET /accounts` - List accounts
- `GET /accounts/:id` - Get account
- `POST /accounts` - Create account
- `PATCH /accounts/:id` - Update account
- `DELETE /accounts/:id` - Delete account

#### 6. Trial Balance (`/trial-balance`)
- `GET /trial-balance` - List entries
- `POST /trial-balance` - Create entry
- `POST /trial-balance/import` - Import CSV/Excel
- `GET /trial-balance/export` - Export data
- `PATCH /trial-balance/:id` - Update entry
- `DELETE /trial-balance/:id` - Delete entry

#### 7. Audit Procedures (`/audit-procedures`)
- `GET /audit-procedures` - List procedures
- `GET /audit-procedures/:id` - Get procedure
- `POST /audit-procedures` - Create procedure
- `PATCH /audit-procedures/:id` - Update procedure
- `DELETE /audit-procedures/:id` - Delete procedure
- `GET /audit-procedures/statistics` - Get statistics
- `POST /audit-procedures/bulk-assign` - Bulk assignment

#### 8. Workpapers (`/workpapers`)
- `GET /workpapers` - List workpapers
- `POST /workpapers` - Create workpaper
- `PATCH /workpapers/:id` - Update workpaper
- `DELETE /workpapers/:id` - Delete workpaper

#### 9. Findings (`/findings`)
- `GET /findings` - List findings
- `POST /findings` - Create finding
- `PATCH /findings/:id` - Update finding
- `DELETE /findings/:id` - Delete finding

#### 10. Journal Entries (`/journal-entries`)
- `GET /journal-entries` - List entries
- `POST /journal-entries` - Create entry
- `PATCH /journal-entries/:id` - Update entry
- `DELETE /journal-entries/:id` - Delete entry
- `POST /journal-entries/:id/approve` - Approve entry

#### 11. Financial Statements (`/financial-statements`)
- `GET /financial-statements` - List statements
- `POST /financial-statements/generate` - Generate statement
- `GET /financial-statements/:id` - Get statement
- `GET /financial-statements/:id/export` - Export PDF/Excel

#### 12. Documents (`/documents`)
- `GET /documents` - List documents
- `POST /documents/upload` - Upload file
- `GET /documents/:id` - Get document
- `GET /documents/:id/download` - Download file
- `DELETE /documents/:id` - Delete document

#### 13. Templates (`/procedure-templates`)
- `GET /procedure-templates` - List templates
- `POST /procedure-templates` - Create template
- `PATCH /procedure-templates/:id` - Update template
- `DELETE /procedure-templates/:id` - Delete template

#### 14. Reports (`/reports`)
- `GET /reports` - List reports
- `POST /reports/generate` - Generate report
- `GET /reports/:id` - Get report

#### 15. Super Admin (`/super-admin`)
- `POST /super-admin/login` - Super admin login
- `GET /super-admin/pending-approvals` - Get pending companies
- `POST /super-admin/approve/:id` - Approve company
- `POST /super-admin/reject/:id` - Reject company

### Response Format

**Success Response**:
```json
{
  "data": { ... },
  "message": "Operation successful"
}
```

**Error Response**:
```json
{
  "statusCode": 400,
  "message": "Error description",
  "error": "Bad Request"
}
```

### API Versioning

Currently: **v1** (implicit in routes)
Future: Path-based versioning `/api/v2/...`

---

## 🎨 Frontend Architecture

### Component Structure

```
frontend/src/
├── components/           # Reusable components
│   ├── admin/           # Admin-specific components
│   ├── forms/           # Form components
│   ├── Layout.tsx       # Main layout wrapper
│   └── ...
├── pages/               # Page components (routes)
│   ├── admin/           # Admin pages
│   ├── auditor/         # Auditor pages
│   ├── client/          # Client portal pages
│   ├── AuditProcedures.tsx
│   ├── KanbanBoard.tsx
│   ├── CalendarView.tsx
│   └── ...
├── contexts/            # React contexts
│   └── AuthContext.tsx  # Authentication context
├── services/            # API client services
│   └── api.ts           # Axios client
├── utils/               # Utility functions
├── App.tsx              # Root component
└── main.tsx             # Application entry
```

### State Management

**React Context API** for:
- Authentication state
- User information
- Tenant context

**Local State** (useState, useReducer) for:
- Component-specific state
- Form state
- UI state

### Routing Structure

```typescript
/                           → Dashboard
/login                      → Login page
/register                   → Registration page

/admin/*                    → Admin portal
  /admin/companies          → Company management
  /admin/users              → User management
  /admin/pending-approvals  → Approval queue

/audit/*                    → Audit workspace
  /audit/procedures         → Procedure list
  /audit/procedures/:id     → Procedure details
  /audit/kanban            → Kanban board
  /audit/calendar          → Calendar view
  /audit/my-work           → My work dashboard
  /audit/templates         → Template library

/documents                  → Document management
/ledger                    → General ledger
/financial-statements      → Financial statements
/reports                   → Reports
/client                    → Client portal
```

### Component Patterns

**Page Components**: Route-level components
```typescript
const AuditProcedures: React.FC = () => {
  // Fetch data, manage state
  // Render UI
  return <Box>...</Box>;
};
```

**Reusable Components**: Shared UI elements
```typescript
interface ProcedureFormProps {
  procedure?: Procedure;
  onSubmit: (data: ProcedureData) => void;
}

export const ProcedureForm: React.FC<ProcedureFormProps> = ({...}) => {
  // Form logic
};
```

**Layout Components**: Wrappers
```typescript
<Layout>
  <Routes>
    <Route path="/audit/procedures" element={<AuditProcedures />} />
  </Routes>
</Layout>
```

---

## 🔧 Backend Architecture

### NestJS Module Structure

```
backend/src/
├── main.ts                    # Application bootstrap
├── app.module.ts              # Root module
├── auth/                      # Authentication module
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   ├── auth.module.ts
│   ├── strategies/            # Passport strategies
│   └── guards/                # Auth guards
├── user/                      # User management
├── company/                   # Company module
├── period/                    # Period module
├── account/                   # Account module
├── trial-balance/             # Trial balance module
├── audit-procedure/           # Audit procedure module
├── workpaper/                 # Workpaper module
├── finding/                   # Finding module
├── journal-entry/             # Journal entry module
├── financial-statement/       # Financial statement module
├── document/                  # Document module
├── procedure-template/        # Template module
├── reports/                   # Reports module
├── email/                     # Email service
├── super-admin/               # Super admin module
├── database/                  # Database service
│   └── prisma.service.ts      # Prisma client
├── common/                    # Shared utilities
│   ├── decorators/            # Custom decorators
│   ├── filters/               # Exception filters
│   ├── guards/                # Custom guards
│   ├── interceptors/          # Interceptors
│   └── pipes/                 # Validation pipes
└── config/                    # Configuration
```

### Module Pattern

Each module follows consistent structure:
```typescript
@Module({
  imports: [DatabaseModule],
  controllers: [ProcedureController],
  providers: [ProcedureService],
  exports: [ProcedureService],
})
export class AuditProcedureModule {}
```

### Service Layer

Business logic encapsulation:
```typescript
@Injectable()
export class AuditProcedureService {
  constructor(
    private prisma: PrismaService,
    private emailService: EmailService,
  ) {}

  async create(data: CreateProcedureDto) {
    // Business logic
    const procedure = await this.prisma.auditProcedure.create({...});
    await this.emailService.sendAssignmentNotification(...);
    return procedure;
  }
}
```

### Dependency Injection

NestJS built-in DI container:
```typescript
// Service automatically injected
constructor(
  private readonly procedureService: AuditProcedureService,
  private readonly emailService: EmailService,
) {}
```

---

## 🛡️ Security Implementation

### Security Layers

1. **Network Security**
   - HTTPS/TLS encryption
   - CORS configuration
   - Rate limiting (planned)

2. **Authentication Security**
   - JWT tokens
   - Secure password hashing
   - Token expiration
   - Refresh token rotation

3. **Authorization Security**
   - Role-based access control
   - Resource ownership validation
   - Tenant isolation

4. **Data Security**
   - Database-level isolation
   - SQL injection prevention (Prisma)
   - Input validation
   - Output sanitization

5. **Application Security**
   - XSS protection
   - CSRF protection
   - Content Security Policy
   - Secure headers

### Audit Trail

All significant actions logged:
```typescript
await this.prisma.auditTrail.create({
  data: {
    userId: user.id,
    action: 'PROCEDURE_CREATED',
    entityType: 'AuditProcedure',
    entityId: procedure.id,
    changes: JSON.stringify(data),
    ipAddress: req.ip,
    userAgent: req.headers['user-agent'],
  },
});
```

---

## 📦 Deployment Architecture

### Docker Containerization

**Multi-Container Setup**:
- Frontend container (Nginx + React SPA)
- Backend container (Node.js + NestJS)
- PostgreSQL container
- Redis container (optional)
- Nginx reverse proxy

**Docker Compose Services**:
```yaml
services:
  postgres:      # Database
  redis:         # Cache
  backend:       # NestJS API
  frontend:      # React SPA
  nginx:         # Reverse proxy
```

### Azure Deployment

**Azure Services Used**:
- Azure App Service (Backend + Frontend)
- Azure Database for PostgreSQL
- Azure Blob Storage (Documents)
- Azure Key Vault (Secrets)
- Azure Application Insights (Monitoring)

**Infrastructure as Code**:
- ARM templates for resource provisioning
- Automated deployment scripts
- Environment configuration

---

## 🔄 Data Flow Examples

### Audit Procedure Creation Flow

```
1. User fills form in React
   ↓
2. Form validation (client-side)
   ↓
3. POST /api/audit-procedures
   ↓
4. JWT validation (backend)
   ↓
5. Role authorization check
   ↓
6. DTO validation (class-validator)
   ↓
7. Service business logic
   ↓
8. Prisma database insert
   ↓
9. Email notification sent
   ↓
10. Audit trail logged
   ↓
11. Response returned
   ↓
12. React state updated
   ↓
13. UI re-rendered
```

---

**Next Document**: Phase 3 - User Roles & Permissions

**Last Updated**: December 27, 2025
