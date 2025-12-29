# Technical Architecture & Design Specifications

## Architecture Overview

This document provides detailed technical specifications for the multi-tenant web application migration of eAuditPro. The architecture follows modern cloud-native patterns with microservices, containerization, and multi-tenant design principles.

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        CDN/WAF Layer                        │
│                    (CloudFlare/AWS CloudFront)             │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                    Load Balancer                            │
│                  (NGINX/AWS ALB)                            │
│              SSL Termination & Rate Limiting               │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                   API Gateway                               │
│           (Kong/AWS API Gateway/Custom)                     │
│       Authentication, Routing, Tenant Resolution           │
└─────────────────────────┬───────────────────────────────────┘
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
┌───────────┐    ┌─────────────┐    ┌─────────────┐
│ Frontend  │    │   Backend   │    │   Admin     │
│  Service  │    │ Microservices│    │  Dashboard  │
│           │    │             │    │             │
│ React SPA │    │ Node.js/    │    │ Management  │
│    PWA    │    │ .NET Core   │    │    UI       │
└───────────┘    └─────────────┘    └─────────────┘
                          │
                ┌─────────┼─────────┐
                │         │         │
                ▼         ▼         ▼
        ┌──────────┐ ┌─────────┐ ┌─────────┐
        │ Tenant   │ │ Audit   │ │Document │
        │Management│ │ Core    │ │Service  │
        │ Service  │ │ Service │ │         │
        └──────────┘ └─────────┘ └─────────┘
                │         │         │
                └─────────┼─────────┘
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                    Data Layer                               │
│  ┌─────────────────┐  ┌─────────────────┐ ┌──────────────┐ │
│  │ Tenant Registry │  │ Tenant Database │ │ File Storage │ │
│  │   (Central)     │  │     Pool        │ │   (S3/Blob)  │ │
│  │   PostgreSQL    │  │   PostgreSQL    │ │              │ │
│  └─────────────────┘  └─────────────────┘ └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Technology Stack Details

### Frontend Technologies

#### Core Framework
- **React 18+** with TypeScript for type safety
- **Vite** for build tooling and development server
- **React Router v6** for routing and navigation
- **React Query (TanStack Query)** for server state management

#### UI Framework
```typescript
// Material-UI (MUI) Configuration
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { CssBaseline } from '@mui/material';

const theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
        },
      },
    },
  },
});
```

#### State Management
```typescript
// Redux Toolkit Store Configuration
import { configureStore } from '@reduxjs/toolkit';
import authSlice from './slices/authSlice';
import tenantSlice from './slices/tenantSlice';
import uiSlice from './slices/uiSlice';

export const store = configureStore({
  reducer: {
    auth: authSlice,
    tenant: tenantSlice,
    ui: uiSlice,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: ['persist/PERSIST'],
      },
    }),
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```

#### Frontend Services Layer
```typescript
// Client Portal Services (NEW - Implemented)
import axios from 'axios';

// Invitation Service
export const invitationService = {
  async create(invitation: CreateInvitationDto) {
    const response = await axios.post('/api/invitations', invitation);
    return response.data;
  },
  
  async validate(token: string) {
    const response = await axios.get(`/api/invitations/validate/${token}`);
    return response.data;
  },
  
  async accept(token: string, userData: AcceptInvitationDto) {
    const response = await axios.post(`/api/invitations/accept/${token}`, userData);
    return response.data;
  },
  
  async list(filters?: InvitationFilters) {
    const response = await axios.get('/api/invitations', { params: filters });
    return response.data;
  },
  
  async resend(id: string) {
    const response = await axios.post(`/api/invitations/${id}/resend`);
    return response.data;
  },
  
  async cancel(id: string) {
    await axios.delete(`/api/invitations/${id}`);
  }
};

// Messaging Service with Threading
export const messagingService = {
  async sendMessage(message: CreateMessageDto) {
    const response = await axios.post('/api/messages', message);
    return response.data;
  },
  
  async getThreads(companyId?: string) {
    const response = await axios.get('/api/messages/threads', {
      params: { companyId }
    });
    return response.data;
  },
  
  async getMessages(threadId: string) {
    const response = await axios.get(`/api/messages/threads/${threadId}`);
    return response.data;
  },
  
  async markAsRead(messageId: string) {
    await axios.patch(`/api/messages/${messageId}/read`);
  },
  
  async markThreadAsRead(threadId: string) {
    await axios.patch(`/api/messages/threads/${threadId}/read`);
  },
  
  async getUnreadCount(companyId?: string) {
    const response = await axios.get('/api/messages/unread-count', {
      params: { companyId }
    });
    return response.data;
  }
};

// Notification Service
export const notificationService = {
  async getNotifications(filters?: NotificationFilters) {
    const response = await axios.get('/api/notifications', { params: filters });
    return response.data;
  },
  
  async markAsRead(notificationId: string) {
    await axios.patch(`/api/notifications/${notificationId}/read`);
  },
  
  async markAllAsRead() {
    await axios.patch('/api/notifications/mark-all-read');
  },
  
  async getUnreadCount() {
    const response = await axios.get('/api/notifications/unread-count');
    return response.data;
  },
  
  async deleteNotification(notificationId: string) {
    await axios.delete(`/api/notifications/${notificationId}`);
  }
};

// Client Portal Dashboard Service
export const clientPortalService = {
  async getAuditOverview(companyId: string, timeframe?: string) {
    const response = await axios.get(`/api/dashboard/company/${companyId}/audit`, {
      params: { timeframe }
    });
    return response.data;
  },
  
  async getDocumentRequests(companyId: string) {
    const response = await axios.get('/api/documents', {
      params: { companyId, type: 'REQUEST' }
    });
    return response.data;
  },
  
  async uploadDocument(formData: FormData) {
    const response = await axios.post('/api/documents/upload', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    });
    return response.data;
  }
};
```

#### New React Components (Client Portal & Communication)
```typescript
// NotificationBell Component
import React, { useEffect, useState } from 'react';
import { Badge, IconButton, Menu, MenuItem } from '@mui/material';
import NotificationsIcon from '@mui/icons-material/Notifications';
import { notificationService } from '../services/notification.service';

const NotificationBell: React.FC = () => {
  const [unreadCount, setUnreadCount] = useState(0);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  
  useEffect(() => {
    // Poll for notifications every 30 seconds
    const fetchUnreadCount = async () => {
      const { count } = await notificationService.getUnreadCount();
      setUnreadCount(count);
    };
    
    fetchUnreadCount();
    const interval = setInterval(fetchUnreadCount, 30000);
    return () => clearInterval(interval);
  }, []);
  
  return (
    <IconButton onClick={(e) => setAnchorEl(e.currentTarget)}>
      <Badge badgeContent={unreadCount} color="error">
        <NotificationsIcon />
      </Badge>
    </IconButton>
  );
};
```

#### Progressive Web App (PWA) Features
```typescript
// Service Worker Configuration
const swConfig = {
  onSuccess: (registration: ServiceWorkerRegistration) => {
    console.log('SW registered: ', registration);
  },
  onUpdate: (registration: ServiceWorkerRegistration) => {
    if (registration && registration.waiting) {
      registration.waiting.postMessage({ type: 'SKIP_WAITING' });
    }
  },
};

// Offline support for critical features
const cacheStrategy = {
  runtimeCaching: [
    {
      urlPattern: /^https:\/\/api\.eauditpro\.com\/api\/(companies|procedures|accounts)/,
      handler: 'CacheFirst',
      options: {
        cacheName: 'api-cache',
        expiration: {
          maxEntries: 100,
          maxAgeSeconds: 86400, // 24 hours
        },
      },
    },
  ],
};
```

### Backend Technologies

#### Option 1: Node.js Stack
```typescript
// Express.js Application Structure
import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import compression from 'compression';
import rateLimit from 'express-rate-limit';

const app = express();

// Security middleware
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
}));

// CORS configuration for multi-tenant
app.use(cors({
  origin: (origin, callback) => {
    // Allow tenant subdomains
    if (!origin || /^https:\/\/[\w-]+\.eauditpro\.com$/.test(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
}));

// Rate limiting per tenant
const rateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: (req) => {
    const tenantId = req.headers['x-tenant-id'];
    // Different limits based on subscription tier
    return getTenantRateLimit(tenantId);
  },
  keyGenerator: (req) => {
    return `${req.headers['x-tenant-id']}:${req.ip}`;
  },
});
```

#### Option 2: .NET Core Stack
```csharp
// Program.cs for .NET 6+
var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllers();
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
        };
    });

// Multi-tenant service registration
builder.Services.AddScoped<ITenantService, TenantService>();
builder.Services.AddScoped<ITenantResolver, TenantResolver>();
builder.Services.AddDbContext<TenantDbContext>((serviceProvider, options) =>
{
    var tenantResolver = serviceProvider.GetRequiredService<ITenantResolver>();
    var connectionString = tenantResolver.GetTenantConnectionString();
    options.UseNpgsql(connectionString);
});

var app = builder.Build();

// Middleware pipeline
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<TenantResolutionMiddleware>();
app.MapControllers();
```

### Database Architecture

#### Tenant Registry Schema (Central Database)
```sql
-- Central tenant management database
CREATE DATABASE eaudit_registry;

USE eaudit_registry;

-- Tenant master table
CREATE TABLE tenants (
    tenant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_name VARCHAR(255) NOT NULL,
    subdomain VARCHAR(100) UNIQUE NOT NULL,
    database_name VARCHAR(100) UNIQUE NOT NULL,
    connection_string TEXT NOT NULL,
    
    -- Subscription details
    subscription_tier VARCHAR(50) NOT NULL DEFAULT 'standard',
    max_users INTEGER NOT NULL DEFAULT 10,
    max_companies INTEGER NOT NULL DEFAULT 5,
    storage_limit_gb INTEGER NOT NULL DEFAULT 10,
    
    -- Status and lifecycle
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    suspended_at TIMESTAMP WITH TIME ZONE,
    trial_ends_at TIMESTAMP WITH TIME ZONE,
    
    -- Billing
    billing_email VARCHAR(255),
    billing_address JSONB,
    
    -- Technical configuration
    feature_flags JSONB DEFAULT '{}',
    custom_config JSONB DEFAULT '{}',
    
    CONSTRAINT valid_status CHECK (status IN ('active', 'suspended', 'cancelled', 'trial'))
);

-- Tenant users (for cross-tenant admin access)
CREATE TABLE tenant_users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(tenant_id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(50) NOT NULL DEFAULT 'user',
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_login_at TIMESTAMP WITH TIME ZONE,
    
    UNIQUE(tenant_id, email)
);

-- Subscription tracking
CREATE TABLE subscriptions (
    subscription_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(tenant_id),
    plan_id VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    current_period_start TIMESTAMP WITH TIME ZONE NOT NULL,
    current_period_end TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_subscription_status 
        CHECK (status IN ('active', 'past_due', 'cancelled', 'unpaid'))
);

-- Usage metrics for billing
CREATE TABLE usage_metrics (
    metric_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(tenant_id),
    metric_name VARCHAR(100) NOT NULL,
    metric_value BIGINT NOT NULL,
    period_start TIMESTAMP WITH TIME ZONE NOT NULL,
    period_end TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(tenant_id, metric_name, period_start)
);

-- Indexes for performance
CREATE INDEX idx_tenants_subdomain ON tenants(subdomain);
CREATE INDEX idx_tenants_status ON tenants(status);
CREATE INDEX idx_tenant_users_email ON tenant_users(email);
CREATE INDEX idx_tenant_users_tenant_id ON tenant_users(tenant_id);
CREATE INDEX idx_subscriptions_tenant_id ON subscriptions(tenant_id);
CREATE INDEX idx_usage_metrics_tenant_id ON usage_metrics(tenant_id);
```

#### Individual Tenant Database Schema
```sql
-- Template for individual tenant databases
CREATE DATABASE eaudit_tenant_{{TENANT_ID}};

USE eaudit_tenant_{{TENANT_ID}};

-- Core business entities
CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    company_code VARCHAR(50) UNIQUE NOT NULL,
    company_short_name VARCHAR(100),
    
    -- Contact information
    address_line_1 VARCHAR(255),
    address_line_2 VARCHAR(255),
    address_line_3 VARCHAR(255),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(255),
    website VARCHAR(255),
    
    -- Primary contact
    contact_person VARCHAR(255),
    contact_designation VARCHAR(100),
    contact_phone VARCHAR(50),
    contact_email VARCHAR(255),
    
    -- Business details
    currency_id INTEGER,
    industry_sector VARCHAR(100),
    fiscal_year_end DATE,
    
    -- Status and metadata
    status_id INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    updated_by INTEGER,
    
    -- Audit metadata
    version INTEGER DEFAULT 1,
    is_deleted BOOLEAN DEFAULT FALSE,
    
    CONSTRAINT valid_status CHECK (status_id IN (1, 2)) -- 1=Active, 2=Inactive
);

-- Audit periods
CREATE TABLE periods (
    period_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    period_name VARCHAR(255) NOT NULL,
    period_start_date DATE NOT NULL,
    period_end_date DATE NOT NULL,
    audit_type VARCHAR(50) NOT NULL,
    
    -- Period status
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    is_current BOOLEAN DEFAULT FALSE,
    
    -- Audit parameters
    materiality_amount DECIMAL(15,2),
    materiality_percentage DECIMAL(5,2),
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    updated_by INTEGER,
    
    CONSTRAINT valid_audit_type 
        CHECK (audit_type IN ('annual', 'interim', 'quarterly')),
    CONSTRAINT valid_period_status 
        CHECK (status IN ('active', 'closed', 'archived')),
    CONSTRAINT valid_date_range 
        CHECK (period_end_date > period_start_date)
);

-- Chart of accounts
CREATE TABLE account_types (
    account_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    type_code VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    normal_balance VARCHAR(10) NOT NULL,
    
    -- Display settings
    display_order INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_category 
        CHECK (category IN ('assets', 'liabilities', 'equity', 'revenue', 'expenses')),
    CONSTRAINT valid_normal_balance 
        CHECK (normal_balance IN ('debit', 'credit'))
);

CREATE TABLE account_heads (
    account_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    account_type_id INTEGER NOT NULL REFERENCES account_types(account_type_id),
    
    -- Account details
    account_name VARCHAR(255) NOT NULL,
    account_code VARCHAR(50),
    account_description TEXT,
    
    -- Hierarchy
    parent_account_id INTEGER REFERENCES account_heads(account_id),
    account_level INTEGER DEFAULT 1,
    
    -- Trial balance settings
    trial_balance_order INTEGER,
    include_in_trial_balance BOOLEAN DEFAULT TRUE,
    
    -- Status
    status_id INTEGER NOT NULL DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    updated_by INTEGER,
    
    UNIQUE(company_id, account_code),
    CONSTRAINT valid_account_level CHECK (account_level BETWEEN 1 AND 5)
);

-- Trial balance data
CREATE TABLE trial_balance (
    trial_balance_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    period_id INTEGER NOT NULL REFERENCES periods(period_id),
    account_id INTEGER NOT NULL REFERENCES account_heads(account_id),
    
    -- Balance amounts
    opening_debit DECIMAL(15,2) DEFAULT 0,
    opening_credit DECIMAL(15,2) DEFAULT 0,
    period_debit DECIMAL(15,2) DEFAULT 0,
    period_credit DECIMAL(15,2) DEFAULT 0,
    closing_debit DECIMAL(15,2) DEFAULT 0,
    closing_credit DECIMAL(15,2) DEFAULT 0,
    
    -- Adjustments
    adjustment_debit DECIMAL(15,2) DEFAULT 0,
    adjustment_credit DECIMAL(15,2) DEFAULT 0,
    
    -- Final amounts for reporting
    final_debit DECIMAL(15,2) GENERATED ALWAYS AS 
        (closing_debit + adjustment_debit) STORED,
    final_credit DECIMAL(15,2) GENERATED ALWAYS AS 
        (closing_credit + adjustment_credit) STORED,
    
    -- Status and metadata
    is_balanced BOOLEAN DEFAULT TRUE,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by INTEGER,
    
    UNIQUE(company_id, period_id, account_id)
);

-- Journal entries for adjustments
CREATE TABLE journal_entries (
    journal_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    period_id INTEGER NOT NULL REFERENCES periods(period_id),
    
    -- Journal details
    journal_number VARCHAR(50) NOT NULL,
    journal_date DATE NOT NULL,
    reference_number VARCHAR(100),
    description TEXT,
    
    -- Journal type
    journal_type VARCHAR(50) NOT NULL DEFAULT 'adjustment',
    
    -- Totals
    total_debit DECIMAL(15,2) DEFAULT 0,
    total_credit DECIMAL(15,2) DEFAULT 0,
    
    -- Status
    status VARCHAR(50) DEFAULT 'draft',
    is_posted BOOLEAN DEFAULT FALSE,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    posted_at TIMESTAMP WITH TIME ZONE,
    posted_by INTEGER,
    
    UNIQUE(company_id, journal_number),
    CONSTRAINT valid_journal_type 
        CHECK (journal_type IN ('adjustment', 'reclassification', 'error_correction')),
    CONSTRAINT valid_status 
        CHECK (status IN ('draft', 'posted', 'reversed'))
);

CREATE TABLE journal_lines (
    line_id SERIAL PRIMARY KEY,
    journal_id INTEGER NOT NULL REFERENCES journal_entries(journal_id) ON DELETE CASCADE,
    account_id INTEGER NOT NULL REFERENCES account_heads(account_id),
    
    -- Line details
    line_number INTEGER NOT NULL,
    description TEXT,
    
    -- Amounts
    debit_amount DECIMAL(15,2) DEFAULT 0,
    credit_amount DECIMAL(15,2) DEFAULT 0,
    
    -- Reference
    reference VARCHAR(255),
    
    CONSTRAINT valid_amounts 
        CHECK ((debit_amount > 0 AND credit_amount = 0) OR 
               (credit_amount > 0 AND debit_amount = 0))
);

-- Audit procedures
CREATE TABLE procedure_templates (
    template_id SERIAL PRIMARY KEY,
    template_name VARCHAR(255) NOT NULL,
    template_category VARCHAR(100),
    procedure_text TEXT NOT NULL,
    
    -- Configuration
    is_mandatory BOOLEAN DEFAULT FALSE,
    estimated_hours DECIMAL(5,2),
    required_skills JSONB,
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    version INTEGER DEFAULT 1,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE procedures (
    procedure_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    period_id INTEGER NOT NULL REFERENCES periods(period_id),
    template_id INTEGER REFERENCES procedure_templates(template_id),
    
    -- Procedure details
    procedure_name VARCHAR(255) NOT NULL,
    procedure_description TEXT,
    procedure_type VARCHAR(100),
    account_id INTEGER REFERENCES account_heads(account_id),
    
    -- Assignment and tracking
    assigned_to INTEGER,
    assigned_date DATE,
    due_date DATE,
    estimated_hours DECIMAL(5,2),
    actual_hours DECIMAL(5,2),
    
    -- Status tracking
    status VARCHAR(50) DEFAULT 'not_started',
    completion_percentage INTEGER DEFAULT 0,
    
    -- Review process
    review_status VARCHAR(50) DEFAULT 'not_reviewed',
    reviewer_id INTEGER,
    reviewed_date DATE,
    review_notes TEXT,
    
    -- Final sign-off
    signed_off_by INTEGER,
    signed_off_date DATE,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    updated_by INTEGER,
    
    CONSTRAINT valid_status 
        CHECK (status IN ('not_started', 'in_progress', 'completed', 'on_hold')),
    CONSTRAINT valid_review_status 
        CHECK (review_status IN ('not_reviewed', 'in_review', 'reviewed', 'approved')),
    CONSTRAINT valid_completion_percentage 
        CHECK (completion_percentage BETWEEN 0 AND 100)
);

-- Document management
CREATE TABLE documents (
    document_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    
    -- Document metadata
    document_name VARCHAR(255) NOT NULL,
    original_filename VARCHAR(255),
    file_extension VARCHAR(10),
    mime_type VARCHAR(100),
    file_size_bytes BIGINT,
    
    -- Storage information
    storage_provider VARCHAR(50) DEFAULT 's3',
    storage_path TEXT NOT NULL,
    storage_bucket VARCHAR(100),
    
    -- Document classification
    document_type VARCHAR(100),
    category VARCHAR(100),
    classification VARCHAR(50) DEFAULT 'confidential',
    
    -- Linking
    linked_entity_type VARCHAR(50), -- 'procedure', 'account', 'company'
    linked_entity_id INTEGER,
    
    -- Version control
    version INTEGER DEFAULT 1,
    is_current_version BOOLEAN DEFAULT TRUE,
    parent_document_id INTEGER REFERENCES documents(document_id),
    
    -- Security
    access_level VARCHAR(50) DEFAULT 'internal',
    password_protected BOOLEAN DEFAULT FALSE,
    
    -- Metadata
    uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    uploaded_by INTEGER NOT NULL,
    last_accessed_at TIMESTAMP WITH TIME ZONE,
    
    -- Compliance
    retention_period INTERVAL DEFAULT '7 years',
    scheduled_deletion_date DATE GENERATED ALWAYS AS 
        (DATE(uploaded_at + retention_period)) STORED,
    
    CONSTRAINT valid_file_size CHECK (file_size_bytes > 0),
    CONSTRAINT valid_classification 
        CHECK (classification IN ('public', 'internal', 'confidential', 'restricted')),
    CONSTRAINT valid_access_level 
        CHECK (access_level IN ('public', 'internal', 'restricted'))
);

-- Users (tenant-specific)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    
    -- Personal information
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    display_name VARCHAR(200) GENERATED ALWAYS AS 
        (first_name || ' ' || last_name) STORED,
    
    -- Professional information
    job_title VARCHAR(100),
    department VARCHAR(100),
    employee_id VARCHAR(50),
    
    -- Contact information
    phone VARCHAR(50),
    mobile VARCHAR(50),
    
    -- System access
    role VARCHAR(50) NOT NULL DEFAULT 'auditor',
    permissions JSONB DEFAULT '[]',
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Session management
    last_login_at TIMESTAMP WITH TIME ZONE,
    last_activity_at TIMESTAMP WITH TIME ZONE,
    login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP WITH TIME ZONE,
    
    -- Preferences
    timezone VARCHAR(50) DEFAULT 'UTC',
    language VARCHAR(10) DEFAULT 'en',
    theme VARCHAR(20) DEFAULT 'light',
    
    -- Password policy
    password_changed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    must_change_password BOOLEAN DEFAULT FALSE,
    
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by INTEGER,
    
    CONSTRAINT valid_role 
        CHECK (role IN ('admin', 'manager', 'senior_auditor', 'auditor', 'intern')),
    CONSTRAINT valid_login_attempts 
        CHECK (login_attempts >= 0)
);

-- Comprehensive audit trail
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    
    -- Entity information
    table_name VARCHAR(100) NOT NULL,
    record_id VARCHAR(100) NOT NULL,
    action VARCHAR(50) NOT NULL,
    
    -- Change details
    old_values JSONB,
    new_values JSONB,
    changed_fields JSONB GENERATED ALWAYS AS (
        CASE 
            WHEN old_values IS NULL THEN new_values
            WHEN new_values IS NULL THEN old_values
            ELSE (
                SELECT jsonb_object_agg(key, value)
                FROM jsonb_each(new_values)
                WHERE value != COALESCE(old_values->key, 'null'::jsonb)
            )
        END
    ) STORED,
    
    -- User context
    user_id INTEGER,
    user_email VARCHAR(255),
    
    -- Session context
    session_id VARCHAR(255),
    ip_address INET,
    user_agent TEXT,
    
    -- Request context
    request_id VARCHAR(255),
    endpoint VARCHAR(255),
    http_method VARCHAR(10),
    
    -- Timing
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    processing_time_ms INTEGER,
    
    -- Classification
    risk_level VARCHAR(20) DEFAULT 'low',
    compliance_relevant BOOLEAN DEFAULT FALSE,
    
    -- Retention
    retention_period INTERVAL DEFAULT '7 years',
    archived_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT valid_action 
        CHECK (action IN ('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT', 'ACCESS')),
    CONSTRAINT valid_risk_level 
        CHECK (risk_level IN ('low', 'medium', 'high', 'critical'))
);

-- Performance indexes
CREATE INDEX idx_companies_status ON companies(status_id);
CREATE INDEX idx_companies_code ON companies(company_code);

CREATE INDEX idx_periods_company ON periods(company_id);
CREATE INDEX idx_periods_status ON periods(status);
CREATE INDEX idx_periods_current ON periods(company_id, is_current) WHERE is_current = TRUE;

CREATE INDEX idx_account_heads_company ON account_heads(company_id);
CREATE INDEX idx_account_heads_type ON account_heads(account_type_id);
CREATE INDEX idx_account_heads_parent ON account_heads(parent_account_id);
CREATE INDEX idx_account_heads_code ON account_heads(company_id, account_code);

CREATE INDEX idx_trial_balance_company_period ON trial_balance(company_id, period_id);
CREATE INDEX idx_trial_balance_account ON trial_balance(account_id);

CREATE INDEX idx_journal_entries_company_period ON journal_entries(company_id, period_id);
CREATE INDEX idx_journal_entries_date ON journal_entries(journal_date);
CREATE INDEX idx_journal_entries_status ON journal_entries(status);

CREATE INDEX idx_procedures_company_period ON procedures(company_id, period_id);
CREATE INDEX idx_procedures_assigned ON procedures(assigned_to);
CREATE INDEX idx_procedures_status ON procedures(status);
CREATE INDEX idx_procedures_review ON procedures(review_status);

CREATE INDEX idx_documents_company ON documents(company_id);
CREATE INDEX idx_documents_type ON documents(document_type);
CREATE INDEX idx_documents_linked ON documents(linked_entity_type, linked_entity_id);
CREATE INDEX idx_documents_uploaded ON documents(uploaded_at);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_active ON users(is_active);

CREATE INDEX idx_audit_logs_table_record ON audit_logs(table_name, record_id);
CREATE INDEX idx_audit_logs_user ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_logs_compliance ON audit_logs(compliance_relevant) WHERE compliance_relevant = TRUE;

-- Row Level Security (RLS) for additional data isolation
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE periods ENABLE ROW LEVEL SECURITY;
ALTER TABLE account_heads ENABLE ROW LEVEL SECURITY;
ALTER TABLE trial_balance ENABLE ROW LEVEL SECURITY;
ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE procedures ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;

-- RLS policies (to be applied by application with proper context)
-- CREATE POLICY tenant_isolation ON companies FOR ALL USING (current_setting('app.tenant_id')::integer = tenant_id);
```

## Microservices Architecture

### Service Communication Patterns

#### Synchronous Communication (HTTP/REST)
```typescript
// API Client with tenant context
class ApiClient {
  private baseURL: string;
  private tenantId: string;
  private authToken: string;

  constructor(tenantId: string, authToken: string) {
    this.baseURL = process.env.API_BASE_URL || 'https://api.eauditpro.com';
    this.tenantId = tenantId;
    this.authToken = authToken;
  }

  private async request<T>(
    endpoint: string, 
    options: RequestInit = {}
  ): Promise<T> {
    const url = `${this.baseURL}${endpoint}`;
    const headers = {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${this.authToken}`,
      'X-Tenant-ID': this.tenantId,
      ...options.headers,
    };

    const response = await fetch(url, {
      ...options,
      headers,
    });

    if (!response.ok) {
      throw new ApiError(response.status, await response.text());
    }

    return response.json();
  }

  // Service-specific methods
  async getCompanies(): Promise<Company[]> {
    return this.request<Company[]>('/api/v1/companies');
  }

  async createCompany(company: CreateCompanyRequest): Promise<Company> {
    return this.request<Company>('/api/v1/companies', {
      method: 'POST',
      body: JSON.stringify(company),
    });
  }
}
```

#### Asynchronous Communication (Message Queue)
```typescript
// Event-driven architecture with Redis Streams
interface DomainEvent {
  eventId: string;
  eventType: string;
  aggregateId: string;
  tenantId: string;
  timestamp: Date;
  payload: any;
  version: number;
}

class EventPublisher {
  private redis: Redis;

  constructor(redis: Redis) {
    this.redis = redis;
  }

  async publish(event: DomainEvent): Promise<void> {
    const streamKey = `events:${event.tenantId}:${event.eventType}`;
    
    await this.redis.xadd(
      streamKey,
      '*',
      'eventId', event.eventId,
      'aggregateId', event.aggregateId,
      'payload', JSON.stringify(event.payload),
      'timestamp', event.timestamp.toISOString(),
      'version', event.version.toString()
    );
  }
}

class EventHandler {
  private redis: Redis;
  private consumerGroup: string;
  private consumerName: string;

  constructor(redis: Redis, consumerGroup: string, consumerName: string) {
    this.redis = redis;
    this.consumerGroup = consumerGroup;
    this.consumerName = consumerName;
  }

  async handleEvents(streamKey: string): Promise<void> {
    while (true) {
      try {
        const messages = await this.redis.xreadgroup(
          'GROUP', this.consumerGroup, this.consumerName,
          'BLOCK', 5000,
          'COUNT', 10,
          'STREAMS', streamKey, '>'
        );

        for (const [stream, streamMessages] of messages) {
          for (const [messageId, fields] of streamMessages) {
            await this.processMessage(messageId, fields);
            await this.redis.xack(streamKey, this.consumerGroup, messageId);
          }
        }
      } catch (error) {
        console.error('Error processing events:', error);
        await new Promise(resolve => setTimeout(resolve, 5000));
      }
    }
  }

  private async processMessage(messageId: string, fields: any[]): Promise<void> {
    // Convert Redis array format to object
    const event: Partial<DomainEvent> = {};
    for (let i = 0; i < fields.length; i += 2) {
      event[fields[i]] = fields[i + 1];
    }
    
    // Handle the specific event
    await this.handleDomainEvent(event as DomainEvent);
  }

  protected async handleDomainEvent(event: DomainEvent): Promise<void> {
    // Override in concrete implementations
    throw new Error('Not implemented');
  }
}
```

### Individual Service Architectures

#### 1. Tenant Management Service
```typescript
// Domain Model
interface Tenant {
  id: string;
  name: string;
  subdomain: string;
  databaseName: string;
  subscriptionTier: SubscriptionTier;
  status: TenantStatus;
  configuration: TenantConfiguration;
  createdAt: Date;
  updatedAt: Date;
}

interface TenantConfiguration {
  features: FeatureFlag[];
  limits: UsageLimits;
  customization: CustomizationSettings;
}

// Service Implementation
@injectable()
class TenantService {
  constructor(
    @inject('TenantRepository') private tenantRepo: ITenantRepository,
    @inject('DatabaseProvisioningService') private dbService: IDatabaseProvisioningService,
    @inject('EventPublisher') private eventPublisher: IEventPublisher
  ) {}

  async createTenant(request: CreateTenantRequest): Promise<Tenant> {
    // Validate request
    await this.validateTenantCreation(request);

    // Generate unique identifiers
    const tenantId = uuidv4();
    const databaseName = `eaudit_tenant_${tenantId.replace(/-/g, '_')}`;

    // Create database
    await this.dbService.createTenantDatabase(databaseName);

    // Create tenant record
    const tenant = await this.tenantRepo.create({
      id: tenantId,
      name: request.name,
      subdomain: request.subdomain,
      databaseName,
      subscriptionTier: request.subscriptionTier || 'standard',
      status: 'active',
      configuration: this.getDefaultConfiguration(),
    });

    // Publish event
    await this.eventPublisher.publish({
      eventId: uuidv4(),
      eventType: 'TenantCreated',
      aggregateId: tenantId,
      tenantId,
      timestamp: new Date(),
      payload: { tenant },
      version: 1,
    });

    return tenant;
  }

  async getTenantBySubdomain(subdomain: string): Promise<Tenant | null> {
    return this.tenantRepo.findBySubdomain(subdomain);
  }

  async updateTenantConfiguration(
    tenantId: string, 
    configuration: Partial<TenantConfiguration>
  ): Promise<Tenant> {
    const tenant = await this.tenantRepo.findById(tenantId);
    if (!tenant) {
      throw new TenantNotFoundError(tenantId);
    }

    const updatedTenant = await this.tenantRepo.update(tenantId, {
      configuration: { ...tenant.configuration, ...configuration },
      updatedAt: new Date(),
    });

    await this.eventPublisher.publish({
      eventId: uuidv4(),
      eventType: 'TenantConfigurationUpdated',
      aggregateId: tenantId,
      tenantId,
      timestamp: new Date(),
      payload: { configuration },
      version: 1,
    });

    return updatedTenant;
  }

  private getDefaultConfiguration(): TenantConfiguration {
    return {
      features: [
        { name: 'advanced_reporting', enabled: false },
        { name: 'api_access', enabled: true },
        { name: 'sso_integration', enabled: false },
      ],
      limits: {
        maxUsers: 10,
        maxCompanies: 5,
        storageGB: 10,
        apiCallsPerHour: 1000,
      },
      customization: {
        logoUrl: null,
        primaryColor: '#1976d2',
        customDomain: null,
      },
    };
  }
}

// Controller
@controller('/api/v1/tenants')
class TenantController {
  constructor(@inject('TenantService') private tenantService: TenantService) {}

  @httpPost('/')
  @authenticate()
  @authorize(['system_admin'])
  async createTenant(@request() req: Request): Promise<Tenant> {
    const createRequest = plainToClass(CreateTenantRequest, req.body);
    await this.validateRequest(createRequest);
    
    return this.tenantService.createTenant(createRequest);
  }

  @httpGet('/:subdomain')
  async getTenantBySubdomain(@requestParam('subdomain') subdomain: string): Promise<Tenant> {
    const tenant = await this.tenantService.getTenantBySubdomain(subdomain);
    if (!tenant) {
      throw new NotFoundError(`Tenant with subdomain '${subdomain}' not found`);
    }
    return tenant;
  }
}
```

#### 2. Authentication & Authorization Service
```typescript
// JWT Token Structure
interface JWTPayload {
  sub: string; // user ID
  email: string;
  tenantId: string;
  role: string;
  permissions: string[];
  iat: number;
  exp: number;
}

// Authentication Service
@injectable()
class AuthenticationService {
  constructor(
    @inject('UserRepository') private userRepo: IUserRepository,
    @inject('TenantService') private tenantService: ITenantService,
    @inject('PasswordService') private passwordService: IPasswordService,
    @inject('JwtService') private jwtService: IJwtService,
    @inject('AuditLogger') private auditLogger: IAuditLogger
  ) {}

  async authenticate(credentials: LoginCredentials): Promise<AuthenticationResult> {
    // Resolve tenant
    const tenant = await this.tenantService.getTenantBySubdomain(credentials.subdomain);
    if (!tenant || tenant.status !== 'active') {
      throw new InvalidCredentialsError();
    }

    // Find user in tenant context
    const user = await this.userRepo.findByEmail(credentials.email, tenant.id);
    if (!user || !user.isActive) {
      await this.auditLogger.log({
        action: 'LOGIN_FAILED',
        reason: 'USER_NOT_FOUND',
        tenantId: tenant.id,
        email: credentials.email,
        ipAddress: credentials.ipAddress,
      });
      throw new InvalidCredentialsError();
    }

    // Check account lockout
    if (user.lockedUntil && user.lockedUntil > new Date()) {
      throw new AccountLockedError(user.lockedUntil);
    }

    // Verify password
    const isPasswordValid = await this.passwordService.verify(
      credentials.password, 
      user.passwordHash
    );

    if (!isPasswordValid) {
      await this.handleFailedLogin(user, tenant.id, credentials.ipAddress);
      throw new InvalidCredentialsError();
    }

    // Reset failed attempts
    if (user.loginAttempts > 0) {
      await this.userRepo.update(user.id, {
        loginAttempts: 0,
        lockedUntil: null,
      });
    }

    // Generate tokens
    const accessToken = await this.generateAccessToken(user, tenant);
    const refreshToken = await this.generateRefreshToken(user, tenant);

    // Update last login
    await this.userRepo.update(user.id, {
      lastLoginAt: new Date(),
      lastActivityAt: new Date(),
    });

    // Log successful authentication
    await this.auditLogger.log({
      action: 'LOGIN_SUCCESS',
      tenantId: tenant.id,
      userId: user.id,
      ipAddress: credentials.ipAddress,
      userAgent: credentials.userAgent,
    });

    return {
      accessToken,
      refreshToken,
      user: this.sanitizeUser(user),
      tenant: this.sanitizeTenant(tenant),
      expiresIn: 3600, // 1 hour
    };
  }

  private async generateAccessToken(user: User, tenant: Tenant): Promise<string> {
    const payload: JWTPayload = {
      sub: user.id,
      email: user.email,
      tenantId: tenant.id,
      role: user.role,
      permissions: this.getUserPermissions(user, tenant),
      iat: Math.floor(Date.now() / 1000),
      exp: Math.floor(Date.now() / 1000) + 3600, // 1 hour
    };

    return this.jwtService.sign(payload);
  }

  private getUserPermissions(user: User, tenant: Tenant): string[] {
    const rolePermissions = this.getRolePermissions(user.role);
    const tenantPermissions = this.getTenantPermissions(tenant);
    const userPermissions = user.permissions || [];

    return [...new Set([...rolePermissions, ...tenantPermissions, ...userPermissions])];
  }

  private getRolePermissions(role: string): string[] {
    const roleMap: Record<string, string[]> = {
      'admin': [
        'companies.create', 'companies.read', 'companies.update', 'companies.delete',
        'users.create', 'users.read', 'users.update', 'users.delete',
        'procedures.create', 'procedures.read', 'procedures.update', 'procedures.delete',
        'documents.create', 'documents.read', 'documents.update', 'documents.delete',
        'reports.generate', 'settings.manage'
      ],
      'manager': [
        'companies.create', 'companies.read', 'companies.update',
        'users.read', 'users.update',
        'procedures.create', 'procedures.read', 'procedures.update',
        'procedures.assign', 'procedures.review',
        'documents.create', 'documents.read', 'documents.update',
        'reports.generate'
      ],
      'senior_auditor': [
        'companies.read',
        'procedures.create', 'procedures.read', 'procedures.update',
        'documents.create', 'documents.read', 'documents.update',
        'reports.generate'
      ],
      'auditor': [
        'companies.read',
        'procedures.read', 'procedures.update',
        'documents.create', 'documents.read',
        'reports.view'
      ],
    };

    return roleMap[role] || [];
  }
}

// Authorization Middleware
export function authorize(requiredPermissions: string[]) {
  return (target: any, propertyName: string, descriptor: PropertyDescriptor) => {
    const method = descriptor.value;

    descriptor.value = async function (...args: any[]) {
      const req = args.find(arg => arg.user && arg.headers);
      
      if (!req?.user) {
        throw new UnauthorizedError('Authentication required');
      }

      const userPermissions: string[] = req.user.permissions || [];
      const hasPermission = requiredPermissions.every(permission =>
        userPermissions.includes(permission)
      );

      if (!hasPermission) {
        throw new ForbiddenError('Insufficient permissions');
      }

      return method.apply(this, args);
    };

    return descriptor;
  };
}
```

#### 3. Audit Core Service
```typescript
// Domain Models
interface Company {
  id: number;
  name: string;
  code: string;
  shortName?: string;
  contactInfo: ContactInfo;
  businessInfo: BusinessInfo;
  status: CompanyStatus;
  metadata: EntityMetadata;
}

interface Period {
  id: number;
  companyId: number;
  name: string;
  startDate: Date;
  endDate: Date;
  auditType: AuditType;
  status: PeriodStatus;
  isCurrent: boolean;
  auditParameters: AuditParameters;
  metadata: EntityMetadata;
}

interface Account {
  id: number;
  companyId: number;
  typeId: number;
  name: string;
  code: string;
  description?: string;
  parentAccountId?: number;
  level: number;
  trialBalanceOrder?: number;
  status: AccountStatus;
  metadata: EntityMetadata;
}

// Service Implementation
@injectable()
class CompanyService {
  constructor(
    @inject('CompanyRepository') private companyRepo: ICompanyRepository,
    @inject('PeriodRepository') private periodRepo: IPeriodRepository,
    @inject('EventPublisher') private eventPublisher: IEventPublisher,
    @inject('TenantContext') private tenantContext: ITenantContext
  ) {}

  async createCompany(request: CreateCompanyRequest): Promise<Company> {
    const tenantId = this.tenantContext.getTenantId();
    
    // Validate business rules
    await this.validateCompanyCreation(request, tenantId);

    // Create company
    const company = await this.companyRepo.create({
      ...request,
      status: 'active',
      metadata: {
        createdAt: new Date(),
        createdBy: this.tenantContext.getUserId(),
        version: 1,
      },
    });

    // Create default period if requested
    if (request.createDefaultPeriod) {
      await this.createDefaultPeriod(company.id, request.defaultPeriod);
    }

    // Publish domain event
    await this.eventPublisher.publish({
      eventId: uuidv4(),
      eventType: 'CompanyCreated',
      aggregateId: company.id.toString(),
      tenantId,
      timestamp: new Date(),
      payload: { company },
      version: 1,
    });

    return company;
  }

  async getCompanies(filters?: CompanyFilters): Promise<PaginatedResult<Company>> {
    const tenantId = this.tenantContext.getTenantId();
    return this.companyRepo.findAll(tenantId, filters);
  }

  async getCompanyById(companyId: number): Promise<Company> {
    const tenantId = this.tenantContext.getTenantId();
    const company = await this.companyRepo.findById(companyId, tenantId);
    
    if (!company) {
      throw new CompanyNotFoundError(companyId);
    }

    return company;
  }

  async updateCompany(companyId: number, request: UpdateCompanyRequest): Promise<Company> {
    const tenantId = this.tenantContext.getTenantId();
    const existingCompany = await this.getCompanyById(companyId);

    // Check for optimistic locking
    if (request.version && request.version !== existingCompany.metadata.version) {
      throw new ConcurrencyError('Company has been modified by another user');
    }

    const updatedCompany = await this.companyRepo.update(companyId, {
      ...request,
      metadata: {
        ...existingCompany.metadata,
        updatedAt: new Date(),
        updatedBy: this.tenantContext.getUserId(),
        version: existingCompany.metadata.version + 1,
      },
    }, tenantId);

    await this.eventPublisher.publish({
      eventId: uuidv4(),
      eventType: 'CompanyUpdated',
      aggregateId: companyId.toString(),
      tenantId,
      timestamp: new Date(),
      payload: { 
        companyId, 
        changes: request,
        previousVersion: existingCompany.metadata.version,
      },
      version: 1,
    });

    return updatedCompany;
  }

  private async createDefaultPeriod(companyId: number, periodRequest?: CreatePeriodRequest): Promise<Period> {
    const defaultRequest: CreatePeriodRequest = {
      name: periodRequest?.name || `FY ${new Date().getFullYear()}`,
      startDate: periodRequest?.startDate || new Date(new Date().getFullYear(), 0, 1),
      endDate: periodRequest?.endDate || new Date(new Date().getFullYear(), 11, 31),
      auditType: periodRequest?.auditType || 'annual',
      isCurrent: true,
      auditParameters: {
        materialityAmount: periodRequest?.auditParameters?.materialityAmount,
        materialityPercentage: periodRequest?.auditParameters?.materialityPercentage || 5,
      },
    };

    return this.createPeriod(companyId, defaultRequest);
  }

  async createPeriod(companyId: number, request: CreatePeriodRequest): Promise<Period> {
    const tenantId = this.tenantContext.getTenantId();
    
    // Validate company exists
    await this.getCompanyById(companyId);

    // Validate period dates
    if (request.endDate <= request.startDate) {
      throw new ValidationError('End date must be after start date');
    }

    // Check for overlapping periods
    const overlappingPeriod = await this.periodRepo.findOverlapping(
      companyId, 
      request.startDate, 
      request.endDate,
      tenantId
    );

    if (overlappingPeriod) {
      throw new ValidationError('Period dates overlap with existing period');
    }

    // If setting as current, update other periods
    if (request.isCurrent) {
      await this.periodRepo.clearCurrentFlags(companyId, tenantId);
    }

    const period = await this.periodRepo.create({
      companyId,
      ...request,
      status: 'active',
      metadata: {
        createdAt: new Date(),
        createdBy: this.tenantContext.getUserId(),
        version: 1,
      },
    }, tenantId);

    await this.eventPublisher.publish({
      eventId: uuidv4(),
      eventType: 'PeriodCreated',
      aggregateId: period.id.toString(),
      tenantId,
      timestamp: new Date(),
      payload: { period, companyId },
      version: 1,
    });

    return period;
  }
}

// Repository Implementation with Multi-tenancy
@injectable()
class PostgresCompanyRepository implements ICompanyRepository {
  constructor(@inject('DatabaseContext') private db: IDatabaseContext) {}

  async create(company: CreateCompanyData): Promise<Company> {
    const query = `
      INSERT INTO companies (
        company_name, company_code, company_short_name,
        address_line_1, address_line_2, address_line_3,
        phone, email, website,
        contact_person, contact_designation, contact_phone, contact_email,
        currency_id, industry_sector, fiscal_year_end,
        status_id, created_at, created_by
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19
      ) RETURNING *
    `;

    const values = [
      company.name,
      company.code,
      company.shortName,
      company.contactInfo?.addressLine1,
      company.contactInfo?.addressLine2,
      company.contactInfo?.addressLine3,
      company.contactInfo?.phone,
      company.contactInfo?.email,
      company.contactInfo?.website,
      company.contactInfo?.contactPerson,
      company.contactInfo?.contactDesignation,
      company.contactInfo?.contactPhone,
      company.contactInfo?.contactEmail,
      company.businessInfo?.currencyId,
      company.businessInfo?.industrySector,
      company.businessInfo?.fiscalYearEnd,
      company.status === 'active' ? 1 : 2,
      company.metadata.createdAt,
      company.metadata.createdBy,
    ];

    const result = await this.db.query(query, values);
    return this.mapToCompany(result.rows[0]);
  }

  async findAll(tenantId: string, filters?: CompanyFilters): Promise<PaginatedResult<Company>> {
    let query = 'SELECT * FROM companies WHERE is_deleted = FALSE';
    const params: any[] = [];
    let paramCount = 0;

    if (filters?.search) {
      paramCount++;
      query += ` AND (company_name ILIKE $${paramCount} OR company_code ILIKE $${paramCount})`;
      params.push(`%${filters.search}%`);
    }

    if (filters?.status) {
      paramCount++;
      query += ` AND status_id = $${paramCount}`;
      params.push(filters.status === 'active' ? 1 : 2);
    }

    // Add pagination
    const page = filters?.page || 1;
    const limit = filters?.limit || 50;
    const offset = (page - 1) * limit;

    query += ` ORDER BY company_name LIMIT $${++paramCount} OFFSET $${++paramCount}`;
    params.push(limit, offset);

    const [dataResult, countResult] = await Promise.all([
      this.db.query(query, params),
      this.db.query('SELECT COUNT(*) FROM companies WHERE is_deleted = FALSE', []),
    ]);

    return {
      data: dataResult.rows.map(row => this.mapToCompany(row)),
      pagination: {
        page,
        limit,
        total: parseInt(countResult.rows[0].count),
        totalPages: Math.ceil(parseInt(countResult.rows[0].count) / limit),
      },
    };
  }

  private mapToCompany(row: any): Company {
    return {
      id: row.company_id,
      name: row.company_name,
      code: row.company_code,
      shortName: row.company_short_name,
      contactInfo: {
        addressLine1: row.address_line_1,
        addressLine2: row.address_line_2,
        addressLine3: row.address_line_3,
        phone: row.phone,
        email: row.email,
        website: row.website,
        contactPerson: row.contact_person,
        contactDesignation: row.contact_designation,
        contactPhone: row.contact_phone,
        contactEmail: row.contact_email,
      },
      businessInfo: {
        currencyId: row.currency_id,
        industrySector: row.industry_sector,
        fiscalYearEnd: row.fiscal_year_end,
      },
      status: row.status_id === 1 ? 'active' : 'inactive',
      metadata: {
        createdAt: row.created_at,
        updatedAt: row.updated_at,
        createdBy: row.created_by,
        updatedBy: row.updated_by,
        version: row.version,
        isDeleted: row.is_deleted,
      },
    };
  }
}
```

This technical architecture provides a comprehensive foundation for building a scalable, secure, and maintainable multi-tenant audit management system. The design emphasizes data isolation, performance, security, and developer productivity while maintaining the rich feature set of the original desktop application.