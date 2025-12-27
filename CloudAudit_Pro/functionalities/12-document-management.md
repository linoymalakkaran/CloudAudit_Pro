# CloudAudit Pro - Document Management

## 📁 Overview

CloudAudit Pro's Document Management system provides secure storage, organization, and retrieval of audit documentation and supporting evidence. The system supports multiple file types, version control, and intelligent linking to audit procedures, findings, and workpapers.

**Key Features**:
- Secure file upload and storage
- Multiple file type support
- Document organization and categorization
- Link documents to procedures, findings, workpapers
- Version control
- Full-text search capabilities
- Access control and permissions
- Audit trail for all document activities

---

## 📋 Document Structure

```typescript
interface Document {
  id: string;
  name: string;               // Document name/title
  description?: string;       // Document description
  type: DocumentType;         // Document classification
  
  // File Information
  originalFilename: string;   // Original upload filename
  fileExtension: string;      // .pdf, .xlsx, .docx, etc.
  fileSizeBytes: number;      // File size in bytes
  mimeType: string;           // MIME type
  filePath: string;           // Storage path (internal)
  
  // Organization
  companyId: string;          // Company association
  periodId?: string;          // Period association (optional)
  accountId?: string;         // Account association (optional)
  tenantId: string;           // Multi-tenant isolation
  
  // Linking
  procedureId?: string;       // Link to audit procedure
  workpaperId?: string;       // Link to workpaper
  findingId?: string;         // Link to finding
  journalEntryId?: string;    // Link to journal entry
  
  // Classification
  tags?: string[];            // Custom tags for search
  category?: string;          // Document category
  
  // Status
  status: DocumentStatus;     // PENDING, REVIEWED, APPROVED
  isArchived: boolean;        // Archived status
  
  // Metadata
  uploadedBy: string;         // User who uploaded
  uploadedAt: Date;           // Upload timestamp
  reviewedBy?: string;        // Reviewer
  reviewedAt?: Date;          // Review timestamp
  
  // Timestamps
  createdAt: Date;
  updatedAt: Date;
}
```

---

## 📂 Document Types

```typescript
enum DocumentType {
  FINANCIAL_STATEMENT = 'FINANCIAL_STATEMENT',    // Balance sheet, income statement
  TRIAL_BALANCE = 'TRIAL_BALANCE',                // Trial balance files
  GENERAL_LEDGER = 'GENERAL_LEDGER',              // Ledger reports
  BANK_STATEMENT = 'BANK_STATEMENT',              // Bank statements
  INVOICE = 'INVOICE',                            // Invoices
  RECEIPT = 'RECEIPT',                            // Receipts
  CONTRACT = 'CONTRACT',                          // Contracts, agreements
  CORRESPONDENCE = 'CORRESPONDENCE',              // Emails, letters
  WORKING_PAPER = 'WORKING_PAPER',                // Audit workpapers
  MANAGEMENT_LETTER = 'MANAGEMENT_LETTER',        // Management letters
  OTHER = 'OTHER'                                 // Miscellaneous
}
```

---

## 📤 File Upload

### Upload Process

**Step 1: Select File**
```http
POST /api/documents/upload
Authorization: Bearer {token}
Content-Type: multipart/form-data

FormData:
- file: [binary file data]
- name: "December Bank Statement"
- description: "Bank of America checking account statement"
- type: "BANK_STATEMENT"
- companyId: "comp_acme"
- periodId: "per_fy2024"
- tags: ["bank", "december", "checking"]
```

**Step 2: Validation**
- File size check (max 10MB default)
- File type validation
- Virus scan (if configured)
- Duplicate detection

**Step 3: Storage**
- Generate unique file ID
- Store in secure location
- Create database record
- Generate thumbnail (if image/PDF)

**Step 4: Response**
```json
{
  "id": "doc_001",
  "name": "December Bank Statement",
  "originalFilename": "bank_statement_dec_2024.pdf",
  "fileExtension": "pdf",
  "fileSizeBytes": 245678,
  "mimeType": "application/pdf",
  "type": "BANK_STATEMENT",
  "status": "PENDING",
  "uploadedBy": "user_123",
  "uploadedAt": "2025-01-15T10:30:00Z",
  "downloadUrl": "/api/documents/doc_001/download",
  "previewUrl": "/api/documents/doc_001/preview"
}
```

---

## 📥 File Download

```http
GET /api/documents/:id/download
Authorization: Bearer {token}

Response:
- Content-Type: [file mime type]
- Content-Disposition: attachment; filename="document.pdf"
- Body: [file binary data]
```

---

## 🔗 Document Linking

### Link to Audit Procedure

```http
POST /api/documents/:id/link
Content-Type: application/json

{
  "linkType": "PROCEDURE",
  "linkId": "proc_123"
}
```

### Link to Workpaper

```http
POST /api/documents/:id/link
Content-Type: application/json

{
  "linkType": "WORKPAPER",
  "linkId": "wp_001"
}
```

### Link to Finding

```http
POST /api/documents/:id/link
Content-Type: application/json

{
  "linkType": "FINDING",
  "linkId": "find_001"
}
```

---

## 🔍 Search & Retrieval

### Search Documents

```http
GET /api/documents?search=bank&type=BANK_STATEMENT&companyId=comp_acme&page=1&limit=20
Authorization: Bearer {token}

Response:
{
  "documents": [
    {
      "id": "doc_001",
      "name": "December Bank Statement",
      "type": "BANK_STATEMENT",
      "fileExtension": "pdf",
      "fileSizeBytes": 245678,
      "uploadedAt": "2025-01-15T10:30:00Z",
      "uploadedBy": { "firstName": "John", "lastName": "Auditor" }
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

### Filter Options
- By document type
- By company
- By period
- By date range
- By uploader
- By status
- By tags
- Full-text search

---

## 📊 Supported File Types

| Category | Extensions | Max Size | Features |
|----------|-----------|----------|----------|
| **Documents** | .pdf, .doc, .docx | 10MB | Preview, full-text search |
| **Spreadsheets** | .xls, .xlsx, .csv | 10MB | Preview, data extract |
| **Images** | .jpg, .png, .gif, .bmp | 5MB | Thumbnail, preview |
| **Archives** | .zip, .rar | 25MB | Extract, list contents |
| **Text** | .txt, .rtf | 1MB | Full-text search, preview |

---

## 💼 Use Cases

### Use Case 1: Upload Client Documents

**Scenario**: Client provides supporting documentation

**Steps**:
1. Navigate to Documents page
2. Click "Upload Document"
3. Select file(s) from computer
4. Enter document details:
   - Name: "Vendor Invoice #12345"
   - Type: INVOICE
   - Company: Select client
   - Period: Select audit period
   - Tags: vendor, invoice, accounts-payable
5. Link to procedure (if applicable)
6. Click "Upload"
7. System stores and indexes document

### Use Case 2: Attach Evidence to Finding

**Scenario**: Auditor identifies finding and needs to attach supporting evidence

**Steps**:
1. Create or open finding
2. Click "Attach Documents"
3. Either:
   - Upload new document, OR
   - Select from existing documents
4. Link document to finding
5. Document appears in finding's attachments
6. Available for review and audit trail

### Use Case 3: Search for Bank Statements

**Scenario**: Need to find all bank statements for review

**Steps**:
1. Go to Documents page
2. Filter by:
   - Type: Bank Statement
   - Company: Acme Corporation
   - Period: FY 2024
3. View results (15 bank statements)
4. Download specific statement
5. Preview in browser (if PDF)

---

## ⚙️ Best Practices

1. **Descriptive Names**: Use clear, descriptive document names
2. **Proper Classification**: Select correct document type
3. **Tag Appropriately**: Add relevant tags for easy search
4. **Link Documents**: Link to related procedures, findings, workpapers
5. **Organize by Period**: Associate documents with correct audit period
6. **Regular Cleanup**: Archive or delete obsolete documents
7. **Version Control**: Use version numbers for revised documents
8. **Security**: Don't upload sensitive passwords or credentials

---

## 🔐 Access Control

| Role | Upload | Download | Delete | Link | Review |
|------|--------|----------|--------|------|--------|
| Intern | ✅ | ✅ Own | ❌ | ✅ | ❌ |
| Auditor | ✅ | ✅ All | ✅ Own | ✅ | ❌ |
| Senior | ✅ | ✅ All | ✅ All | ✅ | ✅ |
| Manager | ✅ | ✅ All | ✅ All | ✅ | ✅ |
| Admin | ✅ | ✅ All | ✅ All | ✅ | ✅ |
| Client | ✅ Own | ✅ Own | ❌ | ❌ | ❌ |

---

## ❗ Troubleshooting

**Problem**: Upload Fails  
**Solution**: Check file size (max 10MB), verify file type is supported, ensure stable internet connection

**Problem**: Cannot Download Document  
**Solution**: Verify permissions, check if document exists, clear browser cache

**Problem**: Search Returns No Results  
**Solution**: Check spelling, remove filters, try broader search terms, verify company/period selection

**Problem**: Preview Not Working  
**Solution**: Ensure browser PDF plugin enabled, try downloading instead, check file isn't corrupted

---

*For document management support, contact your system administrator.*
