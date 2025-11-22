-- Initialize CloudAudit Pro Database
-- This script runs when PostgreSQL container starts for the first time

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create database if it doesn't exist
-- (The main database is already created by POSTGRES_DB environment variable)

-- Create additional schemas if needed
-- CREATE SCHEMA IF NOT EXISTS audit;
-- CREATE SCHEMA IF NOT EXISTS reports;

-- Set default privileges
GRANT ALL PRIVILEGES ON DATABASE cloudaudit_pro TO cloudaudit;

-- Create additional users if needed for different environments
-- CREATE USER cloudaudit_readonly WITH PASSWORD 'readonly_password';
-- GRANT CONNECT ON DATABASE cloudaudit_pro TO cloudaudit_readonly;
-- GRANT USAGE ON SCHEMA public TO cloudaudit_readonly;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO cloudaudit_readonly;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO cloudaudit_readonly;

\echo 'CloudAudit Pro database initialization completed!';