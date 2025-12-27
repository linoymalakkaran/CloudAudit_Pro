# CloudAudit Pro - Email Notifications

## 📧 Overview

CloudAudit Pro includes a comprehensive email notification system that keeps audit team members and clients informed about important events, status changes, and action items. The system sends automated, contextual emails based on predefined triggers.

**Key Features**:
- Automated notification triggers
- Customizable email templates
- User notification preferences
- Email delivery tracking
- Notification history
- Digest emails (daily/weekly summaries)
- HTML formatted emails
- Mobile-friendly design

---

## 🔔 Notification Triggers

### 1. Procedure Assignment

**When**: Procedure assigned to user

**Recipients**: Assigned user

**Email Content**:
```
Subject: New Audit Procedure Assigned: [Procedure Name]

Hi [User Name],

You have been assigned a new audit procedure:

Procedure: [Procedure Name]
Company: [Company Name]
Period: [Period Name]
Due Date: [Due Date]
Priority: [Priority Level]

Description:
[Procedure Description]

Please log in to CloudAudit Pro to view details and begin work.

[View Procedure Button]

Best regards,
CloudAudit Pro Team
```

---

### 2. Status Change

**When**: Procedure status changes

**Recipients**: Assigned user, assignedBy user

**Email Content**:
```
Subject: Procedure Status Update: [Procedure Name]

Hi [User Name],

The status of procedure "[Procedure Name]" has been updated:

Previous Status: [Old Status]
New Status: [New Status]
Updated By: [User Name]
Updated At: [Timestamp]

[View Procedure Button]
```

---

### 3. Review Request

**When**: Procedure submitted for review

**Recipients**: Reviewer/Manager

**Email Content**:
```
Subject: Procedure Ready for Review: [Procedure Name]

Hi [Reviewer Name],

A procedure is ready for your review:

Procedure: [Procedure Name]
Prepared By: [Auditor Name]
Completed Date: [Date]
Company: [Company Name]

The procedure has been completed and is awaiting your review. Please review at your earliest convenience.

[Review Procedure Button]
```

---

### 4. Approval Request

**When**: Journal entry, workpaper, or procedure requires approval

**Recipients**: Approver(s)

**Email Content**:
```
Subject: Approval Required: [Item Type] - [Item Name]

Hi [Approver Name],

The following item requires your approval:

Type: [Journal Entry / Workpaper / Procedure]
Name/Number: [Item Identifier]
Submitted By: [User Name]
Submitted Date: [Date]
Amount (if applicable): [Amount]

Please review and approve or reject.

[Approve Button] [Reject Button] [View Details Button]
```

---

### 5. Due Date Reminder

**When**: Procedure due date approaching (3 days, 1 day, overdue)

**Recipients**: Assigned user, Manager

**Email Content**:
```
Subject: Reminder: Procedure Due [When]

Hi [User Name],

This is a reminder that the following procedure is due [in 3 days / tomorrow / OVERDUE]:

Procedure: [Procedure Name]
Company: [Company Name]
Due Date: [Due Date]
Current Status: [Status]
Days Until Due: [Number] ([OVERDUE] if past due)

Please ensure this procedure is completed on time.

[View Procedure Button]
```

**Reminder Schedule**:
- 3 days before due date
- 1 day before due date
- On due date (if not completed)
- Daily after due date (if overdue)

---

### 6. Finding Created

**When**: New finding identified

**Recipients**: Manager, Client (if appropriate)

**Email Content**:
```
Subject: New Audit Finding: [Finding Title]

Hi [Recipient Name],

A new audit finding has been identified:

Finding: [Finding Title]
Severity: [CRITICAL / HIGH / MEDIUM / LOW]
Procedure: [Procedure Name]
Identified By: [Auditor Name]
Date Identified: [Date]

Summary:
[Finding Description - first 200 characters]

This finding requires attention. Please review the full details and provide a management response.

[View Finding Button] [Provide Response Button]
```

---

### 7. Finding Resolution

**When**: Finding marked as resolved

**Recipients**: Identifier, Manager, Client

**Email Content**:
```
Subject: Finding Resolved: [Finding Title]

Hi [Recipient Name],

The following finding has been marked as resolved:

Finding: [Finding Title]
Original Severity: [Severity]
Resolved By: [User Name]
Resolved Date: [Date]
Resolution Notes: [Notes]

The resolution has been verified and the finding is now closed.

[View Finding Button]
```

---

### 8. Comment Added

**When**: Comment added to procedure

**Recipients**: Procedure assigned user, commenters, mentioned users (@mentions)

**Email Content**:
```
Subject: New Comment on Procedure: [Procedure Name]

Hi [User Name],

[Commenter Name] added a comment to "[Procedure Name]":

"[Comment Text]"

Posted: [Timestamp]

[Reply Button] [View Procedure Button]
```

---

### 9. Document Uploaded

**When**: Document uploaded and linked

**Recipients**: Procedure assigned user, Manager

**Email Content**:
```
Subject: New Document Uploaded: [Document Name]

Hi [User Name],

A new document has been uploaded:

Document: [Document Name]
Type: [Document Type]
Uploaded By: [User Name]
Upload Date: [Date]
Linked To: [Procedure / Finding / Workpaper Name]

[View Document Button]
```

---

### 10. Company Approval

**When**: New company registration (for Super Admin)

**Recipients**: Super Admin users

**Email Content**:
```
Subject: New Company Registration Awaiting Approval

Hi Super Admin,

A new company has registered and is awaiting your approval:

Company Name: [Company Name]
Business Type: [Type]
Contact Email: [Email]
Registration Date: [Date]
Admin User: [First Admin Name]

Please review the registration details and approve or reject.

[Approve Button] [Reject Button] [View Details Button]
```

---

## ⚙️ Email Templates

### Template Structure

```typescript
interface EmailTemplate {
  id: string;
  name: string;
  subject: string;
  htmlBody: string;
  textBody: string;
  variables: string[];         // Placeholders: {{userName}}, {{procedureName}}, etc.
  category: EmailCategory;
  isActive: boolean;
}
```

### Available Variables

Common placeholders available in templates:
- `{{userName}}` - Recipient's name
- `{{procedureName}}` - Procedure name
- `{{companyName}}` - Company name
- `{{periodName}}` - Period name
- `{{dueDate}}` - Due date
- `{{status}}` - Current status
- `{{priority}}` - Priority level
- `{{url}}` - Direct link to item
- `{{currentDate}}` - Current date/time

### Template Customization

Admins can customize email templates:
1. Navigate to Settings → Email Templates
2. Select template to edit
3. Modify subject line and body content
4. Use available variables
5. Preview email
6. Save changes

---

## 🔕 Notification Preferences

### User Preferences

Each user can configure their notification preferences:

```typescript
interface NotificationPreferences {
  userId: string;
  
  // Email Notifications
  email: {
    procedureAssignment: boolean;
    statusChange: boolean;
    reviewRequest: boolean;
    approvalRequest: boolean;
    dueReminder: boolean;
    findingCreated: boolean;
    findingResolved: boolean;
    commentAdded: boolean;
    documentUploaded: boolean;
  };
  
  // Digest Preferences
  digest: {
    enabled: boolean;
    frequency: 'DAILY' | 'WEEKLY';
    dayOfWeek?: number;        // For weekly (1=Monday, 7=Sunday)
    timeOfDay?: string;        // HH:MM format
  };
  
  // Quiet Hours
  quietHours: {
    enabled: boolean;
    startTime: string;         // HH:MM format
    endTime: string;           // HH:MM format
  };
}
```

### Configure Preferences

```http
PATCH /api/users/me/notification-preferences
Content-Type: application/json

{
  "email": {
    "procedureAssignment": true,
    "statusChange": true,
    "reviewRequest": true,
    "approvalRequest": true,
    "dueReminder": true,
    "findingCreated": true,
    "findingResolved": false,
    "commentAdded": true,
    "documentUploaded": false
  },
  "digest": {
    "enabled": true,
    "frequency": "DAILY",
    "timeOfDay": "08:00"
  }
}
```

---

## 📬 Digest Emails

### Daily Digest

**When**: Sent once daily at configured time

**Content**: Summary of all activities from previous day

**Example**:
```
Subject: CloudAudit Pro Daily Digest - January 15, 2025

Good morning [User Name],

Here's your daily summary:

📋 YOUR PROCEDURES (5)
- 2 assigned to you
- 1 due today
- 2 waiting for review

🔍 FINDINGS (3)
- 1 new finding created
- 2 awaiting management response

💬 COMMENTS (4)
- New comments on 2 procedures

📄 DOCUMENTS (1)
- 1 new document uploaded

[View Dashboard Button]
```

### Weekly Digest

**When**: Sent once weekly (typically Monday morning)

**Content**: Summary of previous week's activities

---

## 🔧 Email Configuration

### SMTP Settings (Admin)

```typescript
interface EmailConfig {
  provider: 'SMTP' | 'SENDGRID' | 'AWS_SES';
  smtp: {
    host: string;
    port: number;
    secure: boolean;
    auth: {
      user: string;
      pass: string;
    };
  };
  from: {
    name: string;              // "CloudAudit Pro"
    email: string;             // "noreply@cloudauditpro.com"
  };
  replyTo?: string;
  maxRetries: number;
  retryDelay: number;
}
```

---

## 📊 Email Tracking

### Delivery Status

System tracks email delivery:
- **Sent**: Email successfully sent
- **Delivered**: Confirmed delivery to recipient
- **Opened**: Recipient opened email (tracking pixel)
- **Clicked**: Recipient clicked link in email
- **Bounced**: Email bounced (invalid address)
- **Failed**: Delivery failed

### View Email History

```http
GET /api/notifications/history?userId=user_123&startDate=2025-01-01&endDate=2025-01-31
Authorization: Bearer {token}

Response:
{
  "notifications": [
    {
      "id": "notif_001",
      "type": "PROCEDURE_ASSIGNMENT",
      "recipient": "john.auditor@firm.com",
      "subject": "New Audit Procedure Assigned: Cash Testing",
      "sentAt": "2025-01-15T10:00:00Z",
      "status": "DELIVERED",
      "openedAt": "2025-01-15T10:15:00Z",
      "clickedAt": "2025-01-15T10:16:00Z"
    }
  ],
  "total": 45
}
```

---

## ⚙️ Best Practices

1. **Configure Preferences**: Set up notification preferences early
2. **Use Digests**: Enable daily digest to reduce email clutter
3. **Quiet Hours**: Configure quiet hours for work-life balance
4. **Unsubscribe Selectively**: Disable low-priority notifications
5. **Check Spam**: Ensure emails aren't going to spam folder
6. **Whitelist Sender**: Add CloudAudit Pro to email whitelist
7. **Test Templates**: Preview customized templates before deploying

---

## ❗ Troubleshooting

**Problem**: Not Receiving Emails  
**Solutions**:
- Check notification preferences are enabled
- Verify email address in profile
- Check spam/junk folder
- Confirm email server settings (Admin)
- Check quiet hours settings

**Problem**: Too Many Emails  
**Solutions**:
- Enable daily digest
- Disable less critical notifications
- Configure quiet hours
- Adjust due date reminder frequency

**Problem**: Emails Going to Spam  
**Solutions**:
- Whitelist sender address
- Add to safe senders list
- Contact IT to adjust spam filters
- Request Admin check SPF/DKIM records

---

## 🔐 Security

- Email content doesn't include sensitive data (passwords, etc.)
- Links include secure tokens with expiration
- Unsubscribe links in all emails
- GDPR compliant
- Email history retained per retention policy

---

*For email notification support, contact your system administrator.*
