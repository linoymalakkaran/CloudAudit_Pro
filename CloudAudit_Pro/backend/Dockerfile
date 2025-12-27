# Multi-stage Dockerfile for CloudAudit Pro Backend (Monorepo)
# Optimized for npm workspaces monorepo structure

FROM node:18-slim
LABEL maintainer="CloudAudit Pro Team"
LABEL description="CloudAudit Pro Backend API - NestJS"

# Set working directory
WORKDIR /app

# Install required runtime tools
# - dumb-init: proper signal handling
# - curl: used by container healthcheck
# - ca-certificates + openssl: required by Prisma to download engines over TLS
RUN apt-get update && \
  apt-get install -y --no-install-recommends dumb-init curl ca-certificates openssl && \
  update-ca-certificates && \
  rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r nodejs && useradd -r -g nodejs nextjs

# Copy root-level package files (for monorepo workspace)
COPY --chown=nextjs:nodejs package*.json ./
COPY --chown=nextjs:nodejs .npmrc* ./

# Copy backend package files
COPY --chown=nextjs:nodejs backend/package*.json ./backend/

# Install dependencies (production + dev)
# Clean install without optional dependencies
RUN npm ci --workspaces --include-workspace-root --legacy-peer-deps 2>&1 | grep -v "^npm warn"

# Copy backend source code
COPY --chown=nextjs:nodejs backend ./backend

# Copy prisma schema for database migrations
COPY --chown=nextjs:nodejs backend/prisma ./backend/prisma

# Set backend as working directory
WORKDIR /app/backend

# Generate Prisma client (requires OpenSSL and CA certs present)
ENV NODE_TLS_REJECT_UNAUTHORIZED=0
RUN npx prisma generate
ENV NODE_TLS_REJECT_UNAUTHORIZED=1

# Build the application
RUN npm run build

# Switch to non-root user
USER nextjs

# Expose API port
EXPOSE 3001 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3001/health || exit 1

# Use dumb-init to handle signals
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Start application
CMD ["npm", "run", "start:prod"]