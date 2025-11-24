# CloudAudit Pro - API Documentation

## Overview

The CloudAudit Pro API is built with NestJS and provides a comprehensive REST API for managing audit operations, user management, and document handling in a multi-tenant SaaS environment.

## Base URL
```
Production: https://api.cloudauditpro.com
Development: http://localhost:3001
```

## Authentication

All API endpoints (except public authentication routes) require a valid JWT token in the Authorization header:

```http
Authorization: Bearer <jwt_token>
```

## API Categories

### 1. Authentication & Authorization

#### POST /auth/register
Register a new company/tenant.

**Request Body:**
```json
{
  "companyName": "string",
  "adminFirstName": "string",
  "adminLastName": "string",
  "adminEmail": "string",
  "phone": "string",
  "address": "string",
  "industry": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Registration submitted for approval",
  "tenantId": "uuid"
}
```

#### POST /auth/login
Authenticate user and get JWT token.

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "token": "string",
  "user": {
    "id": "uuid",
    "email": "string",
    "firstName": "string",
    "lastName": "string",
    "role": "ADMIN|MANAGER|SENIOR_AUDITOR|AUDITOR|INTERN",
    "tenantId": "uuid",
    "tenantName": "string"
  }
}
```

#### POST /auth/logout
Invalidate current session.

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

#### GET /auth/me
Get current user information.

**Response:**
```json
{
  "id": "uuid",
  "email": "string",
  "firstName": "string",
  "lastName": "string",
  "role": "string",
  "tenantId": "uuid",
  "lastLoginAt": "datetime"
}
```

### 2. Super Admin Endpoints

#### GET /super-admin/tenants
Get all tenants for super admin review.

**Query Parameters:**
- `status`: PENDING | ACTIVE | SUSPENDED | REJECTED
- `page`: number (default: 1)
- `limit`: number (default: 20)

**Response:**
```json
{
  "tenants": [
    {
      "id": "uuid",
      "companyName": "string",
      "status": "string",
      "adminEmail": "string",
      "createdAt": "datetime",
      "approvedAt": "datetime",
      "userCount": number
    }
  ],
  "totalCount": number,
  "currentPage": number
}
```

#### PATCH /super-admin/tenants/:id/approve
Approve or reject a tenant registration.

**Request Body:**
```json
{
  "action": "APPROVE|REJECT",
  "reason": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Tenant approved successfully"
}
```

#### GET /super-admin/analytics
Get system-wide analytics.

**Response:**
```json
{
  "totalTenants": number,
  "activeTenants": number,
  "pendingTenants": number,
  "totalUsers": number,
  "recentActivity": [
    {
      "type": "string",
      "description": "string",
      "timestamp": "datetime"
    }
  ]
}
```

### 3. User Management

#### GET /users
Get users in current tenant.

**Query Parameters:**
- `role`: Role filter
- `status`: ACTIVE | INACTIVE | INVITED
- `search`: Search term
- `page`: Page number
- `limit`: Items per page

**Response:**
```json
{
  "users": [
    {
      "id": "uuid",
      "email": "string",
      "firstName": "string",
      "lastName": "string",
      "role": "string",
      "status": "string",
      "createdAt": "datetime",
      "lastLoginAt": "datetime"
    }
  ],
  "totalCount": number
}
```

#### POST /users/invite
Invite a new user to the tenant.

**Request Body:**
```json
{
  "email": "string",
  "firstName": "string",
  "lastName": "string",
  "role": "MANAGER|SENIOR_AUDITOR|AUDITOR|INTERN",
  "department": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Invitation sent successfully",
  "userId": "uuid"
}
```

#### PATCH /users/:id
Update user information.

**Request Body:**
```json
{
  "firstName": "string",
  "lastName": "string",
  "role": "string",
  "status": "string",
  "department": "string"
}
```

#### DELETE /users/:id
Deactivate a user (soft delete).

**Response:**
```json
{
  "success": true,
  "message": "User deactivated successfully"
}
```

### 4. Document Management

#### GET /documents
Get documents accessible to current user.

**Query Parameters:**
- `category`: Document category
- `search`: Search term
- `uploadedBy`: User ID filter
- `dateFrom`: Start date filter
- `dateTo`: End date filter
- `page`: Page number
- `limit`: Items per page

**Response:**
```json
{
  "documents": [
    {
      "id": "uuid",
      "filename": "string",
      "originalName": "string",
      "category": "string",
      "size": number,
      "uploadedBy": {
        "id": "uuid",
        "firstName": "string",
        "lastName": "string"
      },
      "uploadedAt": "datetime",
      "tags": ["string"]
    }
  ],
  "totalCount": number
}
```

#### POST /documents/upload
Upload a new document.

**Request Body:** (multipart/form-data)
- `file`: File upload
- `category`: string
- `description`: string
- `tags`: string[] (optional)

**Response:**
```json
{
  "success": true,
  "document": {
    "id": "uuid",
    "filename": "string",
    "originalName": "string",
    "category": "string",
    "size": number,
    "uploadedAt": "datetime"
  }
}
```

#### GET /documents/:id/download
Get secure download URL for document.

**Response:**
```json
{
  "downloadUrl": "string",
  "expiresAt": "datetime"
}
```

#### DELETE /documents/:id
Delete a document (with proper authorization check).

**Response:**
```json
{
  "success": true,
  "message": "Document deleted successfully"
}
```

### 5. Audit Procedures

#### GET /procedures
Get audit procedures for current user.

**Query Parameters:**
- `status`: ASSIGNED | IN_PROGRESS | COMPLETED | REVIEWED
- `assignedTo`: User ID filter
- `dueDate`: Date filter
- `priority`: HIGH | MEDIUM | LOW

**Response:**
```json
{
  "procedures": [
    {
      "id": "uuid",
      "title": "string",
      "description": "string",
      "status": "string",
      "priority": "string",
      "assignedTo": {
        "id": "uuid",
        "firstName": "string",
        "lastName": "string"
      },
      "createdBy": {
        "id": "uuid",
        "firstName": "string",
        "lastName": "string"
      },
      "dueDate": "datetime",
      "progress": number
    }
  ],
  "totalCount": number
}
```

#### POST /procedures
Create a new audit procedure.

**Request Body:**
```json
{
  "title": "string",
  "description": "string",
  "assignedToId": "uuid",
  "dueDate": "datetime",
  "priority": "HIGH|MEDIUM|LOW",
  "checklist": [
    {
      "item": "string",
      "required": boolean
    }
  ]
}
```

#### PATCH /procedures/:id/progress
Update procedure progress.

**Request Body:**
```json
{
  "completedItems": ["uuid"],
  "notes": "string",
  "attachments": ["uuid"]
}
```

#### POST /procedures/:id/complete
Mark procedure as completed.

**Request Body:**
```json
{
  "finalNotes": "string",
  "recommendations": "string",
  "attachments": ["uuid"]
}
```

### 6. Reports & Analytics

#### GET /reports
Get available reports.

**Response:**
```json
{
  "reports": [
    {
      "id": "uuid",
      "title": "string",
      "type": "COMPLIANCE|PERFORMANCE|SUMMARY",
      "generatedAt": "datetime",
      "status": "GENERATING|COMPLETED|FAILED",
      "downloadUrl": "string"
    }
  ]
}
```

#### POST /reports/generate
Generate a new report.

**Request Body:**
```json
{
  "type": "COMPLIANCE|PERFORMANCE|SUMMARY",
  "dateRange": {
    "from": "datetime",
    "to": "datetime"
  },
  "filters": {
    "department": "string",
    "auditor": "uuid",
    "status": "string"
  },
  "format": "PDF|EXCEL|CSV"
}
```

#### GET /analytics/dashboard
Get dashboard analytics.

**Response:**
```json
{
  "overview": {
    "totalProcedures": number,
    "completedProcedures": number,
    "overdueProcedures": number,
    "activeUsers": number
  },
  "recentActivity": [
    {
      "type": "string",
      "description": "string",
      "user": "string",
      "timestamp": "datetime"
    }
  ],
  "complianceScore": number,
  "monthlyProgress": [
    {
      "month": "string",
      "completed": number,
      "total": number
    }
  ]
}
```

### 7. Notifications

#### GET /notifications
Get user notifications.

**Query Parameters:**
- `unread`: boolean
- `type`: EMAIL | IN_APP | SYSTEM
- `page`: number
- `limit`: number

**Response:**
```json
{
  "notifications": [
    {
      "id": "uuid",
      "type": "string",
      "title": "string",
      "message": "string",
      "isRead": boolean,
      "createdAt": "datetime",
      "actionUrl": "string"
    }
  ],
  "unreadCount": number
}
```

#### PATCH /notifications/:id/read
Mark notification as read.

#### POST /notifications/mark-all-read
Mark all notifications as read.

## Error Handling

The API uses standard HTTP status codes and returns consistent error responses:

```json
{
  "success": false,
  "error": {
    "code": "string",
    "message": "string",
    "details": {}
  },
  "timestamp": "datetime",
  "path": "string"
}
```

### Common Error Codes:
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `409` - Conflict
- `422` - Validation Error
- `429` - Rate Limit Exceeded
- `500` - Internal Server Error

## Rate Limiting

API endpoints are rate limited to ensure fair usage:

- **Public endpoints**: 100 requests per 15 minutes per IP
- **Authenticated endpoints**: 1000 requests per 15 minutes per user
- **File upload endpoints**: 10 requests per 5 minutes per user

Rate limit headers are included in all responses:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

## WebSocket Events

The application supports real-time updates via WebSocket connections:

### Connection
```javascript
const socket = io('ws://localhost:3001', {
  auth: {
    token: 'your-jwt-token'
  }
});
```

### Events
- `notification_received` - New notification
- `procedure_assigned` - New procedure assignment
- `procedure_completed` - Procedure completion
- `document_uploaded` - New document upload
- `user_status_changed` - User status update

## Pagination

List endpoints support cursor-based pagination:

**Request:**
```http
GET /users?page=1&limit=20
```

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalCount": 100,
    "hasNext": true,
    "hasPrevious": false
  }
}
```

## Data Export

Most endpoints support data export in multiple formats:

**Request:**
```http
GET /users?format=csv
Accept: text/csv
```

Supported formats:
- JSON (default)
- CSV
- Excel (XLSX)
- PDF (reports only)