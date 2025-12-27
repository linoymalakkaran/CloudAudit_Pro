# Quick Start Guide - CloudAudit Pro

**Everything is set up! Follow these steps to run the application.**

---

## Prerequisites Check

✅ Docker installed  
✅ Node.js 18+ installed (v24.7.0)  
✅ npm installed (v10.5.2)  
✅ PostgreSQL running (Docker)  
✅ Redis running (Docker)  
✅ Database schema created  

---

## Start the Application

### Step 1: Ensure Docker Services are Running

```bash
cd "c:\ADPorts\eAuditPro\CloudAudit_Pro"
docker-compose up -d postgres redis
```

Check status:
```bash
docker-compose ps
```

Expected output:
```
NAME                  STATUS
cloudaudit-postgres   Up (healthy)
cloudaudit-redis      Up (healthy)
```

### Step 2: Start the Backend API

**Terminal 1**:
```bash
cd "c:\ADPorts\eAuditPro\CloudAudit_Pro\backend"
npm run start:dev
```

Wait for message:
```
[Nest] 12345 - 12/27/2025, 3:00:00 PM     LOG [NestFactory] Starting Nest application...
[Nest] 12345 - 12/27/2025, 3:00:01 PM     LOG [InstanceLoader] PrismaModule dependencies initialized
[Nest] 12345 - 12/27/2025, 3:00:02 PM     LOG [RoutesResolver] AppController {/}:
[Nest] 12345 - 12/27/2025, 3:00:03 PM     LOG [NestApplication] Nest application successfully started
```

Then visit:
- **API Root**: http://localhost:3001/api
- **Health Check**: http://localhost:3001/health
- **Swagger Docs**: http://localhost:3001/api/docs

### Step 3: Start the Frontend

**Terminal 2** (new terminal):
```bash
cd "c:\ADPorts\eAuditPro\CloudAudit_Pro\frontend"
npm run dev
```

Wait for message:
```
VITE v4.x.x  ready in 123 ms

➜  Local:   http://localhost:5173/
```

Then visit:
- **Frontend App**: http://localhost:5173/
- Or: http://localhost:3000 (if configured differently)

---

## Verify Everything is Working

### Test Backend API

```bash
# In a new terminal
curl http://localhost:3001/health

# Expected response:
# {"status":"ok"}
```

### Test Database

```bash
# Check PostgreSQL
docker exec cloudaudit-postgres psql -U cloudaudit -d cloudaudit_pro -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';"

# Expected: Shows number of tables (should be > 20)
```

### Test Redis

```bash
# Check Redis
docker exec cloudaudit-redis redis-cli PING

# Expected response:
# PONG
```

---

## Access the Application

Once both servers are running:

| Component | URL |
|-----------|-----|
| **Frontend App** | http://localhost:5173 |
| **API Base** | http://localhost:3001/api |
| **Swagger API Docs** | http://localhost:3001/api/docs |
| **Health Check** | http://localhost:3001/health |
| **Database (Adminer)** | http://localhost:8080 (optional) |

---

## Database Management (Optional)

### Start Database Admin Tool

```bash
# In Docker
docker-compose --profile development up -d adminer
```

Then visit: http://localhost:8080

**Login**:
- System: PostgreSQL
- Server: cloudaudit-postgres
- Username: cloudaudit
- Password: cloudaudit_dev_password
- Database: cloudaudit_pro

### Start Redis GUI

```bash
# In Docker
docker-compose --profile development up -d redis-commander
```

Then visit: http://localhost:8081

---

## Common Commands

### Backend
```bash
cd backend

# Development with watch mode
npm run start:dev

# Production build
npm run build

# Production run
npm run start:prod

# Run tests
npm test

# Database commands
npx prisma studio      # Open Prisma Studio
npx prisma migrate dev # Create new migration
npx prisma db push    # Push schema changes
```

### Frontend
```bash
cd frontend

# Development
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Run tests
npm test

# Lint and format
npm run lint
npm run format
```

### Docker
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f postgres

# Restart services
docker-compose restart

# Remove everything (WARNING: deletes data!)
docker-compose down -v
```

---

## Features Available

Once logged in, you can:

### ✅ Audit Management
- Create and manage audit procedures
- Track procedure status
- Assign work to team members
- Monitor progress with dashboards

### ✅ Workpapers & Findings
- Document audit work
- Track findings and issues
- Link supporting documents
- Version control for workpapers

### ✅ Financial Records
- Create and manage journal entries
- Generate financial statements
- Track accounting periods
- Export in multiple formats

### ✅ Document Management
- Upload audit documents
- Organize by company/period
- Link to procedures/findings
- Full-text search

### ✅ Reporting
- Generate custom reports
- Use pre-built templates
- View analytics and metrics
- Export to Excel/PDF/CSV

### ✅ Multi-Tenant
- Support multiple companies
- User role-based access
- Separate data per tenant
- Audit trail logging

---

## Troubleshooting

### Backend Won't Start

**Error**: `connect ECONNREFUSED 127.0.0.1:5432`

**Solution**: Start Docker services first
```bash
docker-compose up -d postgres redis
```

**Error**: `Port 3001 already in use`

**Solution**: Kill process using port
```bash
# Windows
netstat -ano | findstr :3001
taskkill /PID <PID> /F

# Mac/Linux
lsof -i :3001
kill -9 <PID>
```

### Frontend Won't Build

**Error**: `npm ERR! network read ETIMEDOUT`

**Solution**: Clear npm cache and reinstall
```bash
npm cache clean --force
rm -rf node_modules
npm install
```

### Database Connection Error

**Error**: `FATAL: remaining connection slots are reserved`

**Solution**: Restart Docker containers
```bash
docker-compose restart postgres
```

### Port 3000/5173 Already in Use

**Solution**: Change port in `.env`
```
# Frontend .env
VITE_DEV_PORT=3002
```

Then start:
```bash
npm run dev -- --port 3002
```

---

## Performance Tips

1. **Use Redis**: Cache is enabled for faster queries
2. **Browser DevTools**: Monitor network requests
3. **Database Indexing**: Check table indexes for large queries
4. **WebSocket**: Real-time updates are enabled
5. **API Rate Limiting**: API is rate-limited (100 requests/15 min)

---

## Security Notes

⚠️ **Development Only**

The following are for development purposes only:
- JWT secrets should be changed in production
- Database password should be changed in production
- CORS is open for localhost
- Email uses mock SMTP
- SSL/TLS not configured

For production, update:
- JWT_ACCESS_SECRET
- JWT_REFRESH_SECRET  
- SMTP_HOST/SMTP_USER/SMTP_PASSWORD
- Database credentials
- Azure Storage connection strings
- SSL certificates for HTTPS

---

## Next Steps

1. ✅ Start the backend (`npm run start:dev`)
2. ✅ Start the frontend (`npm run dev`)
3. ✅ Open frontend in browser (http://localhost:5173)
4. ✅ Access API docs (http://localhost:3001/api/docs)
5. ✅ Create your first user
6. ✅ Create a company
7. ✅ Create an audit period
8. ✅ Start creating audit procedures!

---

## Support Resources

- **Swagger API Docs**: http://localhost:3001/api/docs
- **Backend Source**: `backend/src/`
- **Frontend Source**: `frontend/src/`
- **Database Schema**: `backend/prisma/schema.prisma`
- **Configuration**: `.env` files in backend and frontend

---

**Ready to go! 🚀**

Start your services and begin using CloudAudit Pro!

