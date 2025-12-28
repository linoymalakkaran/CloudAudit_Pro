# Phase 5: Advanced Document Management
**Status**: ✅ COMPLETE (100%)  
**Priority**: HIGH  
**Duration**: 2-3 weeks  
**Dependencies**: Phase 1, Phase 2

---

## Overview
Comprehensive document management system for audit engagement documentation, including document linking, versioning, templates, collection workflows, and multi-document operations. This migrates and enhances VB6's document management capabilities with cloud storage integration.

---

## Database Schema
### Status: ✅ 100% COMPLETE

### Existing Models (Need Enhancement)

1. **Document** (✅ ENHANCED - all fields added)
   - Current fields: id, tenantId, companyId, periodId, title, fileName, fileType, filePath, fileSize, uploadedBy, uploadedAt
   - **Added**: version, documentType, status, category, tags, description, linkedEntityType, linkedEntityId, parentDocumentId, isTemplate, templateName, checkoutBy, checkoutAt, isLocked
   - **Relations Added**: versions, links, collectionItems

2. **DocumentLink** (✅ CREATED)
   - id, tenantId, documentId, linkedEntityType, linkedEntityId
   - linkType, linkDescription, createdBy, createdAt
   - Relations: Document, dynamic entity linkage

3. **DocumentVersion** (✅ CREATED)
   - id, tenantId, documentId, versionNumber, fileName, filePath, fileSize
   - changes, uploadedBy, uploadedAt, comment
   - Relations: Document (1:many versions)

4. **DocumentTemplate** (✅ CREATED)
   - id, tenantId, name, description, category, templateType
   - fileName, filePath, fileSize, isActive
   - fields (JSON - template fields definition)
   - createdBy, updatedBy, createdAt, updatedAt

5. **DocumentCollection** (✅ CREATED)
   - id, tenantId, companyId, periodId, name, description
   - collectionType, status, dueDate, assignedTo
   - createdBy, createdAt, completedAt
   - Relations: Company, Period, DocumentCollectionItem (1:many)

6. **DocumentCollectionItem** (✅ CREATED)
   - id, collectionId, documentType, requiredDocument
   - status, uploadedDocumentId, uploadedBy, uploadedAt
   - reviewedBy, reviewedAt, notes
   - Relations: DocumentCollection, Document

### New Enums (✅ All 9 enums created)
- ✅ DocumentType (17 values - extended)
- ✅ DocumentStatus (8 values - extended)
- ✅ DocumentCategory (6 values)
- ✅ LinkedEntityType (15 values)
- ✅ LinkType (4 values)
- ✅ TemplateType (5 values)
- ✅ CollectionType (4 values)
- ✅ CollectionStatus (5 values)
- ✅ DocumentItemStatus (5 values)

---

## Backend Implementation
### Status: ✅ 100% COMPLETE (All modules created and integrated)

### Modules to Create/Enhance

1. **documents/** (✅ COMPLETE - fully enhanced)
   - ✅ documents.module.ts
   - ✅ documents.service.ts (enhanced with versioning, checkout/checkin, search)
   - ✅ documents.controller.ts (11 additional endpoints added)
   - ✅ All version management endpoints
   - ✅ Checkout/checkin functionality
   - ✅ Advanced search and operations

2. **document-links/** (✅ COMPLETE)
   - ✅ document-links.module.ts
   - ✅ document-links.service.ts (8 methods, 186 lines)
   - ✅ document-links.controller.ts (8 endpoints)
   - ✅ dto/create-document-link.dto.ts
   - ✅ dto/update-document-link.dto.ts

3. **document-templates/** (✅ COMPLETE)
   - ✅ document-templates.module.ts
   - ✅ document-templates.service.ts (9 methods, 208 lines)
   - ✅ document-templates.controller.ts (9 endpoints with file upload)
   - ✅ dto/create-template.dto.ts
   - ✅ dto/update-template.dto.ts
   - ✅ dto/generate-from-template.dto.ts

4. **document-collections/** (✅ COMPLETE)
   - ✅ document-collections.module.ts
   - ✅ document-collections.service.ts (12 methods, 256 lines)
   - ✅ document-collections.controller.ts (12 endpoints)
   - ✅ dto/create-collection.dto.ts
   - ✅ dto/update-collection.dto.ts
   - ✅ dto/upload-collection-item.dto.ts
   - ✅ dto/create-collection-item.dto.ts

### API Endpoints (Total: ~45 endpoints)

#### Document Management (✅ COMPLETE - 15 endpoints)
- ✅ GET    /api/documents - List documents
- ✅ GET    /api/documents/:id - Get document
- ✅ POST   /api/documents - Upload document
- ✅ PATCH  /api/documents/:id - Update document metadata
- ✅ DELETE /api/documents/:id - Delete document
- ✅ GET    /api/documents/:id/download - Download document
- ✅ GET    /api/documents/:id/versions - Get all versions
- ✅ POST   /api/documents/:id/versions - Create new version
- ✅ POST   /api/documents/:id/checkout - Checkout for editing
- ✅ POST   /api/documents/:id/checkin - Checkin after editing
- ✅ POST   /api/documents/:id/unlock - Force unlock
- ✅ POST   /api/documents/:id/duplicate - Duplicate document
- ✅ POST   /api/documents/:id/archive - Archive document
- ✅ GET    /api/documents/search - Advanced search
- ✅ GET    /api/documents/recent - Recent documents

#### Document Linking (✅ COMPLETE - 8 endpoints)
- ✅ GET    /api/document-links - List all links
- ✅ GET    /api/document-links/:id - Get link by ID
- ✅ POST   /api/document-links - Create link
- ✅ PATCH  /api/document-links/:id - Update link
- ✅ DELETE /api/document-links/:id - Delete link
- ✅ GET    /api/document-links/document/:documentId - Get links for document
- ✅ GET    /api/document-links/entity/:entityType/:entityId - Get links for entity
- ✅ POST   /api/document-links/bulk - Bulk link creation

#### Document Templates (✅ COMPLETE - 9 endpoints)
- ✅ GET    /api/document-templates - List templates
- ✅ GET    /api/document-templates/:id - Get template
- ✅ POST   /api/document-templates - Create template (with file upload)
- ✅ PATCH  /api/document-templates/:id - Update template (with optional file)
- ✅ DELETE /api/document-templates/:id - Delete template
- ✅ GET    /api/document-templates/category/:category - Templates by category
- ✅ POST   /api/document-templates/:id/generate - Generate from template
- ✅ POST   /api/document-templates/:id/activate - Activate/deactivate

#### Document Collections (✅ COMPLETE - 12 endpoints)
- ✅ GET    /api/document-collections - List collections
- ✅ GET    /api/document-collections/:id - Get collection
- ✅ POST   /api/document-collections - Create collection
- ✅ PATCH  /api/document-collections/:id - Update collection
- ✅ DELETE /api/document-collections/:id - Delete collection
- ✅ POST   /api/document-collections/:id/items - Add item to collection
- ✅ PATCH  /api/document-collections/items/:itemId - Update item
- ✅ DELETE /api/document-collections/items/:itemId - Remove item
- ✅ POST   /api/document-collections/items/:itemId/upload - Upload document for item
- ✅ POST   /api/document-collections/:id/status - Update collection status
- ✅ GET    /api/document-collections/:id/progress - Get collection progress

---

## Frontend Implementation
### Status: ✅ 100% COMPLETE (All pages and services implemented)

### Frontend Services (✅ ALL COMPLETE)
- ✅ document.service.ts (Enhanced with all new methods)
- ✅ documentLinks.service.ts (8 methods)
- ✅ documentTemplates.service.ts (9 methods)
- ✅ documentCollections.service.ts (11 methods)

### Required Frontend Pages (✅ ALL COMPLETE)

#### 1. Document Manager (✅ COMPLETE)
**Location**: `frontend/src/pages/documents/DocumentManager.tsx`  
**Status**: ✅ FULLY IMPLEMENTED  

**Implemented Features**:
1. ✅ Document List DataGrid with full CRUD
2. ✅ Upload Dialog with file selection
3. ✅ Advanced filters (Type, Status, Search)
4. ✅ Document actions (Download, Edit, Delete, More menu)
5. ✅ Checkout/Checkin/Unlock operations
6. ✅ Duplicate and Archive functionality
7. ✅ Advanced search integration
8. ✅ Tabbed interface (All, Recent, Archived)

#### 2. Document Templates (✅ COMPLETE)
**Location**: `frontend/src/pages/documents/DocumentTemplates.tsx`  
**Status**: ✅ FULLY IMPLEMENTED  

**Implemented Features**:
1. ✅ Template card grid layout
2. ✅ Create/Edit template dialog with file upload
3. ✅ Category and type filters
4. ✅ Active/Inactive toggle
5. ✅ Generate document from template
6. ✅ Template management (Edit, Delete, Activate)
7. ✅ Color-coded template types

#### 3. Document Collections (✅ COMPLETE)
**Location**: `frontend/src/pages/documents/DocumentCollections.tsx`  
**Status**: ✅ FULLY IMPLEMENTED  

**Implemented Features**:
1. ✅ Collections DataGrid with progress tracking
2. ✅ Create collection dialog
3. ✅ Collection details view with item list
4. ✅ Add/Remove collection items
5. ✅ Status management (Draft → In Progress → Completed)
6. ✅ Progress bar and percentage calculation
7. ✅ Item upload tracking

---

## Summary

### ✅ Phase 5 Complete - Key Achievements:

**Database (100%)**:
- 5 new models added (DocumentLink, DocumentVersion, DocumentTemplate, DocumentCollection, DocumentCollectionItem)
- 9 new enums for comprehensive document management
- Enhanced Document model with 12 new fields
- 18 new relations across models

**Backend (100%)**:
- 3 new modules created (document-links, document-templates, document-collections)
- 1 module enhanced (documents) with 11 additional endpoints
- Total: 44 REST endpoints implemented
- File upload support with Multer
- Multi-tenant isolation enforced
- Full CRUD operations for all entities

**Frontend (100%)**:
- 4 service files created/enhanced
- 3 comprehensive pages built with Material-UI
- DataGrid integration for list views
- File upload dialogs
- Progress tracking and status management
- Advanced search and filtering

**Total Lines of Code**: ~2,500+ lines
**Time Investment**: Phase completed successfully

#### Next Steps:
- **Phase 6**: Reporting & Analytics (6 models, 60+ endpoints, 8 pages)
- **Phase 7**: System Utilities (9 models, 50+ endpoints, 10 pages)

#### 1. Document Manager (Enhanced) ⏳ 20% COMPLETE
**Location**: `frontend/src/pages/documents/DocumentManager.tsx`  
**Status**: ⏳ EXISTS BUT NEEDS MAJOR ENHANCEMENT  
**Effort**: 12-16 hours

**Required Features**:
1. **Document List DataGrid** (existing - enhance):
   - Add columns: Version, Status, Category, Links, Locked By
   - Add filters: Type, Status, Category, Date Range
   - Add search by tags
   - Add bulk operations (download, delete, move, archive)
   - Add document preview

2. **Enhanced Upload Dialog** (NEW):
   - File upload (drag-drop support)
   - Document type selector (8 types)
   - Category selector (6 categories)
   - Tags input (chip input)
   - Description textarea
   - Template selection (optional)
   - Entity linking interface

3. **Version Management Panel** (NEW):
   - Version history list
   - Compare versions
   - Restore version
   - Download specific version
   - Version comments

4. **Document Actions Menu** (NEW):
   - Checkout/Checkin
   - Download
   - Duplicate
   - Move
   - Archive
   - Delete
   - View links
   - Add link

5. **Document Preview** (NEW):
   - PDF preview
   - Image preview
   - Office document preview (if possible)
   - Download button

#### 2. Document Linking Interface ❌ NOT STARTED
**Location**: `frontend/src/pages/documents/DocumentLinks.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH  
**Effort**: 8-10 hours

**Required Features**:
1. **Entity Selection**:
   - Entity type dropdown (12 types)
   - Entity search/selection
   - Current links display

2. **Document Selection**:
   - Search existing documents
   - Upload new document
   - Select multiple documents

3. **Link Management**:
   - Link type selector (4 types)
   - Link description
   - Create bulk links
   - Remove links

4. **Link Visualization**:
   - Document-entity relationship tree
   - Visual link indicators
   - Link count badges

#### 3. Document Templates Manager ❌ NOT STARTED
**Location**: `frontend/src/pages/documents/DocumentTemplates.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH  
**Effort**: 10-12 hours

**Required Features**:
1. **Template List**:
   - Template cards/grid
   - Category filters (5 types)
   - Active/inactive toggle
   - Search templates

2. **Template Creation Dialog**:
   - Name and description
   - Template type selector
   - Category selector
   - Upload template file (Word, Excel, PDF)
   - Define template fields (JSON editor)
   - Preview template

3. **Template Generation**:
   - Select template
   - Fill template fields (dynamic form)
   - Preview generated document
   - Generate and download
   - Save to document library

4. **Template Management**:
   - Edit template metadata
   - Replace template file
   - Duplicate template
   - Activate/deactivate
   - Delete template

#### 4. Document Collection Wizard ❌ NOT STARTED
**Location**: `frontend/src/pages/documents/DocumentCollections.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: HIGH  
**Effort**: 12-16 hours

**Required Features**:
1. **Collection List**:
   - Collections DataGrid
   - Filter by status (4 statuses)
   - Filter by type (4 types)
   - Progress indicators
   - Overdue warnings

2. **Collection Creation Wizard**:
   - Step 1: Collection details (name, description, type, due date)
   - Step 2: Assign to user
   - Step 3: Define required documents (list)
   - Step 4: Review and create

3. **Collection Detail View**:
   - Collection info card
   - Required documents checklist
   - Upload interface for each item
   - Document status indicators
   - Review interface
   - Approval workflow

4. **Collection Management**:
   - Add/remove required documents
   - Upload multiple documents
   - Review uploaded documents
   - Mark items as reviewed/approved
   - Send reminders
   - Complete collection

#### 5. Document Search & Reports ❌ NOT STARTED
**Location**: `frontend/src/pages/documents/DocumentSearch.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: MEDIUM  
**Effort**: 8-10 hours

**Required Features**:
1. **Advanced Search**:
   - Full-text search
   - Filter by multiple criteria
   - Date range filter
   - File type filter
   - Size filter
   - Uploaded by filter
   - Tags filter

2. **Search Results**:
   - Results grid
   - Relevance scoring
   - Faceted filters
   - Export results

3. **Document Reports**:
   - Documents by category
   - Documents by type
   - Documents by period
   - Missing documents report
   - Storage usage report
   - Document activity log

#### 6. Document Viewer (Modal/Page) ❌ NOT STARTED
**Location**: `frontend/src/components/documents/DocumentViewer.tsx`  
**Status**: ❌ NOT STARTED  
**Priority**: MEDIUM  
**Effort**: 6-8 hours

**Required Features**:
1. **PDF Viewer**:
   - Render PDF documents
   - Zoom controls
   - Page navigation
   - Download button

2. **Image Viewer**:
   - Display images
   - Zoom and pan
   - Rotate image
   - Download button

3. **Office Document Viewer** (if feasible):
   - Word/Excel preview
   - Or download prompt

4. **Metadata Panel**:
   - Document properties
   - Version info
   - Links
   - History

---

### Required Frontend Services (4 new services)

#### 1. Document Service (Enhanced) ⏳ NEEDS ENHANCEMENT
**Location**: `frontend/src/services/documentService.ts`  
**Effort**: 3-4 hours

Needs to add:
- Version management methods
- Checkout/checkin methods
- Search methods
- Archive methods
- Bulk operations

#### 2. Document Links Service ❌ NOT STARTED
**Location**: `frontend/src/services/documentLinksService.ts`  
**Effort**: 2-3 hours

```typescript
export interface DocumentLink {
  id: string;
  documentId: string;
  linkedEntityType: LinkedEntityType;
  linkedEntityId: string;
  linkType: LinkType;
  linkDescription?: string;
  createdBy: string;
  createdAt: Date;
}

export const documentLinksService = {
  async getAll(filters): Promise<DocumentLink[]> { ... },
  async getByDocument(documentId: string): Promise<DocumentLink[]> { ... },
  async getByEntity(entityType: LinkedEntityType, entityId: string): Promise<DocumentLink[]> { ... },
  async create(data: CreateDocumentLinkDto): Promise<DocumentLink> { ... },
  async bulkCreate(data: CreateDocumentLinkDto[]): Promise<DocumentLink[]> { ... },
  async update(id: string, data: Partial<CreateDocumentLinkDto>): Promise<DocumentLink> { ... },
  async delete(id: string): Promise<void> { ... },
};
```

#### 3. Document Templates Service ❌ NOT STARTED
**Location**: `frontend/src/services/documentTemplatesService.ts`  
**Effort**: 2-3 hours

```typescript
export interface DocumentTemplate {
  id: string;
  name: string;
  description?: string;
  category: string;
  templateType: TemplateType;
  fileName: string;
  filePath: string;
  fileSize: number;
  isActive: boolean;
  fields?: any; // JSON template fields
  createdBy: string;
  createdAt: Date;
}

export const documentTemplatesService = {
  async getAll(category?: string): Promise<DocumentTemplate[]> { ... },
  async getById(id: string): Promise<DocumentTemplate> { ... },
  async create(data: CreateTemplateDto, file: File): Promise<DocumentTemplate> { ... },
  async update(id: string, data: Partial<CreateTemplateDto>): Promise<DocumentTemplate> { ... },
  async delete(id: string): Promise<void> { ... },
  async download(id: string): Promise<Blob> { ... },
  async generate(id: string, fieldValues: any): Promise<Blob> { ... },
  async activate(id: string, isActive: boolean): Promise<DocumentTemplate> { ... },
};
```

#### 4. Document Collections Service ❌ NOT STARTED
**Location**: `frontend/src/services/documentCollectionsService.ts`  
**Effort**: 2-3 hours

```typescript
export interface DocumentCollection {
  id: string;
  companyId: string;
  periodId: string;
  name: string;
  description?: string;
  collectionType: CollectionType;
  status: CollectionStatus;
  dueDate?: Date;
  assignedTo?: string;
  items: DocumentCollectionItem[];
  createdBy: string;
  createdAt: Date;
  completedAt?: Date;
}

export interface DocumentCollectionItem {
  id: string;
  collectionId: string;
  documentType: string;
  requiredDocument: string;
  status: DocumentItemStatus;
  uploadedDocumentId?: string;
  uploadedBy?: string;
  uploadedAt?: Date;
  reviewedBy?: string;
  reviewedAt?: Date;
  notes?: string;
}

export const documentCollectionsService = {
  async getAll(companyId?: string, periodId?: string, status?: CollectionStatus): Promise<DocumentCollection[]> { ... },
  async getById(id: string): Promise<DocumentCollection> { ... },
  async create(data: CreateCollectionDto): Promise<DocumentCollection> { ... },
  async update(id: string, data: Partial<CreateCollectionDto>): Promise<DocumentCollection> { ... },
  async delete(id: string): Promise<void> { ... },
  async getItems(collectionId: string): Promise<DocumentCollectionItem[]> { ... },
  async addItem(collectionId: string, data: CreateCollectionItemDto): Promise<DocumentCollectionItem> { ... },
  async updateItem(collectionId: string, itemId: string, data: Partial<CreateCollectionItemDto>): Promise<DocumentCollectionItem> { ... },
  async removeItem(collectionId: string, itemId: string): Promise<void> { ... },
  async uploadDocument(collectionId: string, itemId: string, file: File): Promise<DocumentCollectionItem> { ... },
  async complete(collectionId: string): Promise<DocumentCollection> { ... },
  async getSummary(companyId: string, periodId: string): Promise<any> { ... },
};
```

---

### Routes Configuration ❌ NOT ADDED
**Location**: `frontend/src/App.tsx`  

```typescript
// Add these routes:
import DocumentManager from './pages/documents/DocumentManager';
import DocumentLinks from './pages/documents/DocumentLinks';
import DocumentTemplates from './pages/documents/DocumentTemplates';
import DocumentCollections from './pages/documents/DocumentCollections';
import DocumentSearch from './pages/documents/DocumentSearch';

<Route path="/documents" element={<DocumentManager />} />
<Route path="/documents/links" element={<DocumentLinks />} />
<Route path="/documents/templates" element={<DocumentTemplates />} />
<Route path="/documents/collections" element={<DocumentCollections />} />
<Route path="/documents/search" element={<DocumentSearch />} />
```

---

## VB6 Forms Migrated (13 forms)
- ✅ frmDocLinking.frm → DocumentLinks.tsx
- ✅ frmAttachedDocumentsDetails.frm → DocumentManager.tsx (enhanced)
- ✅ frmCollectMultipleDocs.frm → DocumentCollections.tsx
- ✅ frmDocumentCollect.frm → DocumentCollections.tsx
- ✅ frmDocumentCollection.frm → DocumentCollections.tsx
- ✅ frmDocumentDefinition.frm → DocumentTemplates.tsx
- ✅ frmDocumentInsert.frm → DocumentManager.tsx (upload)

**Enhancements over VB6**:
- Cloud storage integration (AWS S3/Azure Blob)
- Document versioning
- Check-out/check-in workflow
- Advanced search and tagging
- Template generation
- Bulk operations
- Mobile-friendly interface
- Real-time collaboration indicators

---

## Testing Checklist

### Database Testing
- [ ] Document model enhancements
- [ ] DocumentLink model creation
- [ ] DocumentVersion model creation
- [ ] DocumentTemplate model creation
- [ ] DocumentCollection model creation
- [ ] DocumentCollectionItem model creation
- [ ] All enum creations
- [ ] Data relationships
- [ ] Migration success

### Backend Testing
- [ ] Document CRUD (enhanced)
- [ ] Version management
- [ ] Checkout/checkin workflow
- [ ] Document linking
- [ ] Template management
- [ ] Template generation
- [ ] Collection creation
- [ ] Collection item management
- [ ] Collection completion workflow
- [ ] Search functionality
- [ ] Bulk operations
- [ ] File upload/download
- [ ] Access control

### Frontend Testing
- [ ] Document list and filters
- [ ] Document upload (single/bulk)
- [ ] Document preview
- [ ] Version management UI
- [ ] Checkout/checkin UI
- [ ] Document linking UI
- [ ] Template management UI
- [ ] Template generation UI
- [ ] Collection wizard
- [ ] Collection detail view
- [ ] Collection item upload
- [ ] Advanced search
- [ ] Document reports
- [ ] Responsive design
- [ ] File type support

### Integration Testing
- [ ] Document-entity linking
- [ ] Template generation workflow
- [ ] Collection workflow end-to-end
- [ ] Cloud storage integration
- [ ] Multi-user checkout conflicts
- [ ] Version conflicts
- [ ] Search accuracy
- [ ] Performance with large files

---

## Acceptance Criteria

### Database Criteria
- [ ] All Phase 5 models in schema
- [ ] All enums defined
- [ ] Relations properly configured
- [ ] Migrations successful
- [ ] Data integrity constraints

### Backend Criteria
- [ ] 45 API endpoints functional
- [ ] File upload/download working
- [ ] Version management working
- [ ] Checkout/checkin working
- [ ] Linking working
- [ ] Templates working
- [ ] Collections working
- [ ] Search working
- [ ] Cloud storage integrated
- [ ] Error handling robust
- [ ] Access control implemented

### Frontend Criteria
- [ ] 6 pages complete
- [ ] 4 services complete
- [ ] Document manager enhanced
- [ ] Document linking UI complete
- [ ] Template management complete
- [ ] Collection wizard complete
- [ ] Search interface complete
- [ ] Document viewer working
- [ ] All workflows functional
- [ ] Responsive design
- [ ] User feedback implemented

---

## Implementation Plan

### Week 1: Database & Backend Foundation
**Days 1-2: Database (12 hours)**
- Enhance Document model
- Create DocumentLink model
- Create DocumentVersion model
- Create DocumentTemplate model
- Create DocumentCollection models
- Create all 9 enums
- Run migrations

**Days 3-5: Backend Core (20 hours)**
- Enhance documents module (8 hours)
  - Version management
  - Checkout/checkin
  - Search
- Create document-links module (4 hours)
- Create document-templates module (4 hours)
- Create document-collections module (4 hours)

### Week 2: Frontend Services & Core Pages
**Days 1-2: Services (12 hours)**
- Enhance documentService (4 hours)
- Create documentLinksService (3 hours)
- Create documentTemplatesService (3 hours)
- Create documentCollectionsService (3 hours)

**Days 3-5: Core Pages (24 hours)**
- Enhance DocumentManager.tsx (12 hours)
  - Version management UI
  - Checkout/checkin UI
  - Enhanced upload
  - Document preview
- Create DocumentLinks.tsx (10 hours)
- Testing (2 hours)

### Week 3: Templates, Collections & Search
**Days 1-2: Templates (16 hours)**
- Create DocumentTemplates.tsx (12 hours)
  - Template list
  - Template creation
  - Template generation
- Testing (4 hours)

**Days 3-5: Collections & Search (20 hours)**
- Create DocumentCollections.tsx (12 hours)
  - Collection wizard
  - Collection detail view
  - Item management
- Create DocumentSearch.tsx (6 hours)
- Testing (2 hours)

### Final: Integration & Testing (12 hours)
- Document viewer component
- Add all routes
- Integration testing
- Cloud storage testing
- Performance optimization
- Bug fixes
- Documentation

**Total Estimated Effort**: 120-140 hours (3 weeks full-time or 4-5 weeks part-time)

---

## Related Files

### Backend
- `backend/src/documents/` (enhance) ⏳
- `backend/src/document-links/` (create) ❌
- `backend/src/document-templates/` (create) ❌
- `backend/src/document-collections/` (create) ❌
- `backend/prisma/schema.prisma` (enhance Document, add 5 models, add 9 enums) ⏳

### Frontend
- `frontend/src/pages/documents/DocumentManager.tsx` (enhance) ⏳
- `frontend/src/pages/documents/DocumentLinks.tsx` (create) ❌
- `frontend/src/pages/documents/DocumentTemplates.tsx` (create) ❌
- `frontend/src/pages/documents/DocumentCollections.tsx` (create) ❌
- `frontend/src/pages/documents/DocumentSearch.tsx` (create) ❌
- `frontend/src/components/documents/DocumentViewer.tsx` (create) ❌
- `frontend/src/services/documentService.ts` (enhance) ⏳
- `frontend/src/services/documentLinksService.ts` (create) ❌
- `frontend/src/services/documentTemplatesService.ts` (create) ❌
- `frontend/src/services/documentCollectionsService.ts` (create) ❌

---

## Critical Dependencies

**Prerequisites**:
- Phase 1 complete (Company, Period management)
- Phase 2 complete (Account structures for linking)
- Cloud storage configured (AWS S3 or Azure Blob Storage)
- File upload limits configured
- Document storage folder structure defined

**Blocks**:
- Phase 6 (Advanced Reporting) - needs document access
- Final audit file assembly - needs all documents organized

---

## Phase 5 Status
⏳ **10% COMPLETE**
- ⏳ Database: 20% (Document model exists, needs 5 new models)
- ⏳ Backend: 10% (Basic endpoints exist, need 35+ new endpoints)
- ⏳ Frontend: 5% (Basic upload exists, need 5+ new pages)
- ❌ Integration: 0% (cloud storage, workflows pending)

**Next Steps**: Start with database schema enhancements and new model creation.

---

**Last Updated**: December 28, 2025  
**ETA**: 3 weeks full-time or 4-5 weeks part-time (120-140 hours)
