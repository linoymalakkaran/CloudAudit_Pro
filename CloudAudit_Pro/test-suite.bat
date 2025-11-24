@echo off
echo 🚀 CloudAudit Pro - Comprehensive Test Suite
echo =============================================

:: Configuration
set FRONTEND_URL=http://localhost:5174
set BACKEND_URL=http://localhost:3000
set TEST_EMAIL=test@example.com
set ADMIN_EMAIL=admin@company.com
set SUPER_ADMIN_EMAIL=super.admin@cloudaudit.pro

echo.
echo 🌐 Testing Frontend Accessibility...
curl -s -o nul -w "%%{http_code}" %FRONTEND_URL% > temp_response.txt
set /p response=<temp_response.txt
if "%response%"=="200" (
    echo ✓ Frontend is accessible
) else (
    echo ✗ Frontend accessibility failed (HTTP %response%)
)
del temp_response.txt

echo.
echo 🏥 Testing Backend Health...
curl -s -o nul -w "%%{http_code}" %BACKEND_URL%/health > temp_response.txt
set /p response=<temp_response.txt
if "%response%"=="200" (
    echo ✓ Backend is healthy
) else (
    echo ⚠ Backend health check (HTTP %response%) - may need to start backend
)
del temp_response.txt

echo.
echo 🔐 Testing Authentication APIs...
curl -s -X POST "%BACKEND_URL%/api/auth/register" -H "Content-Type: application/json" -d "{\"companyName\":\"Test Company\",\"adminEmail\":\"%TEST_EMAIL%\",\"adminFirstName\":\"Test\",\"adminLastName\":\"User\",\"industry\":\"Technology\",\"companySize\":\"1-10\",\"country\":\"USA\"}" -o nul -w "%%{http_code}" > temp_response.txt
set /p response=<temp_response.txt
if "%response%"=="201" (
    echo ✓ Registration API is working
) else if "%response%"=="400" (
    echo ✓ Registration API is responsive (validation working)
) else (
    echo ⚠ Registration API returned HTTP %response%
)
del temp_response.txt

echo.
echo 👥 Testing User Management APIs...
curl -s -o nul -w "%%{http_code}" "%BACKEND_URL%/api/users/stats" > temp_response.txt
set /p response=<temp_response.txt
if "%response%"=="401" (
    echo ✓ User stats API requires authentication (secure)
) else if "%response%"=="200" (
    echo ✓ User stats API is working
) else (
    echo ⚠ User stats API returned HTTP %response%
)
del temp_response.txt

echo.
echo 🛣️ Testing Frontend Routes...
for %%r in (/login /register /dashboard /admin/dashboard /admin/users /documents /reports) do (
    curl -s -o nul -w "%%{http_code}" %FRONTEND_URL%%%r > temp_response.txt
    set /p response=<temp_response.txt
    if "!response!"=="200" (
        echo ✓ Route %%r accessible
    ) else (
        echo ⚠ Route %%r returned HTTP !response!
    )
    del temp_response.txt
)

echo.
echo 🧩 Testing Component Files...
if exist "frontend\src\components\admin\AdminDashboard.tsx" (
    echo ✓ AdminDashboard.tsx exists
) else (
    echo ✗ AdminDashboard.tsx missing
)

if exist "frontend\src\components\admin\UserManagement.tsx" (
    echo ✓ UserManagement.tsx exists
) else (
    echo ✗ UserManagement.tsx missing
)

if exist "frontend\src\components\admin\InviteUser.tsx" (
    echo ✓ InviteUser.tsx exists
) else (
    echo ✗ InviteUser.tsx missing
)

if exist "frontend\src\services\api.ts" (
    echo ✓ API service exists
) else (
    echo ✗ API service missing
)

if exist "backend\src\auth\auth.controller.ts" (
    echo ✓ Auth controller exists
) else (
    echo ✗ Auth controller missing
)

if exist "backend\src\users\users.controller.ts" (
    echo ✓ Users controller exists
) else (
    echo ✗ Users controller missing
)

if exist "backend\prisma\schema.prisma" (
    echo ✓ Prisma schema exists
) else (
    echo ✗ Prisma schema missing
)

echo.
echo 📧 Testing Email Configuration...
if exist "backend\.env" (
    findstr /C:"MAIL_HOST" backend\.env >nul
    if !errorlevel!==0 (
        echo ✓ Email configuration found
    ) else (
        echo ⚠ Email configuration missing in .env file
    )
) else (
    echo ⚠ Backend .env file not found
)

echo.
echo 🔨 Testing Build Status...
if exist "frontend\dist" (
    echo ✓ Frontend build directory exists
) else (
    echo ⚠ Frontend not built yet (run npm run build)
)

if exist "backend\dist" (
    echo ✓ Backend build directory exists
) else (
    echo ⚠ Backend not built yet (run npm run build)
)

echo.
echo ⚡ Performance Test...
powershell -Command "$start = Get-Date; Invoke-WebRequest -Uri '%FRONTEND_URL%' -UseBasicParsing | Out-Null; $end = Get-Date; $duration = ($end - $start).TotalMilliseconds; if ($duration -lt 1000) { Write-Host '✓ Frontend response time:' $duration 'ms (excellent)' } elseif ($duration -lt 2000) { Write-Host '✓ Frontend response time:' $duration 'ms (good)' } else { Write-Host '⚠ Frontend response time:' $duration 'ms (needs optimization)' }"

echo.
echo =============================================
echo 🏁 Test Suite Complete!
echo.
echo 📊 Summary:
echo - Frontend URL: %FRONTEND_URL%
echo - Backend URL: %BACKEND_URL%
echo - Test completed at: %date% %time%
echo.
echo 🔍 Review the output above for any issues.
echo 🚀 Access the application at: %FRONTEND_URL%
echo.
echo 📋 Next Steps:
echo 1. If backend tests failed, start backend: cd backend ^&^& npm run start:dev
echo 2. If frontend tests failed, start frontend: cd frontend ^&^& npm run dev
echo 3. Configure email settings in backend/.env for notifications
echo 4. Set up database with: cd backend ^&^& npx prisma migrate dev
echo.
pause