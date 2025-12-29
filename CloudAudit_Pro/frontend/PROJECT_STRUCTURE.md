# CloudAudit Pro - Frontend Project Structure

## 📁 Standard Folder Organization

This document describes the organized folder structure for the CloudAudit Pro frontend application following industry best practices.

---

## Directory Structure

```
frontend/
├── public/                      # Static assets
├── src/
│   ├── components/              # Reusable UI components
│   │   ├── admin/              # Admin-specific components
│   │   │   ├── AdminDashboard.tsx
│   │   │   ├── UserManagement.tsx
│   │   │   ├── InviteUser.tsx
│   │   │   └── PendingApprovals.tsx
│   │   ├── dialogs/            # Dialog components
│   │   │   ├── AssignmentDialog.tsx
│   │   │   └── ReviewDialog.tsx
│   │   ├── forms/              # Form components
│   │   │   ├── CommentForm.tsx
│   │   │   ├── FindingForm.tsx
│   │   │   ├── ProcedureForm.tsx
│   │   │   └── WorkpaperForm.tsx
│   │   └── Layout.tsx          # Main layout wrapper
│   │
│   ├── contexts/               # React Context providers
│   │   └── AuthContext.tsx    # Authentication context
│   │
│   ├── pages/                  # Page components (organized by feature)
│   │   ├── admin/             # Admin management pages
│   │   │   ├── AdminPortal.tsx
│   │   │   ├── Companies.tsx
│   │   │   └── Users.tsx
│   │   │
│   │   ├── audit/             # Audit workflow pages
│   │   │   ├── AuditFinalization.tsx
│   │   │   ├── CalendarView.tsx
│   │   │   ├── KanbanBoard.tsx
│   │   │   ├── MyWork.tsx
│   │   │   └── ProcedureDetails.tsx
│   │   │
│   │   ├── auditor/           # Auditor portal
│   │   │   ├── AuditProcedures.tsx
│   │   │   └── AuditorPortal.tsx
│   │   │
│   │   ├── client/            # Client portal pages
│   │   │   └── ClientPortal.tsx
│   │   │
│   │   ├── documents/         # Document management
│   │   │   └── (document-related pages)
│   │   │
│   │   ├── finance/           # Financial pages
│   │   │   ├── FinancialStatements.tsx
│   │   │   └── GeneralLedger.tsx
│   │   │
│   │   ├── master/            # Master data management
│   │   │   ├── BankMaster.tsx
│   │   │   ├── CountryMaster.tsx
│   │   │   └── CurrencyMaster.tsx
│   │   │
│   │   ├── reports/           # Reporting & analytics
│   │   │   ├── AnalyticsOverview.tsx
│   │   │   ├── DashboardBuilder.tsx
│   │   │   ├── DashboardViewer.tsx
│   │   │   ├── ReportGenerator.tsx
│   │   │   ├── ReportScheduler.tsx
│   │   │   ├── ReportsDashboard.tsx
│   │   │   ├── ReportTemplates.tsx
│   │   │   └── ReportViewer.tsx
│   │   │
│   │   ├── review/            # Review workflow
│   │   │   ├── ManagerReviewList.tsx
│   │   │   └── ReviewPointManagement.tsx
│   │   │
│   │   ├── schedules/         # Financial schedules
│   │   │   ├── EquitySchedule.tsx
│   │   │   ├── FixedAssetSchedule.tsx
│   │   │   └── LiabilitySchedule.tsx
│   │   │
│   │   ├── settings/          # Application settings
│   │   │   ├── IntegrationsManager.tsx
│   │   │   ├── SystemSettings.tsx
│   │   │   └── UserPreferences.tsx
│   │   │
│   │   ├── testing/           # Testing & compliance
│   │   │   ├── InternalControls.tsx
│   │   │   ├── SamplingPlan.tsx
│   │   │   └── SubstantiveTesting.tsx
│   │   │
│   │   ├── utilities/         # Utility pages
│   │   │   ├── DataImportExport.tsx
│   │   │   └── NotificationsCenter.tsx
│   │   │
│   │   ├── Dashboard.tsx      # Main dashboard
│   │   ├── Documents.tsx      # Documents page
│   │   ├── Login.tsx          # Login page
│   │   ├── Register.tsx       # Registration page
│   │   ├── Reports.tsx        # Reports overview
│   │   ├── Settings.tsx       # Settings overview
│   │   └── TemplateLibrary.tsx # Template library
│   │
│   ├── services/              # API services & business logic
│   │   ├── api.ts            # Main API client (axios)
│   │   ├── analytics.service.ts
│   │   ├── auditFinalizationService.ts
│   │   ├── bankService.ts
│   │   ├── countryService.ts
│   │   ├── currencyService.ts
│   │   ├── dashboards.service.ts
│   │   ├── dataTransferService.ts
│   │   ├── document.service.ts
│   │   ├── documentCollections.service.ts
│   │   ├── documentLinks.service.ts
│   │   ├── documentTemplates.service.ts
│   │   ├── equityService.ts
│   │   ├── fixedAssetService.ts
│   │   ├── integrationsService.ts
│   │   ├── internalControlsService.ts
│   │   ├── liabilityService.ts
│   │   ├── managerReviewService.ts
│   │   ├── notificationsService.ts
│   │   ├── reporting.service.ts
│   │   ├── reports.service.ts
│   │   ├── reviewPointService.ts
│   │   ├── samplingService.ts
│   │   ├── substantiveTestingService.ts
│   │   ├── superAdminService.ts
│   │   ├── systemConfigService.ts
│   │   └── userPreferencesService.ts
│   │
│   ├── types/                 # TypeScript type definitions
│   │
│   ├── App.tsx               # Root application component
│   ├── main.tsx              # Application entry point
│   ├── index.css             # Global styles
│   └── vite-env.d.ts         # Vite environment types
│
├── .env                      # Environment variables
├── Dockerfile                # Docker configuration
├── index.html                # HTML entry point
├── nginx.conf                # Nginx configuration
├── package.json              # Dependencies & scripts
├── tsconfig.json             # TypeScript configuration
├── vite.config.ts            # Vite build configuration
├── FUNCTIONALITY_AUDIT_REPORT.md  # Audit report
└── PROJECT_STRUCTURE.md      # This file
```

---

## 🎯 Organization Principles

### 1. **Feature-Based Structure**
Pages are organized by business domain/feature area:
- `admin/` - Administrative functions
- `audit/` - Audit workflow and procedures
- `finance/` - Financial data and statements
- `reports/` - Reporting and analytics
- `testing/` - Testing and compliance
- `settings/` - Application configuration
- `utilities/` - System utilities

### 2. **Component Hierarchy**
```
components/
├── admin/      # Domain-specific components (Admin)
├── dialogs/    # Modal/Dialog components
├── forms/      # Form components
└── Layout.tsx  # Global layout wrapper
```

### 3. **Service Layer**
All API communication and business logic centralized in `services/`:
- `api.ts` - Main axios client with interceptors
- Feature-specific services for domain logic
- Consistent error handling and data transformation

### 4. **Type Safety**
- TypeScript types in `types/` folder
- Interface definitions in component files
- Shared types exported from services

---

## 📦 Key Directories Explained

### `/pages`
Contains all route-level components. Each page represents a distinct URL route in the application.

**Structure:**
- Root level: Core pages (Dashboard, Login, Register, Documents, Reports)
- Subfolders: Feature-grouped pages (admin/, audit/, reports/, etc.)

### `/components`
Reusable UI components used across multiple pages.

**Categories:**
- **admin/**: Admin-specific components (UserManagement, InviteUser)
- **dialogs/**: Modal dialogs (AssignmentDialog, ReviewDialog)
- **forms/**: Form components (ProcedureForm, FindingForm)
- **Layout.tsx**: Main application layout wrapper

### `/services`
API clients and business logic layer.

**Purpose:**
- Centralize all HTTP requests
- Provide consistent error handling
- Abstract backend API details from components
- Enable easy testing and mocking

### `/contexts`
React Context providers for global state management.

**Current contexts:**
- `AuthContext` - User authentication and authorization state

---

## 🔄 Recent Cleanup Actions

### Deleted Files
- ❌ `Documents_old.tsx` - Obsolete version, replaced by new Documents.tsx
- ❌ `InternalControls.tsx` (root) - Duplicate, moved to testing/
- ❌ `SamplingPlan.tsx` (root) - Duplicate, moved to testing/
- ❌ `SubstantiveTesting.tsx` (root) - Duplicate, moved to testing/
- ❌ `AuditProcedures.tsx` (root) - Duplicate, using auditor version

### Reorganized Files

**Moved to `/pages/audit/`:**
- ✅ CalendarView.tsx
- ✅ KanbanBoard.tsx
- ✅ MyWork.tsx
- ✅ ProcedureDetails.tsx

**Moved to `/pages/finance/`:**
- ✅ GeneralLedger.tsx
- ✅ FinancialStatements.tsx

**Moved to `/pages/settings/`:**
- ✅ SystemSettings.tsx
- ✅ UserPreferences.tsx
- ✅ IntegrationsManager.tsx

**Moved to `/pages/utilities/`:**
- ✅ DataImportExport.tsx
- ✅ NotificationsCenter.tsx

**Moved to `/pages/testing/`:**
- ✅ InternalControls.tsx
- ✅ SamplingPlan.tsx
- ✅ SubstantiveTesting.tsx

### Import Path Updates
All import statements updated to reflect new folder structure:
- Updated relative paths (`../` → `../../`)
- Fixed API client imports
- Fixed component imports
- Fixed context imports

---

## 🚀 Benefits of This Structure

### 1. **Scalability**
- Easy to add new pages in appropriate feature folders
- Clear separation of concerns
- Modular architecture

### 2. **Maintainability**
- Intuitive file locations
- Reduced cognitive load
- Easier code reviews

### 3. **Developer Experience**
- Faster file discovery
- Logical grouping
- Standard patterns

### 4. **Team Collaboration**
- Clear ownership boundaries
- Parallel development without conflicts
- Consistent patterns across team

---

## 📋 Naming Conventions

### Files
- **Components**: PascalCase (e.g., `UserManagement.tsx`)
- **Services**: camelCase with .service suffix (e.g., `userManagement.service.ts`)
- **Types**: PascalCase (e.g., `User.ts`, `types.ts`)
- **Utilities**: camelCase (e.g., `formatters.ts`, `validators.ts`)

### Folders
- **Lowercase with hyphens** for multi-word names (e.g., `master-data/`)
- **Plural names** for collections (e.g., `components/`, `services/`)
- **Singular names** for feature areas (e.g., `admin/`, `audit/`)

---

## 🔗 Related Documentation

- [FUNCTIONALITY_AUDIT_REPORT.md](FUNCTIONALITY_AUDIT_REPORT.md) - Complete functionality audit
- [README.md](README.md) - Project setup and getting started
- [package.json](package.json) - Dependencies and scripts

---

## 📝 Notes

- All duplicate files have been removed
- All import paths have been updated and tested
- Structure follows React/TypeScript best practices
- Compatible with Vite build system
- Optimized for development and production builds

---

**Last Updated:** December 29, 2025  
**Maintained By:** CloudAudit Pro Development Team
