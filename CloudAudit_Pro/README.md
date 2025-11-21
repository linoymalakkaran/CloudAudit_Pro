# CloudAudit Pro

**Modern Multi-Tenant Audit Management SaaS Platform**

CloudAudit Pro is the complete modernization of the eAuditPro desktop application, transformed into a cutting-edge, cloud-native, multi-tenant SaaS platform built with modern web technologies.

## 🚀 Features

### 🏢 Multi-Tenant Architecture
- **Database-per-Tenant**: Complete data isolation for regulatory compliance
- **Automated Provisioning**: Seamless tenant onboarding
- **Subscription Management**: Flexible pricing tiers and billing
- **Custom Branding**: Tenant-specific customization options

### 📊 Comprehensive Audit Management
- **Company & Period Management**: Multi-company, multi-period support
- **Chart of Accounts**: Flexible account structures
- **Trial Balance Management**: Import, edit, and validate financial data
- **Audit Procedures**: Complete workflow management with assignment and review
- **Journal Entries**: Adjustment entries with validation
- **Document Management**: Secure file storage and linking
- **Financial Reporting**: Automated financial statement generation

### 💻 Modern Technology Stack
- **Backend**: NestJS + TypeScript + Prisma ORM
- **Frontend**: React 18 + TypeScript + Material-UI
- **Database**: PostgreSQL (Azure Database)
- **Cloud Platform**: Microsoft Azure
- **Progressive Web App**: Offline capabilities and mobile optimization

### 🔒 Enterprise Security
- **JWT Authentication**: Secure token-based authentication
- **Role-Based Access**: Granular permission system
- **Data Encryption**: Encryption at rest and in transit
- **Audit Trails**: Comprehensive logging and compliance
- **Azure Security**: Enterprise-grade cloud security

## 🏗️ Project Structure

```
cloudaudit-pro/
├── 📱 frontend/          # React TypeScript SPA
├── 🔧 backend/           # NestJS TypeScript API
├── 📱 pwa/              # Progressive Web App config
├── 🏗️ infrastructure/    # Azure ARM templates & scripts
├── 📚 docs/             # Comprehensive documentation
├── 🔨 scripts/          # Setup and deployment scripts
├── 🧪 tests/            # E2E and integration tests
└── 🛠️ tools/            # Development and migration tools
```

## 🚀 Quick Start

### Prerequisites
- **Node.js 18+**
- **npm or yarn**
- **Docker** (for local database)
- **Azure CLI** (for deployment)

### 1. Clone and Setup
```bash
git clone <repository-url>
cd CloudAudit_Pro

# Run setup script (macOS/Linux)
./scripts/setup.sh

# Or setup manually:
npm install
cp .env.example .env
```

### 2. Configure Environment
Edit `.env` with your configuration:
```bash
# Database
DATABASE_URL=postgresql://username:password@localhost:5432/cloudaudit_dev

# JWT Secrets
JWT_SECRET=your_jwt_secret_key_here

# Azure Storage
AZURE_STORAGE_ACCOUNT_NAME=your_storage_account
AZURE_STORAGE_ACCOUNT_KEY=your_storage_key
```

### 3. Setup Database
```bash
# Start PostgreSQL with Docker
docker-compose up -d postgres

# Setup database schema
cd backend
npx prisma generate
npx prisma db push
npx prisma db seed
cd ..
```

### 4. Start Development Servers
```bash
# Start both frontend and backend
npm run dev

# Or start individually:
npm run dev:backend  # http://localhost:3000
npm run dev:frontend # http://localhost:3001
```

### 5. Access Application
- **Frontend**: http://localhost:3001
- **Backend API**: http://localhost:3000/api/v1
- **API Documentation**: http://localhost:3000/api/docs
- **Database Studio**: `cd backend && npx prisma studio`

## 🧪 Development

### Available Scripts
```bash
# Development
npm run dev              # Start both frontend and backend
npm run dev:backend      # Start backend only
npm run dev:frontend     # Start frontend only

# Building
npm run build            # Build both applications
npm run build:backend    # Build backend only
npm run build:frontend   # Build frontend only

# Testing
npm run test             # Run all tests
npm run test:backend     # Backend unit tests
npm run test:frontend    # Frontend unit tests
npm run test:e2e         # End-to-end tests

# Database
npm run migrate:dev      # Run database migrations
npm run db:seed          # Seed database
npm run db:reset         # Reset database

# Docker
npm run docker:up        # Start all services
npm run docker:down      # Stop all services

# Deployment
npm run deploy:dev       # Deploy to development
npm run deploy:staging   # Deploy to staging
npm run deploy:prod      # Deploy to production
```

### Technology Details

#### Backend (NestJS)
- **Framework**: NestJS with TypeScript
- **Database**: Prisma ORM with PostgreSQL
- **Authentication**: JWT with Passport.js
- **Documentation**: Swagger/OpenAPI
- **Testing**: Jest with Supertest
- **Validation**: Class-validator and class-transformer

#### Frontend (React)
- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite for fast development
- **UI Library**: Material-UI (MUI) components
- **State Management**: Redux Toolkit with RTK Query
- **Routing**: React Router v6
- **Forms**: React Hook Form with Yup validation
- **Testing**: Jest with React Testing Library

#### Progressive Web App
- **Service Worker**: Offline functionality
- **Web App Manifest**: Installable app experience
- **Push Notifications**: Real-time notifications
- **Background Sync**: Offline data synchronization

## 🏗️ Architecture

### Multi-Tenant Strategy
CloudAudit Pro uses a **Database-per-Tenant** architecture:

- **Central Tenant Registry**: Manages tenant metadata and routing
- **Isolated Databases**: Each tenant has a dedicated database
- **Shared Infrastructure**: Optimized resource utilization
- **Automated Provisioning**: New tenant setup in minutes

### Security Model
- **Authentication**: JWT tokens with refresh mechanism
- **Authorization**: Role-based access control (RBAC)
- **Data Isolation**: Complete tenant data separation
- **Encryption**: Data encrypted at rest and in transit
- **Audit Logging**: Comprehensive activity tracking

### Deployment Architecture
```
Azure Cloud
├── 🌐 Azure CDN + Front Door
├── 🔐 Azure App Service (Backend API)
├── 📱 Azure Static Web Apps (Frontend)
├── 🗄️ Azure Database for PostgreSQL
├── 📁 Azure Blob Storage (Documents)
└── 📊 Azure Application Insights (Monitoring)
```

## 📚 Documentation

Comprehensive documentation is available in the `/docs` directory:

- [**Business Analysis**](docs/01_Business_Analysis.md) - Complete business requirements
- [**Implementation Plan**](docs/02_Implementation_Plan.md) - Detailed development roadmap  
- [**Technical Architecture**](docs/03_Technical_Architecture.md) - System design specifications
- [**Data Migration Strategy**](docs/04_Data_Migration_Strategy.md) - Legacy data migration
- [**Security & Compliance**](docs/05_Security_Compliance_Framework.md) - Security framework
- [**Performance Guide**](docs/06_Performance_Scalability_Guide.md) - Performance optimization
- [**Project Analysis**](docs/07_Project_Analysis_and_Implementation_Plan.md) - Complete project analysis
- [**Project Structure**](docs/08_Project_Structure_Template.md) - Detailed project structure
- [**Executive Summary**](docs/09_Executive_Summary_Next_Steps.md) - Executive overview

## 🚀 Deployment

### Development Environment
```bash
# Deploy to Azure development environment
npm run deploy:dev
```

### Production Environment
```bash
# Deploy to Azure production environment
npm run deploy:prod
```

See [Deployment Guide](docs/deployment/) for detailed instructions.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is proprietary software. All rights reserved.

## 🆘 Support

For support and questions:
- 📧 Email: support@cloudauditpro.com
- 📚 Documentation: [docs/](docs/)
- 🐛 Issues: [GitHub Issues](issues/)

---

**CloudAudit Pro** - Transforming Audit Management for the Digital Age 🚀