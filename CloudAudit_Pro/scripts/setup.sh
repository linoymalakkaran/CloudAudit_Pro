#!/bin/bash

# CloudAudit Pro Setup Script
# This script initializes the development environment

set -e

echo "🚀 Setting up CloudAudit Pro development environment..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18 or higher is required. Current version: $(node --version)"
    exit 1
fi

echo "✅ Node.js $(node --version) detected"

# Check if Docker is installed and running
if command -v docker &> /dev/null; then
    if docker ps &> /dev/null; then
        echo "✅ Docker is available and running"
        DOCKER_AVAILABLE=true
    else
        echo "⚠️  Docker is installed but not running. Please start Docker for database setup."
        DOCKER_AVAILABLE=false
    fi
else
    echo "⚠️  Docker not found. You'll need to set up PostgreSQL manually."
    DOCKER_AVAILABLE=false
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ .env file created. Please update it with your configuration."
else
    echo "✅ .env file already exists"
fi

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install
cd ..

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Setup database with Docker if available
if [ "$DOCKER_AVAILABLE" = true ]; then
    echo "🐳 Setting up PostgreSQL with Docker..."
    docker-compose up -d postgres
    
    # Wait for PostgreSQL to be ready
    echo "⏳ Waiting for PostgreSQL to be ready..."
    sleep 5
    
    # Generate Prisma client and run migrations
    echo "🗄️  Setting up database schema..."
    cd backend
    npx prisma generate
    npx prisma db push
    
    # Run database seeds
    echo "🌱 Seeding database with initial data..."
    npx prisma db seed
    cd ..
    
    echo "✅ Database setup complete"
else
    echo "⚠️  Please set up PostgreSQL manually and update the DATABASE_URL in .env"
    echo "   Then run: cd backend && npx prisma generate && npx prisma db push && npx prisma db seed"
fi

# Setup Git hooks
if [ -d ".git" ]; then
    echo "🔧 Setting up Git hooks..."
    npx husky install
    npx husky add .husky/pre-commit "npx lint-staged"
    echo "✅ Git hooks configured"
fi

echo ""
echo "🎉 Setup complete! Next steps:"
echo ""
echo "1. Update the .env file with your configuration"
echo "2. Start the development servers:"
echo "   npm run dev"
echo ""
echo "3. Open your browser:"
echo "   Frontend: http://localhost:3001"
echo "   Backend API: http://localhost:3000"
echo "   API Docs: http://localhost:3000/api/docs"
echo ""
echo "4. For production deployment, see docs/deployment/"
echo ""

# Check if VS Code is available
if command -v code &> /dev/null; then
    echo "💡 Tip: Run 'code .' to open the project in VS Code"
fi

echo "Happy coding! 🚀"