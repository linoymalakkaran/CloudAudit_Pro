# Multi-stage Dockerfile for CloudAudit Pro Frontend (Monorepo)
# Optimized for npm workspaces monorepo structure

# Build stage
FROM node:18-slim AS builder
LABEL maintainer="CloudAudit Pro Team"
LABEL description="CloudAudit Pro Frontend Builder - React + Vite"

WORKDIR /app

# Copy root-level package files (for monorepo workspace)
COPY package*.json ./
COPY .npmrc* ./

# Copy frontend package files
COPY frontend/package*.json ./frontend/

# Install dependencies using npm ci (clean install)
# Uses lock file for exact versions
RUN npm ci --workspaces --include-workspace-root --legacy-peer-deps 2>&1 | grep -v "^npm warn"

# Copy frontend source code
COPY frontend ./frontend

# Set frontend as working directory
WORKDIR /app/frontend

# Build the application
RUN npm run build

# Production stage - lightweight nginx
FROM nginx:alpine
LABEL maintainer="CloudAudit Pro Team"
LABEL description="CloudAudit Pro Frontend - Production Server"

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built application from builder stage
COPY --from=builder /app/frontend/dist /usr/share/nginx/html

# Copy nginx configuration for SPA routing
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user for nginx
RUN addgroup -g 1001 nginx-user && \
    adduser -D -s /bin/sh -G nginx-user nginx-user

# Change ownership of nginx directories
RUN chown -R nginx-user:nginx-user /usr/share/nginx/html && \
    chown -R nginx-user:nginx-user /var/cache/nginx && \
    chown -R nginx-user:nginx-user /var/log/nginx && \
    chown -R nginx-user:nginx-user /etc/nginx/conf.d

# Create pid directory with correct permissions
RUN mkdir -p /tmp/nginx && \
    chown -R nginx-user:nginx-user /tmp/nginx

# Create a custom nginx.conf that writes PID to /tmp
RUN echo 'user nginx-user;' > /etc/nginx/nginx.conf && \
    echo 'worker_processes auto;' >> /etc/nginx/nginx.conf && \
    echo 'error_log /var/log/nginx/error.log warn;' >> /etc/nginx/nginx.conf && \
    echo 'pid /tmp/nginx.pid;' >> /etc/nginx/nginx.conf && \
    echo 'events { worker_connections 1024; }' >> /etc/nginx/nginx.conf && \
    echo 'http {' >> /etc/nginx/nginx.conf && \
    echo '  include /etc/nginx/mime.types;' >> /etc/nginx/nginx.conf && \
    echo '  default_type application/octet-stream;' >> /etc/nginx/nginx.conf && \
    echo '  access_log /var/log/nginx/access.log;' >> /etc/nginx/nginx.conf && \
    echo '  sendfile on;' >> /etc/nginx/nginx.conf && \
    echo '  keepalive_timeout 65;' >> /etc/nginx/nginx.conf && \
    echo '  include /etc/nginx/conf.d/*.conf;' >> /etc/nginx/nginx.conf && \
    echo '}' >> /etc/nginx/nginx.conf

# Switch to non-root user
USER nginx-user

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]