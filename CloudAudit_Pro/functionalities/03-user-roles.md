# CloudAudit Pro - User Roles & Permissions

## 👥 User Hierarchy Structure

CloudAudit Pro implements a hierarchical role-based access control (RBAC) system with seven distinct user roles:

```
SUPER_ADMIN (Platform Level)
    │
    └─── ADMIN (Company Level)
            │
            └─── MANAGER (Department Level)
                    │
                    ├─── SENIOR_AUDITOR
                    │       │
                    │       ├─── AUDITOR
                    │       │       │
                    │       │       └─── INTERN
                    │       │
                    │       └─── AUDITOR
                    │
                    └─── CLIENT (External User)
```

---

## 🎭 Role Definitions

### 1. SUPER_ADMIN (Platform Administrator)

**Description**: Platform-level administrators who manage the entire SaaS system across all tenant companies.

**Scope**: Cross-tenant, system-wide access

**Primary Responsibilities**:
- Review and approve/reject new company registration requests
- Manage platform-level settings and configurations
- Monitor system health and performance
- Manage super admin accounts
- Access all tenant data (for support purposes)
- System maintenance and updates
- Platform billing and subscription management

**Key Characteristics**:
- Separate authentication system from regular users
- Not tied to any specific tenant/company
- Cannot be created through normal registration
- Highest level of system access

**Access Areas**:
- ✅ Super Admin Portal (`/super-admin`)
- ✅ Tenant approval queue
- ✅ System configuration
- ✅ All company data (read-only for support)
- ❌ Not intended for day-to-day audit work

**Typical Users**: Platform owners, system administrators

---

### 2. ADMIN (Company Administrator)

**Description**: Company-level administrators who manage their organization within the platform.

**Scope**: Single tenant/company

**Primary Responsibilities**:
- Complete company setup and configuration
- Create and manage user accounts within the company
- Assign roles to users (Manager, Senior Auditor, Auditor, Intern)
- Manage company settings and preferences
- Configure chart of accounts
- Set up audit periods
- Manage company-wide templates
- Oversee all audit activities
- Generate company-wide reports
- Manage subscriptions and billing (future)

**Key Characteristics**:
- First user created after company approval
- Can create other admins
- Full control within their tenant
- Cannot access other companies' data

**Access Areas**:
- ✅ Admin Portal (`/admin`)
- ✅ User Management (`/admin/users`)
- ✅ Company Management (`/admin/companies`)
- ✅ All audit procedures and workpapers
- ✅ All reports and financial statements
- ✅ System settings
- ✅ Template management
- ✅ Document management
- ✅ Review queue (all pending approvals)

**Typical Users**: Firm owners, managing partners, IT administrators

---

### 3. MANAGER (Audit Manager)

**Description**: Middle management who oversee teams and review audit work.

**Scope**: Department or team level within company

**Primary Responsibilities**:
- Manage team members (Senior Auditors, Auditors, Interns)
- Assign audit procedures to team members
- Review and approve completed work
- Monitor team progress and performance
- Review findings before finalization
- Approve journal entries
- Generate team reports
- Conduct quality reviews
- Mentor senior auditors

**Key Characteristics**:
- Can view all procedures assigned to their team
- Review and approval authority
- Can reassign work
- Cannot create new users (Admin privilege)

**Access Areas**:
- ✅ Manager Portal (enhanced dashboard)
- ✅ My Work Dashboard (`/audit/my-work`)
- ✅ All audit procedures (view all, edit assigned)
- ✅ Review Queue (procedures pending review)
- ✅ Team performance reports
- ✅ Workpapers and findings (review)
- ✅ Journal entries (review and approve)
- ✅ Financial statements
- ✅ Document management
- ✅ Templates
- ⚠️ Limited user management (view only)

**Typical Users**: Audit managers, audit supervisors, senior managers

---

### 4. SENIOR_AUDITOR (Senior Auditor)

**Description**: Experienced auditors who handle complex procedures and mentor junior staff.

**Scope**: Individual contributor with elevated privileges

**Primary Responsibilities**:
- Execute complex audit procedures
- Create and manage workpapers
- Identify and document findings
- Mentor auditors and interns
- Review junior staff work (informal)
- Prepare financial statements
- Prepare journal entries
- Conduct analytical procedures
- Draft audit reports

**Key Characteristics**:
- More complex procedure assignments
- Can create templates
- Higher priority assignments
- Mentorship responsibilities

**Access Areas**:
- ✅ Auditor Workspace
- ✅ My Work Dashboard (`/audit/my-work`)
- ✅ Assigned audit procedures (full edit)
- ✅ Unassigned procedures (view)
- ✅ Kanban board
- ✅ Calendar view
- ✅ Workpapers (create, edit on assigned procedures)
- ✅ Findings (create, edit on assigned procedures)
- ✅ Documents (upload, download)
- ✅ Trial balance (view, edit)
- ✅ Journal entries (create, edit)
- ✅ Financial statements (view, generate)
- ✅ Templates (create, use)
- ✅ Reports (generate, view)
- ⚠️ Comments (on assigned procedures)

**Typical Users**: Senior auditors, audit seniors, experienced staff

---

### 5. AUDITOR (Staff Auditor)

**Description**: Primary workforce executing day-to-day audit procedures.

**Scope**: Individual contributor - standard access

**Primary Responsibilities**:
- Execute assigned audit procedures
- Create and maintain workpapers
- Document findings
- Perform testing and sampling
- Record observations
- Update trial balance
- Prepare simple journal entries
- Assist with document collection
- Update procedure status
- Collaborate with team

**Key Characteristics**:
- Most common user type
- Standard audit permissions
- Can only edit assigned work
- Limited creation permissions

**Access Areas**:
- ✅ Auditor Workspace
- ✅ My Work Dashboard (`/audit/my-work`)
- ✅ Assigned audit procedures (full edit)
- ✅ Unassigned procedures (view only)
- ✅ Kanban board (view all, edit assigned)
- ✅ Calendar view
- ✅ Workpapers (create on assigned procedures)
- ✅ Findings (create on assigned procedures)
- ✅ Documents (upload, download)
- ✅ Trial balance (view, edit with approval)
- ✅ Journal entries (create, requires approval)
- ✅ Financial statements (view only)
- ✅ Templates (use, cannot create)
- ✅ Reports (view, generate basic)
- ✅ Comments (on assigned procedures)
- ❌ Cannot assign procedures
- ❌ Cannot approve work

**Typical Users**: Staff auditors, audit associates, audit assistants

---

### 6. INTERN (Audit Intern)

**Description**: Entry-level users with limited access for learning and basic tasks.

**Scope**: Restricted access, learning mode

**Primary Responsibilities**:
- Assist with basic audit procedures
- Learn audit processes
- Perform simple data entry
- Upload documents
- Shadow senior staff
- Complete training assignments
- Basic testing (under supervision)

**Key Characteristics**:
- Most restricted permissions
- Cannot create most artifacts
- View-only on sensitive data
- Learning and observation focus

**Access Areas**:
- ✅ Auditor Workspace (limited)
- ✅ My Work Dashboard (assigned tasks only)
- ✅ Assigned procedures (edit basic fields)
- ✅ Documents (upload only)
- ✅ Comments (read and write)
- ⚠️ Workpapers (view only)
- ⚠️ Findings (view only)
- ⚠️ Trial balance (view only)
- ⚠️ Financial statements (view only)
- ⚠️ Reports (view only)
- ❌ Cannot create procedures
- ❌ Cannot create workpapers
- ❌ Cannot create findings
- ❌ Cannot create journal entries
- ❌ Cannot approve anything
- ❌ No template access

**Typical Users**: Audit interns, trainees, new hires

---

### 7. CLIENT (External User)

**Description**: External client users who interact with the audit team.

**Scope**: Client portal with restricted access

**Primary Responsibilities**:
- View audit status and progress
- Upload requested documents
- Respond to information requests
- View assigned findings (with permission)
- Download reports
- Communicate with audit team
- Track action items

**Key Characteristics**:
- Separate portal interface
- Cannot access internal audit data
- View-only on most information
- Document upload capability
- No edit permissions on audit work

**Access Areas**:
- ✅ Client Portal (`/client`)
- ✅ Document upload
- ✅ Assigned document requests
- ✅ Approved reports (view, download)
- ✅ Communication/messages
- ✅ Audit status (high-level)
- ⚠️ Findings (only if shared by auditor)
- ❌ No access to audit workspace
- ❌ No access to trial balance
- ❌ No access to workpapers
- ❌ No access to internal procedures

**Typical Users**: Client CFOs, controllers, accounting staff

---

## 🔐 Permission Matrix

### Feature Access by Role

| Feature | Super Admin | Admin | Manager | Senior Auditor | Auditor | Intern | Client |
|---------|-------------|-------|---------|----------------|---------|--------|--------|
| **User Management** |
| View all users | ✅ | ✅ | 👁️ | ❌ | ❌ | ❌ | ❌ |
| Create users | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Edit users | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Delete users | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Assign roles | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Company Management** |
| Approve companies | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Create company | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Edit company | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| View companies | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Audit Procedures** |
| View all procedures | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ❌ |
| Create procedures | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| Edit procedures | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ❌ |
| Delete procedures | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Assign procedures | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Bulk operations | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Workpapers** |
| View workpapers | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ❌ |
| Create workpapers | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Edit workpapers | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| Delete workpapers | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| **Findings** |
| View findings | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ⚠️ |
| Create findings | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Edit findings | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| Delete findings | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **Trial Balance** |
| View trial balance | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ❌ |
| Edit trial balance | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Import data | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| Export data | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| **Journal Entries** |
| View entries | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ❌ |
| Create entries | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Approve entries | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Delete entries | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Financial Statements** |
| View statements | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ⚠️ |
| Generate statements | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Export statements | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ⚠️ |
| **Documents** |
| View documents | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| Upload documents | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Download documents | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| Delete documents | ✅ | ✅ | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| **Templates** |
| View templates | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Create templates | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Edit templates | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Use templates | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| **Reports** |
| View reports | ✅ | ✅ | ✅ | ✅ | ✅ | 👁️ | ⚠️ |
| Generate reports | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Export reports | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ⚠️ |

**Legend:**
- ✅ Full access
- ⚠️ Limited access (own work only or requires approval)
- 👁️ View only
- ❌ No access

---

## 🔄 User Workflow by Role

### Super Admin Workflow

1. **Login** → Super Admin Portal
2. **Review** → Pending company registration requests
3. **Approve/Reject** → Company applications
4. **Monitor** → System health and tenant activity
5. **Support** → Assist with tenant issues

### Admin Workflow

1. **Setup** → Company structure, periods, accounts
2. **Invite** → Team members (Managers, Auditors)
3. **Assign Roles** → Based on responsibilities
4. **Create** → Procedure templates
5. **Monitor** → Overall audit progress
6. **Review** → High-level reports

### Manager Workflow

1. **Plan** → Audit engagements
2. **Assign** → Procedures to team members
3. **Monitor** → Team progress via dashboards
4. **Review** → Completed work (Review Queue)
5. **Approve** → Journal entries and findings
6. **Report** → To Admin or clients

### Senior Auditor Workflow

1. **View** → Assigned procedures (My Work)
2. **Execute** → Complex audit procedures
3. **Create** → Workpapers and findings
4. **Prepare** → Journal entries and statements
5. **Mentor** → Junior team members
6. **Submit** → For manager review

### Auditor Workflow

1. **View** → My Work Dashboard
2. **Execute** → Assigned procedures
3. **Document** → Work in workpapers
4. **Upload** → Supporting documents
5. **Create** → Findings as needed
6. **Update** → Procedure status
7. **Submit** → For review

### Intern Workflow

1. **View** → Assigned learning tasks
2. **Observe** → Audit procedures (view-only)
3. **Assist** → With data entry
4. **Upload** → Documents
5. **Learn** → Audit processes

### Client Workflow

1. **Login** → Client Portal
2. **View** → Document requests
3. **Upload** → Requested documents
4. **Check** → Audit status
5. **Review** → Shared findings (if applicable)
6. **Download** → Approved reports

---

## 🎯 Role Assignment Guidelines

### When to Assign Each Role

**ADMIN**:
- Firm owners
- Managing partners
- IT administrators
- Only 1-3 per company recommended

**MANAGER**:
- Audit managers
- Engagement partners
- Team leads
- Department supervisors

**SENIOR_AUDITOR**:
- 3+ years audit experience
- Complex procedure assignments
- Mentorship capability
- Technical specialists

**AUDITOR**:
- 0-3 years experience
- Primary audit workforce
- Standard procedure execution
- Most common role

**INTERN**:
- New hires (first 3-6 months)
- Summer interns
- Training period
- Transitional role

**CLIENT**:
- External client contacts
- Client CFO/Controller
- Client accounting staff
- Document providers

---

## 🔒 Security Considerations

### Role-Based Data Access

1. **Tenant Isolation**: All non-Super Admin roles are isolated to their tenant
2. **Resource Ownership**: Users can only edit their assigned work
3. **Hierarchical Access**: Higher roles can view subordinate work
4. **Audit Trail**: All role-based actions are logged

### Permission Enforcement

**Backend (NestJS)**:
```typescript
@Roles('ADMIN', 'MANAGER')
@UseGuards(JwtAuthGuard, RolesGuard)
async createProcedure() {
  // Only ADMIN and MANAGER can execute
}
```

**Frontend (React)**:
```typescript
{user.role === 'ADMIN' && (
  <Button onClick={createUser}>Create User</Button>
)}
```

### Permission Changes

- Role changes require Admin privileges
- Role changes logged in audit trail
- Immediate effect (no logout required)
- Email notification on role change

---

## 📧 Role-Specific Notifications

### Email Notifications by Role

**ADMIN**:
- New user registration requests
- System alerts
- Subscription updates
- Critical errors

**MANAGER**:
- Procedures pending review
- Team member updates
- Due date alerts
- Finding escalations

**SENIOR_AUDITOR & AUDITOR**:
- New procedure assignments
- Review comments
- Due date reminders
- Finding assignments

**INTERN**:
- New task assignments
- Training reminders
- Observation requests

**CLIENT**:
- Document requests
- Audit status updates
- Approved report availability

---

## 🎓 Best Practices

### Role Management

1. **Start Minimal**: Begin with AUDITOR role, promote based on performance
2. **Regular Reviews**: Quarterly role appropriateness reviews
3. **Temporary Elevation**: Use caution when temporarily elevating permissions
4. **Separation of Duties**: Don't assign conflicting roles
5. **Documentation**: Document why each role was assigned

### Security Best Practices

1. **Least Privilege**: Assign minimum necessary role
2. **Role Rotation**: Change assignments regularly
3. **Access Reviews**: Audit role usage quarterly
4. **Termination**: Immediate deactivation on employee departure
5. **Training**: Role-specific training before assignment

---

**Next Document**: Phase 4 - Authentication & User Management

**Last Updated**: December 27, 2025
