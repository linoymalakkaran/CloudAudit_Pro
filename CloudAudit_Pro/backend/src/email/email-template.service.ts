import { Injectable, Logger } from '@nestjs/common';
import * as Handlebars from 'handlebars';
import { readFileSync } from 'fs';
import { join } from 'path';
import { 
  EmailTemplate,
  TenantApprovalEmailData,
  UserApprovalEmailData,
  WelcomeEmailData 
} from './interfaces/email.interface';

@Injectable()
export class EmailTemplateService {
  private readonly logger = new Logger(EmailTemplateService.name);
  private readonly templateCache = new Map<string, HandlebarsTemplateDelegate>();

  constructor() {
    this.initializeTemplates();
  }

  private initializeTemplates(): void {
    try {
      // Register Handlebars helpers
      Handlebars.registerHelper('eq', function(a: any, b: any) {
        return a === b;
      });

      Handlebars.registerHelper('formatDate', function(date: Date) {
        return date.toLocaleDateString('en-US', {
          year: 'numeric',
          month: 'long',
          day: 'numeric',
        });
      });

      this.logger.log('Email templates initialized successfully');
    } catch (error) {
      this.logger.error('Failed to initialize email templates', error.stack);
    }
  }

  private getCompiledTemplate(templateName: string): HandlebarsTemplateDelegate {
    if (this.templateCache.has(templateName)) {
      return this.templateCache.get(templateName)!;
    }

    try {
      const templatePath = join(__dirname, 'templates', `${templateName}.hbs`);
      const templateSource = readFileSync(templatePath, 'utf8');
      const compiledTemplate = Handlebars.compile(templateSource);
      
      this.templateCache.set(templateName, compiledTemplate);
      return compiledTemplate;
    } catch (error) {
      this.logger.error(`Failed to load template: ${templateName}`, error.stack);
      // Fallback to inline template
      return this.getFallbackTemplate(templateName);
    }
  }

  private getFallbackTemplate(templateName: string): HandlebarsTemplateDelegate {
    const fallbackTemplates = {
      'tenant-approval': this.getTenantApprovalFallback(),
      'user-approval': this.getUserApprovalFallback(),
      'welcome': this.getWelcomeFallback(),
    };

    const templateSource = fallbackTemplates[templateName] || '<p>Template not found</p>';
    return Handlebars.compile(templateSource);
  }

  async generateTenantApprovalTemplate(data: TenantApprovalEmailData): Promise<EmailTemplate> {
    try {
      const template = this.getCompiledTemplate('tenant-approval');
      const html = template(data);
      
      const subject = data.status === 'APPROVED' 
        ? `🎉 Your CloudAudit Pro tenant "${data.tenantName}" has been approved!`
        : `❌ Your CloudAudit Pro tenant "${data.tenantName}" application update`;

      return {
        subject,
        html,
        text: this.generatePlainText(html),
      };
    } catch (error) {
      this.logger.error('Failed to generate tenant approval template', error.stack);
      throw error;
    }
  }

  async generateUserApprovalTemplate(data: UserApprovalEmailData): Promise<EmailTemplate> {
    try {
      const template = this.getCompiledTemplate('user-approval');
      const html = template(data);
      
      const subject = data.status === 'APPROVED'
        ? `🎉 Welcome to ${data.tenantName} on CloudAudit Pro!`
        : `📧 Update on your CloudAudit Pro access request`;

      return {
        subject,
        html,
        text: this.generatePlainText(html),
      };
    } catch (error) {
      this.logger.error('Failed to generate user approval template', error.stack);
      throw error;
    }
  }

  async generateWelcomeTemplate(data: WelcomeEmailData): Promise<EmailTemplate> {
    try {
      const template = this.getCompiledTemplate('welcome');
      const html = template(data);
      
      const subject = `🚀 Welcome to ${data.tenantName} on CloudAudit Pro`;

      return {
        subject,
        html,
        text: this.generatePlainText(html),
      };
    } catch (error) {
      this.logger.error('Failed to generate welcome template', error.stack);
      throw error;
    }
  }

  private generatePlainText(html: string): string {
    return html
      .replace(/<[^>]*>/g, '') // Remove HTML tags
      .replace(/&nbsp;/g, ' ')
      .replace(/&amp;/g, '&')
      .replace(/&lt;/g, '<')
      .replace(/&gt;/g, '>')
      .replace(/\s+/g, ' ')
      .trim();
  }

  private getTenantApprovalFallback(): string {
    return `
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudAudit Pro - Tenant {{#eq status "APPROVED"}}Approved{{else}}Update{{/eq}}</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px 10px 0 0;">
        <h1 style="margin: 0; font-size: 24px;">CloudAudit Pro</h1>
        <p style="margin: 10px 0 0 0; font-size: 16px;">Enterprise Audit Management Platform</p>
    </div>
    
    <div style="background: white; padding: 30px; border: 1px solid #ddd; border-top: none; border-radius: 0 0 10px 10px;">
        <h2 style="color: #333; margin-top: 0;">
            {{#eq status "APPROVED"}}
                🎉 Congratulations! Your tenant has been approved
            {{else}}
                📧 Update on your tenant application
            {{/eq}}
        </h2>
        
        <p>Dear {{adminName}},</p>
        
        {{#eq status "APPROVED"}}
            <p>We're excited to inform you that your CloudAudit Pro tenant "<strong>{{tenantName}}</strong>" has been approved and is now active!</p>
            
            <div style="background: #f8f9fa; border-left: 4px solid #28a745; padding: 15px; margin: 20px 0;">
                <p style="margin: 0;"><strong>✅ Your tenant is now live and ready to use!</strong></p>
            </div>
            
            <p>You can now:</p>
            <ul>
                <li>Access your tenant dashboard</li>
                <li>Set up your audit workflows</li>
                <li>Invite team members</li>
                <li>Configure compliance frameworks</li>
            </ul>
            
            <div style="text-align: center; margin: 30px 0;">
                <a href="{{loginUrl}}" style="background: #28a745; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;">Access Your Dashboard</a>
            </div>
        {{else}}
            <p>Thank you for your interest in CloudAudit Pro. We have reviewed your tenant application for "<strong>{{tenantName}}</strong>".</p>
            
            <div style="background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0;">
                <p style="margin: 0;"><strong>Status:</strong> {{status}}</p>
                {{#if reviewNotes}}
                <p style="margin: 10px 0 0 0;"><strong>Notes:</strong> {{reviewNotes}}</p>
                {{/if}}
            </div>
            
            <p>If you have any questions or would like to discuss your application further, please don't hesitate to contact our support team.</p>
        {{/eq}}
        
        <hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">
        
        <div style="background: #f8f9fa; padding: 20px; border-radius: 5px;">
            <h3 style="margin-top: 0; color: #495057;">Need Help?</h3>
            <p style="margin-bottom: 0;">Contact our support team at <a href="mailto:{{supportEmail}}" style="color: #007bff;">{{supportEmail}}</a></p>
        </div>
        
        <p style="font-size: 14px; color: #6c757d; margin-top: 30px;">
            Best regards,<br>
            The CloudAudit Pro Team
        </p>
    </div>
    
    <div style="text-align: center; padding: 20px; font-size: 12px; color: #6c757d;">
        <p>© 2024 CloudAudit Pro. All rights reserved.</p>
        <p>This is an automated message, please do not reply to this email.</p>
    </div>
</body>
</html>
    `;
  }

  private getUserApprovalFallback(): string {
    return `
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudAudit Pro - Access {{#eq status "APPROVED"}}Approved{{else}}Update{{/eq}}</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px 10px 0 0;">
        <h1 style="margin: 0; font-size: 24px;">CloudAudit Pro</h1>
        <p style="margin: 10px 0 0 0; font-size: 16px;">{{tenantName}}</p>
    </div>
    
    <div style="background: white; padding: 30px; border: 1px solid #ddd; border-top: none; border-radius: 0 0 10px 10px;">
        <h2 style="color: #333; margin-top: 0;">
            {{#eq status "APPROVED"}}
                🎉 Welcome to the team!
            {{else}}
                📧 Update on your access request
            {{/eq}}
        </h2>
        
        <p>Dear {{userName}},</p>
        
        {{#eq status "APPROVED"}}
            <p>Great news! Your access request to join "<strong>{{tenantName}}</strong>" on CloudAudit Pro has been approved.</p>
            
            <div style="background: #f8f9fa; border-left: 4px solid #28a745; padding: 15px; margin: 20px 0;">
                <p style="margin: 0;"><strong>✅ Access granted with role: {{role}}</strong></p>
            </div>
            
            <p>You can now access your workspace and start collaborating with your team on audit management activities.</p>
            
            <div style="text-align: center; margin: 30px 0;">
                <a href="{{loginUrl}}" style="background: #28a745; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;">Access Your Workspace</a>
            </div>
        {{else}}
            <p>Thank you for your interest in joining "<strong>{{tenantName}}</strong>" on CloudAudit Pro.</p>
            
            <div style="background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0;">
                <p style="margin: 0;"><strong>Status:</strong> {{status}}</p>
                {{#if reviewNotes}}
                <p style="margin: 10px 0 0 0;"><strong>Notes:</strong> {{reviewNotes}}</p>
                {{/if}}
            </div>
            
            <p>If you have any questions about this decision, please contact your organization's administrator or our support team.</p>
        {{/eq}}
        
        <hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">
        
        <div style="background: #f8f9fa; padding: 20px; border-radius: 5px;">
            <h3 style="margin-top: 0; color: #495057;">Need Help?</h3>
            <p style="margin-bottom: 0;">Contact our support team at <a href="mailto:{{supportEmail}}" style="color: #007bff;">{{supportEmail}}</a></p>
        </div>
        
        <p style="font-size: 14px; color: #6c757d; margin-top: 30px;">
            Best regards,<br>
            The CloudAudit Pro Team
        </p>
    </div>
    
    <div style="text-align: center; padding: 20px; font-size: 12px; color: #6c757d;">
        <p>© 2024 CloudAudit Pro. All rights reserved.</p>
        <p>This is an automated message, please do not reply to this email.</p>
    </div>
</body>
</html>
    `;
  }

  private getWelcomeFallback(): string {
    return `
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudAudit Pro - Welcome</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px 10px 0 0;">
        <h1 style="margin: 0; font-size: 24px;">🚀 Welcome to CloudAudit Pro!</h1>
        <p style="margin: 10px 0 0 0; font-size: 16px;">{{tenantName}}</p>
    </div>
    
    <div style="background: white; padding: 30px; border: 1px solid #ddd; border-top: none; border-radius: 0 0 10px 10px;">
        <h2 style="color: #333; margin-top: 0;">Hello {{userName}}!</h2>
        
        <p>Welcome to CloudAudit Pro! We're excited to have you join the <strong>{{tenantName}}</strong> team.</p>
        
        {{#if temporaryPassword}}
        <div style="background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0;">
            <p style="margin: 0;"><strong>🔐 Temporary Password:</strong> {{temporaryPassword}}</p>
            <p style="margin: 10px 0 0 0; font-size: 14px;">Please change your password after your first login.</p>
        </div>
        {{/if}}
        
        <h3 style="color: #495057;">Getting Started</h3>
        <ul>
            <li><strong>Access Your Dashboard:</strong> Log in to explore your workspace</li>
            <li><strong>Complete Your Profile:</strong> Update your personal information</li>
            <li><strong>Explore Features:</strong> Discover audit management tools</li>
            <li><strong>Join Your Team:</strong> Connect with other team members</li>
        </ul>
        
        <div style="text-align: center; margin: 30px 0;">
            <a href="{{loginUrl}}" style="background: #007bff; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;">Get Started</a>
        </div>
        
        <hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">
        
        <div style="background: #f8f9fa; padding: 20px; border-radius: 5px;">
            <h3 style="margin-top: 0; color: #495057;">Need Help?</h3>
            <p>If you have any questions or need assistance, our support team is here to help:</p>
            <p style="margin-bottom: 0;">📧 <a href="mailto:{{supportEmail}}" style="color: #007bff;">{{supportEmail}}</a></p>
        </div>
        
        <p style="font-size: 14px; color: #6c757d; margin-top: 30px;">
            Best regards,<br>
            The CloudAudit Pro Team
        </p>
    </div>
    
    <div style="text-align: center; padding: 20px; font-size: 12px; color: #6c757d;">
        <p>© 2024 CloudAudit Pro. All rights reserved.</p>
        <p>This is an automated message, please do not reply to this email.</p>
    </div>
</body>
</html>
    `;
  }
}