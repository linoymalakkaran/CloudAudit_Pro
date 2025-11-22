# Multi-stage Dockerfile for CloudAudit Pro Backend
FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Create app user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Development stage
FROM base AS development
ENV NODE_ENV=development

# Install all dependencies (including devDependencies)
RUN npm ci

# Copy source code
COPY . .
COPY .env.example .env

# Generate Prisma client
RUN npx prisma generate

# Change ownership to app user
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3001

# Start development server
CMD ["npm", "run", "start:dev"]

# Build stage
FROM base AS builder
ENV NODE_ENV=production

# Install all dependencies
RUN npm ci

# Copy source code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build the application
RUN npm run build

# Production stage
FROM node:18-alpine AS production
ENV NODE_ENV=production

WORKDIR /app

# Create app user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy built application from builder stage
COPY --from=builder --chown=nextjs:nodejs /app/dist ./dist
COPY --from=builder --chown=nextjs:nodejs /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma

# Create uploads directory
RUN mkdir -p uploads && chown nextjs:nodejs uploads

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3001/health || exit 1

# Start production server
CMD ["npm", "run", "start:prod"]