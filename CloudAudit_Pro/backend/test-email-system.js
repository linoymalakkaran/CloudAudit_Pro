/**
 * Email System Test Suite
 * Tests the email notification system for CloudAudit Pro
 */

const { PrismaClient } = require('@prisma/client');

async function testEmailSystemIntegration() {
  console.log('🧪 Starting Email System Integration Tests...\n');

  const tests = [
    {
      name: 'Email Service Dependencies',
      test: () => {
        try {
          const nodemailer = require('nodemailer');
          const handlebars = require('handlebars');
          console.log('✅ All email dependencies are installed');
          return true;
        } catch (error) {
          console.log('❌ Missing email dependencies:', error.message);
          return false;
        }
      }
    },
    {
      name: 'Email Template Files',
      test: () => {
        const fs = require('fs');
        const path = require('path');
        
        const templates = [
          'src/email/templates/tenant-approval.hbs',
          'src/email/templates/user-approval.hbs',
          'src/email/templates/welcome.hbs'
        ];

        let allExist = true;
        templates.forEach(template => {
          if (fs.existsSync(path.join(__dirname, template))) {
            console.log(`✅ Template found: ${template}`);
          } else {
            console.log(`❌ Template missing: ${template}`);
            allExist = false;
          }
        });
        
        return allExist;
      }
    },
    {
      name: 'Email Service Module',
      test: () => {
        const fs = require('fs');
        const path = require('path');
        
        const modules = [
          'src/email/email.module.ts',
          'src/email/email.service.ts',
          'src/email/email-template.service.ts',
          'src/email/interfaces/email.interface.ts'
        ];

        let allExist = true;
        modules.forEach(module => {
          if (fs.existsSync(path.join(__dirname, module))) {
            console.log(`✅ Module found: ${module}`);
          } else {
            console.log(`❌ Module missing: ${module}`);
            allExist = false;
          }
        });
        
        return allExist;
      }
    },
    {
      name: 'Environment Configuration',
      test: () => {
        const fs = require('fs');
        const envFile = fs.readFileSync('.env.example', 'utf8');
        
        const requiredVars = [
          'SMTP_HOST',
          'SMTP_PORT', 
          'SMTP_USER',
          'SMTP_PASSWORD',
          'SMTP_FROM',
          'SUPPORT_EMAIL'
        ];

        let allConfigured = true;
        requiredVars.forEach(variable => {
          if (envFile.includes(variable)) {
            console.log(`✅ Environment variable configured: ${variable}`);
          } else {
            console.log(`❌ Missing environment variable: ${variable}`);
            allConfigured = false;
          }
        });
        
        return allConfigured;
      }
    },
    {
      name: 'Database Schema Compatibility',
      test: async () => {
        try {
          const prisma = new PrismaClient();
          
          // Test if required models exist by checking their schema
          const tenantCount = await prisma.tenant.count();
          const userCount = await prisma.tenantUser.count();
          const approvalCount = await prisma.tenantApprovalRequest.count();
          
          console.log('✅ Database schema is compatible with email system');
          console.log(`   - Tenants: ${tenantCount}`);
          console.log(`   - Users: ${userCount}`); 
          console.log(`   - Approval Requests: ${approvalCount}`);
          
          await prisma.$disconnect();
          return true;
        } catch (error) {
          console.log('❌ Database schema compatibility issue:', error.message);
          return false;
        }
      }
    },
    {
      name: 'Module Integration',
      test: () => {
        const fs = require('fs');
        
        // Check if EmailModule is imported in app.module.ts
        const appModule = fs.readFileSync('src/app.module.ts', 'utf8');
        const superAdminModule = fs.readFileSync('src/super-admin/super-admin.module.ts', 'utf8');
        
        const appModuleCheck = appModule.includes("import { EmailModule } from './email/email.module'");
        const superAdminCheck = superAdminModule.includes("import { EmailModule } from '../email/email.module'");
        
        if (appModuleCheck && superAdminCheck) {
          console.log('✅ EmailModule is properly integrated');
          return true;
        } else {
          console.log('❌ EmailModule integration issues found');
          if (!appModuleCheck) console.log('   - Missing from app.module.ts');
          if (!superAdminCheck) console.log('   - Missing from super-admin.module.ts');
          return false;
        }
      }
    }
  ];

  let passedTests = 0;
  const totalTests = tests.length;

  for (const { name, test } of tests) {
    console.log(`\n📋 Testing: ${name}`);
    console.log('─'.repeat(50));
    
    try {
      const result = await test();
      if (result) {
        passedTests++;
        console.log(`✅ Test passed: ${name}`);
      } else {
        console.log(`❌ Test failed: ${name}`);
      }
    } catch (error) {
      console.log(`❌ Test error: ${name} - ${error.message}`);
    }
  }

  console.log('\n' + '='.repeat(60));
  console.log(`📊 Test Results: ${passedTests}/${totalTests} tests passed`);
  
  if (passedTests === totalTests) {
    console.log('🎉 All email system tests passed! System is ready for use.');
    console.log('\n📋 Next steps:');
    console.log('1. Configure SMTP settings in .env file');
    console.log('2. Test email sending in development environment');
    console.log('3. Set up email monitoring and logging');
    console.log('4. Create email usage documentation');
  } else {
    console.log('⚠️  Some tests failed. Please review the issues above.');
  }
  
  console.log('='.repeat(60));
}

// Run the test suite
if (require.main === module) {
  testEmailSystemIntegration().catch(console.error);
}

module.exports = { testEmailSystemIntegration };