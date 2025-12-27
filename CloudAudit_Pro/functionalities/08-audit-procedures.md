# CloudAudit Pro - Audit Procedures

## 📋 Overview

Audit Procedures are the heart of CloudAudit Pro - they represent the individual tasks and tests that auditors perform during an engagement. The system provides comprehensive functionality for creating, assigning, tracking, and completing audit procedures throughout the audit lifecycle.

---

## 🎯 What is an Audit Procedure?

An Audit Procedure is a specific task or test performed by an auditor to gather audit evidence. Examples include:
- Testing a sample of sales transactions
- Performing analytical procedures on revenue
- Confirming accounts receivable with customers
- Inspecting fixed asset additions
- Reviewing journal entries for appropriateness

Each procedure in CloudAudit Pro contains:
- **Identification**: Name, description, category
- **Assignment**: Who is responsible, due date
- **Status**: Current progress state
- **Priority**: Urgency level
- **Risk**: Risk assessment
- **Links**: Connected workpapers, findings, documents

---

## 📊 Procedure Data Model

```typescript
interface AuditProcedure {
  id: string;                    // Unique identifier
  name: string;                  // Procedure name
  description?: string;          // Detailed description
  category: string;              // Procedure category
  
  // Status tracking
  status: ProcedureStatus;       // Current status
  reviewStatus: ReviewStatus;    // Review state
  completionDate?: Date;         // When completed
  
  // Priority and risk
  priority: Priority;            // Urgency level
  riskLevel: RiskLevel;          // Risk assessment
  
  // Assignment
  assignedTo?: User;             // Assigned auditor
  assignedBy?: User;             // Who assigned
  assignedAt?: Date;             // Assignment timestamp
  dueDate?: Date;                // Completion deadline
  
  // Context
  company: Company;              // Client company
  period: Period;                // Audit period
  
  // Relationships
  workpapers: Workpaper[];       // Linked workpapers
  findings: Finding[];           // Identified findings
  comments: Comment[];           // Collaboration comments
  documents: Document[];         // Attached files
  template?: ProcedureTemplate;  // Source template
  
  // Metrics
  estimatedHours?: number;       // Time estimate
  actualHours?: number;          // Time spent
  
  // Audit trail
  createdAt: Date;
  createdBy: User;
  updatedAt: Date;
  updatedBy?: User;
}
```

---

## 🔄 Status Lifecycle

### Status States

```
NOT_STARTED (Gray)
    ↓
IN_PROGRESS (Blue)
    ↓
REVIEW_REQUIRED (Orange)
    ↓
COMPLETED (Green)
```

Additional states:
- **ON_HOLD** (Yellow): Temporarily paused
- **CANCELLED** (Red): No longer needed

### Status Transitions

| From | To | Triggered By | Permission |
|------|----|--------------| -----------|
| NOT_STARTED | IN_PROGRESS | Auditor starts work | Assigned auditor |
| IN_PROGRESS | REVIEW_REQUIRED | Work completed | Assigned auditor |
| REVIEW_REQUIRED | COMPLETED | Approved by reviewer | Manager/Admin |
| REVIEW_REQUIRED | IN_PROGRESS | Rejected, needs rework | Manager/Admin |
| IN_PROGRESS | ON_HOLD | External dependency | Manager/Admin |
| ON_HOLD | IN_PROGRESS | Dependency resolved | Manager/Admin |
| ANY | CANCELLED | No longer needed | Manager/Admin |

### Status Change Rules

- Auditor can move: NOT_STARTED → IN_PROGRESS → REVIEW_REQUIRED
- Manager can move: ANY → ANY
- Status changes are logged in audit trail
- Email notifications sent on status changes
- Cannot move to COMPLETED without Manager approval

---

## ⚡ Priority Levels

### Priority Definitions

**URGENT** (Red 🔴)
- Immediate attention required
- Critical path item
- Regulatory deadline approaching
- Example: SEC filing deadline in 2 days

**HIGH** (Orange 🟠)
- Important but not immediate
- Key audit area
- Due within 1 week
- Example: Revenue testing for material account

**MEDIUM** (Blue 🔵)
- Standard priority
- Regular timeline
- Due within 2-4 weeks
- Example: Standard expense testing

**LOW** (Green 🟢)
- Can be deferred
- Non-critical area
- Flexible timeline
- Example: Petty cash testing

### Priority Impact

- Urgent procedures appear at top of lists
- Email notifications more frequent for urgent items
- Kanban board sorts by priority
- Dashboard highlights overdue urgent items
- Managers get alerts for overdue high/urgent procedures

---

## 🎨 Risk Levels

### Risk Assessment

**CRITICAL**
- Material account
- High inherent risk
- Complex transactions
- Significant judgments
- Example: Revenue recognition

**HIGH**
- Potentially material
- Elevated risk factors
- Requires senior auditor
- Example: Inventory valuation

**MEDIUM**
- Standard risk
- Routine audit area
- Normal testing
- Example: Prepaid expenses

**LOW**
- Immaterial account
- Low risk area
- Basic testing
- Example: Office supplies

### Risk-Based Assignment

- Critical/High risk → Senior Auditors
- Medium risk → Staff Auditors
- Low risk → Interns (supervised)

---

## 👥 Assignment System

### Assignment Process

1. **Manager assigns procedure**
   ```typescript
   POST /api/audit-procedures/:id/assign
   {
     "assignedTo": "user-id-123",
     "dueDate": "2025-12-31T23:59:59Z",
     "notes": "Please complete by year-end"
   }
   ```

2. **System actions**:
   - Updates assignedTo field
   - Sets assignedAt timestamp
   - Records assignedBy
   - Sends email notification to assignee
   - Logs in audit trail
   - Updates dashboard counts

3. **Assignee receives**:
   - Email notification
   - Dashboard update
   - "My Work" shows new procedure
   - Calendar event created

### Reassignment

Managers can reassign procedures:
- Original assignee notified
- New assignee notified
- Reason logged
- Work history preserved

### Delegation

Senior auditors can delegate to juniors (with manager approval):
- Original assignee remains responsible
- Delegate does the work
- Senior reviews before submission

---

## 📝 Creating Procedures

### Manual Creation

**From Procedure List Page**:

1. Click "New Procedure" button
2. Fill in details:
   - **Name**: Clear, descriptive title
   - **Description**: Detailed instructions
   - **Category**: Select from list
   - **Company**: Select client
   - **Period**: Select audit period
   - **Priority**: Assign priority level
   - **Risk Level**: Assess risk
   - **Due Date**: Set deadline
   - **Estimated Hours**: Time budget
   - **Assign To**: Select auditor
3. Click "Create Procedure"

**API Endpoint**:
```typescript
POST /api/audit-procedures

Request:
{
  "name": "Test Revenue Transactions",
  "description": "Select sample of 25 revenue transactions...",
  "category": "REVENUE",
  "companyId": "company-123",
  "periodId": "period-456",
  "priority": "HIGH",
  "riskLevel": "CRITICAL",
  "dueDate": "2025-12-31",
  "estimatedHours": 8,
  "assignedTo": "user-789"
}

Response:
{
  "id": "proc-xyz",
  "name": "Test Revenue Transactions",
  "status": "NOT_STARTED",
  ...
}
```

### From Templates

**Using Procedure Templates**:

1. Navigate to Template Library
2. Browse or search templates
3. Select template
4. Click "Create from Template"
5. System pre-fills:
   - Name, description
   - Category
   - Risk level
   - Estimated hours
   - Standard procedures
6. Customize as needed
7. Assign and save

**Benefits**:
- ✅ Consistency across engagements
- ✅ Faster procedure creation
- ✅ Best practices built-in
- ✅ Less training needed

---

## 🔄 Bulk Operations

### Bulk Selection

**Multi-Select Interface**:
- Checkbox in table header (select all)
- Checkbox per row (select individual)
- Selected count displayed
- Bulk action toolbar appears

**Bulk Actions Available**:
1. Bulk Assign
2. Bulk Status Update
3. Bulk Delete

### 1. Bulk Assign

**Purpose**: Assign multiple procedures to one user at once

**Workflow**:
1. Select procedures using checkboxes
2. Click "Bulk Assign" button
3. Dialog opens:
   - Select assignee from dropdown
   - Set optional due date
   - Add notes
4. Click "Assign"
5. System updates all selected procedures
6. Email sent to assignee (one email listing all)

**API Endpoint**:
```typescript
POST /api/audit-procedures/bulk-assign

Request:
{
  "procedureIds": ["proc-1", "proc-2", "proc-3"],
  "assignedTo": "user-123",
  "dueDate": "2025-12-31",
  "notes": "Please prioritize these"
}

Response:
{
  "updated": 3,
  "failed": 0,
  "message": "Successfully assigned 3 procedures"
}
```

**Use Cases**:
- Assigning audit program to new team member
- Reallocating work due to staff change
- Distributing workload at engagement start

### 2. Bulk Status Update

**Purpose**: Change status of multiple procedures simultaneously

**Workflow**:
1. Select procedures
2. Click "Bulk Status Update"
3. Choose new status from dropdown
4. Confirm action
5. System updates all selected
6. Notifications sent as appropriate

**Restrictions**:
- Can only bulk update to same status
- Status transition rules still apply
- Manager permission required for most transitions
- Cannot bulk complete (must approve individually)

### 3. Bulk Delete

**Purpose**: Remove multiple obsolete procedures

**Workflow**:
1. Select procedures to delete
2. Click "Bulk Delete" button
3. Confirmation dialog appears
4. Type confirmation phrase
5. Click "Delete Permanently"
6. Procedures deleted with audit log

**Safety Features**:
- ⚠️ Cannot delete if has workpapers
- ⚠️ Cannot delete if completed
- ⚠️ Requires Manager/Admin role
- ⚠️ Confirmation required
- ✅ Audit trail logged

---

## 💬 Comments & Collaboration

### Comment System

**Purpose**: Team communication within procedure context

**Features**:
- Threaded discussions
- @mentions for notifications
- Rich text formatting
- File attachments
- Edit/delete own comments
- Real-time updates

**Comment Types**:
- General notes
- Questions
- Review comments
- Status updates
- Instructions

**API Endpoints**:
```typescript
// List comments
GET /api/audit-procedures/:id/comments

// Add comment
POST /api/audit-procedures/:id/comments
{
  "content": "Please review the client calculations",
  "mentions": ["user-123"],
  "attachments": ["file-xyz"]
}

// Update comment
PATCH /api/comments/:commentId
{
  "content": "Updated instructions..."
}

// Delete comment
DELETE /api/comments/:commentId
```

### Workflow Action Endpoints

CloudAudit Pro provides specialized endpoints for common workflow actions:

#### Start Procedure
```typescript
POST /api/audit-procedures/:id/start

// Marks procedure as IN_PROGRESS and sets start date
// Automatically fills startDate field
// Updates procedure status
// Sends notifications to relevant parties

Response:
{
  "id": "proc-123",
  "status": "IN_PROGRESS",
  "startDate": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-15T10:30:00Z"
}
```

#### Complete Procedure
```typescript
POST /api/audit-procedures/:id/complete

// Marks procedure as COMPLETED and sets completion date
// Automatically fills completedDate field
// Triggers completion workflow
// Sends notifications to managers

Response:
{
  "id": "proc-123",
  "status": "COMPLETED",
  "completedDate": "2025-01-20T16:45:00Z",
  "updatedAt": "2025-01-20T16:45:00Z"
}
```

#### Put Procedure on Hold
```typescript
POST /api/audit-procedures/:id/hold
{
  "reason": "Waiting for client to provide supporting documentation"
}

// Changes status to ON_HOLD with reason
// Logs reason in notes field
// Notifies manager of hold status
// Pauses due date tracking

Response:
{
  "id": "proc-123",
  "status": "ON_HOLD",
  "notes": "Waiting for client to provide supporting documentation",
  "updatedAt": "2025-01-18T11:20:00Z"
}
```

#### Review Procedure
```typescript
POST /api/audit-procedures/:id/review
{
  "action": "APPROVED",  // or "REJECTED"
  "reviewNotes": "Work performed is adequate. Good documentation."
}

// Manager reviews completed procedure
// Approves or rejects work
// If approved: Status → COMPLETED
// If rejected: Status → IN_PROGRESS
// Notifies assignee of review decision

Response:
{
  "id": "proc-123",
  "reviewStatus": "APPROVED",
  "reviewNotes": "Work performed is adequate. Good documentation.",
  "reviewedBy": "user-456",
  "reviewedAt": "2025-01-21T09:15:00Z"
}
```

### Management & Dashboard Endpoints

#### Get Workload Distribution
```typescript
GET /api/audit-procedures/company/:companyId/workload

// Returns workload metrics for all team members
// Shows procedures assigned, hours estimated, completion status
// Helps managers balance workload

Response:
{
  "workload": [
    {
      "user": {
        "id": "user-123",
        "name": "John Smith",
        "role": "Senior Auditor"
      },
      "totalProcedures": 15,
      "estimatedHours": 120,
      "completedProcedures": 8,
      "overdueProcedures": 2,
      "utilizationRate": 0.85
    },
    {
      "user": {
        "id": "user-456",
        "name": "Jane Doe",
        "role": "Staff Auditor"
      },
      "totalProcedures": 12,
      "estimatedHours": 96,
      "completedProcedures": 5,
      "overdueProcedures": 0,
      "utilizationRate": 0.72
    }
  ],
  "companyId": "company-789",
  "lastUpdated": "2025-01-27T14:30:00Z"
}
```

**Use Cases**:
- Identify overburdened team members
- Balance workload across team
- Track utilization rates
- Plan future assignments

#### Get Dashboard Data
```typescript
GET /api/audit-procedures/dashboard/:companyId

// Returns comprehensive dashboard data
// Combines statistics + workload + trends
// Single endpoint for dashboard page

Response:
{
  "statistics": {
    "total": 150,
    "byStatus": {
      "NOT_STARTED": 20,
      "IN_PROGRESS": 80,
      "REVIEW_REQUIRED": 15,
      "COMPLETED": 30,
      "ON_HOLD": 5
    },
    "byPriority": {
      "URGENT": 5,
      "HIGH": 40,
      "MEDIUM": 80,
      "LOW": 25
    },
    "overdue": 12,
    "completionPercentage": 20
  },
  "workload": [
    // ... workload array as above
  ],
  "trends": {
    "completionTrend": "improving",
    "averageCompletionDays": 12.5,
    "onTimeCompletionRate": 0.78
  },
  "lastUpdated": "2025-01-27T14:30:00Z"
}
```

**Dashboard Display**:
- Overview statistics cards
- Workload distribution chart
- Completion trends graph
- Overdue items alert
- Priority breakdown pie chart

#### Get Procedure Templates
```typescript
GET /api/audit-procedures/templates

// Returns available procedure templates
// Templates provide pre-configured procedures
// Speeds up procedure creation

Response:
{
  "templates": [
    {
      "id": "template-1",
      "name": "Revenue Transaction Testing",
      "description": "Sample and test revenue transactions for accuracy and occurrence",
      "category": "REVENUE",
      "riskLevel": "CRITICAL",
      "estimatedHours": 16,
      "procedureSteps": [
        "Select sample of 25 revenue transactions",
        "Trace to source documents",
        "Verify pricing and calculations",
        "Check for proper authorization",
        "Document results in workpaper"
      ]
    },
    {
      "id": "template-2",
      "name": "Bank Reconciliation Review",
      "description": "Review and verify bank reconciliations",
      "category": "CASH",
      "riskLevel": "HIGH",
      "estimatedHours": 4,
      "procedureSteps": [
        "Obtain bank reconciliation",
        "Verify mathematical accuracy",
        "Review outstanding items",
        "Test reconciling items",
        "Document conclusion"
      ]
    }
  ]
}
```

**Template Benefits**:
- Consistent procedures across engagements
- Faster procedure creation
- Built-in best practices
- Reduced training time

### @Mentions

**Usage**: `@John Smith` or `@john.smith`

**Behavior**:
- User receives email notification
- Comment highlighted in their feed
- Notification counter updates
- Can reply directly

---

## 🔍 Filtering & Search

### Available Filters

**Procedure List Page** provides multiple filters:

1. **Company** (dropdown)
   - Filter by client company
   - Multi-company support
   - "All Companies" option

2. **Period** (dropdown)
   - Filter by audit period
   - Only shows periods for selected company
   - "All Periods" option

3. **Status** (dropdown)
   - NOT_STARTED
   - IN_PROGRESS
   - REVIEW_REQUIRED
   - COMPLETED
   - ON_HOLD
   - CANCELLED

4. **Category** (dropdown)
   - REVENUE
   - EXPENSES
   - ASSETS
   - LIABILITIES
   - EQUITY
   - CASH
   - COMPLETENESS
   - VALUATION
   - OTHER

5. **Assigned To** (dropdown)
   - List of all users
   - "Unassigned" option
   - "Assigned to Me"

6. **Priority** (checkbox group)
   - URGENT
   - HIGH
   - MEDIUM
   - LOW

### Search Functionality

**Search Box**: 
- Searches procedure name
- Searches description
- Real-time filtering
- Case-insensitive
- Partial match

**Advanced Search** (planned):
- Date ranges
- Risk level
- Completion percentage
- Tag-based search

---

## 📊 Statistics & Progress Tracking

### Procedure Statistics

**Dashboard Displays**:

```typescript
interface ProcedureStatistics {
  total: number;
  
  byStatus: {
    NOT_STARTED: number;
    IN_PROGRESS: number;
    REVIEW_REQUIRED: number;
    COMPLETED: number;
    ON_HOLD: number;
    CANCELLED: number;
  };
  
  byPriority: {
    URGENT: number;
    HIGH: number;
    MEDIUM: number;
    LOW: number;
  };
  
  byRisk: {
    CRITICAL: number;
    HIGH: number;
    MEDIUM: number;
    LOW: number;
  };
  
  overdue: number;             // Past due date
  dueThisWeek: number;         // Due in next 7 days
  completionPercentage: number; // % completed
  averageCompletionTime: number; // Average days to complete
}
```

**API Endpoint**:
```typescript
GET /api/audit-procedures/statistics?companyId=xxx&periodId=yyy

Response:
{
  "total": 150,
  "byStatus": {
    "NOT_STARTED": 20,
    "IN_PROGRESS": 80,
    "REVIEW_REQUIRED": 15,
    "COMPLETED": 30,
    "ON_HOLD": 5,
    "CANCELLED": 0
  },
  "byPriority": {
    "URGENT": 5,
    "HIGH": 40,
    "MEDIUM": 80,
    "LOW": 25
  },
  "overdue": 12,
  "completionPercentage": 20
}
```

### Progress Visualization

**Charts Available**:
- Status distribution (pie chart)
- Priority breakdown (bar chart)
- Completion timeline (line chart)
- Overdue trend (area chart)
- Team workload (horizontal bar)

---

## 📧 Email Notifications

### Notification Triggers

| Event | Recipient | Template |
|-------|-----------|----------|
| Procedure Assigned | Assignee | Assignment notification |
| Due Date Approaching | Assignee | Reminder (3 days, 1 day) |
| Status Changed | Assignee + Manager | Status update |
| Overdue | Assignee + Manager | Overdue alert |
| Comment Added | @mentioned users | New comment |
| Review Required | Manager | Review request |
| Approved | Assignee | Approval notification |
| Rejected | Assignee | Rejection with notes |

### Email Templates

**Assignment Notification**:
```
Subject: New Procedure Assigned: {ProcedureName}

Hi {UserName},

You have been assigned a new audit procedure:

Procedure: {ProcedureName}
Company: {CompanyName}
Period: {PeriodName}
Priority: {Priority}
Due Date: {DueDate}
Assigned By: {AssignerName}

Description:
{Description}

Notes from assigner:
{Notes}

View Procedure: {ProcedureLink}

Best regards,
CloudAudit Pro
```

### Notification Preferences

Users can configure:
- Email frequency (immediate, daily digest, off)
- Types of notifications
- Time zone for emails
- Language preference

---

## 🎨 View Modes

### List View (Default)

**Features**:
- Tabular display of all procedures
- Sortable columns
- Filterable
- Bulk operations available
- Export to Excel/CSV

**Columns Displayed**:
- Checkbox (for bulk select)
- Name
- Status chip
- Priority chip
- Risk level
- Company
- Period
- Assigned To (avatar + name)
- Due Date
- Workpapers count
- Findings count
- Actions (edit, delete, view)

### Kanban Board View

**Purpose**: Visual workflow management with drag-and-drop

**Layout**: 4 columns representing status
- Not Started (gray column)
- In Progress (blue column)
- Review Required (orange column)
- Completed (green column)

**Card Display**:
```
┌─────────────────────────────┐
│ [Priority Chip] [Risk Chip] │
│ Procedure Name              │
│ Company Name                │
│                             │
│ 👤 John Smith               │
│ 📅 Dec 31, 2025             │
│ 📄 3 workpapers  🔍 2 finds │
└─────────────────────────────┘
```

**Drag & Drop**:
- Drag card between columns
- Automatic status update
- Optimistic UI update
- API call to save
- Email notification sent
- Audit trail logged

**Benefits**:
- Visual progress tracking
- Easy status updates
- Team workload visibility
- Quick prioritization

### Calendar View

**Purpose**: Timeline-based view of procedures by due date

**Layout**:
- Monthly grid (default)
- Weekly grid (optional)
- Day view (optional)

**Event Display**:
- Color-coded by priority/status
- Shows procedure name
- Click to view details modal

**Interaction**:
- Click event → View procedure details
- Drag event → Change due date
- Month/week navigation
- Filter by assignee/status

---

## 📱 My Work Dashboard

### Personal Procedure View

**Purpose**: Auditor's personalized work queue

**Sections**:

1. **Statistics Cards** (5 cards)
   - Assigned to Me (total count)
   - In Progress (my active work)
   - Completed (my finished procedures)
   - Overdue (my past-due items)
   - Pending Review (my submitted procedures)

2. **Overdue Items** (red alert section)
   - List of my overdue procedures
   - Warning icons
   - Days overdue shown
   - Click to navigate

3. **Active Procedures** (table)
   - All my non-completed procedures
   - Sortable by due date/priority
   - Status and priority chips
   - Quick status update

4. **Review Queue** (Managers only)
   - Procedures awaiting my review
   - Submitted by team members
   - Priority-sorted
   - One-click approve/reject

**View Switcher**:
- Switch to List View
- Switch to Kanban Board
- Switch to Calendar View

---

## 🔗 Relationships

### Workpapers

**Link**: One procedure → Many workpapers

**Purpose**: Documentation of audit work

**Examples**:
- Sample selection spreadsheet
- Test results documentation
- Analytical procedures
- Confirmation tracking

**Display**: Workpaper count badge on procedure card

### Findings

**Link**: One procedure → Many findings

**Purpose**: Issues identified during testing

**Examples**:
- Control deficiency
- Accounting error
- Documentation gap
- Compliance issue

**Display**: Finding count badge with severity indicator

### Documents

**Link**: One procedure → Many documents

**Purpose**: Supporting evidence

**Examples**:
- Client-provided schedules
- Scanned invoices
- Contracts
- Correspondence

**Display**: Document count with paperclip icon

### Comments

**Link**: One procedure → Many comments

**Purpose**: Team collaboration

**Display**: Comment count with speech bubble icon

---

## ⚙️ Configuration

### System Settings

**Admin Configuration**:

1. **Default Values**
   - Default priority (MEDIUM)
   - Default risk level (MEDIUM)
   - Default status (NOT_STARTED)
   - Estimated hours (0)

2. **Email Settings**
   - Enable/disable notifications
   - Reminder schedule (days before due)
   - Overdue alert frequency

3. **Workflow Settings**
   - Require manager approval for completion
   - Allow self-assignment
   - Allow status reversion
   - Lock completed procedures

4. **Category Management**
   - Add custom categories
   - Set category colors
   - Define category descriptions

---

## 📈 Best Practices

### Creating Procedures

✅ **DO**:
- Use clear, specific names
- Include detailed instructions in description
- Set realistic due dates
- Assign appropriate priority and risk
- Link to templates when possible
- Attach reference documents

❌ **DON'T**:
- Use vague names ("Test stuff")
- Leave description empty
- Set impossible deadlines
- Mark everything HIGH priority
- Create duplicate procedures

### Managing Procedures

✅ **DO**:
- Update status regularly
- Add comments for context
- Link workpapers as created
- Review assignments weekly
- Archive completed engagements

❌ **DON'T**:
- Let procedures sit in one status too long
- Skip the review process
- Delete procedures with history
- Reassign without communication

### Team Collaboration

✅ **DO**:
- Use @mentions for specific questions
- Add context in comments
- Respond to comments promptly
- Use status updates to communicate progress

❌ **DON'T**:
- Have discussions outside the system
- Leave questions unanswered
- Skip notification of delays

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: Cannot change status
- **Cause**: Insufficient permissions
- **Solution**: Manager must approve completion

**Issue**: Not receiving email notifications
- **Cause**: Notification preferences disabled
- **Solution**: Check user settings → Enable notifications

**Issue**: Procedure not appearing in My Work
- **Cause**: Not assigned to you
- **Solution**: Check assignment, contact manager

**Issue**: Cannot delete procedure
- **Cause**: Has linked workpapers or findings
- **Solution**: Delete child records first, or archive instead

**Issue**: Bulk assign failing
- **Cause**: Mixed companies/periods
- **Solution**: Filter to single company before bulk assign

---

## 🎓 Training Guide

### For Auditors

**Day 1**: 
- View My Work dashboard
- Understand status lifecycle
- Update procedure status
- Add comments

**Week 1**:
- Create workpapers
- Document findings
- Upload documents
- Complete first procedure

### For Managers

**Day 1**:
- Create procedures
- Assign to team
- Use bulk operations
- Review submitted work

**Week 1**:
- Use Kanban board
- Monitor team progress
- Approve completions
- Generate reports

---

**Next Document**: Phase 9 - Workpapers & Findings

**Last Updated**: December 27, 2025
