# CloudAudit Pro - Postman Collections

## Overview

This directory contains comprehensive Postman collections for all CloudAudit Pro API endpoints, organized by module. Each collection includes sample data and environment variables for easy testing.

## Structure

```
postman-collections/
├── 01-authentication.postman_collection.json
├── 02-companies.postman_collection.json
├── 03-periods.postman_collection.json
├── 04-accounts.postman_collection.json
├── 05-audit-procedures.postman_collection.json
├── 06-workpapers.postman_collection.json
├── 07-findings.postman_collection.json
├── 08-journal-entries.postman_collection.json
├── 09-financial-statements.postman_collection.json
├── 10-documents.postman_collection.json
├── 11-reports.postman_collection.json
├── 12-users.postman_collection.json
├── 13-ledger.postman_collection.json
├── 14-trial-balance.postman_collection.json
├── 15-config.postman_collection.json
├── 16-tenants.postman_collection.json
├── 17-currency-exchange.postman_collection.json
├── 18-bank-country.postman_collection.json
├── 19-financial-schedules.postman_collection.json
├── 20-review-qc.postman_collection.json
├── 21-audit-finalization.postman_collection.json
├── 22-advanced-testing.postman_collection.json
├── 23-document-advanced.postman_collection.json
├── 24-dashboard-analytics.postman_collection.json
├── 25-reporting-advanced.postman_collection.json
├── 26-notifications-preferences.postman_collection.json
├── 27-data-management.postman_collection.json
├── 28-integrations.postman_collection.json
├── 29-procedure-templates.postman_collection.json
├── 30-system-config.postman_collection.json
└── CloudAuditPro-Environment.postman_environment.json
```

## Quick Start

### 1. Import Collections

1. Open Postman
2. Click **Import** button
3. Select all `.postman_collection.json` files from this directory
4. Click **Import**

### 2. Import Environment

1. Click **Import** button
2. Select `CloudAuditPro-Environment.postman_environment.json`
3. Click **Import**
4. Select the **CloudAudit Pro** environment from the dropdown

### 3. Configure Environment

Update the following variables in your environment:

- `base_url`: Your API base URL (default: `http://localhost:8000/api`)
- `email`: Your test email
- `password`: Your test password
- `tenant_subdomain`: Your tenant subdomain

### 4. Run Authentication

1. Open **01-authentication** collection
2. Run **Register** or **Login** request
3. The `auth_token` variable will be automatically set
4. All subsequent requests will use this token

## Environment Variables

The environment includes the following variables:

- `base_url`: API base URL
- `auth_token`: JWT authentication token (auto-set)
- `tenant_id`: Current tenant ID (auto-set)
- `user_id`: Current user ID (auto-set)
- `company_id`: Test company ID (auto-set)
- `period_id`: Test period ID (auto-set)
- `account_id`: Test account ID (auto-set)
- `email`: Test user email
- `password`: Test user password
- `tenant_subdomain`: Tenant subdomain

## Collection Features

Each collection includes:

- **Pre-request Scripts**: Automatically set timestamps and generate unique IDs
- **Tests**: Validate response status codes and extract IDs for subsequent requests
- **Sample Data**: Realistic test data for all request bodies
- **Environment Integration**: All IDs are saved to environment variables

## Running Collections

### Individual Requests

1. Select a collection
2. Click on a request
3. Click **Send**

### Entire Collection

1. Right-click on a collection
2. Select **Run collection**
3. Choose requests to run
4. Click **Run CloudAudit Pro**

### Collection Runner with Data

1. Right-click on a collection
2. Select **Run collection**
3. Upload a CSV/JSON data file (optional)
4. Click **Run CloudAudit Pro**

## Testing Order

For best results, run collections in this order:

1. **01-authentication** - Login and get token
2. **02-companies** - Create test company
3. **03-periods** - Create test period
4. **04-accounts** - Setup chart of accounts
5. **14-trial-balance** - Import trial balance
6. **08-journal-entries** - Post adjustments
7. **09-financial-statements** - Generate reports
8. Continue with other modules as needed

## Sample Data

All collections include sample data based on:

- **Company**: Technology/Finance companies
- **Dates**: Fiscal year 2024
- **Amounts**: Realistic financial figures
- **Users**: Standard audit firm roles

## Troubleshooting

### Token Expired

If you get 401 errors:

1. Run **01-authentication > Login** request
2. New token will be automatically set

### Invalid Company/Period IDs

If you get 404 errors:

1. Run **02-companies > Create Company**
2. Run **03-periods > Create Period**
3. IDs will be automatically saved to environment

### Base URL Issues

1. Check your environment variables
2. Ensure `base_url` is set correctly
3. Verify backend is running

## Advanced Usage

### Automated Testing

Use Newman (Postman CLI) to run collections:

```bash
# Install Newman
npm install -g newman

# Run a collection
newman run 01-authentication.postman_collection.json \
  -e CloudAuditPro-Environment.postman_environment.json

# Run all collections
for file in *.postman_collection.json; do
  newman run "$file" -e CloudAuditPro-Environment.postman_environment.json
done
```

### CI/CD Integration

```yaml
# Example GitHub Actions workflow
- name: Run API Tests
  run: |
    npm install -g newman
    newman run postman-collections/*.postman_collection.json \
      -e postman-collections/CloudAuditPro-Environment.postman_environment.json \
      --reporters cli,json
```

## Support

For issues or questions:

1. Check the API Reference: `docs/11_API_Reference.md`
2. Review test scripts: `tests/`
3. Check backend logs: `docker logs cloudaudit-backend`

## Version

- **Collection Version**: 1.0.0
- **API Version**: 1.0.0
- **Last Updated**: December 31, 2025
