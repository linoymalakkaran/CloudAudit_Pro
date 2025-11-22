# Multi-stage Dockerfile for CloudAudit Pro Frontend
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

# Install all dependencies
RUN npm ci

# Copy source code
COPY . .

# Change ownership to app user
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Start development server
CMD ["npm", "run", "dev"]

# Build stage
FROM base AS builder
ENV NODE_ENV=production

# Install all dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine AS production

# Copy built application from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user for nginx
RUN adduser -D -s /bin/sh www-data

# Change ownership of nginx directories
RUN chown -R www-data:www-data /usr/share/nginx/html && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /var/log/nginx && \
    chown -R www-data:www-data /etc/nginx/conf.d

# Switch to non-root user
USER www-data

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]