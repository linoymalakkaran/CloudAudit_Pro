#!/bin/bash

# CloudAudit Pro Deployment Script
# Usage: ./deploy.sh [dev|staging|prod]

set -e

ENVIRONMENT=${1:-dev}
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
APP_NAME="cloudaudit-pro"

echo "🚀 Deploying CloudAudit Pro to $ENVIRONMENT environment..."

# Validate environment parameter
if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|prod)$ ]]; then
    echo "❌ Invalid environment. Use: dev, staging, or prod"
    exit 1
fi

# Load environment-specific configuration
case $ENVIRONMENT in
    "dev")
        RESOURCE_GROUP="CloudAuditPro-Dev-RG"
        WEBAPP_NAME="cloudauditpro-api-dev"
        FRONTEND_APP="cloudauditpro-frontend-dev"
        ;;
    "staging")
        RESOURCE_GROUP="CloudAuditPro-Staging-RG"
        WEBAPP_NAME="cloudauditpro-api-staging"
        FRONTEND_APP="cloudauditpro-frontend-staging"
        ;;
    "prod")
        RESOURCE_GROUP="CloudAuditPro-RG"
        WEBAPP_NAME="cloudauditpro-api"
        FRONTEND_APP="cloudauditpro-frontend"
        ;;
esac

echo "📋 Deployment Configuration:"
echo "   Environment: $ENVIRONMENT"
echo "   Resource Group: $RESOURCE_GROUP"
echo "   Backend App: $WEBAPP_NAME"
echo "   Frontend App: $FRONTEND_APP"
echo "   Timestamp: $TIMESTAMP"
echo ""

# Check Azure CLI login
echo "🔐 Checking Azure CLI login..."
if ! az account show &> /dev/null; then
    echo "❌ Please login to Azure CLI first: az login"
    exit 1
fi

echo "✅ Azure CLI authenticated"

# Build applications
echo "🔨 Building applications..."

# Build backend
echo "📦 Building backend..."
cd backend
npm run build
cd ..

# Build frontend
echo "🎨 Building frontend..."
cd frontend
npm run build
cd ..

echo "✅ Build complete"

# Run tests
echo "🧪 Running tests..."
npm run test

# Deploy backend
echo "🚀 Deploying backend API..."
cd backend

# Create deployment package
zip -r "../backend-$TIMESTAMP.zip" . -x "node_modules/*" "coverage/*" "*.log"

# Deploy to Azure App Service
az webapp deployment source config-zip \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --src "../backend-$TIMESTAMP.zip"

cd ..

# Deploy frontend
echo "🎨 Deploying frontend..."
cd frontend

# Deploy to Azure Static Web Apps or App Service
if [ "$ENVIRONMENT" = "prod" ]; then
    # Production deployment to Azure Static Web Apps
    npx @azure/static-web-apps-cli deploy \
        --app-location "." \
        --output-location "dist" \
        --deployment-token $SWA_DEPLOYMENT_TOKEN
else
    # Development/Staging deployment to App Service
    zip -r "../frontend-$TIMESTAMP.zip" dist/
    
    az webapp deployment source config-zip \
        --resource-group $RESOURCE_GROUP \
        --name $FRONTEND_APP \
        --src "../frontend-$TIMESTAMP.zip"
fi

cd ..

# Update database
echo "🗄️  Updating database..."
cd backend

# Run database migrations
DATABASE_URL="$DATABASE_URL" npx prisma migrate deploy

cd ..

# Health check
echo "🏥 Performing health check..."
sleep 10

BACKEND_URL="https://$WEBAPP_NAME.azurewebsites.net"
FRONTEND_URL="https://$FRONTEND_APP.azurewebsites.net"

# Check backend health
if curl -f "$BACKEND_URL/api/v1/health" > /dev/null 2>&1; then
    echo "✅ Backend health check passed"
else
    echo "❌ Backend health check failed"
    exit 1
fi

# Check frontend
if curl -f "$FRONTEND_URL" > /dev/null 2>&1; then
    echo "✅ Frontend health check passed"
else
    echo "❌ Frontend health check failed"
    exit 1
fi

# Cleanup old deployment packages
echo "🧹 Cleaning up deployment packages..."
rm -f backend-*.zip frontend-*.zip

# Send deployment notification
echo "📧 Sending deployment notification..."
# Add notification logic here (Slack, Teams, email, etc.)

echo ""
echo "🎉 Deployment to $ENVIRONMENT successful!"
echo ""
echo "🌐 Application URLs:"
echo "   Frontend: $FRONTEND_URL"
echo "   Backend API: $BACKEND_URL/api/v1"
echo "   API Docs: $BACKEND_URL/api/docs"
echo ""
echo "📊 Deployment Details:"
echo "   Timestamp: $TIMESTAMP"
echo "   Environment: $ENVIRONMENT"
echo "   Git Commit: $(git rev-parse --short HEAD)"
echo "   Git Branch: $(git branch --show-current)"
echo ""
echo "✅ Deployment complete!"