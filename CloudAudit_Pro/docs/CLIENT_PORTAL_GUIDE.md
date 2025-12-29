# Client Portal Guide

## Overview
The Client Portal provides audit clients with visibility into their audit progress, recent activities, and outstanding items. Clients can also contact their auditors directly through the portal.

## Current Registration Flow

### Standard Registration (Creates New Tenant/Company)
The current registration process is designed for audit firms/organizations setting up a new account:

1. **Step 1: Personal Information**
   - First Name, Last Name
   - Email, Password
   - Job Title, Department

2. **Step 2: Company Setup**
   - Company/Organization Name (required)
   - Subdomain (optional - auto-generated if not provided)

3. **Step 3: Review & Submit**
   - Review all information
   - Submit registration

**Note:** This flow creates a NEW tenant/company in the system.

## Client Access to Portal

### How Clients Should Access the Portal

Currently, there are **two options** for giving clients access to the audit portal:

### Option 1: User Invitation System (Recommended)
1. Audit firm creates a new company record for the client
2. Audit firm invites client users via email
3. Client users receive invitation link
4. Client users set their password and gain access
5. Client users will have LIMITED permissions (view-only for audit progress)

### Option 2: Separate Client Registration Page (To Be Implemented)
A dedicated client registration flow where:
1. Client receives a company code/invitation token from auditor
2. Client registers using the code
3. Client account is automatically linked to the auditor's company
4. Client has limited portal access

## Client Portal Features

### 1. Audit Progress Overview
- Overall completion percentage (calculated based on completed/in-progress/pending procedures)
- Statistics:
  - Completed procedures
  - In-progress procedures
  - Pending procedures
  - Issues/findings count

### 2. Recent Activities
- Latest audit procedures completed
- New findings or observations
- Document uploads/reviews
- Status changes

### 3. Outstanding Items
- Pending document requests
- Actions required from client
- Items waiting for review
- Priority levels (High/Medium/Low)

### 4. Contact Auditor
- Direct messaging to auditor team
- Message history tracking
- Notification system

## Technical Implementation

### Backend API Endpoints Used
- `GET /dashboard/company/:companyId/audit` - Audit progress and statistics
- `POST /notifications/contact-auditor` - Send message to auditor

### Data Flow
1. Client logs in with credentials
2. Frontend fetches audit overview using `companyId` from user profile
3. Dashboard service aggregates:
   - Procedure statistics
   - Recent procedures and findings
   - Pending items and document requests
4. Data is transformed and displayed in client-friendly format

### Services
- `clientPortal.service.ts` - Handles all client portal API interactions
- `ClientPortal.tsx` - Main client portal component

## User Roles and Permissions

### Client Role
- **CAN:**
  - View audit progress
  - See recent activities
  - View outstanding items
  - Contact auditor
  
- **CANNOT:**
  - Create or modify audit procedures
  - Upload audit evidence (unless specifically requested)
  - Access other companies' audits
  - Change audit status or findings

### Auditor Role
- Full access to all audit functions
- Can create and modify procedures
- Can upload evidence and documents
- Can finalize audit reports

## Recommended Improvements

1. **Implement Client-Specific Registration Flow**
   - Add invitation token system
   - Create separate registration page for clients
   - Auto-assign CLIENT role on registration

2. **Enhanced Messaging**
   - Add real-time chat functionality
   - Email notifications for messages
   - Message threading and history

3. **Document Portal**
   - Allow clients to upload requested documents
   - Document version tracking
   - Download audit reports when finalized

4. **Notifications**
   - Real-time notifications for status changes
   - Email alerts for new document requests
   - Reminder system for overdue items

## Security Considerations

1. **Access Control**
   - Clients can only access their own company data
   - All API endpoints check `companyId` against user permissions
   - Role-based access control (RBAC) enforced

2. **Data Privacy**
   - Client portal shows limited information
   - Sensitive audit details are hidden
   - Audit working papers not accessible to clients

3. **Authentication**
   - JWT token-based authentication
   - Session management
   - Password requirements enforced

## Current Status

✅ **Fully Implemented:**

### 1. Invitation System
- **Service:** `invitation.service.ts` - Complete invitation management API
- **Admin Page:** `InviteManagement.tsx` - Full UI for sending, managing, and tracking invitations
- **Features:**
  - Send invitations with email, role, and optional company
  - Track invitation status (PENDING, ACCEPTED, EXPIRED)
  - Resend and cancel invitations
  - View invitation history

### 2. Client Registration Flow
- **Page:** `ClientRegister.tsx` - Token-based registration for invited users
- **Route:** `/register/client?token=<invitation-token>`
- **Features:**
  - Validates invitation token
  - Pre-fills user information if provided
  - Auto-assigns role and company from invitation
  - Auto-login after successful registration
  - Redirects clients to `/client` portal

### 3. Enhanced Messaging System
- **Service:** `messaging.service.ts` - Full messaging API with threading
- **Page:** `Messages.tsx` - Complete messaging interface
- **Features:**
  - Conversation threads with multiple participants
  - Real-time message updates (30-second polling)
  - Message history and threading
  - Unread message tracking
  - Send/receive messages between auditors and clients
  - Message timestamps and status

### 4. Document Upload Portal
- **Page:** `ClientDocuments.tsx` - Document request and upload interface
- **Features:**
  - View document requests from auditors
  - Upload multiple files per request
  - Track upload status (PENDING, SUBMITTED, APPROVED, REJECTED)
  - Priority levels (HIGH, MEDIUM, LOW)
  - File version tracking
  - Download uploaded documents
  - Add notes with uploads

### 5. Notification System
- **Service:** `notification.service.ts` - Comprehensive notification API
- **Component:** `NotificationBell.tsx` - Bell icon with badge counter
- **Features:**
  - Real-time notifications (polling every 30 seconds)
  - Notification types: INFO, SUCCESS, WARNING, ERROR, DOCUMENT_REQUEST, AUDIT_UPDATE, MESSAGE
  - Unread count badge
  - Mark as read / Mark all as read
  - Click notification to navigate to related page
  - Notification dropdown menu

### 6. Enhanced Client Portal
- **Page:** `ClientPortal.tsx` - Upgraded with real API integration
- **Features:**
  - Real-time audit progress tracking
  - Dynamic statistics (completed, in-progress, pending, issues)
  - Recent activities feed
  - Outstanding items list
  - Quick action buttons:
    - Navigate to Messages
    - Navigate to Document Upload
    - Contact Auditor (legacy direct message)

### 7. Routes Configuration
- `/register/client?token=xxx` - Client registration with invitation
- `/client` - Client portal dashboard
- `/client/documents` - Document upload portal
- `/messages` - Messaging system
- `/admin/invitations` - Invitation management (Admin/Manager only)

## How It Works Now

### For Auditors/Administrators:

1. **Invite a Client:**
   - Navigate to `/admin/invitations`
   - Click "Send Invitation"
   - Enter email, role (CLIENT), optional name and company
   - System generates unique invitation token and sends email

2. **Track Invitations:**
   - View all sent invitations
   - See status (PENDING, ACCEPTED, EXPIRED)
   - Resend or cancel pending invitations

3. **Communicate with Clients:**
   - Navigate to `/messages`
   - Start new conversation or reply to existing threads
   - Messages organized by conversation

### For Clients:

1. **Register:**
   - Receive invitation email with link: `/register/client?token=xxx`
   - Click link, fill in name and password
   - System auto-creates account with CLIENT role
   - Auto-login and redirect to `/client` portal

2. **View Audit Progress:**
   - See real-time completion percentage
   - Track completed/in-progress/pending procedures
   - Monitor findings and issues

3. **Upload Documents:**
   - Click "Upload Documents" or navigate to `/client/documents`
   - See all document requests from auditors
   - Upload files with optional notes
   - Track submission status

4. **Communicate:**
   - Click "Messages" to access messaging system
   - View conversation threads
   - Send/receive messages with auditors
   - Get real-time notifications

## API Endpoints (Frontend Services)

### Invitation Service
- `POST /invitations` - Create new invitation
- `GET /invitations` - List all invitations
- `GET /invitations/validate/:token` - Validate invitation token
- `POST /invitations/:id/resend` - Resend invitation email
- `DELETE /invitations/:id` - Cancel invitation
- `POST /invitations/accept/:token` - Accept invitation and create account

### Messaging Service
- `POST /messages` - Send message
- `GET /messages` - List messages
- `GET /messages/threads` - List conversation threads
- `GET /messages/threads/:id` - Get specific thread
- `PATCH /messages/:id/read` - Mark message as read
- `PATCH /messages/threads/:id/read` - Mark thread as read
- `DELETE /messages/:id` - Delete message
- `GET /messages/unread-count` - Get unread count

### Notification Service
- `GET /notifications` - List notifications
- `PATCH /notifications/:id/read` - Mark as read
- `PATCH /notifications/mark-all-read` - Mark all as read
- `DELETE /notifications/:id` - Delete notification
- `GET /notifications/unread-count` - Get unread count
- `POST /notifications` - Create notification

### Client Portal Service
- `GET /dashboard/company/:companyId/audit` - Get audit overview
- `POST /notifications/contact-auditor` - Send message to auditor

### Document Service
- `GET /documents` - List documents/requests
- `POST /documents/upload` - Upload document
- `GET /documents/:id/download` - Download document

## Technical Implementation Details

### File Structure
```
frontend/src/
├── services/
│   ├── invitation.service.ts         (NEW)
│   ├── messaging.service.ts          (NEW)
│   ├── notification.service.ts       (NEW)
│   └── clientPortal.service.ts       (ENHANCED)
├── pages/
│   ├── ClientRegister.tsx            (NEW)
│   ├── Messages.tsx                  (NEW)
│   ├── admin/
│   │   └── InviteManagement.tsx      (NEW)
│   └── client/
│       ├── ClientPortal.tsx          (ENHANCED)
│       └── ClientDocuments.tsx       (NEW)
└── components/
    └── NotificationBell.tsx          (NEW)
```

### State Management
- All components use React hooks (useState, useEffect)
- Services handle API communication
- Auth context provides user information
- Real-time updates via polling (30-second intervals)

### Security
- JWT token authentication for all API calls
- Role-based access control enforced on routes
- Invitation tokens expire after set period
- CompanyId validation ensures data isolation
- Type-safe TypeScript interfaces

## Recommended Improvements

1. **WebSocket Integration** (Future Enhancement)
   - Replace polling with WebSocket for true real-time updates
   - Instant message delivery
   - Live notification push

2. **Email Notifications**
   - Send email when document is requested
   - Email alerts for new messages
   - Reminder emails for overdue items

3. **File Preview**
   - Preview documents before download
   - Support common file types (PDF, images, Excel)

4. **Advanced Search**
   - Search messages by keyword
   - Filter documents by status/date
   - Search audit activities

5. **Mobile Optimization**
   - Responsive design improvements
   - Touch-friendly interfaces
   - Mobile app (future)
