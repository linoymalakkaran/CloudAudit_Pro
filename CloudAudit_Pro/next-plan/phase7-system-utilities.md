# Phase 7: Remaining Features & System Polish
**Status**: ⏳ NOT STARTED (0%)  
**Priority**: MEDIUM-HIGH  
**Duration**: 2-3 weeks  
**Dependencies**: All previous phases

---

## Overview
Final phase completing remaining VB6 features, system utilities, integrations, and polish. Includes database backup/restore, data import/export, system configuration, user preferences, audit trails, notifications, and overall system refinement.

---

## Database Schema
### Status: ⏳ 40% COMPLETE (Some models exist, need enhancements)

### Existing Models (Need Enhancement)

1. **User** (Existing - enhance)
   - Current: Basic user info
   - **Add**: preferences (JSON), lastLoginAt, loginCount, passwordChangedAt, passwordExpiryDays, isTwoFactorEnabled, twoFactorSecret, failedLoginAttempts, lockedUntil

2. **AuditLog** (Existing - basic)
   - Current: Basic audit trail
   - **Enhance**: Add more detail fields, performance indexing

### New Models (9 models needed)

3. **SystemConfiguration** (NEW)
   - id, tenantId, configKey, configValue (JSON)
   - category, description, dataType, isEncrypted
   - updatedBy, updatedAt, createdAt

4. **UserPreference** (NEW)
   - id, userId, preferenceKey, preferenceValue (JSON)
   - category, createdAt, updatedAt

5. **Notification** (NEW)
   - id, tenantId, userId, title, message
   - notificationType, priority, status
   - actionUrl, actionText, relatedEntityType, relatedEntityId
   - readAt, dismissedAt, expiresAt
   - createdBy, createdAt

6. **NotificationTemplate** (NEW)
   - id, tenantId, templateKey, templateName
   - subject, bodyTemplate, notificationType
   - triggers (JSON - when to send), recipients (JSON - who to send to)
   - isActive, createdBy, updatedBy, createdAt, updatedAt

7. **DataImport** (NEW)
   - id, tenantId, companyId, importType
   - fileName, filePath, fileSize, status
   - totalRecords, successfulRecords, failedRecords
   - errors (JSON), mapping (JSON - field mapping)
   - importedBy, importedAt, completedAt
   - rollbackAvailable, rollbackAt

8. **DataExport** (NEW)
   - id, tenantId, companyId, exportType
   - fileName, filePath, fileSize, status
   - filters (JSON), options (JSON)
   - totalRecords, exportedBy, exportedAt, completedAt, expiresAt

9. **SystemBackup** (NEW)
   - id, tenantId, backupType, status
   - fileName, filePath, fileSize
   - includesDocuments, includesDatabase
   - startedAt, completedAt, expiresAt
   - canRestore, restoredAt, createdBy

10. **Integration** (NEW)
    - id, tenantId, integrationType, name, description
    - isActive, configuration (JSON - API keys, endpoints, etc.)
    - lastSyncAt, nextSyncAt, syncFrequency
    - status, lastError, createdBy, updatedBy, createdAt, updatedAt

11. **IntegrationLog** (NEW)
    - id, integrationId, logType, status
    - request (JSON), response (JSON), errorMessage
    - recordsProcessed, recordsFailed
    - duration, createdAt

### New Enums (13 enums)
- NotificationType (8: INFO, SUCCESS, WARNING, ERROR, REMINDER, APPROVAL_REQUEST, TASK_ASSIGNMENT, SYSTEM_ALERT)
- NotificationPriority (4: LOW, MEDIUM, HIGH, URGENT)
- NotificationStatus (4: UNREAD, READ, DISMISSED, EXPIRED)
- ImportType (10: ACCOUNTS, TRANSACTIONS, FIXED_ASSETS, LIABILITIES, EQUITY, DOCUMENTS, USERS, OPENING_BALANCES, BUDGETS, CUSTOM)
- ImportStatus (5: PENDING, PROCESSING, COMPLETED, FAILED, PARTIAL)
- ExportType (8: ACCOUNTS, TRANSACTIONS, FINANCIAL_STATEMENTS, AUDIT_TRAIL, REPORTS, DOCUMENTS, FULL_BACKUP, CUSTOM)
- ExportStatus (4: PENDING, PROCESSING, COMPLETED, FAILED)
- BackupType (4: FULL, INCREMENTAL, DOCUMENTS_ONLY, DATABASE_ONLY)
- BackupStatus (5: PENDING, IN_PROGRESS, COMPLETED, FAILED, RESTORED)
- IntegrationType (8: ACCOUNTING_SOFTWARE, ERP, BANK, EMAIL, CLOUD_STORAGE, SSO, API, WEBHOOK)
- IntegrationStatus (4: ACTIVE, INACTIVE, ERROR, SYNCING)
- LogType (4: SYNC, ERROR, WARNING, INFO)
- ConfigCategory (8: GENERAL, SECURITY, EMAIL, STORAGE, INTEGRATION, NOTIFICATION, AUDIT, PERFORMANCE)

---

## Backend Implementation
### Status: ⏳ 20% COMPLETE (User/Auth exist, need 8 new modules)

### Modules to Create/Enhance

1. **system-config/** (NEW module)
   - system-config.module.ts
   - system-config.service.ts (10 methods)
   - system-config.controller.ts
   - dto/create-config.dto.ts
   - dto/update-config.dto.ts

2. **user-preferences/** (NEW module)
   - user-preferences.module.ts
   - user-preferences.service.ts (8 methods)
   - user-preferences.controller.ts
   - dto/set-preference.dto.ts

3. **notifications/** (NEW module)
   - notifications.module.ts
   - notifications.service.ts (12 methods)
   - notifications.controller.ts
   - dto/create-notification.dto.ts
   - dto/notification-template.dto.ts
   - providers/
     - email-notification.provider.ts
     - push-notification.provider.ts
     - in-app-notification.provider.ts

4. **data-import/** (NEW module)
   - data-import.module.ts
   - data-import.service.ts (10 methods)
   - data-import.controller.ts
   - dto/import-data.dto.ts
   - importers/
     - base-importer.ts
     - accounts-importer.ts
     - transactions-importer.ts
     - fixed-assets-importer.ts
     - custom-importer.ts

5. **data-export/** (NEW module)
   - data-export.module.ts
   - data-export.service.ts (10 methods)
   - data-export.controller.ts
   - dto/export-data.dto.ts
   - exporters/
     - base-exporter.ts
     - accounts-exporter.ts
     - transactions-exporter.ts
     - financial-statements-exporter.ts
     - full-backup-exporter.ts

6. **system-backup/** (NEW module)
   - system-backup.module.ts
   - system-backup.service.ts (8 methods)
   - system-backup.controller.ts
   - dto/create-backup.dto.ts
   - dto/restore-backup.dto.ts

7. **integrations/** (NEW module)
   - integrations.module.ts
   - integrations.service.ts (15 methods)
   - integrations.controller.ts
   - dto/create-integration.dto.ts
   - dto/sync-integration.dto.ts
   - connectors/
     - base-connector.ts
     - quickbooks-connector.ts
     - xero-connector.ts
     - bank-api-connector.ts
     - google-drive-connector.ts
     - onedrive-connector.ts

8. **audit-trail/** (Enhance existing)
   - Add more detailed logging
   - Add search/filter capabilities
   - Add audit report generation

### API Endpoints (Total: ~85 endpoints)

#### System Configuration (12 endpoints)
- ❌ GET    /api/system-config - List all configurations
- ❌ GET    /api/system-config/:key - Get configuration
- ❌ POST   /api/system-config - Create configuration
- ❌ PATCH  /api/system-config/:key - Update configuration
- ❌ DELETE /api/system-config/:key - Delete configuration
- ❌ GET    /api/system-config/category/:category - Get by category
- ❌ POST   /api/system-config/bulk - Bulk update configurations
- ❌ GET    /api/system-config/export - Export configurations
- ❌ POST   /api/system-config/import - Import configurations
- ❌ POST   /api/system-config/:key/encrypt - Encrypt value
- ❌ GET    /api/system-config/defaults - Get default configurations
- ❌ POST   /api/system-config/reset - Reset to defaults

#### User Preferences (8 endpoints)
- ❌ GET    /api/user-preferences - Get all user preferences
- ❌ GET    /api/user-preferences/:key - Get specific preference
- ❌ POST   /api/user-preferences - Set preference
- ❌ PATCH  /api/user-preferences/:key - Update preference
- ❌ DELETE /api/user-preferences/:key - Delete preference
- ❌ POST   /api/user-preferences/bulk - Bulk set preferences
- ❌ GET    /api/user-preferences/defaults - Get default preferences
- ❌ POST   /api/user-preferences/reset - Reset to defaults

#### Notifications (15 endpoints)
- ❌ GET    /api/notifications - List notifications (paginated)
- ❌ GET    /api/notifications/:id - Get notification
- ❌ POST   /api/notifications - Create notification
- ❌ PATCH  /api/notifications/:id - Update notification
- ❌ DELETE /api/notifications/:id - Delete notification
- ❌ GET    /api/notifications/unread - Get unread notifications
- ❌ GET    /api/notifications/unread-count - Get unread count
- ❌ POST   /api/notifications/:id/read - Mark as read
- ❌ POST   /api/notifications/:id/dismiss - Dismiss notification
- ❌ POST   /api/notifications/mark-all-read - Mark all as read
- ❌ POST   /api/notifications/bulk-dismiss - Bulk dismiss
- ❌ GET    /api/notifications/templates - List templates
- ❌ POST   /api/notifications/templates - Create template
- ❌ PATCH  /api/notifications/templates/:id - Update template
- ❌ DELETE /api/notifications/templates/:id - Delete template

#### Data Import (12 endpoints)
- ❌ GET    /api/data-import - List imports
- ❌ GET    /api/data-import/:id - Get import
- ❌ POST   /api/data-import - Upload import file
- ❌ POST   /api/data-import/:id/validate - Validate import data
- ❌ POST   /api/data-import/:id/process - Process import
- ❌ POST   /api/data-import/:id/rollback - Rollback import
- ❌ GET    /api/data-import/:id/errors - Get import errors
- ❌ GET    /api/data-import/:id/download-errors - Download errors CSV
- ❌ GET    /api/data-import/templates - Get import templates
- ❌ GET    /api/data-import/templates/:type - Download template
- ❌ DELETE /api/data-import/:id - Delete import
- ❌ GET    /api/data-import/summary - Import summary

#### Data Export (10 endpoints)
- ❌ GET    /api/data-export - List exports
- ❌ GET    /api/data-export/:id - Get export
- ❌ POST   /api/data-export - Create export
- ❌ POST   /api/data-export/:id/process - Process export
- ❌ GET    /api/data-export/:id/download - Download export file
- ❌ DELETE /api/data-export/:id - Delete export
- ❌ GET    /api/data-export/summary - Export summary
- ❌ GET    /api/data-export/types - Available export types
- ❌ POST   /api/data-export/quick - Quick export
- ❌ POST   /api/data-export/schedule - Schedule export

#### System Backup (10 endpoints)
- ❌ GET    /api/system-backup - List backups
- ❌ GET    /api/system-backup/:id - Get backup
- ❌ POST   /api/system-backup - Create backup
- ❌ POST   /api/system-backup/:id/restore - Restore backup
- ❌ DELETE /api/system-backup/:id - Delete backup
- ❌ GET    /api/system-backup/:id/download - Download backup
- ❌ POST   /api/system-backup/schedule - Schedule backup
- ❌ GET    /api/system-backup/schedule - Get backup schedule
- ❌ PATCH  /api/system-backup/schedule/:id - Update schedule
- ❌ DELETE /api/system-backup/schedule/:id - Delete schedule

#### Integrations (18 endpoints)
- ❌ GET    /api/integrations - List integrations
- ❌ GET    /api/integrations/:id - Get integration
- ❌ POST   /api/integrations - Create integration
- ❌ PATCH  /api/integrations/:id - Update integration
- ❌ DELETE /api/integrations/:id - Delete integration
- ❌ POST   /api/integrations/:id/activate - Activate integration
- ❌ POST   /api/integrations/:id/deactivate - Deactivate integration
- ❌ POST   /api/integrations/:id/test - Test connection
- ❌ POST   /api/integrations/:id/sync - Trigger sync
- ❌ GET    /api/integrations/:id/logs - Get sync logs
- ❌ GET    /api/integrations/:id/status - Get sync status
- ❌ GET    /api/integrations/types - Available integration types
- ❌ GET    /api/integrations/connectors - Available connectors
- ❌ POST   /api/integrations/:id/oauth - OAuth flow
- ❌ POST   /api/integrations/:id/oauth/callback - OAuth callback
- ❌ GET    /api/integrations/:id/data-preview - Preview data from integration
- ❌ POST   /api/integrations/:id/import - Import from integration
- ❌ POST   /api/integrations/:id/export - Export to integration

---

## Frontend Implementation
### Status: ⏳ 15% COMPLETE (User management exists, need 10+ new pages)

### Required Frontend Pages (12 new pages)

#### 1. System Configuration ❌ NOT STARTED
**Location**: `frontend/src/pages/admin/SystemConfiguration.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH (Admin feature)  
**Effort**: 10-12 hours

**Required Features**:
1. **Configuration Categories Tabs**:
   - General settings
   - Security settings
   - Email settings
   - Storage settings
   - Integration settings
   - Notification settings
   - Audit settings
   - Performance settings

2. **General Settings**:
   - Company name/logo
   - Default currency
   - Default timezone
   - Date format
   - Number format
   - Fiscal year settings
   - Multi-tenant mode

3. **Security Settings**:
   - Password policy (min length, complexity, expiry)
   - Two-factor authentication (enable/disable)
   - Session timeout
   - Failed login attempts limit
   - IP whitelist
   - SSL enforcement

4. **Email Settings**:
   - SMTP server configuration
   - From email/name
   - Test email button
   - Email templates configuration

5. **Storage Settings**:
   - Document storage location
   - Max upload size
   - Allowed file types
   - Cloud storage configuration (AWS S3/Azure Blob)

6. **Configuration Actions**:
   - Save button
   - Reset to defaults button
   - Export configurations
   - Import configurations

#### 2. User Preferences (Enhanced User Profile) ⏳ EXISTS BUT NEEDS ENHANCEMENT
**Location**: `frontend/src/pages/user/UserProfile.tsx`  
**Status**: ⏳ EXISTS BUT NEEDS ENHANCEMENT  
**Effort**: 6-8 hours

**Add to existing profile**:
1. **Appearance Preferences**:
   - Theme (light/dark/auto)
   - Primary color
   - Font size
   - Compact mode

2. **Dashboard Preferences**:
   - Default dashboard
   - Default landing page
   - Show/hide widgets

3. **Notification Preferences**:
   - Enable/disable notification types
   - Email notifications
   - Push notifications
   - In-app notifications
   - Notification frequency

4. **Regional Preferences**:
   - Language
   - Timezone
   - Date format
   - Number format
   - Currency

5. **Other Preferences**:
   - Default company
   - Default period
   - Rows per page
   - Auto-save interval

#### 3. Notifications Center ❌ NOT STARTED
**Location**: `frontend/src/pages/notifications/NotificationsCenter.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH  
**Effort**: 10-12 hours

**Required Features**:
1. **Notifications List**:
   - All notifications (paginated)
   - Filter by type (8 types)
   - Filter by priority (4 levels)
   - Filter by status (4 statuses)
   - Search notifications
   - Color-coded by type/priority

2. **Notification Item**:
   - Icon (type-based)
   - Title and message
   - Timestamp (relative)
   - Action button (if applicable)
   - Mark as read button
   - Dismiss button

3. **Bulk Actions**:
   - Select multiple notifications
   - Mark all as read
   - Bulk dismiss
   - Delete all dismissed

4. **Notification Badge** (Header component):
   - Unread count badge
   - Dropdown with recent notifications
   - "View all" link to NotificationsCenter

5. **Notification Templates Admin** (Admin only):
   - List templates
   - Create/edit templates
   - Template variables
   - Test template

#### 4. Data Import Wizard ❌ NOT STARTED
**Location**: `frontend/src/pages/utilities/DataImport.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: MEDIUM  
**Effort**: 12-16 hours

**Required Features**:
1. **Import Type Selection**:
   - Import type cards (10 types)
   - Type descriptions
   - Download template button per type

2. **File Upload**:
   - Drag-drop file upload
   - Supported formats: CSV, Excel, JSON
   - File validation
   - Progress indicator

3. **Data Preview & Mapping**:
   - Preview uploaded data (first 10 rows)
   - Field mapping interface
     * Source columns → Target fields
     * Auto-mapping suggestions
     * Manual mapping
   - Data type validation
   - Required field check

4. **Validation Results**:
   - Validation success/error summary
   - Error list with row numbers
   - Download errors CSV
   - Fix and re-upload option
   - Proceed despite warnings option

5. **Import Confirmation**:
   - Import summary (total records, valid, invalid)
   - Import options (skip duplicates, update existing, etc.)
   - Process import button

6. **Import Progress**:
   - Progress bar
   - Records processed / total
   - Success/failure counts
   - Cancel button

7. **Import Results**:
   - Success/failure summary
   - View imported records
   - View errors
   - Rollback button (if available)

8. **Import History**:
   - Past imports list
   - Status, date, records count
   - View details
   - Rollback option
   - Delete import

#### 5. Data Export Manager ❌ NOT STARTED
**Location**: `frontend/src/pages/utilities/DataExport.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: MEDIUM  
**Effort**: 10-12 hours

**Required Features**:
1. **Export Type Selection**:
   - Export type cards (8 types)
   - Type descriptions
   - Quick export button

2. **Export Configuration**:
   - Select export type
   - Select data range (company, period, date range)
   - Select filters
   - Select export format (CSV, Excel, JSON, PDF)
   - Select columns/fields
   - Options (include headers, formatting, etc.)

3. **Export Preview**:
   - Preview export data (first 10 rows)
   - Record count
   - Export button

4. **Export Progress**:
   - Progress indicator
   - Records exported / total
   - Cancel button

5. **Export Results**:
   - Success summary
   - Download button
   - File size
   - Expiry info
   - Delete button

6. **Export History**:
   - Past exports list
   - Status, date, type, records count
   - Download button
   - Delete button
   - Expired indicator

#### 6. Backup & Restore Manager ❌ NOT STARTED
**Location**: `frontend/src/pages/admin/BackupRestore.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: CRITICAL (Admin feature)  
**Effort**: 12-16 hours

**Required Features**:
1. **Backup List**:
   - All backups DataGrid
   - Columns: Date, Type, Size, Status, Can Restore
   - Filter by type (4 types)
   - Filter by status (5 statuses)
   - Search backups

2. **Create Backup Dialog**:
   - Backup type selector (4 types)
   - Description input
   - Include options:
     * Include database (checkbox)
     * Include documents (checkbox)
   - Start backup button

3. **Backup Progress**:
   - Progress bar
   - Status updates
   - Cancel button
   - Estimated time remaining

4. **Backup Actions**:
   - Download backup
   - Restore backup (with confirmation)
   - Delete backup
   - View backup details

5. **Restore Confirmation Dialog**:
   - Warning message
   - Backup details
   - Current system state
   - Create pre-restore backup checkbox
   - Confirm button

6. **Restore Progress**:
   - Progress indicator
   - Status updates
   - Cannot cancel (irreversible)

7. **Backup Schedule**:
   - Scheduled backups list
   - Create schedule button
   - Schedule details (frequency, time, type)
   - Enable/disable schedule
   - Edit/delete schedule

#### 7. Integrations Manager ❌ NOT STARTED
**Location**: `frontend/src/pages/admin/Integrations.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH  
**Effort**: 14-18 hours

**Required Features**:
1. **Integrations List**:
   - Integration cards (visual)
   - Integration type icons
   - Status indicators (active/inactive/error)
   - Last sync time
   - Add integration button

2. **Integration Types**:
   - Accounting Software (QuickBooks, Xero, Sage, etc.)
   - ERP Systems
   - Bank APIs
   - Email (Gmail, Outlook, SendGrid)
   - Cloud Storage (Google Drive, OneDrive, Dropbox)
   - SSO (SAML, OAuth)
   - Custom API
   - Webhooks

3. **Add Integration Wizard**:
   - Step 1: Select integration type
   - Step 2: Configuration
     * Integration name
     * API keys/credentials
     * OAuth flow (if applicable)
     * Endpoint URLs
     * Test connection button
   - Step 3: Sync options
     * Sync frequency
     * Auto-sync enable/disable
     * Data mapping
   - Step 4: Review & Save

4. **Integration Details Page**:
   - Integration info
   - Configuration (editable)
   - Status and last sync
   - Sync logs (recent 50)
   - Sync now button
   - Test connection button
   - Data preview
   - Import/export buttons

5. **Sync Logs**:
   - Log entries list
   - Type (sync/error/warning/info)
   - Timestamp
   - Status
   - Records processed/failed
   - Error message
   - View details

6. **Integration Actions**:
   - Edit configuration
   - Activate/deactivate
   - Sync now
   - Test connection
   - View logs
   - Delete integration

#### 8. Audit Trail Viewer (Enhanced) ⏳ EXISTS BUT NEEDS ENHANCEMENT
**Location**: `frontend/src/pages/admin/AuditTrail.tsx`  
**Status**: ⏳ EXISTS BUT NEEDS ENHANCEMENT  
**Effort**: 6-8 hours

**Add to existing**:
1. **Enhanced Filtering**:
   - Date range picker
   - User filter
   - Entity type filter
   - Action type filter
   - Search by entity ID
   - Changes filter (has changes/no changes)

2. **Audit Log Details**:
   - Expandable rows
   - Show before/after values
   - Color-coded changes (added/modified/deleted)
   - IP address
   - User agent

3. **Audit Reports**:
   - Export audit log (CSV, Excel, PDF)
   - User activity report
   - Entity history report
   - Changes summary report

4. **Retention Policy** (Admin):
   - Set retention period
   - Auto-archive old logs
   - Delete archived logs

#### 9. Database Utilities ❌ NOT STARTED
**Location**: `frontend/src/pages/admin/DatabaseUtilities.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: MEDIUM (Admin feature)  
**Effort**: 8-10 hours

**Required Features**:
1. **Database Information**:
   - Database size
   - Table count
   - Record counts per table
   - Last backup date
   - Database version

2. **Maintenance Tasks**:
   - Vacuum database
   - Analyze database
   - Reindex database
   - Check database integrity
   - Repair database (if issues found)

3. **Data Cleanup**:
   - Delete old audit logs
   - Delete old notifications
   - Delete expired exports
   - Delete old backups
   - Archive old data

4. **Performance Monitoring**:
   - Slow query log
   - Connection pool status
   - Cache hit ratio
   - Index usage statistics

#### 10. Change Password ✅ EXISTS
**Location**: `frontend/src/pages/user/ChangePassword.tsx`  
**Status**: ✅ EXISTS (migrated from VB6)

#### 11. About & System Info ❌ NOT STARTED
**Location**: `frontend/src/pages/help/About.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: LOW  
**Effort**: 4-6 hours

**Required Features**:
1. **Application Info**:
   - Application name and logo
   - Version number
   - Build date
   - Copyright notice
   - License information

2. **System Information**:
   - Backend version
   - Database version
   - Node.js version
   - Browser information
   - Operating system

3. **Credits**:
   - Development team
   - Third-party libraries
   - Open-source licenses

4. **Support**:
   - Support email
   - Documentation link
   - Release notes link
   - Report bug button

#### 12. Help & Documentation ❌ NOT STARTED
**Location**: `frontend/src/pages/help/HelpCenter.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: LOW  
**Effort**: 8-10 hours

**Required Features**:
1. **Help Topics**:
   - Getting started
   - User guides (by module)
   - Video tutorials
   - FAQs
   - Troubleshooting

2. **Search**:
   - Search help articles
   - Search results with relevance

3. **Context-Sensitive Help**:
   - Help button on each page
   - Opens relevant help article

4. **Contact Support**:
   - Support ticket form
   - Chat support (if available)

---

### Required Frontend Services (7 new services)

#### 1. System Config Service ❌ NOT STARTED
**Location**: `frontend/src/services/systemConfigService.ts`  
**Effort**: 2 hours

#### 2. User Preferences Service ❌ NOT STARTED
**Location**: `frontend/src/services/userPreferencesService.ts`  
**Effort**: 1-2 hours

#### 3. Notifications Service ❌ NOT STARTED
**Location**: `frontend/src/services/notificationsService.ts`  
**Effort**: 2-3 hours

#### 4. Data Import Service ❌ NOT STARTED
**Location**: `frontend/src/services/dataImportService.ts`  
**Effort**: 2-3 hours

#### 5. Data Export Service ❌ NOT STARTED
**Location**: `frontend/src/services/dataExportService.ts`  
**Effort**: 2 hours

#### 6. System Backup Service ❌ NOT STARTED
**Location**: `frontend/src/services/systemBackupService.ts`  
**Effort**: 2-3 hours

#### 7. Integrations Service ❌ NOT STARTED
**Location**: `frontend/src/services/integrationsService.ts`  
**Effort**: 3-4 hours

---

## VB6 Forms Migrated (15+ forms)
- ✅ frmChangePassword.frm → ChangePassword.tsx (EXISTS)
- ✅ frmConnection.frm → SystemConfiguration.tsx (DB connection)
- ✅ frmBackupData.frm → BackupRestore.tsx
- ✅ frmDetachAttach.frm → BackupRestore.tsx
- ✅ frmDetachNAttach.frm → BackupRestore.tsx
- ✅ frmDetachNBackup.frm → BackupRestore.tsx
- ✅ frmDettachDataBase.frm → BackupRestore.tsx
- ✅ frmConvertWizard.frm → DataImport.tsx
- ✅ frmUpgradeDatabase.cls → DatabaseUtilities.tsx

**Enhancements over VB6**:
- Cloud-based backup
- Automated scheduling
- Real-time notifications
- Modern integrations (OAuth, REST APIs)
- User preferences persistence
- Advanced audit trail
- Better import/export formats
- Modern UI/UX

---

## Testing Checklist

### Database Testing
- [ ] All 11 models created/enhanced
- [ ] All 13 enums created
- [ ] Data relationships correct
- [ ] Migrations successful

### Backend Testing
- [ ] 85 API endpoints functional
- [ ] Configuration management
- [ ] User preferences
- [ ] Notifications delivery
- [ ] Import/export working
- [ ] Backup/restore working
- [ ] Integrations working
- [ ] Audit trail comprehensive

### Frontend Testing
- [ ] 12 pages complete
- [ ] 7 services complete
- [ ] System configuration UI
- [ ] User preferences UI
- [ ] Notifications center
- [ ] Import wizard functional
- [ ] Export manager functional
- [ ] Backup/restore UI
- [ ] Integrations manager
- [ ] All workflows complete

### Integration Testing
- [ ] End-to-end workflows
- [ ] Third-party integrations
- [ ] OAuth flows
- [ ] Email delivery
- [ ] Backup/restore process
- [ ] Import/export accuracy
- [ ] Notification triggers
- [ ] Performance

---

## Acceptance Criteria

### Database Criteria
- [ ] All models in schema
- [ ] All enums defined
- [ ] Relations configured
- [ ] Migrations successful

### Backend Criteria
- [ ] 85 API endpoints functional
- [ ] Configuration management working
- [ ] Notifications working
- [ ] Import/export working
- [ ] Backup/restore working
- [ ] Integrations framework working
- [ ] Audit trail comprehensive
- [ ] Performance optimized

### Frontend Criteria
- [ ] 12 pages complete
- [ ] 7 services complete
- [ ] All utilities functional
- [ ] Admin features complete
- [ ] User features complete
- [ ] Help/documentation complete
- [ ] Responsive design
- [ ] Accessibility

---

## Implementation Plan

### Week 1: Configuration & Preferences
**Days 1-2: Database & Backend (16 hours)**
- Create system-config module (8 hours)
- Create user-preferences module (4 hours)
- Create notifications module (4 hours)

**Days 3-5: Frontend (20 hours)**
- SystemConfiguration.tsx (10 hours)
- Enhance UserProfile.tsx (6 hours)
- NotificationsCenter.tsx (10 hours)
- Create 3 services (4 hours)

### Week 2: Import/Export & Backup
**Days 1-2: Backend (16 hours)**
- Create data-import module (6 hours)
- Create data-export module (5 hours)
- Create system-backup module (5 hours)

**Days 3-5: Frontend (24 hours)**
- DataImport.tsx (12 hours)
- DataExport.tsx (10 hours)
- BackupRestore.tsx (12 hours)
- Create 3 services (6 hours)

### Week 3: Integrations & Polish
**Days 1-3: Integrations (24 hours)**
- Create integrations module (12 hours)
- Integrations.tsx (14 hours)
- Create integrationsService (3 hours)

**Days 4-5: Remaining Pages (16 hours)**
- Enhance AuditTrail.tsx (6 hours)
- DatabaseUtilities.tsx (8 hours)
- About.tsx (4 hours)
- HelpCenter.tsx (8 hours)

### Final: Integration & Testing (12 hours)
- Add all routes
- Integration testing
- End-to-end testing
- Bug fixes
- Documentation
- Final polish

**Total Estimated Effort**: 120-140 hours (3 weeks full-time or 4-5 weeks part-time)

---

## Related Files

### Backend
- `backend/src/system-config/` (create) ❌
- `backend/src/user-preferences/` (create) ❌
- `backend/src/notifications/` (create) ❌
- `backend/src/data-import/` (create) ❌
- `backend/src/data-export/` (create) ❌
- `backend/src/system-backup/` (create) ❌
- `backend/src/integrations/` (create) ❌
- `backend/src/audit-trail/` (enhance) ⏳
- `backend/src/users/` (enhance) ⏳

### Frontend
- `frontend/src/pages/admin/SystemConfiguration.tsx` (create) ❌
- `frontend/src/pages/user/UserProfile.tsx` (enhance) ⏳
- `frontend/src/pages/notifications/NotificationsCenter.tsx` (create) ❌
- `frontend/src/pages/utilities/DataImport.tsx` (create) ❌
- `frontend/src/pages/utilities/DataExport.tsx` (create) ❌
- `frontend/src/pages/admin/BackupRestore.tsx` (create) ❌
- `frontend/src/pages/admin/Integrations.tsx` (create) ❌
- `frontend/src/pages/admin/AuditTrail.tsx` (enhance) ⏳
- `frontend/src/pages/admin/DatabaseUtilities.tsx` (create) ❌
- `frontend/src/pages/help/About.tsx` (create) ❌
- `frontend/src/pages/help/HelpCenter.tsx` (create) ❌
- `frontend/src/services/` (7 new services) ❌

---

## Phase 7 Status
⏳ **20% COMPLETE**
- ⏳ Database: 40% (User/AuditLog exist, need 9 models)
- ⏳ Backend: 20% (User/Auth exist, need 8 modules)
- ⏳ Frontend: 15% (ChangePassword exists, need 11 pages)
- ❌ Integration: 0% (all pending)

**Note**: This phase completes the migration and adds essential system utilities. Consider as final phase before production deployment.

---

**Last Updated**: December 28, 2025  
**ETA**: 3 weeks full-time or 4-5 weeks part-time (120-140 hours)
