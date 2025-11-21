# Security & Compliance Framework

## Executive Summary

This document outlines the comprehensive security and compliance framework for the multi-tenant eAuditPro web application. Given the sensitive nature of audit data and regulatory requirements in the accounting industry, security and compliance are paramount concerns that must be addressed at every level of the architecture.

## Regulatory & Compliance Requirements

### Industry Standards & Regulations

#### Financial Services Compliance
- **SOX (Sarbanes-Oxley Act)**: Controls over financial reporting
- **PCAOB (Public Company Accounting Oversight Board)**: Audit standards compliance
- **GAAP/IFRS**: Financial reporting standards
- **SEC Requirements**: Securities and Exchange Commission regulations
- **ISA (International Standards on Auditing)**: Global audit standards

#### Data Protection Regulations
- **GDPR (General Data Protection Regulation)**: EU data protection
- **CCPA (California Consumer Privacy Act)**: California privacy rights
- **SOC 2 Type II**: Security, availability, and confidentiality controls
- **ISO 27001**: Information security management
- **NIST Cybersecurity Framework**: Risk management framework

#### Industry-Specific Requirements
- **AICPA Standards**: Professional accounting standards
- **IIA Standards**: Internal audit standards
- **State CPA Licensing Requirements**: Professional practice standards
- **Client Confidentiality Requirements**: Professional privilege protection

## Multi-Tenant Security Architecture

### Tenant Isolation Strategy

#### Database-Level Isolation
```sql
-- Row Level Security (RLS) Implementation
-- Enable RLS on all tenant tables
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE periods ENABLE ROW LEVEL SECURITY;
ALTER TABLE account_heads ENABLE ROW LEVEL SECURITY;
ALTER TABLE trial_balance ENABLE ROW LEVEL SECURITY;
ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE procedures ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create tenant isolation policies
CREATE POLICY tenant_isolation_companies ON companies
    FOR ALL
    USING (current_setting('app.tenant_id', true)::uuid = tenant_id);

CREATE POLICY tenant_isolation_users ON users
    FOR ALL
    USING (current_setting('app.tenant_id', true)::uuid = tenant_id);

-- Function to set tenant context
CREATE OR REPLACE FUNCTION set_tenant_context(tenant_uuid UUID)
RETURNS void AS $$
BEGIN
    PERFORM set_config('app.tenant_id', tenant_uuid::text, true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get current tenant context
CREATE OR REPLACE FUNCTION get_current_tenant_id()
RETURNS UUID AS $$
BEGIN
    RETURN current_setting('app.tenant_id', true)::uuid;
EXCEPTION
    WHEN others THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

#### Application-Level Isolation
```typescript
// Tenant Context Middleware
interface TenantContext {
  tenantId: string;
  tenantName: string;
  subscriptionTier: string;
  features: string[];
  limits: TenantLimits;
}

interface TenantLimits {
  maxUsers: number;
  maxCompanies: number;
  storageGB: number;
  apiCallsPerHour: number;
  maxConcurrentSessions: number;
}

class TenantSecurityMiddleware {
  async validateTenantAccess(
    req: AuthenticatedRequest, 
    res: Response, 
    next: NextFunction
  ): Promise<void> {
    try {
      // Extract tenant identifier from subdomain or header
      const tenantId = this.extractTenantId(req);
      
      if (!tenantId) {
        throw new SecurityError('Tenant identifier not found', 'TENANT_NOT_FOUND');
      }

      // Validate tenant exists and is active
      const tenant = await this.tenantService.getTenant(tenantId);
      if (!tenant || tenant.status !== 'active') {
        throw new SecurityError('Invalid or inactive tenant', 'TENANT_INVALID');
      }

      // Validate user belongs to this tenant
      if (req.user.tenantId !== tenantId) {
        await this.auditLogger.logSecurityEvent({
          type: 'UNAUTHORIZED_TENANT_ACCESS_ATTEMPT',
          userId: req.user.id,
          tenantId: tenantId,
          requestedTenant: req.user.tenantId,
          ipAddress: req.ip,
          userAgent: req.get('User-Agent')
        });
        throw new SecurityError('Unauthorized tenant access', 'TENANT_ACCESS_DENIED');
      }

      // Check subscription limits
      await this.validateTenantLimits(tenant, req);

      // Set tenant context
      req.tenantContext = {
        tenantId: tenant.id,
        tenantName: tenant.name,
        subscriptionTier: tenant.subscriptionTier,
        features: tenant.features,
        limits: tenant.limits
      };

      // Set database context
      await this.databaseService.setTenantContext(tenantId);

      next();
    } catch (error) {
      this.handleSecurityError(error, res);
    }
  }

  private extractTenantId(req: Request): string | null {
    // Method 1: Subdomain extraction
    const host = req.get('host');
    if (host) {
      const subdomain = host.split('.')[0];
      if (subdomain && subdomain !== 'www' && subdomain !== 'api') {
        return this.resolveTenantBySubdomain(subdomain);
      }
    }

    // Method 2: Header-based tenant identification
    const tenantHeader = req.get('X-Tenant-ID');
    if (tenantHeader) {
      return tenantHeader;
    }

    // Method 3: JWT token tenant claim
    if (req.user?.tenantId) {
      return req.user.tenantId;
    }

    return null;
  }

  private async validateTenantLimits(tenant: Tenant, req: Request): Promise<void> {
    // Check concurrent sessions
    const activeSessions = await this.sessionService.getActiveSessions(tenant.id);
    if (activeSessions.length >= tenant.limits.maxConcurrentSessions) {
      throw new SecurityError('Maximum concurrent sessions exceeded', 'LIMIT_EXCEEDED');
    }

    // Check API rate limits
    const apiUsage = await this.rateLimitService.getCurrentUsage(tenant.id);
    if (apiUsage.callsPerHour >= tenant.limits.apiCallsPerHour) {
      throw new SecurityError('API rate limit exceeded', 'RATE_LIMIT_EXCEEDED');
    }

    // Check storage limits
    const storageUsage = await this.storageService.getUsage(tenant.id);
    if (storageUsage.usedGB >= tenant.limits.storageGB) {
      throw new SecurityError('Storage limit exceeded', 'STORAGE_LIMIT_EXCEEDED');
    }
  }
}
```

## Authentication & Authorization Framework

### Multi-Factor Authentication (MFA)
```typescript
interface MFAConfiguration {
  enabled: boolean;
  methods: MFAMethod[];
  gracePeriod: number; // days before MFA becomes mandatory
  backupCodes: number;
  rememberDevice: boolean;
  rememberDeviceDays: number;
}

interface MFAMethod {
  type: 'totp' | 'sms' | 'email' | 'hardware_token';
  enabled: boolean;
  primary: boolean;
  configuration: any;
}

class MFAService {
  async setupTOTP(userId: string, tenantId: string): Promise<TOTPSetupResult> {
    // Generate secret key
    const secret = speakeasy.generateSecret({
      name: `eAuditPro (${await this.getTenantName(tenantId)})`,
      issuer: 'eAuditPro',
      length: 32
    });

    // Store secret temporarily (encrypted)
    await this.storeTempMFASecret(userId, secret.base32, 'totp');

    // Return setup information
    return {
      secret: secret.base32,
      qrCodeUrl: secret.otpauth_url,
      manualEntryKey: secret.base32,
      backupCodes: await this.generateBackupCodes(userId)
    };
  }

  async verifyTOTP(userId: string, token: string, setup: boolean = false): Promise<boolean> {
    let secret: string;

    if (setup) {
      secret = await this.getTempMFASecret(userId, 'totp');
    } else {
      const user = await this.userService.getUser(userId);
      secret = await this.decryptMFASecret(user.mfaSecret);
    }

    const verified = speakeasy.totp.verify({
      secret: secret,
      encoding: 'base32',
      token: token,
      window: 2 // Allow 30 second window
    });

    if (verified && setup) {
      // Complete TOTP setup
      await this.completeTOTPSetup(userId, secret);
    }

    return verified;
  }

  private async generateBackupCodes(userId: string): Promise<string[]> {
    const codes = [];
    for (let i = 0; i < 10; i++) {
      codes.push(crypto.randomBytes(6).toString('hex').toUpperCase());
    }

    // Store encrypted backup codes
    const encryptedCodes = await Promise.all(
      codes.map(code => this.encryptionService.encrypt(code))
    );

    await this.userService.updateMFABackupCodes(userId, encryptedCodes);
    return codes;
  }
}

// Authentication Flow with MFA
class AuthenticationService {
  async authenticateUser(credentials: LoginCredentials): Promise<AuthenticationResult> {
    // Step 1: Basic credential validation
    const user = await this.validateCredentials(credentials);
    
    // Step 2: Check if MFA is required
    if (user.mfaEnabled) {
      return {
        status: 'mfa_required',
        tempToken: await this.generateTempToken(user.id),
        mfaMethods: user.availableMFAMethods
      };
    }

    // Step 3: Complete authentication without MFA
    return this.completeAuthentication(user, credentials);
  }

  async verifyMFA(tempToken: string, mfaCredentials: MFACredentials): Promise<AuthenticationResult> {
    // Validate temporary token
    const userId = await this.validateTempToken(tempToken);
    if (!userId) {
      throw new SecurityError('Invalid or expired temporary token');
    }

    const user = await this.userService.getUser(userId);

    // Verify MFA token based on method
    let mfaValid = false;
    switch (mfaCredentials.method) {
      case 'totp':
        mfaValid = await this.mfaService.verifyTOTP(userId, mfaCredentials.token);
        break;
      case 'sms':
        mfaValid = await this.mfaService.verifySMS(userId, mfaCredentials.token);
        break;
      case 'backup_code':
        mfaValid = await this.mfaService.verifyBackupCode(userId, mfaCredentials.token);
        break;
    }

    if (!mfaValid) {
      await this.auditLogger.logSecurityEvent({
        type: 'MFA_VERIFICATION_FAILED',
        userId: userId,
        method: mfaCredentials.method,
        ipAddress: mfaCredentials.ipAddress
      });
      throw new SecurityError('Invalid MFA token');
    }

    // Complete authentication
    return this.completeAuthentication(user, {
      ...mfaCredentials,
      mfaVerified: true
    });
  }

  private async completeAuthentication(user: User, credentials: any): Promise<AuthenticationResult> {
    // Generate JWT tokens
    const accessToken = await this.jwtService.generateAccessToken(user);
    const refreshToken = await this.jwtService.generateRefreshToken(user);

    // Update user session info
    await this.userService.updateLastLogin(user.id, {
      loginTime: new Date(),
      ipAddress: credentials.ipAddress,
      userAgent: credentials.userAgent,
      mfaUsed: user.mfaEnabled
    });

    // Log successful authentication
    await this.auditLogger.logSecurityEvent({
      type: 'AUTHENTICATION_SUCCESS',
      userId: user.id,
      tenantId: user.tenantId,
      ipAddress: credentials.ipAddress,
      userAgent: credentials.userAgent,
      mfaUsed: user.mfaEnabled
    });

    return {
      status: 'success',
      accessToken,
      refreshToken,
      user: this.sanitizeUser(user),
      expiresIn: 3600
    };
  }
}
```

### Role-Based Access Control (RBAC)

```typescript
interface Permission {
  resource: string;
  action: string;
  conditions?: PermissionCondition[];
}

interface PermissionCondition {
  field: string;
  operator: 'equals' | 'not_equals' | 'in' | 'not_in' | 'contains';
  value: any;
}

interface Role {
  name: string;
  description: string;
  permissions: Permission[];
  hierarchyLevel: number;
  isSystemRole: boolean;
}

class RBACService {
  private roleHierarchy: Map<string, Role> = new Map();

  constructor() {
    this.initializeSystemRoles();
  }

  private initializeSystemRoles(): void {
    // System Administrator (Super Admin)
    this.roleHierarchy.set('system_admin', {
      name: 'System Administrator',
      description: 'Full system access across all tenants',
      hierarchyLevel: 100,
      isSystemRole: true,
      permissions: [
        { resource: '*', action: '*' }
      ]
    });

    // Tenant Administrator
    this.roleHierarchy.set('tenant_admin', {
      name: 'Tenant Administrator',
      description: 'Full access within tenant scope',
      hierarchyLevel: 90,
      isSystemRole: false,
      permissions: [
        { resource: 'companies', action: '*' },
        { resource: 'users', action: '*' },
        { resource: 'settings', action: '*' },
        { resource: 'reports', action: '*' },
        { resource: 'procedures', action: '*' },
        { resource: 'documents', action: '*' },
        { resource: 'periods', action: '*' },
        { resource: 'accounts', action: '*' }
      ]
    });

    // Audit Manager
    this.roleHierarchy.set('audit_manager', {
      name: 'Audit Manager',
      description: 'Manages audit engagements and teams',
      hierarchyLevel: 80,
      isSystemRole: false,
      permissions: [
        { resource: 'companies', action: 'read' },
        { resource: 'companies', action: 'update', 
          conditions: [{ field: 'assigned_manager', operator: 'equals', value: '${user.id}' }] },
        { resource: 'users', action: 'read' },
        { resource: 'users', action: 'update',
          conditions: [{ field: 'role', operator: 'not_in', value: ['tenant_admin', 'audit_manager'] }] },
        { resource: 'procedures', action: '*' },
        { resource: 'procedures', action: 'assign' },
        { resource: 'procedures', action: 'review' },
        { resource: 'documents', action: '*' },
        { resource: 'reports', action: 'generate' },
        { resource: 'periods', action: '*' },
        { resource: 'accounts', action: '*' }
      ]
    });

    // Senior Auditor
    this.roleHierarchy.set('senior_auditor', {
      name: 'Senior Auditor',
      description: 'Performs complex audit procedures and reviews junior work',
      hierarchyLevel: 70,
      isSystemRole: false,
      permissions: [
        { resource: 'companies', action: 'read' },
        { resource: 'procedures', action: 'read' },
        { resource: 'procedures', action: 'update',
          conditions: [{ field: 'assigned_to', operator: 'equals', value: '${user.id}' }] },
        { resource: 'procedures', action: 'review',
          conditions: [{ field: 'created_by', operator: 'not_equals', value: '${user.id}' }] },
        { resource: 'documents', action: '*' },
        { resource: 'reports', action: 'generate' },
        { resource: 'periods', action: 'read' },
        { resource: 'accounts', action: 'read' },
        { resource: 'accounts', action: 'update',
          conditions: [{ field: 'requires_review', operator: 'equals', value: false }] }
      ]
    });

    // Auditor
    this.roleHierarchy.set('auditor', {
      name: 'Auditor',
      description: 'Performs audit procedures and documentation',
      hierarchyLevel: 60,
      isSystemRole: false,
      permissions: [
        { resource: 'companies', action: 'read' },
        { resource: 'procedures', action: 'read' },
        { resource: 'procedures', action: 'update',
          conditions: [{ field: 'assigned_to', operator: 'equals', value: '${user.id}' }] },
        { resource: 'documents', action: 'read' },
        { resource: 'documents', action: 'create' },
        { resource: 'documents', action: 'update',
          conditions: [{ field: 'created_by', operator: 'equals', value: '${user.id}' }] },
        { resource: 'reports', action: 'view' },
        { resource: 'periods', action: 'read' },
        { resource: 'accounts', action: 'read' }
      ]
    });
  }

  async checkPermission(
    userId: string, 
    resource: string, 
    action: string, 
    context?: any
  ): Promise<boolean> {
    const user = await this.userService.getUser(userId);
    const role = this.roleHierarchy.get(user.role);

    if (!role) {
      return false;
    }

    // Check for wildcard permissions
    const wildcardPermission = role.permissions.find(p => 
      (p.resource === '*' && p.action === '*') ||
      (p.resource === resource && p.action === '*')
    );

    if (wildcardPermission) {
      return true;
    }

    // Check specific permission
    const permission = role.permissions.find(p => 
      p.resource === resource && p.action === action
    );

    if (!permission) {
      return false;
    }

    // Evaluate conditions if present
    if (permission.conditions && context) {
      return this.evaluateConditions(permission.conditions, context, user);
    }

    return true;
  }

  private evaluateConditions(
    conditions: PermissionCondition[], 
    context: any, 
    user: User
  ): boolean {
    return conditions.every(condition => {
      const contextValue = this.getNestedValue(context, condition.field);
      let conditionValue = condition.value;

      // Replace user variable placeholders
      if (typeof conditionValue === 'string' && conditionValue.includes('${user.')) {
        conditionValue = conditionValue.replace(/\${user\.(\w+)}/g, (match, prop) => {
          return user[prop] || '';
        });
      }

      switch (condition.operator) {
        case 'equals':
          return contextValue === conditionValue;
        case 'not_equals':
          return contextValue !== conditionValue;
        case 'in':
          return Array.isArray(conditionValue) && conditionValue.includes(contextValue);
        case 'not_in':
          return Array.isArray(conditionValue) && !conditionValue.includes(contextValue);
        case 'contains':
          return String(contextValue).toLowerCase().includes(String(conditionValue).toLowerCase());
        default:
          return false;
      }
    });
  }
}

// Authorization Decorator
function RequirePermission(resource: string, action: string) {
  return function (target: any, propertyName: string, descriptor: PropertyDescriptor) {
    const method = descriptor.value;

    descriptor.value = async function (...args: any[]) {
      const req = args.find(arg => arg.user && arg.tenantContext);
      
      if (!req?.user) {
        throw new UnauthorizedError('Authentication required');
      }

      const hasPermission = await this.rbacService.checkPermission(
        req.user.id,
        resource,
        action,
        req.body || req.params || {}
      );

      if (!hasPermission) {
        await this.auditLogger.logSecurityEvent({
          type: 'AUTHORIZATION_DENIED',
          userId: req.user.id,
          tenantId: req.user.tenantId,
          resource,
          action,
          ipAddress: req.ip
        });
        throw new ForbiddenError(`Insufficient permissions for ${action} on ${resource}`);
      }

      return method.apply(this, args);
    };

    return descriptor;
  };
}
```

## Data Encryption & Protection

### Encryption at Rest
```typescript
interface EncryptionConfiguration {
  algorithm: string;
  keySize: number;
  keyRotationIntervalDays: number;
  encryptionScope: EncryptionScope;
}

interface EncryptionScope {
  database: boolean;
  documents: boolean;
  backups: boolean;
  logs: boolean;
  pii: boolean; // Personally Identifiable Information
}

class EncryptionService {
  private masterKey: string;
  private keyDerivationFunction: string = 'PBKDF2';
  private iterations: number = 100000;

  constructor(masterKey: string) {
    this.masterKey = masterKey;
  }

  async encryptField(data: string, context: EncryptionContext): Promise<EncryptedData> {
    // Generate unique salt for this encryption
    const salt = crypto.randomBytes(32);
    
    // Derive encryption key from master key + context
    const derivedKey = crypto.pbkdf2Sync(
      this.masterKey + context.tenantId + context.purpose,
      salt,
      this.iterations,
      32,
      'sha256'
    );

    // Encrypt data
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipher('aes-256-gcm', derivedKey);
    cipher.setAAD(Buffer.from(context.additionalData || ''));
    
    let encrypted = cipher.update(data, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    
    const authTag = cipher.getAuthTag();

    return {
      encryptedData: encrypted,
      salt: salt.toString('hex'),
      iv: iv.toString('hex'),
      authTag: authTag.toString('hex'),
      algorithm: 'aes-256-gcm',
      keyVersion: context.keyVersion || 1
    };
  }

  async decryptField(encryptedData: EncryptedData, context: EncryptionContext): Promise<string> {
    // Derive the same key used for encryption
    const derivedKey = crypto.pbkdf2Sync(
      this.masterKey + context.tenantId + context.purpose,
      Buffer.from(encryptedData.salt, 'hex'),
      this.iterations,
      32,
      'sha256'
    );

    // Decrypt data
    const decipher = crypto.createDecipher('aes-256-gcm', derivedKey);
    decipher.setAAD(Buffer.from(context.additionalData || ''));
    decipher.setAuthTag(Buffer.from(encryptedData.authTag, 'hex'));

    let decrypted = decipher.update(encryptedData.encryptedData, 'hex', 'utf8');
    decrypted += decipher.final('utf8');

    return decrypted;
  }

  // Database field-level encryption
  async encryptSensitiveFields(record: any, schema: FieldEncryptionSchema): Promise<any> {
    const encryptedRecord = { ...record };

    for (const field of schema.encryptedFields) {
      if (record[field.name] && record[field.name] !== '') {
        const context: EncryptionContext = {
          tenantId: schema.tenantId,
          purpose: `field_${field.name}`,
          additionalData: `${schema.tableName}_${field.name}`,
          keyVersion: 1
        };

        encryptedRecord[field.name] = await this.encryptField(record[field.name], context);
      }
    }

    return encryptedRecord;
  }
}

// Document Encryption for Cloud Storage
class DocumentEncryptionService {
  async encryptDocument(
    fileBuffer: Buffer, 
    tenantId: string, 
    documentId: string
  ): Promise<EncryptedDocument> {
    // Generate unique document encryption key
    const documentKey = crypto.randomBytes(32);
    
    // Encrypt the document key with tenant-specific key
    const tenantKey = await this.getTenantEncryptionKey(tenantId);
    const encryptedDocumentKey = await this.encryptionService.encryptField(
      documentKey.toString('hex'),
      {
        tenantId,
        purpose: 'document_key',
        additionalData: documentId
      }
    );

    // Encrypt document content with document key
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipher('aes-256-cbc', documentKey);
    
    const encryptedChunks: Buffer[] = [];
    encryptedChunks.push(cipher.update(fileBuffer));
    encryptedChunks.push(cipher.final());
    
    const encryptedContent = Buffer.concat(encryptedChunks);

    return {
      encryptedContent,
      encryptedKey: encryptedDocumentKey,
      iv: iv.toString('hex'),
      algorithm: 'aes-256-cbc',
      contentHash: crypto.createHash('sha256').update(fileBuffer).digest('hex')
    };
  }

  async decryptDocument(
    encryptedDocument: EncryptedDocument,
    tenantId: string,
    documentId: string
  ): Promise<Buffer> {
    // Decrypt document key
    const documentKeyHex = await this.encryptionService.decryptField(
      encryptedDocument.encryptedKey,
      {
        tenantId,
        purpose: 'document_key',
        additionalData: documentId
      }
    );

    const documentKey = Buffer.from(documentKeyHex, 'hex');

    // Decrypt document content
    const decipher = crypto.createDecipher('aes-256-cbc', documentKey);
    
    const decryptedChunks: Buffer[] = [];
    decryptedChunks.push(decipher.update(encryptedDocument.encryptedContent));
    decryptedChunks.push(decipher.final());
    
    const decryptedContent = Buffer.concat(decryptedChunks);

    // Verify content integrity
    const contentHash = crypto.createHash('sha256').update(decryptedContent).digest('hex');
    if (contentHash !== encryptedDocument.contentHash) {
      throw new SecurityError('Document integrity check failed');
    }

    return decryptedContent;
  }
}
```

### Encryption in Transit
```typescript
// TLS Configuration
const tlsConfig = {
  minVersion: 'TLSv1.2',
  maxVersion: 'TLSv1.3',
  cipherSuites: [
    'TLS_AES_256_GCM_SHA384',
    'TLS_CHACHA20_POLY1305_SHA256',
    'TLS_AES_128_GCM_SHA256',
    'ECDHE-RSA-AES256-GCM-SHA384',
    'ECDHE-RSA-AES128-GCM-SHA256'
  ],
  certificatePinning: true,
  hsts: {
    maxAge: 31536000, // 1 year
    includeSubDomains: true,
    preload: true
  }
};

// API Security Headers
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
      fontSrc: ["'self'"],
      connectSrc: ["'self'"],
      frameAncestors: ["'none'"],
      objectSrc: ["'none'"],
      baseUri: ["'self'"]
    }
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  noSniff: true,
  frameguard: { action: 'deny' },
  xssFilter: true
}));

// Certificate Pinning for API Clients
class SecureApiClient {
  private certFingerprints: string[] = [
    'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=', // Primary cert
    'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB='  // Backup cert
  ];

  async makeSecureRequest(url: string, options: RequestOptions): Promise<any> {
    const agent = new https.Agent({
      checkServerIdentity: (host, cert) => {
        const fingerprint = crypto
          .createHash('sha256')
          .update(cert.raw)
          .digest('base64');
        
        const pinnedFingerprint = `sha256/${fingerprint}`;
        
        if (!this.certFingerprints.includes(pinnedFingerprint)) {
          throw new Error(`Certificate pinning failed. Expected: ${this.certFingerprints.join(', ')}, Got: ${pinnedFingerprint}`);
        }
      }
    });

    return fetch(url, {
      ...options,
      agent
    });
  }
}
```

## Audit Trail & Compliance Logging

### Comprehensive Audit Logging
```typescript
interface AuditLogEntry {
  eventId: string;
  timestamp: Date;
  tenantId: string;
  userId?: string;
  sessionId?: string;
  
  // Event classification
  eventType: AuditEventType;
  category: AuditCategory;
  severity: AuditSeverity;
  
  // Context information
  resource?: string;
  action?: string;
  entityType?: string;
  entityId?: string;
  
  // Change tracking
  oldValues?: any;
  newValues?: any;
  changesSummary?: string;
  
  // Request context
  ipAddress?: string;
  userAgent?: string;
  requestId?: string;
  endpoint?: string;
  httpMethod?: string;
  
  // Security context
  authenticationMethod?: string;
  authorizationLevel?: string;
  accessGranted: boolean;
  
  // Compliance metadata
  complianceRelevant: boolean;
  retentionPeriod: number; // in days
  legalHold: boolean;
  
  // Additional context
  metadata?: Record<string, any>;
  correlationId?: string;
}

enum AuditEventType {
  AUTHENTICATION = 'AUTHENTICATION',
  AUTHORIZATION = 'AUTHORIZATION', 
  DATA_ACCESS = 'DATA_ACCESS',
  DATA_MODIFICATION = 'DATA_MODIFICATION',
  SYSTEM_ACCESS = 'SYSTEM_ACCESS',
  CONFIGURATION_CHANGE = 'CONFIGURATION_CHANGE',
  SECURITY_EVENT = 'SECURITY_EVENT',
  COMPLIANCE_EVENT = 'COMPLIANCE_EVENT'
}

enum AuditCategory {
  SECURITY = 'SECURITY',
  BUSINESS = 'BUSINESS',
  TECHNICAL = 'TECHNICAL',
  COMPLIANCE = 'COMPLIANCE',
  OPERATIONAL = 'OPERATIONAL'
}

enum AuditSeverity {
  INFO = 'INFO',
  WARNING = 'WARNING',
  ERROR = 'ERROR',
  CRITICAL = 'CRITICAL'
}

class ComplianceAuditLogger {
  async logEvent(entry: Partial<AuditLogEntry>): Promise<void> {
    const fullEntry: AuditLogEntry = {
      eventId: uuidv4(),
      timestamp: new Date(),
      accessGranted: true,
      complianceRelevant: this.isComplianceRelevant(entry),
      retentionPeriod: this.calculateRetentionPeriod(entry),
      legalHold: false,
      severity: entry.severity || AuditSeverity.INFO,
      category: entry.category || AuditCategory.TECHNICAL,
      ...entry
    };

    // Store in primary audit log
    await this.storeAuditEntry(fullEntry);
    
    // Store in compliance log if relevant
    if (fullEntry.complianceRelevant) {
      await this.storeComplianceEntry(fullEntry);
    }

    // Send to SIEM if high severity
    if (fullEntry.severity === AuditSeverity.CRITICAL || fullEntry.severity === AuditSeverity.ERROR) {
      await this.sendToSIEM(fullEntry);
    }

    // Real-time alerting for security events
    if (fullEntry.category === AuditCategory.SECURITY) {
      await this.processSecurityAlert(fullEntry);
    }
  }

  private isComplianceRelevant(entry: Partial<AuditLogEntry>): boolean {
    const complianceEvents = [
      AuditEventType.DATA_ACCESS,
      AuditEventType.DATA_MODIFICATION,
      AuditEventType.AUTHENTICATION,
      AuditEventType.CONFIGURATION_CHANGE
    ];

    const complianceResources = [
      'companies', 'trial_balance', 'journal_entries',
      'procedures', 'documents', 'financial_statements',
      'audit_reports'
    ];

    return complianceEvents.includes(entry.eventType!) ||
           complianceResources.includes(entry.resource!) ||
           entry.category === AuditCategory.COMPLIANCE;
  }

  private calculateRetentionPeriod(entry: Partial<AuditLogEntry>): number {
    // SOX compliance requires 7 years retention for financial records
    if (this.isFinancialRecord(entry)) {
      return 7 * 365; // 7 years
    }

    // Security logs - 3 years
    if (entry.category === AuditCategory.SECURITY) {
      return 3 * 365; // 3 years
    }

    // General audit logs - 7 years (conservative approach)
    if (entry.complianceRelevant) {
      return 7 * 365; // 7 years
    }

    // Technical logs - 1 year
    return 365; // 1 year
  }

  private isFinancialRecord(entry: Partial<AuditLogEntry>): boolean {
    const financialResources = [
      'trial_balance', 'journal_entries', 'financial_statements',
      'companies', 'procedures', 'audit_reports'
    ];

    return financialResources.includes(entry.resource!);
  }

  // Automated audit trail verification
  async verifyAuditTrailIntegrity(tenantId: string, period: DateRange): Promise<IntegrityCheckResult> {
    const auditLogs = await this.getAuditLogs(tenantId, period);
    
    const result: IntegrityCheckResult = {
      totalRecords: auditLogs.length,
      validRecords: 0,
      corruptedRecords: 0,
      missingRecords: 0,
      sequenceGaps: [],
      checksumFailures: [],
      timestampAnomalies: []
    };

    let previousTimestamp = new Date(0);
    let expectedSequence = 1;

    for (const log of auditLogs) {
      // Check record integrity
      if (await this.verifyRecordChecksum(log)) {
        result.validRecords++;
      } else {
        result.corruptedRecords++;
        result.checksumFailures.push(log.eventId);
      }

      // Check timestamp ordering
      if (log.timestamp < previousTimestamp) {
        result.timestampAnomalies.push({
          eventId: log.eventId,
          timestamp: log.timestamp,
          previousTimestamp
        });
      }
      previousTimestamp = log.timestamp;

      // Check for sequence gaps (if using sequence numbers)
      if (log.sequenceNumber && log.sequenceNumber !== expectedSequence) {
        result.sequenceGaps.push({
          expected: expectedSequence,
          actual: log.sequenceNumber,
          eventId: log.eventId
        });
      }
      expectedSequence = (log.sequenceNumber || expectedSequence) + 1;
    }

    return result;
  }
}

// Database trigger for automatic audit logging
const auditTriggerFunction = `
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    old_data JSONB;
    new_data JSONB;
    excluded_cols TEXT[] := ARRAY['updated_at', 'last_accessed_at'];
BEGIN
    IF TG_OP = 'DELETE' THEN
        old_data = to_jsonb(OLD);
        INSERT INTO audit_logs (
            event_id, timestamp, tenant_id, user_id, event_type, category,
            table_name, entity_id, action, old_values, compliance_relevant,
            retention_period
        ) VALUES (
            gen_random_uuid(),
            NOW(),
            current_setting('app.tenant_id', true)::uuid,
            current_setting('app.user_id', true)::integer,
            'DATA_MODIFICATION'::audit_event_type,
            'BUSINESS'::audit_category,
            TG_TABLE_NAME,
            OLD.id::text,
            'DELETE',
            old_data,
            true,
            2555 -- 7 years in days
        );
        RETURN OLD;
    ELSIF TG_OP = 'UPDATE' THEN
        old_data = to_jsonb(OLD);
        new_data = to_jsonb(NEW);
        
        -- Only log if there are actual changes
        IF old_data IS DISTINCT FROM new_data THEN
            INSERT INTO audit_logs (
                event_id, timestamp, tenant_id, user_id, event_type, category,
                table_name, entity_id, action, old_values, new_values,
                compliance_relevant, retention_period
            ) VALUES (
                gen_random_uuid(),
                NOW(),
                current_setting('app.tenant_id', true)::uuid,
                current_setting('app.user_id', true)::integer,
                'DATA_MODIFICATION'::audit_event_type,
                'BUSINESS'::audit_category,
                TG_TABLE_NAME,
                NEW.id::text,
                'UPDATE',
                old_data,
                new_data,
                true,
                2555 -- 7 years in days
            );
        END IF;
        RETURN NEW;
    ELSIF TG_OP = 'INSERT' THEN
        new_data = to_jsonb(NEW);
        INSERT INTO audit_logs (
            event_id, timestamp, tenant_id, user_id, event_type, category,
            table_name, entity_id, action, new_values, compliance_relevant,
            retention_period
        ) VALUES (
            gen_random_uuid(),
            NOW(),
            current_setting('app.tenant_id', true)::uuid,
            current_setting('app.user_id', true)::integer,
            'DATA_MODIFICATION'::audit_event_type,
            'BUSINESS'::audit_category,
            TG_TABLE_NAME,
            NEW.id::text,
            'INSERT',
            new_data,
            true,
            2555 -- 7 years in days
        );
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
`;
```

## Incident Response & Security Monitoring

### Security Incident Detection
```typescript
interface SecurityIncident {
  incidentId: string;
  tenantId?: string;
  severity: IncidentSeverity;
  category: IncidentCategory;
  title: string;
  description: string;
  detectionTime: Date;
  detectionMethod: DetectionMethod;
  affectedUsers: string[];
  affectedResources: string[];
  indicators: SecurityIndicator[];
  status: IncidentStatus;
  assignedTo?: string;
  resolutionTime?: Date;
  rootCause?: string;
  remedialActions: RemedialAction[];
}

enum IncidentSeverity {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL'
}

enum IncidentCategory {
  AUTHENTICATION_FAILURE = 'AUTHENTICATION_FAILURE',
  UNAUTHORIZED_ACCESS = 'UNAUTHORIZED_ACCESS',
  DATA_BREACH = 'DATA_BREACH',
  MALWARE = 'MALWARE',
  DENIAL_OF_SERVICE = 'DENIAL_OF_SERVICE',
  CONFIGURATION_ERROR = 'CONFIGURATION_ERROR',
  INSIDER_THREAT = 'INSIDER_THREAT'
}

class SecurityMonitoringService {
  private incidentThresholds = {
    failedLogins: { count: 5, windowMinutes: 15 },
    dataAccess: { count: 100, windowMinutes: 5 },
    apiCalls: { count: 1000, windowMinutes: 1 },
    downloadVolume: { sizeGB: 5, windowMinutes: 30 }
  };

  async detectAnomalies(): Promise<SecurityIncident[]> {
    const incidents: SecurityIncident[] = [];

    // Detect failed authentication attempts
    const authFailures = await this.detectAuthenticationFailures();
    incidents.push(...authFailures);

    // Detect unusual data access patterns
    const dataAnomalies = await this.detectDataAccessAnomalies();
    incidents.push(...dataAnomalies);

    // Detect potential data exfiltration
    const exfiltrationAttempts = await this.detectDataExfiltration();
    incidents.push(...exfiltrationAttempts);

    // Detect privilege escalation attempts
    const privilegeAnomalies = await this.detectPrivilegeEscalation();
    incidents.push(...privilegeAnomalies);

    return incidents;
  }

  private async detectAuthenticationFailures(): Promise<SecurityIncident[]> {
    const query = `
      SELECT 
        ip_address, 
        user_email, 
        COUNT(*) as failure_count,
        MIN(timestamp) as first_failure,
        MAX(timestamp) as last_failure
      FROM audit_logs 
      WHERE event_type = 'AUTHENTICATION' 
        AND access_granted = false
        AND timestamp >= NOW() - INTERVAL '15 minutes'
      GROUP BY ip_address, user_email
      HAVING COUNT(*) >= $1
    `;

    const results = await this.db.query(query, [this.incidentThresholds.failedLogins.count]);
    const incidents: SecurityIncident[] = [];

    for (const result of results.rows) {
      incidents.push({
        incidentId: uuidv4(),
        severity: result.failure_count > 10 ? IncidentSeverity.HIGH : IncidentSeverity.MEDIUM,
        category: IncidentCategory.AUTHENTICATION_FAILURE,
        title: `Multiple Authentication Failures`,
        description: `${result.failure_count} failed login attempts from IP ${result.ip_address} for user ${result.user_email}`,
        detectionTime: new Date(),
        detectionMethod: DetectionMethod.AUTOMATED,
        affectedUsers: [result.user_email],
        affectedResources: [],
        indicators: [
          {
            type: 'ip_address',
            value: result.ip_address,
            confidence: 0.9
          },
          {
            type: 'user_email', 
            value: result.user_email,
            confidence: 0.8
          }
        ],
        status: IncidentStatus.OPEN,
        remedialActions: []
      });
    }

    return incidents;
  }

  private async detectDataAccessAnomalies(): Promise<SecurityIncident[]> {
    // Detect users accessing unusually large amounts of data
    const query = `
      WITH user_access_stats AS (
        SELECT 
          user_id,
          COUNT(*) as access_count,
          COUNT(DISTINCT entity_id) as unique_entities,
          MIN(timestamp) as first_access,
          MAX(timestamp) as last_access
        FROM audit_logs 
        WHERE event_type = 'DATA_ACCESS'
          AND timestamp >= NOW() - INTERVAL '5 minutes'
        GROUP BY user_id
      ),
      user_baselines AS (
        SELECT 
          user_id,
          AVG(daily_access_count) as avg_daily_access,
          STDDEV(daily_access_count) as stddev_daily_access
        FROM (
          SELECT 
            user_id,
            DATE(timestamp) as access_date,
            COUNT(*) as daily_access_count
          FROM audit_logs 
          WHERE event_type = 'DATA_ACCESS'
            AND timestamp >= NOW() - INTERVAL '30 days'
          GROUP BY user_id, DATE(timestamp)
        ) daily_stats
        GROUP BY user_id
      )
      SELECT 
        uas.*,
        ub.avg_daily_access,
        ub.stddev_daily_access,
        (uas.access_count - ub.avg_daily_access) / NULLIF(ub.stddev_daily_access, 0) as z_score
      FROM user_access_stats uas
      JOIN user_baselines ub ON uas.user_id = ub.user_id
      WHERE (uas.access_count - ub.avg_daily_access) / NULLIF(ub.stddev_daily_access, 0) > 3.0
         OR uas.access_count > $1
    `;

    const results = await this.db.query(query, [this.incidentThresholds.dataAccess.count]);
    const incidents: SecurityIncident[] = [];

    for (const result of results.rows) {
      incidents.push({
        incidentId: uuidv4(),
        severity: result.z_score > 5 ? IncidentSeverity.HIGH : IncidentSeverity.MEDIUM,
        category: IncidentCategory.UNAUTHORIZED_ACCESS,
        title: `Unusual Data Access Pattern`,
        description: `User ${result.user_id} accessed ${result.access_count} records in 5 minutes (${result.z_score.toFixed(2)} standard deviations above normal)`,
        detectionTime: new Date(),
        detectionMethod: DetectionMethod.AUTOMATED,
        affectedUsers: [result.user_id.toString()],
        affectedResources: [],
        indicators: [
          {
            type: 'user_behavior',
            value: `access_count_${result.access_count}`,
            confidence: Math.min(0.9, result.z_score / 10)
          }
        ],
        status: IncidentStatus.OPEN,
        remedialActions: []
      });
    }

    return incidents;
  }

  async respondToIncident(incidentId: string): Promise<IncidentResponse> {
    const incident = await this.getIncident(incidentId);
    const response: IncidentResponse = {
      incidentId,
      responseTime: new Date(),
      actions: []
    };

    // Automated response based on incident type and severity
    switch (incident.category) {
      case IncidentCategory.AUTHENTICATION_FAILURE:
        if (incident.severity === IncidentSeverity.HIGH) {
          // Temporarily block IP address
          await this.blockIPAddress(incident.indicators[0].value, '1 hour');
          response.actions.push({
            type: 'BLOCK_IP',
            target: incident.indicators[0].value,
            duration: '1 hour',
            automated: true
          });
        }
        break;

      case IncidentCategory.UNAUTHORIZED_ACCESS:
        if (incident.severity === IncidentSeverity.HIGH) {
          // Suspend user account
          await this.suspendUserAccount(incident.affectedUsers[0], '24 hours');
          response.actions.push({
            type: 'SUSPEND_USER',
            target: incident.affectedUsers[0],
            duration: '24 hours',
            automated: true
          });
        }
        break;

      case IncidentCategory.DATA_BREACH:
        // Immediate notification to security team
        await this.notifySecurityTeam(incident);
        response.actions.push({
          type: 'NOTIFY_SECURITY_TEAM',
          automated: true
        });
        break;
    }

    // Update incident status
    await this.updateIncidentStatus(incidentId, IncidentStatus.IN_PROGRESS);

    return response;
  }
}
```

This comprehensive security and compliance framework ensures that the multi-tenant eAuditPro application meets the stringent requirements of the audit industry while providing robust protection against modern security threats. The implementation addresses all major compliance requirements and provides the foundation for maintaining trust and regulatory adherence in a cloud-native environment.