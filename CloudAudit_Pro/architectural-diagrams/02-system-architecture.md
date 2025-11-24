# CloudAudit Pro - System Architecture Diagrams

## Overall System Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        WEB[Web Application<br/>React + TypeScript]
        MOB[Mobile App<br/>(Future)]
    end
    
    subgraph "Load Balancer & CDN"
        LB[Load Balancer]
        CDN[Content Delivery Network]
    end
    
    subgraph "Application Layer"
        API[NestJS API Server]
        AUTH[Authentication Service]
        EMAIL[Email Service]
        FILE[File Service]
    end
    
    subgraph "Data Layer"
        DB[(PostgreSQL<br/>Primary Database)]
        REDIS[(Redis Cache<br/>Sessions & Temp Data)]
        BLOB[File Storage<br/>Azure Blob/S3]
    end
    
    subgraph "External Services"
        SMTP[Email Provider<br/>SendGrid/SES]
        MONITOR[Monitoring<br/>New Relic/DataDog]
    end
    
    WEB --> LB
    MOB --> LB
    LB --> API
    CDN --> WEB
    
    API --> AUTH
    API --> EMAIL
    API --> FILE
    API --> DB
    API --> REDIS
    
    EMAIL --> SMTP
    FILE --> BLOB
    API --> MONITOR
```

## Database Architecture

```mermaid
erDiagram
    TENANT ||--o{ TENANT_USER : has
    TENANT ||--o{ COMPANY : contains
    TENANT ||--o{ SUBSCRIPTION : subscribes
    
    COMPANY ||--o{ USER : employs
    COMPANY ||--o{ PERIOD : manages
    COMPANY ||--o{ DOCUMENT : owns
    
    USER ||--o{ TENANT_USER : "maps to"
    USER ||--o{ PROCEDURE : assigned
    USER ||--o{ AUDIT_LOG : creates
    
    PERIOD ||--o{ ACCOUNT_HEAD : contains
    PERIOD ||--o{ TRIAL_BALANCE_ENTRY : includes
    PERIOD ||--o{ JOURNAL_ENTRY : records
    
    PROCEDURE ||--o{ DOCUMENT : generates
    PROCEDURE ||--o{ REPORT : produces
    
    TENANT {
        string id PK
        string name
        string subdomain
        string status
        datetime createdAt
        datetime approvedAt
    }
    
    TENANT_USER {
        string id PK
        string tenantId FK
        string userId FK
        string role
        string status
        boolean isDeleted
    }
    
    USER {
        string id PK
        string email UK
        string firstName
        string lastName
        string hashedPassword
        datetime lastLoginAt
    }
    
    COMPANY {
        string id PK
        string tenantId FK
        string name
        string industry
        string size
        json settings
    }
    
    PERIOD {
        string id PK
        string companyId FK
        string name
        date startDate
        date endDate
        string status
    }
    
    PROCEDURE {
        string id PK
        string companyId FK
        string assignedToId FK
        string name
        string status
        json template
    }
    
    DOCUMENT {
        string id PK
        string companyId FK
        string uploadedById FK
        string fileName
        string filePath
        string category
    }
```

## Microservices Architecture (Future State)

```mermaid
graph TB
    subgraph "API Gateway"
        GW[Kong/Nginx Gateway<br/>Rate Limiting, Auth]
    end
    
    subgraph "Core Services"
        AUTH_SVC[Authentication Service<br/>JWT, RBAC, Sessions]
        USER_SVC[User Management Service<br/>CRUD, Invitations, Roles]
        TENANT_SVC[Tenant Service<br/>Multi-tenancy, Isolation]
        COMPANY_SVC[Company Service<br/>Settings, Periods]
    end
    
    subgraph "Business Services"
        DOC_SVC[Document Service<br/>Upload, Storage, Metadata]
        PROC_SVC[Procedure Service<br/>Workflows, Templates]
        RPT_SVC[Report Service<br/>Generation, Analytics]
        AUDIT_SVC[Audit Service<br/>Trail, Compliance]
    end
    
    subgraph "Infrastructure Services"
        EMAIL_SVC[Email Service<br/>Templates, Notifications]
        FILE_SVC[File Service<br/>Storage, CDN]
        SEARCH_SVC[Search Service<br/>ElasticSearch]
        NOTIF_SVC[Notification Service<br/>Real-time Updates]
    end
    
    subgraph "Data Stores"
        MAIN_DB[(Main Database<br/>PostgreSQL)]
        DOC_DB[(Document Store<br/>MongoDB)]
        SEARCH_DB[(Search Index<br/>ElasticSearch)]
        CACHE[(Cache Layer<br/>Redis)]
        BLOB_STORAGE[(File Storage<br/>S3/Azure Blob)]
    end
    
    GW --> AUTH_SVC
    GW --> USER_SVC
    GW --> TENANT_SVC
    GW --> COMPANY_SVC
    GW --> DOC_SVC
    GW --> PROC_SVC
    GW --> RPT_SVC
    GW --> AUDIT_SVC
    
    AUTH_SVC --> MAIN_DB
    USER_SVC --> MAIN_DB
    TENANT_SVC --> MAIN_DB
    COMPANY_SVC --> MAIN_DB
    
    DOC_SVC --> DOC_DB
    DOC_SVC --> BLOB_STORAGE
    PROC_SVC --> MAIN_DB
    RPT_SVC --> MAIN_DB
    AUDIT_SVC --> MAIN_DB
    
    EMAIL_SVC --> CACHE
    FILE_SVC --> BLOB_STORAGE
    SEARCH_SVC --> SEARCH_DB
    NOTIF_SVC --> CACHE
```

## Security Architecture

```mermaid
graph TB
    subgraph "Security Layers"
        WAF[Web Application Firewall<br/>DDoS Protection, Rate Limiting]
        
        subgraph "Application Security"
            JWT[JWT Token Validation]
            RBAC[Role-Based Access Control]
            TENANT[Tenant Isolation]
            AUDIT[Security Audit Logging]
        end
        
        subgraph "Data Security"
            ENCRYPT[Data Encryption at Rest]
            TLS[TLS 1.3 in Transit]
            BACKUP[Encrypted Backups]
            KEY[Key Management]
        end
        
        subgraph "Infrastructure Security"
            VPN[Private Network/VPN]
            FW[Network Firewall]
            MONITOR[Security Monitoring]
            INCIDENT[Incident Response]
        end
    end
    
    WAF --> JWT
    JWT --> RBAC
    RBAC --> TENANT
    TENANT --> AUDIT
    
    ENCRYPT --> TLS
    TLS --> BACKUP
    BACKUP --> KEY
    
    VPN --> FW
    FW --> MONITOR
    MONITOR --> INCIDENT
```

## Deployment Architecture

```mermaid
graph TB
    subgraph "Production Environment"
        subgraph "Web Tier (DMZ)"
            LB[Load Balancer<br/>HAProxy/ALB]
            WEB1[Web Server 1<br/>Nginx + React App]
            WEB2[Web Server 2<br/>Nginx + React App]
        end
        
        subgraph "Application Tier"
            APP1[API Server 1<br/>NestJS + Node.js]
            APP2[API Server 2<br/>NestJS + Node.js]
            APP3[API Server 3<br/>NestJS + Node.js]
        end
        
        subgraph "Data Tier"
            DB_MASTER[(PostgreSQL Master)]
            DB_REPLICA[(PostgreSQL Replica)]
            REDIS_CLUSTER[(Redis Cluster)]
        end
        
        subgraph "Storage Tier"
            FILE_STORAGE[(Cloud Storage<br/>S3/Azure Blob)]
            BACKUP_STORAGE[(Backup Storage)]
        end
    end
    
    subgraph "Staging Environment"
        STAGE_WEB[Staging Web]
        STAGE_API[Staging API]
        STAGE_DB[(Staging Database)]
    end
    
    subgraph "Development Environment"
        DEV_LOCAL[Local Development]
        DEV_DB[(Local Database)]
    end
    
    LB --> WEB1
    LB --> WEB2
    WEB1 --> APP1
    WEB1 --> APP2
    WEB2 --> APP2
    WEB2 --> APP3
    
    APP1 --> DB_MASTER
    APP2 --> DB_MASTER
    APP3 --> DB_REPLICA
    APP1 --> REDIS_CLUSTER
    APP2 --> REDIS_CLUSTER
    APP3 --> REDIS_CLUSTER
    
    APP1 --> FILE_STORAGE
    APP2 --> FILE_STORAGE
    APP3 --> FILE_STORAGE
    
    DB_MASTER --> BACKUP_STORAGE
```

## Monitoring & Observability Architecture

```mermaid
graph TB
    subgraph "Application Monitoring"
        APM[Application Performance Monitoring<br/>New Relic/DataDog]
        LOGS[Centralized Logging<br/>ELK Stack]
        METRICS[Metrics Collection<br/>Prometheus]
    end
    
    subgraph "Infrastructure Monitoring"
        INFRA[Infrastructure Monitoring<br/>CloudWatch/Azure Monitor]
        ALERTS[Alerting System<br/>PagerDuty]
        DASH[Monitoring Dashboard<br/>Grafana]
    end
    
    subgraph "Security Monitoring"
        SIEM[Security Information Event Management]
        THREAT[Threat Detection]
        COMPLIANCE[Compliance Monitoring]
    end
    
    subgraph "Business Monitoring"
        ANALYTICS[Business Analytics]
        KPI[KPI Dashboard]
        REPORTS[Automated Reports]
    end
    
    APM --> DASH
    LOGS --> DASH
    METRICS --> DASH
    INFRA --> ALERTS
    
    SIEM --> THREAT
    THREAT --> ALERTS
    COMPLIANCE --> REPORTS
    
    ANALYTICS --> KPI
    KPI --> REPORTS
```

## Integration Architecture

```mermaid
graph LR
    subgraph "CloudAudit Pro"
        CORE[Core Platform]
        API_LAYER[API Layer]
        WEBHOOK[Webhook Handler]
    end
    
    subgraph "Third-Party Integrations"
        ACCOUNTING[Accounting Software<br/>QuickBooks, Sage]
        CRM[CRM Systems<br/>Salesforce, HubSpot]
        STORAGE[Cloud Storage<br/>OneDrive, Google Drive]
        SSO[Single Sign-On<br/>Active Directory, Okta]
        PAYMENT[Payment Gateways<br/>Stripe, PayPal]
    end
    
    subgraph "Data Exchange"
        REST_API[REST APIs]
        WEBHOOKS[Webhooks]
        FILE_SYNC[File Synchronization]
        OAUTH[OAuth 2.0]
    end
    
    API_LAYER --> REST_API
    REST_API --> ACCOUNTING
    REST_API --> CRM
    
    WEBHOOK --> WEBHOOKS
    WEBHOOKS --> STORAGE
    WEBHOOKS --> PAYMENT
    
    CORE --> FILE_SYNC
    FILE_SYNC --> STORAGE
    
    CORE --> OAUTH
    OAUTH --> SSO
```