# CloudAudit Pro - Deployment Guide

## Table of Contents

1. [Overview](#overview)
2. [System Requirements](#system-requirements)
3. [Environment Setup](#environment-setup)
4. [Database Configuration](#database-configuration)
5. [Backend Deployment](#backend-deployment)
6. [Frontend Deployment](#frontend-deployment)
7. [Environment Variables](#environment-variables)
8. [Docker Deployment](#docker-deployment)
9. [Production Deployment](#production-deployment)
10. [Monitoring & Maintenance](#monitoring--maintenance)
11. [Troubleshooting](#troubleshooting)

---

## Overview

CloudAudit Pro is a modern multi-tenant SaaS application built with:
- **Backend:** NestJS with TypeScript, Prisma ORM
- **Frontend:** React 18 with TypeScript, Vite, Material-UI
- **Database:** PostgreSQL (production), SQLite (development)
- **Authentication:** JWT with role-based access control
- **Email:** Configurable email service with Handlebars templates

### Architecture Overview

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │     Backend      │    │    Database     │
│   (React/Vite)  │◄──►│   (NestJS/API)   │◄──►│  (PostgreSQL)   │
│   Port: 3000    │    │   Port: 3001     │    │   Port: 5432    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

---

## System Requirements

### Minimum Requirements
- **CPU:** 2 vCPU cores
- **RAM:** 4 GB
- **Storage:** 20 GB SSD
- **OS:** Linux Ubuntu 20.04+, Windows Server 2019+, macOS 10.15+
- **Network:** Stable internet connection with public IP for production

### Recommended Production Requirements
- **CPU:** 4+ vCPU cores
- **RAM:** 8+ GB
- **Storage:** 100+ GB SSD with automated backups
- **OS:** Linux Ubuntu 22.04 LTS (recommended)
- **Network:** Load balancer with SSL termination

### Software Dependencies
- **Node.js:** Version 18.x or higher
- **npm:** Version 8.x or higher
- **PostgreSQL:** Version 14.x or higher
- **Git:** For source code management
- **PM2:** For production process management (recommended)

---

## Environment Setup

### 1. Install Node.js and npm

#### On Ubuntu/Debian:
```bash
# Update package list
sudo apt update

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

#### On Windows:
1. Download Node.js from [nodejs.org](https://nodejs.org/)
2. Run the installer and follow the setup wizard
3. Verify installation in Command Prompt

#### On macOS:
```bash
# Using Homebrew
brew install node@18

# Or download from nodejs.org
```

### 2. Install PostgreSQL

#### On Ubuntu/Debian:
```bash
# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Start and enable PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create database user
sudo -u postgres createuser --interactive --pwprompt cloudaudit_user
sudo -u postgres createdb cloudaudit_pro
```

#### On Windows:
1. Download PostgreSQL from [postgresql.org](https://www.postgresql.org/download/windows/)
2. Run installer and follow setup wizard
3. Note down the superuser password

#### On macOS:
```bash
# Using Homebrew
brew install postgresql@14
brew services start postgresql@14

# Create user and database
createuser --interactive --pwprompt cloudaudit_user
createdb cloudaudit_pro
```

### 3. Clone Repository

```bash
git clone <repository-url>
cd CloudAudit_Pro
```

---

## Database Configuration

### 1. PostgreSQL Setup

#### Create Database and User
```sql
-- Connect to PostgreSQL as superuser
sudo -u postgres psql

-- Create database
CREATE DATABASE cloudaudit_pro;

-- Create user with password
CREATE USER cloudaudit_user WITH PASSWORD 'secure_password_here';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE cloudaudit_pro TO cloudaudit_user;
GRANT CREATE ON SCHEMA public TO cloudaudit_user;

-- Exit psql
\q
```

#### Configure PostgreSQL (Optional for production)
```bash
# Edit PostgreSQL configuration
sudo nano /etc/postgresql/14/main/postgresql.conf

# Key settings for production:
# listen_addresses = '*'
# max_connections = 100
# shared_buffers = 256MB
# effective_cache_size = 1GB

# Edit access control
sudo nano /etc/postgresql/14/main/pg_hba.conf

# Add line for application access:
# host    cloudaudit_pro    cloudaudit_user    localhost    md5

# Restart PostgreSQL
sudo systemctl restart postgresql
```

### 2. Database Initialization

The database schema will be automatically created when the backend starts using Prisma migrations.

---

## Backend Deployment

### 1. Navigate to Backend Directory
```bash
cd backend
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Environment Configuration

Create `.env` file in backend directory:
```bash
# Copy example environment file
cp .env.example .env

# Edit environment variables
nano .env
```

Required environment variables (see [Environment Variables](#environment-variables) section for complete list):
```env
DATABASE_URL="postgresql://cloudaudit_user:secure_password_here@localhost:5432/cloudaudit_pro"
JWT_SECRET="your-super-secret-jwt-key-here"
NODE_ENV="production"
PORT=3001
```

### 4. Database Migration
```bash
# Generate Prisma client
npx prisma generate

# Run database migrations
npx prisma migrate deploy

# (Optional) Seed initial data
npx prisma db seed
```

### 5. Build Backend
```bash
npm run build
```

### 6. Start Backend

#### Development Mode:
```bash
npm run start:dev
```

#### Production Mode:
```bash
# Using npm
npm run start:prod

# Or using PM2 (recommended for production)
npm install -g pm2
pm2 start dist/main.js --name "cloudaudit-backend"
pm2 save
pm2 startup
```

---

## Frontend Deployment

### 1. Navigate to Frontend Directory
```bash
cd ../frontend
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Environment Configuration

Create `.env` file in frontend directory:
```bash
# Copy example environment file
cp .env.example .env

# Edit environment variables
nano .env
```

Required environment variables:
```env
VITE_API_BASE_URL=http://localhost:3001
VITE_APP_NAME="CloudAudit Pro"
VITE_ENABLE_MOCK_MODE=false
```

### 4. Build Frontend
```bash
npm run build
```

### 5. Serve Frontend

#### Development Mode:
```bash
npm run dev
```

#### Production Mode:

##### Option 1: Using npm serve
```bash
npm install -g serve
serve -s dist -p 3000
```

##### Option 2: Using Nginx (Recommended)
```bash
# Install Nginx
sudo apt install nginx

# Copy built files
sudo cp -r dist/* /var/www/html/cloudaudit-pro/

# Create Nginx configuration
sudo nano /etc/nginx/sites-available/cloudaudit-pro
```

Nginx configuration:
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name your-domain.com;

    root /var/www/html/cloudaudit-pro;
    index index.html;

    # Handle React routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy
    location /api {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Security headers
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
}
```

Enable and start Nginx:
```bash
sudo ln -s /etc/nginx/sites-available/cloudaudit-pro /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Environment Variables

### Backend Environment Variables

#### Required Variables
```env
# Database Configuration
DATABASE_URL="postgresql://username:password@localhost:5432/database_name"

# JWT Configuration
JWT_SECRET="your-super-secret-jwt-key-minimum-32-characters"
JWT_EXPIRES_IN="24h"

# Server Configuration
NODE_ENV="production"
PORT=3001
CORS_ORIGIN="http://localhost:3000,https://your-domain.com"

# Email Configuration (Choose one provider)
# Mock Email (Development only)
EMAIL_PROVIDER="mock"

# Gmail SMTP
EMAIL_PROVIDER="gmail"
EMAIL_HOST="smtp.gmail.com"
EMAIL_PORT=587
EMAIL_USER="your-email@gmail.com"
EMAIL_PASS="your-app-password"
EMAIL_FROM="CloudAudit Pro <noreply@your-domain.com>"

# SendGrid
EMAIL_PROVIDER="sendgrid"
SENDGRID_API_KEY="your-sendgrid-api-key"
EMAIL_FROM="CloudAudit Pro <noreply@your-domain.com>"
```

#### Optional Variables
```env
# File Upload Configuration
MAX_FILE_SIZE_MB=50
UPLOAD_DIR="./uploads"

# Session Configuration
SESSION_SECRET="your-session-secret"
COOKIE_SECURE=true
COOKIE_SAME_SITE="strict"

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# Logging
LOG_LEVEL="info"
LOG_FORMAT="json"

# Health Check
HEALTH_CHECK_ENABLED=true

# Super Admin Configuration
SUPER_ADMIN_EMAIL="admin@your-company.com"
```

### Frontend Environment Variables

```env
# API Configuration
VITE_API_BASE_URL="http://localhost:3001"

# Application Configuration
VITE_APP_NAME="CloudAudit Pro"
VITE_APP_VERSION="1.0.0"
VITE_APP_DESCRIPTION="Professional Audit Management Platform"

# Feature Flags
VITE_ENABLE_MOCK_MODE=false
VITE_ENABLE_DEBUG_MODE=false
VITE_ENABLE_ANALYTICS=true

# UI Configuration
VITE_DEFAULT_THEME="light"
VITE_ENABLE_DARK_MODE=true
VITE_DEFAULT_LANGUAGE="en"

# External Services
VITE_GOOGLE_ANALYTICS_ID="GA_TRACKING_ID"
VITE_SENTRY_DSN="your-sentry-dsn"
```

---

## Docker Deployment

### 1. Using Docker Compose (Recommended)

The project includes a `docker-compose.yml` file for easy deployment:

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### 2. Manual Docker Deployment

#### Backend Dockerfile
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build application
RUN npm run build

# Expose port
EXPOSE 3001

# Start application
CMD ["npm", "run", "start:prod"]
```

#### Frontend Dockerfile
```dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy application code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Build and Run
```bash
# Build backend
cd backend
docker build -t cloudaudit-backend .

# Build frontend
cd ../frontend
docker build -t cloudaudit-frontend .

# Run with Docker Network
docker network create cloudaudit-network

# Run PostgreSQL
docker run -d \
  --name cloudaudit-postgres \
  --network cloudaudit-network \
  -e POSTGRES_DB=cloudaudit_pro \
  -e POSTGRES_USER=cloudaudit_user \
  -e POSTGRES_PASSWORD=secure_password \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:14

# Run backend
docker run -d \
  --name cloudaudit-backend \
  --network cloudaudit-network \
  -p 3001:3001 \
  -e DATABASE_URL="postgresql://cloudaudit_user:secure_password@cloudaudit-postgres:5432/cloudaudit_pro" \
  cloudaudit-backend

# Run frontend
docker run -d \
  --name cloudaudit-frontend \
  --network cloudaudit-network \
  -p 3000:80 \
  cloudaudit-frontend
```

---

## Production Deployment

### 1. SSL/HTTPS Setup

#### Using Certbot (Let's Encrypt)
```bash
# Install certbot
sudo apt install snapd
sudo snap install --classic certbot

# Generate certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo certbot renew --dry-run
```

#### Nginx SSL Configuration
```nginx
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name your-domain.com;

    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;
    
    # SSL Configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512;
    
    # HSTS
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
    
    # Other security headers
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
    
    # Application configuration
    root /var/www/html/cloudaudit-pro;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Redirect HTTP to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}
```

### 2. Database Backup

#### Automated Backup Script
```bash
#!/bin/bash
# /opt/scripts/backup-cloudaudit.sh

BACKUP_DIR="/opt/backups/cloudaudit"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="cloudaudit_pro"
DB_USER="cloudaudit_user"

# Create backup directory
mkdir -p $BACKUP_DIR

# Create database backup
pg_dump -h localhost -U $DB_USER -d $DB_NAME -f $BACKUP_DIR/cloudaudit_$DATE.sql

# Compress backup
gzip $BACKUP_DIR/cloudaudit_$DATE.sql

# Remove backups older than 7 days
find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete

echo "Backup completed: cloudaudit_$DATE.sql.gz"
```

#### Setup Cron Job
```bash
# Make script executable
chmod +x /opt/scripts/backup-cloudaudit.sh

# Add to crontab (daily at 2 AM)
crontab -e

# Add line:
0 2 * * * /opt/scripts/backup-cloudaudit.sh
```

### 3. Process Management with PM2

#### PM2 Ecosystem File
Create `ecosystem.config.js`:
```javascript
module.exports = {
  apps: [{
    name: 'cloudaudit-backend',
    script: 'dist/main.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production',
      PORT: 3001
    },
    error_file: '/var/log/cloudaudit/error.log',
    out_file: '/var/log/cloudaudit/access.log',
    log_file: '/var/log/cloudaudit/combined.log',
    time: true,
    max_memory_restart: '512M',
    restart_delay: 1000,
    max_restarts: 10,
    min_uptime: '10s'
  }]
};
```

#### Deploy with PM2
```bash
# Install PM2 globally
npm install -g pm2

# Start application
pm2 start ecosystem.config.js

# Save PM2 configuration
pm2 save

# Setup startup script
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u your-username --hp /home/your-username
```

---

## Monitoring & Maintenance

### 1. Health Checks

#### Application Health Endpoint
The backend includes health check endpoints:
- `GET /health` - Basic health check
- `GET /health/detailed` - Detailed system status

#### Monitoring Script
```bash
#!/bin/bash
# /opt/scripts/health-check.sh

API_URL="https://your-domain.com/api/health"
EMAIL="admin@your-company.com"

response=$(curl -s -o /dev/null -w "%{http_code}" $API_URL)

if [ $response -ne 200 ]; then
    echo "CloudAudit Pro API is down. HTTP Status: $response" | mail -s "CloudAudit Pro Alert" $EMAIL
    
    # Restart PM2 processes
    pm2 restart cloudaudit-backend
fi
```

### 2. Log Management

#### Log Rotation Setup
```bash
# Create logrotate configuration
sudo nano /etc/logrotate.d/cloudaudit

# Add content:
/var/log/cloudaudit/*.log {
    daily
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    create 644 www-data www-data
    postrotate
        pm2 reloadLogs
    endscript
}
```

#### Centralized Logging (Optional)
Consider implementing centralized logging with:
- **ELK Stack** (Elasticsearch, Logstash, Kibana)
- **Grafana + Loki**
- **Cloud services** (AWS CloudWatch, Azure Monitor)

### 3. Performance Monitoring

#### System Monitoring
```bash
# Install monitoring tools
sudo apt install htop iotop nethogs

# Monitor system resources
htop

# Monitor disk I/O
iotop

# Monitor network usage
nethogs
```

#### Application Performance
- Monitor database query performance
- Track API response times
- Monitor memory usage
- Set up alerts for high CPU/memory usage

### 4. Security Updates

#### Regular Update Schedule
```bash
# System updates (monthly)
sudo apt update && sudo apt upgrade

# Node.js security updates
npm audit
npm audit fix

# Dependency updates
npm update

# Database updates (plan maintenance windows)
sudo apt upgrade postgresql
```

---

## Troubleshooting

### Common Issues

#### 1. Database Connection Issues

**Error:** "Cannot connect to database"
**Solutions:**
1. Check if PostgreSQL is running:
   ```bash
   sudo systemctl status postgresql
   ```
2. Verify database credentials in `.env`
3. Check PostgreSQL logs:
   ```bash
   sudo tail -f /var/log/postgresql/postgresql-14-main.log
   ```
4. Test connection manually:
   ```bash
   psql -h localhost -U cloudaudit_user -d cloudaudit_pro
   ```

#### 2. Backend Startup Issues

**Error:** "Port already in use"
**Solutions:**
1. Check what's using the port:
   ```bash
   sudo lsof -i :3001
   ```
2. Kill the process or use a different port
3. Update frontend API URL if port changes

**Error:** "Module not found"
**Solutions:**
1. Reinstall dependencies:
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```
2. Rebuild the application:
   ```bash
   npm run build
   ```

#### 3. Frontend Build Issues

**Error:** "Build failed"
**Solutions:**
1. Check Node.js version compatibility
2. Clear npm cache:
   ```bash
   npm cache clean --force
   ```
3. Check environment variables
4. Review build logs for specific errors

#### 4. Permission Issues

**Error:** "Permission denied"
**Solutions:**
1. Check file ownership:
   ```bash
   ls -la
   ```
2. Fix ownership:
   ```bash
   sudo chown -R $USER:$USER /path/to/app
   ```
3. Check directory permissions:
   ```bash
   chmod 755 /path/to/app
   ```

### Performance Issues

#### 1. Slow Database Queries
```sql
-- Check slow queries
SELECT query, mean_time, calls, total_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Add database indexes if needed
CREATE INDEX CONCURRENTLY idx_users_tenant_id ON users(tenant_id);
```

#### 2. High Memory Usage
```bash
# Monitor Node.js memory usage
ps aux | grep node

# PM2 memory monitoring
pm2 monit

# Restart if memory leak suspected
pm2 restart cloudaudit-backend
```

#### 3. Network Issues
```bash
# Test API connectivity
curl -I http://localhost:3001/health

# Check network configuration
netstat -tlnp | grep 3001

# Test DNS resolution
nslookup your-domain.com
```

### Getting Help

#### Log Collection
When reporting issues, collect these logs:
```bash
# Application logs
pm2 logs cloudaudit-backend

# System logs
sudo journalctl -u nginx
sudo journalctl -u postgresql

# Database logs
sudo tail -f /var/log/postgresql/postgresql-14-main.log

# System resources
top
df -h
free -h
```

#### Support Channels
- **Documentation:** Check this guide and API documentation
- **GitHub Issues:** Report bugs and feature requests
- **Email Support:** technical-support@cloudauditpro.com
- **Community Forum:** discuss with other users

---

This deployment guide provides comprehensive instructions for setting up CloudAudit Pro in various environments. For additional support or customization requirements, please contact our technical support team.