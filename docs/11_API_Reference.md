# CloudAudit Pro - Complete API Reference

## Overview

This document provides comprehensive API documentation for CloudAudit Pro's backend services. The API follows RESTful principles, uses JSON for data exchange, and requires JWT authentication for all protected endpoints.

## Base URL

```
Production:  https://api.cloudauditpro.com
Staging:     https://staging-api.cloudauditpro.com  
Development: http://localhost:3000
```

## Authentication

### Authentication Methods

**JWT Token-Based Authentication**
```http
Authorization: Bearer <jwt_token>
```

### Obtaining a Token

**Login**
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}

Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "role": "AUDITOR",
    "companyId": "company-uuid",
    "tenantId": "tenant-uuid"
  }
}
```

**Register (Organization)**
```http
POST /auth/register
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "email": "user@example.com",
  "password": "password123",
  "companyName": "ABC Audit Firm",
  "tenantSubdomain": "abc-audit"
}
```

## API Endpoints by Module

### 1. Invitation System

#### Create Invitation
```http
POST /invitations
Authorization: Bearer <token>
Content-Type: application/json

Request:
{
  "email": "client@example.com",
  "firstName": "Jane",
  "lastName": "Smith",
  "role": "CLIENT",
  "companyId": "company-uuid",
  "message": "Welcome to our audit portal"
}

Response: 201 Created
{
  "id": "invitation-uuid",
  "email": "client@example.com",
  "firstName": "Jane",
  "lastName": "Smith",
  "role": "CLIENT",
  "companyId": "company-uuid",
  "token": "secure-random-token",
  "status": "PENDING",
  "expiresAt": "2025-01-05T12:00:00Z",
  "createdAt": "2024-12-29T12:00:00Z",
  "createdBy": {
    "id": "user-uuid",
    "firstName": "John",
    "lastName": "Doe"
  }
}
```

#### List Invitations
```http
GET /invitations?status=PENDING&role=CLIENT
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "invitation-uuid",
      "email": "client@example.com",
      "role": "CLIENT",
      "status": "PENDING",
      "expiresAt": "2025-01-05T12:00:00Z",
      "createdAt": "2024-12-29T12:00:00Z"
    }
  ],
  "pagination": {
    "total": 1,
    "page": 1,
    "limit": 10,
    "pages": 1
  }
}
```

#### Validate Invitation Token
```http
GET /invitations/validate/:token

Response: 200 OK
{
  "valid": true,
  "invitation": {
    "id": "invitation-uuid",
    "email": "client@example.com",
    "firstName": "Jane",
    "lastName": "Smith",
    "role": "CLIENT",
    "companyId": "company-uuid"
  }
}
```

#### Accept Invitation
```http
POST /invitations/accept/:token
Content-Type: application/json

Request:
{
  "firstName": "Jane",
  "lastName": "Smith",
  "password": "securepassword123"
}

Response: 201 Created
{
  "user": {
    "id": "user-uuid",
    "email": "client@example.com",
    "firstName": "Jane",
    "lastName": "Smith",
    "role": "CLIENT",
    "companyId": "company-uuid"
  },
  "token": "jwt-access-token"
}
```

#### Resend Invitation
```http
POST /invitations/:id/resend
Authorization: Bearer <token>

Response: 200 OK
{
  "message": "Invitation resent successfully"
}
```

#### Cancel Invitation
```http
DELETE /invitations/:id
Authorization: Bearer <token>

Response: 204 No Content
```

---

### 2. Messaging System

#### Send Message
```http
POST /messages
Authorization: Bearer <token>
Content-Type: application/json

Request:
{
  "subject": "Document Request Follow-up",
  "message": "Please upload the requested financial statements",
  "companyId": "company-uuid",
  "threadId": "thread-uuid" // Optional, creates new thread if omitted
}

Response: 201 Created
{
  "id": "message-uuid",
  "threadId": "thread-uuid",
  "sender": {
    "id": "user-uuid",
    "firstName": "John",
    "lastName": "Doe",
    "role": "AUDITOR"
  },
  "message": "Please upload the requested financial statements",
  "isRead": false,
  "createdAt": "2024-12-29T12:00:00Z"
}
```

#### List Messages
```http
GET /messages?companyId=company-uuid&threadId=thread-uuid&unreadOnly=true
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "message-uuid",
      "threadId": "thread-uuid",
      "sender": {
        "id": "user-uuid",
        "firstName": "John",
        "lastName": "Doe"
      },
      "message": "Message content",
      "isRead": false,
      "createdAt": "2024-12-29T12:00:00Z"
    }
  ],
  "pagination": {
    "total": 5,
    "page": 1,
    "limit": 20,
    "pages": 1
  }
}
```

#### List Conversation Threads
```http
GET /messages/threads?companyId=company-uuid
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "thread-uuid",
      "subject": "Document Request Follow-up",
      "companyId": "company-uuid",
      "participants": [
        {
          "id": "user-uuid",
          "firstName": "John",
          "lastName": "Doe",
          "role": "AUDITOR"
        }
      ],
      "messages": [...],
      "lastMessageAt": "2024-12-29T12:00:00Z",
      "unreadCount": 2
    }
  ],
  "pagination": {
    "total": 10,
    "page": 1,
    "limit": 20,
    "pages": 1
  }
}
```

#### Get Thread Details
```http
GET /messages/threads/:threadId
Authorization: Bearer <token>

Response: 200 OK
{
  "id": "thread-uuid",
  "subject": "Document Request Follow-up",
  "companyId": "company-uuid",
  "participants": [...],
  "messages": [
    {
      "id": "message-uuid",
      "sender": {...},
      "message": "Message content",
      "isRead": true,
      "createdAt": "2024-12-29T12:00:00Z"
    }
  ],
  "lastMessageAt": "2024-12-29T12:00:00Z",
  "unreadCount": 0
}
```

#### Mark Message as Read
```http
PATCH /messages/:messageId/read
Authorization: Bearer <token>

Response: 200 OK
{
  "message": "Message marked as read"
}
```

#### Mark Thread as Read
```http
PATCH /messages/threads/:threadId/read
Authorization: Bearer <token>

Response: 200 OK
{
  "message": "All messages in thread marked as read"
}
```

#### Get Unread Count
```http
GET /messages/unread-count?companyId=company-uuid
Authorization: Bearer <token>

Response: 200 OK
{
  "count": 5
}
```

---

### 3. Notification System

#### Create Notification
```http
POST /notifications
Authorization: Bearer <token>
Content-Type: application/json

Request:
{
  "userId": "user-uuid", // Optional, defaults to all company users
  "companyId": "company-uuid", // Optional
  "title": "Document Uploaded",
  "message": "Client has uploaded the requested financial statements",
  "type": "DOCUMENT_REQUEST",
  "link": "/client/documents/doc-uuid"
}

Response: 201 Created
{
  "id": "notification-uuid",
  "userId": "user-uuid",
  "title": "Document Uploaded",
  "message": "Client has uploaded the requested financial statements",
  "type": "DOCUMENT_REQUEST",
  "isRead": false,
  "link": "/client/documents/doc-uuid",
  "createdAt": "2024-12-29T12:00:00Z"
}
```

#### List Notifications
```http
GET /notifications?unreadOnly=true&type=MESSAGE
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "notification-uuid",
      "title": "New Message",
      "message": "You have a new message from John Doe",
      "type": "MESSAGE",
      "isRead": false,
      "link": "/messages/thread-uuid",
      "createdAt": "2024-12-29T12:00:00Z"
    }
  ],
  "pagination": {
    "total": 8,
    "page": 1,
    "limit": 20,
    "pages": 1
  }
}
```

#### Mark Notification as Read
```http
PATCH /notifications/:notificationId/read
Authorization: Bearer <token>

Response: 200 OK
{
  "message": "Notification marked as read"
}
```

#### Mark All as Read
```http
PATCH /notifications/mark-all-read
Authorization: Bearer <token>

Response: 200 OK
{
  "message": "All notifications marked as read",
  "count": 8
}
```

#### Get Unread Count
```http
GET /notifications/unread-count
Authorization: Bearer <token>

Response: 200 OK
{
  "count": 8
}
```

#### Delete Notification
```http
DELETE /notifications/:notificationId
Authorization: Bearer <token>

Response: 204 No Content
```

---

### 4. Client Portal Dashboard

#### Get Audit Overview
```http
GET /dashboard/company/:companyId/audit?timeframe=30_DAYS
Authorization: Bearer <token>

Response: 200 OK
{
  "procedureStats": {
    "total": 45,
    "completed": 30,
    "inProgress": 10,
    "notStarted": 5,
    "overdue": 2
  },
  "findingsStats": {
    "total": 5,
    "high": 1,
    "medium": 2,
    "low": 2
  },
  "recentProcedures": [
    {
      "id": "procedure-uuid",
      "name": "Cash Verification",
      "status": "COMPLETED",
      "completedAt": "2024-12-28T15:30:00Z"
    }
  ],
  "recentFindings": [...],
  "pendingProcedures": [...],
  "documentRequests": [...]
}
```

---

### 5. Document Management

#### Upload Document
```http
POST /documents/upload
Authorization: Bearer <token>
Content-Type: multipart/form-data

Request:
- file: [binary file data]
- companyId: "company-uuid"
- requestId: "request-uuid"
- type: "CLIENT_SUBMISSION"
- notes: "Financial statements for Q4 2024"

Response: 201 Created
{
  "id": "document-uuid",
  "fileName": "financial-statements-q4-2024.pdf",
  "fileSize": 2048576,
  "mimeType": "application/pdf",
  "storageUrl": "https://storage.cloudauditpro.com/...",
  "version": 1,
  "uploadedBy": {
    "id": "user-uuid",
    "firstName": "Jane",
    "lastName": "Smith"
  },
  "uploadedAt": "2024-12-29T12:00:00Z"
}
```

#### List Documents
```http
GET /documents?companyId=company-uuid&type=REQUEST
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "request-uuid",
      "title": "Financial Statements Q4 2024",
      "description": "Please provide audited financial statements",
      "dueDate": "2025-01-15",
      "priority": "HIGH",
      "status": "PENDING",
      "uploadedFiles": []
    }
  ],
  "pagination": {
    "total": 5,
    "page": 1,
    "limit": 20,
    "pages": 1
  }
}
```

#### Download Document
```http
GET /documents/:documentId/download
Authorization: Bearer <token>

Response: 200 OK
Content-Type: application/pdf
Content-Disposition: attachment; filename="document.pdf"

[Binary file data]
```

---

### 6. Companies

#### List Companies
```http
GET /companies?status=active
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "company-uuid",
      "name": "ABC Corporation",
      "code": "ABC",
      "status": "ACTIVE",
      "createdAt": "2024-01-15T10:00:00Z"
    }
  ],
  "pagination": {
    "total": 25,
    "page": 1,
    "limit": 20,
    "pages": 2
  }
}
```

#### Get Company Details
```http
GET /companies/:companyId
Authorization: Bearer <token>

Response: 200 OK
{
  "id": "company-uuid",
  "name": "ABC Corporation",
  "code": "ABC",
  "status": "ACTIVE",
  "address": "123 Main St",
  "city": "New York",
  "country": "USA",
  "phone": "+1-555-0123",
  "email": "contact@abccorp.com",
  "createdAt": "2024-01-15T10:00:00Z"
}
```

---

### 7. Audit Procedures

#### List Procedures
```http
GET /procedures?companyId=company-uuid&periodId=period-uuid&status=IN_PROGRESS
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "procedure-uuid",
      "name": "Cash Verification",
      "procedureType": "CASH_AND_BANK",
      "status": "IN_PROGRESS",
      "assignedUser": {
        "id": "user-uuid",
        "firstName": "John",
        "lastName": "Doe"
      },
      "dueDate": "2025-01-10",
      "riskLevel": "HIGH"
    }
  ],
  "pagination": {
    "total": 45,
    "page": 1,
    "limit": 20,
    "pages": 3
  }
}
```

#### Get Procedure Statistics
```http
GET /procedures/statistics?companyId=company-uuid
Authorization: Bearer <token>

Response: 200 OK
{
  "total": 45,
  "byStatus": {
    "NOT_STARTED": 5,
    "IN_PROGRESS": 10,
    "COMPLETED": 28,
    "UNDER_REVIEW": 2
  },
  "byRisk": {
    "HIGH": 15,
    "MEDIUM": 20,
    "LOW": 10
  },
  "overdue": 2,
  "completionRate": 62.2
}
```

---

### 8. Reports

#### List Reports
```http
GET /reports?companyId=company-uuid&status=COMPLETED
Authorization: Bearer <token>

Response: 200 OK
{
  "data": [
    {
      "id": "report-uuid",
      "name": "Trial Balance Report Q4 2024",
      "reportType": "TRIAL_BALANCE",
      "category": "FINANCIAL",
      "status": "COMPLETED",
      "company": {
        "id": "company-uuid",
        "name": "ABC Corporation"
      },
      "period": {
        "id": "period-uuid",
        "name": "Q4 2024"
      },
      "generatedBy": {
        "id": "user-uuid",
        "firstName": "John",
        "lastName": "Doe"
      },
      "createdAt": "2024-12-28T14:30:00Z"
    }
  ],
  "pagination": {
    "total": 15,
    "page": 1,
    "limit": 20,
    "pages": 1
  }
}
```

#### Create Report
```http
POST /reports
Authorization: Bearer <token>
Content-Type: application/json

Request:
{
  "name": "Trial Balance Report Q4 2024",
  "reportType": "TRIAL_BALANCE",
  "category": "FINANCIAL",
  "companyId": "company-uuid",
  "periodId": "period-uuid"
}

Response: 201 Created
{
  "id": "report-uuid",
  "name": "Trial Balance Report Q4 2024",
  "reportType": "TRIAL_BALANCE",
  "status": "QUEUED",
  "createdAt": "2024-12-29T12:00:00Z"
}
```

---

## Error Responses

### Standard Error Format
```json
{
  "statusCode": 400,
  "message": "Validation failed",
  "error": "Bad Request",
  "details": [
    {
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

### Common HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request succeeded |
| 201 | Created | Resource created successfully |
| 204 | No Content | Success with no response body |
| 400 | Bad Request | Invalid request parameters |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Resource conflict (duplicate) |
| 422 | Unprocessable Entity | Validation error |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server error |

---

## Rate Limiting

```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

**Limits:**
- Authenticated: 1000 requests per hour
- Unauthenticated: 100 requests per hour

---

## Pagination

All list endpoints support pagination with query parameters:

```
?page=1&limit=20&sortBy=createdAt&sortOrder=desc
```

**Response Headers:**
```http
X-Total-Count: 150
X-Page: 1
X-Per-Page: 20
X-Total-Pages: 8
```

---

## Webhooks (Future)

Coming soon: Webhook support for real-time event notifications.

---

## SDK & Libraries

**JavaScript/TypeScript**
```typescript
import { CloudAuditClient } from '@cloudaudit/sdk';

const client = new CloudAuditClient({
  apiKey: 'your-api-key',
  baseURL: 'https://api.cloudauditpro.com'
});

const invitations = await client.invitations.list();
```

**Python**
```python
from cloudaudit import CloudAuditClient

client = CloudAuditClient(api_key='your-api-key')
invitations = client.invitations.list()
```

---

## Support

- **API Documentation**: https://docs.cloudauditpro.com
- **Support Email**: api-support@cloudauditpro.com
- **Status Page**: https://status.cloudauditpro.com
