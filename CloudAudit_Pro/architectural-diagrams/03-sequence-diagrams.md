# CloudAudit Pro - Sequence Diagrams

## 1. User Registration & Tenant Approval Sequence

```mermaid
sequenceDiagram
    participant C as Company Admin
    participant F as Frontend
    participant A as Auth API
    participant DB as Database
    participant E as Email Service
    participant SA as Super Admin
    participant SAP as Super Admin Portal
    
    Note over C,SAP: Company Registration Flow
    
    C->>F: Access Registration Page
    F->>C: Display Registration Form
    C->>F: Submit Company Details
    F->>A: POST /auth/register
    A->>DB: Create Tenant (PENDING status)
    A->>DB: Create Admin User (INACTIVE)
    A->>E: Queue Registration Notification
    E->>SA: Send "New Tenant Registration" Email
    A->>F: Return Registration Success
    F->>C: Show "Pending Approval" Message
    
    Note over SA,SAP: Super Admin Approval Flow
    
    SA->>SAP: Login to Super Admin Portal
    SAP->>A: GET /super-admin/tenants
    A->>DB: Fetch Pending Tenants
    DB-->>A: Return Tenant List
    A-->>SAP: Return Tenant Data
    SAP-->>SA: Display Pending Approvals
    
    SA->>SAP: Review Tenant Details
    SA->>SAP: Click "Approve" or "Reject"
    SAP->>A: PATCH /super-admin/tenants/:id/approve
    A->>DB: Update Tenant Status
    A->>DB: Update Admin User Status
    A->>E: Queue Approval Email
    
    alt Approved
        E->>C: Send "Approval + Setup Instructions"
        A-->>SAP: Return Success Response
    else Rejected
        E->>C: Send "Rejection with Reason"
        A-->>SAP: Return Success Response
    end
    
    SAP-->>SA: Show Updated Status
```

## 2. User Invitation & Onboarding Sequence

```mermaid
sequenceDiagram
    participant CA as Company Admin
    participant AP as Admin Portal
    participant UA as User API
    participant DB as Database
    participant E as Email Service
    participant NU as New User
    participant F as Frontend
    
    Note over CA,NU: User Invitation Flow
    
    CA->>AP: Navigate to User Management
    AP->>UA: GET /users (to show current users)
    UA->>DB: Fetch Company Users
    DB-->>UA: Return User List
    UA-->>AP: Return User Data
    AP-->>CA: Display User Management Interface
    
    CA->>AP: Click "Invite New User"
    AP->>CA: Show Invitation Form
    CA->>AP: Fill User Details + Role
    AP->>UA: POST /users/invite
    
    UA->>DB: Validate Role Hierarchy
    UA->>DB: Create User Record (INVITED status)
    UA->>DB: Generate Invitation Token
    UA->>E: Queue Invitation Email
    E->>NU: Send "Invitation to Join" Email
    UA-->>AP: Return Success Response
    AP-->>CA: Show "Invitation Sent" Confirmation
    
    Note over NU,F: User Acceptance Flow
    
    NU->>NU: Receive & Click Email Link
    NU->>F: Access /accept-invitation?token=xxx
    F->>UA: GET /auth/validate-invitation
    UA->>DB: Validate Token & Check Expiry
    
    alt Token Valid
        DB-->>UA: Return User Details
        UA-->>F: Return Validation Success
        F->>NU: Show Account Setup Form
        NU->>F: Enter Password & Profile Info
        F->>UA: POST /auth/complete-invitation
        UA->>DB: Update User Status (ACTIVE)
        UA->>DB: Hash & Store Password
        UA->>E: Queue Welcome Email
        E->>NU: Send Welcome Email
        UA-->>F: Return Setup Success
        F->>NU: Redirect to Dashboard
    else Token Invalid/Expired
        UA-->>F: Return Error
        F->>NU: Show "Invalid/Expired Link" Error
    end
```

## 3. Authentication & Authorization Sequence

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant A as Auth API
    participant DB as Database
    participant R as Redis Cache
    participant P as Protected Resource
    
    Note over U,R: Login Flow
    
    U->>F: Enter Credentials
    F->>A: POST /auth/login
    A->>DB: Validate Email & Password
    DB-->>A: Return User + Tenant Data
    A->>A: Generate JWT Token
    A->>R: Store Session Data
    A->>DB: Update lastLoginAt
    A-->>F: Return Token + User Profile
    F->>F: Store Token in Memory/LocalStorage
    F-->>U: Redirect to Dashboard
    
    Note over U,P: Accessing Protected Resources
    
    U->>F: Navigate to Protected Page
    F->>F: Check Token Exists
    F->>P: GET /protected-resource
    Note right of F: Include Authorization: Bearer <token>
    
    P->>A: Validate Token
    A->>A: Verify JWT Signature
    A->>R: Check Session Status
    R-->>A: Return Session Data
    A->>DB: Verify User & Tenant Status
    DB-->>A: Return User Permissions
    
    alt Token Valid & User Active
        A-->>P: Return User Context
        P->>DB: Fetch Resource (with tenant filter)
        DB-->>P: Return Filtered Data
        P-->>F: Return Authorized Response
        F-->>U: Display Content
    else Token Invalid/Expired
        A-->>P: Return 401 Unauthorized
        P-->>F: Return 401 Error
        F->>F: Clear Stored Token
        F->>F: Redirect to Login
        F-->>U: Show Login Page
    else User Inactive/Suspended
        A-->>P: Return 403 Forbidden
        P-->>F: Return 403 Error
        F-->>U: Show "Access Suspended" Message
    end
```

## 4. Document Upload & Processing Sequence

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant DA as Document API
    participant FS as File Storage
    participant DB as Database
    participant PS as Processing Service
    participant N as Notification Service
    
    Note over U,N: Document Upload Flow
    
    U->>F: Select File for Upload
    F->>F: Validate File (size, type, etc.)
    F->>DA: POST /documents/upload
    Note right of F: Multipart form data
    
    DA->>DA: Validate User Permissions
    DA->>FS: Upload File to Storage
    FS-->>DA: Return File URL & Metadata
    DA->>DB: Create Document Record
    DB-->>DA: Return Document ID
    DA-->>F: Return Upload Success + Document ID
    F-->>U: Show "Upload Successful"
    
    Note over PS,N: Background Processing
    
    DA->>PS: Queue Document Processing Job
    PS->>FS: Download File for Processing
    PS->>PS: Extract Metadata, OCR, etc.
    PS->>DB: Update Document with Processed Data
    PS->>N: Send Processing Complete Notification
    N->>F: Real-time Notification (WebSocket)
    F->>U: Show "Document Ready" Notification
    
    Note over U,DB: Document Access Flow
    
    U->>F: Request Document List
    F->>DA: GET /documents
    DA->>DB: Fetch User's Accessible Documents
    DB-->>DA: Return Document List (filtered by tenant/permissions)
    DA-->>F: Return Document Data
    F-->>U: Display Document Grid
    
    U->>F: Click Download Document
    F->>DA: GET /documents/:id/download
    DA->>DB: Verify Document Access Permissions
    DA->>FS: Generate Signed Download URL
    FS-->>DA: Return Secure URL
    DA-->>F: Return Download URL
    F->>FS: Direct Download Request
    FS-->>U: Serve File Content
```

## 5. Audit Procedure Execution Sequence

```mermaid
sequenceDiagram
    participant A as Auditor
    participant F as Frontend
    participant PA as Procedure API
    participant DB as Database
    participant RA as Report API
    participant E as Email Service
    participant M as Manager
    
    Note over A,M: Procedure Assignment & Execution
    
    M->>F: Access Procedure Management
    F->>PA: GET /procedures/templates
    PA->>DB: Fetch Available Templates
    DB-->>PA: Return Template List
    PA-->>F: Return Templates
    F-->>M: Display Template Options
    
    M->>F: Assign Procedure to Auditor
    F->>PA: POST /procedures/assign
    PA->>DB: Create Procedure Assignment
    PA->>E: Queue Assignment Notification
    E->>A: Send "New Procedure Assigned" Email
    PA-->>F: Return Assignment Success
    
    Note over A,RA: Procedure Execution
    
    A->>F: Login & View Dashboard
    F->>PA: GET /procedures/assigned
    PA->>DB: Fetch User's Assigned Procedures
    DB-->>PA: Return Procedure List
    PA-->>F: Return Procedures
    F-->>A: Display "My Procedures"
    
    A->>F: Start Procedure
    F->>PA: POST /procedures/:id/start
    PA->>DB: Update Procedure Status (IN_PROGRESS)
    PA->>DB: Create Audit Log Entry
    PA-->>F: Return Status Update
    
    A->>F: Upload Supporting Documents
    F->>PA: POST /procedures/:id/documents
    PA->>DB: Link Documents to Procedure
    PA-->>F: Return Upload Confirmation
    
    A->>F: Complete Procedure Steps
    F->>PA: PATCH /procedures/:id/progress
    PA->>DB: Update Completion Progress
    PA-->>F: Return Progress Update
    
    A->>F: Submit for Review
    F->>PA: POST /procedures/:id/complete
    PA->>DB: Update Status (COMPLETED)
    PA->>RA: Trigger Report Generation
    RA->>DB: Compile Procedure Results
    RA->>DB: Generate Procedure Report
    PA->>E: Queue Completion Notification
    E->>M: Send "Procedure Completed" Email
    PA-->>F: Return Completion Success
    F-->>A: Show "Submitted for Review"
```

## 6. Report Generation & Analytics Sequence

```mermaid
sequenceDiagram
    participant M as Manager
    participant F as Frontend
    participant RA as Report API
    participant DB as Database
    participant RG as Report Generator
    participant FS as File Storage
    participant E as Email Service
    
    Note over M,E: Report Generation Flow
    
    M->>F: Access Reports Dashboard
    F->>RA: GET /reports/dashboard
    RA->>DB: Fetch Report Statistics
    DB-->>RA: Return Analytics Data
    RA-->>F: Return Dashboard Data
    F-->>M: Display Report Dashboard
    
    M->>F: Request Custom Report
    F->>M: Show Report Configuration Form
    M->>F: Configure Report Parameters
    F->>RA: POST /reports/generate
    
    RA->>DB: Validate Data Access Permissions
    RA->>RG: Queue Report Generation Job
    RG->>DB: Extract Required Data
    RG->>RG: Process & Format Data
    RG->>FS: Generate Report Files (PDF, Excel)
    FS-->>RG: Return File URLs
    RG->>DB: Save Report Metadata
    RG->>E: Queue Report Ready Notification
    E->>M: Send "Report Generated" Email
    RA-->>F: Return Job ID & Status
    
    Note over M,FS: Report Access
    
    F->>RA: Poll Report Status
    RA->>DB: Check Generation Status
    DB-->>RA: Return Current Status
    RA-->>F: Return Status Update
    
    loop Until Complete
        F->>F: Wait 5 seconds
        F->>RA: GET /reports/:id/status
        RA->>DB: Check Status
        DB-->>RA: Return Status
        RA-->>F: Return Status
    end
    
    RA-->>F: Report Complete
    F-->>M: Show "Report Ready" Notification
    
    M->>F: Download Report
    F->>RA: GET /reports/:id/download
    RA->>FS: Get Signed Download URL
    FS-->>RA: Return Secure URL
    RA-->>F: Return Download Link
    F->>FS: Download Report
    FS-->>M: Serve Report File
```

## 7. Real-time Notification & Updates Sequence

```mermaid
sequenceDiagram
    participant U1 as User 1
    participant F1 as Frontend 1
    participant WS as WebSocket Server
    participant A as API Server
    participant DB as Database
    participant F2 as Frontend 2
    participant U2 as User 2
    
    Note over U1,U2: Real-time Updates Setup
    
    U1->>F1: Login to Application
    F1->>WS: Establish WebSocket Connection
    WS->>WS: Store Connection with User ID
    WS-->>F1: Connection Acknowledged
    
    U2->>F2: Login to Application
    F2->>WS: Establish WebSocket Connection
    WS->>WS: Store Connection with User ID
    WS-->>F2: Connection Acknowledged
    
    Note over U1,U2: Real-time Event Broadcasting
    
    U1->>F1: Perform Action (e.g., Upload Document)
    F1->>A: POST /documents/upload
    A->>DB: Save Document
    A->>WS: Broadcast Event to Team Members
    
    WS->>WS: Identify Recipients (same tenant/company)
    WS->>F2: Send Real-time Notification
    F2->>F2: Display In-app Notification
    F2-->>U2: Show "New Document Uploaded" Toast
    
    Note over U1,U2: Status Updates
    
    A->>WS: Broadcast "Document Processing Complete"
    WS->>F1: Send Update to Document Owner
    WS->>F2: Send Update to Team Members
    F1-->>U1: Show "Processing Complete"
    F2-->>U2: Show "Team Document Updated"
    
    Note over U1,U2: Connection Management
    
    U1->>F1: Navigate Away/Close Tab
    F1->>WS: Close WebSocket Connection
    WS->>WS: Remove User Connection
    
    Note over WS: Periodic Cleanup
    WS->>WS: Check Connection Health
    WS->>WS: Remove Stale Connections
```