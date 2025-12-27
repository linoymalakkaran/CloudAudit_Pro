import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';
import { EmailTemplateService } from './email-template.service';
import { 
  TenantApprovalEmailData, 
  UserApprovalEmailData, 
  WelcomeEmailData 
} from './interfaces/email.interface';

@Injectable()
export class EmailService {
  private readonly logger = new Logger(EmailService.name);
  private transporter: nodemailer.Transporter | null = null;
  private mockMode = false;

  constructor(
    private readonly configService: ConfigService,
    private readonly emailTemplateService: EmailTemplateService,
  ) {
    this.initializeTransporter();
  }

  private async initializeTransporter(): Promise<void> {
    try {
      // Check if SMTP configuration is available
      const smtpHost = this.configService.get('SMTP_HOST');
      if (!smtpHost) {
        this.logger.warn('SMTP configuration not found, using mock mode');
        this.mockMode = true;
        return;
      }

      this.transporter = nodemailer.createTransport({
        host: smtpHost,
        port: this.configService.get('SMTP_PORT', 587),
        secure: this.configService.get('SMTP_SECURE') === 'true',
        auth: {
          user: this.configService.get('SMTP_USER'),
          pass: this.configService.get('SMTP_PASSWORD'),
        },
      });

      // Verify connection with timeout
      const verificationPromise = this.transporter.verify();
      const timeoutPromise = new Promise((_, reject) => {
        setTimeout(() => reject(new Error('SMTP verification timeout')), 5000);
      });

      await Promise.race([verificationPromise, timeoutPromise]);
      this.logger.log('SMTP connection verified successfully');
    } catch (error) {
      this.logger.warn('Failed to initialize SMTP transporter, using mock mode');
      this.mockMode = true;
    }
  }

  private async sendEmail(mailOptions: nodemailer.SendMailOptions): Promise<void> {
    if (this.mockMode || !this.transporter) {
      this.logger.log(`[MOCK MODE] Email would be sent to: ${mailOptions.to}`);
      this.logger.log(`[MOCK MODE] Subject: ${mailOptions.subject}`);
      return;
    }

    try {
      const result = await this.transporter.sendMail(mailOptions);
      this.logger.log(`Email sent successfully to ${mailOptions.to}: ${result.messageId}`);
    } catch (error) {
      this.logger.error(`Failed to send email to ${mailOptions.to}`, error.stack);
      throw error;
    }
  }

  async sendTenantApprovalNotification(data: TenantApprovalEmailData): Promise<void> {
    try {
      const template = await this.emailTemplateService.generateTenantApprovalTemplate(data);
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to: data.to,
        subject: template.subject,
        html: template.html,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send tenant approval notification', error.stack);
      throw error;
    }
  }

  async sendUserApprovalNotification(data: UserApprovalEmailData): Promise<void> {
    try {
      const template = await this.emailTemplateService.generateUserApprovalTemplate(data);
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to: data.to,
        subject: template.subject,
        html: template.html,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send user approval notification', error.stack);
      throw error;
    }
  }

  async sendWelcomeEmail(data: WelcomeEmailData): Promise<void> {
    try {
      const template = await this.emailTemplateService.generateWelcomeTemplate(data);
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to: data.to,
        subject: template.subject,
        html: template.html,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send welcome email', error.stack);
      throw error;
    }
  }

  async sendPasswordResetEmail(to: string, resetToken: string): Promise<void> {
    try {
      const resetUrl = `${this.configService.get('FRONTEND_URL')}/reset-password?token=${resetToken}`;
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to,
        subject: 'Password Reset Request - CloudAudit Pro',
        html: `
          <h2>Password Reset Request</h2>
          <p>You requested a password reset for your CloudAudit Pro account.</p>
          <p>Click the link below to reset your password:</p>
          <a href="${resetUrl}" style="background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Reset Password</a>
          <p>This link will expire in 1 hour.</p>
          <p>If you didn't request this password reset, please ignore this email.</p>
        `,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send password reset email', error.stack);
      throw error;
    }
  }

  async sendUserInvitationEmail(
    to: string, 
    inviterName: string, 
    companyName: string, 
    role: string,
    invitationToken: string
  ): Promise<void> {
    try {
      const invitationUrl = `${this.configService.get('FRONTEND_URL')}/accept-invitation?token=${invitationToken}`;
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to,
        subject: `Invitation to join ${companyName} on CloudAudit Pro`,
        html: `
          <h2>You're Invited to CloudAudit Pro</h2>
          <p>${inviterName} has invited you to join ${companyName} as a ${role}.</p>
          <p>Click the link below to accept your invitation and set up your account:</p>
          <a href="${invitationUrl}" style="background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Accept Invitation</a>
          <p>This invitation will expire in 7 days.</p>
          <p>Welcome to CloudAudit Pro!</p>
        `,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send user invitation email', error.stack);
      throw error;
    }
  }

  async sendProcedureAssignmentNotification(
    to: string,
    assigneeName: string,
    procedureName: string,
    companyName: string,
    dueDate?: Date,
  ): Promise<void> {
    try {
      const dueDateStr = dueDate ? new Date(dueDate).toLocaleDateString() : 'No due date set';
      const frontendUrl = this.configService.get('FRONTEND_URL') || 'http://localhost:3000';
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to,
        subject: `Audit Procedure Assigned: ${procedureName}`,
        html: `
          <h2>New Audit Procedure Assignment</h2>
          <p>Hi ${assigneeName},</p>
          <p>You have been assigned a new audit procedure:</p>
          <div style="background-color: #f5f5f5; padding: 15px; border-left: 4px solid #1976d2; margin: 15px 0;">
            <strong>Procedure:</strong> ${procedureName}<br/>
            <strong>Company:</strong> ${companyName}<br/>
            <strong>Due Date:</strong> ${dueDateStr}
          </div>
          <p>Please log in to CloudAudit Pro to view the details and start working on this procedure.</p>
          <a href="${frontendUrl}/audit/procedures" style="background-color: #1976d2; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 10px;">View Procedure</a>
          <p style="margin-top: 20px;">Thank you,<br/>CloudAudit Pro Team</p>
        `,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send procedure assignment notification', error.stack);
      throw error;
    }
  }

  async sendProcedureReviewNotification(
    to: string,
    assigneeName: string,
    procedureName: string,
    companyName: string,
    reviewStatus: string,
    reviewNotes?: string,
  ): Promise<void> {
    try {
      const statusMessages = {
        APPROVED: { title: 'Approved', color: '#28a745', message: 'Your procedure has been approved! Great work!' },
        REJECTED: { title: 'Rejected', color: '#dc3545', message: 'Your procedure has been rejected and requires rework.' },
        REQUIRES_REVISION: { title: 'Revision Required', color: '#ffc107', message: 'Your procedure requires some revisions before approval.' },
      };

      const statusInfo = statusMessages[reviewStatus] || statusMessages.REQUIRES_REVISION;
      const frontendUrl = this.configService.get('FRONTEND_URL') || 'http://localhost:3000';
      
      const mailOptions = {
        from: this.configService.get('SMTP_FROM') || this.configService.get('SMTP_USER'),
        to,
        subject: `Procedure Review: ${procedureName} - ${statusInfo.title}`,
        html: `
          <h2 style="color: ${statusInfo.color}">Procedure Review: ${statusInfo.title}</h2>
          <p>Hi ${assigneeName},</p>
          <p>${statusInfo.message}</p>
          <div style="background-color: #f5f5f5; padding: 15px; border-left: 4px solid ${statusInfo.color}; margin: 15px 0;">
            <strong>Procedure:</strong> ${procedureName}<br/>
            <strong>Company:</strong> ${companyName}<br/>
            <strong>Status:</strong> ${statusInfo.title}
            ${reviewNotes ? `<br/><br/><strong>Reviewer Notes:</strong><br/>${reviewNotes}` : ''}
          </div>
          <p>Please log in to CloudAudit Pro to view the full details.</p>
          <a href="${frontendUrl}/audit/procedures" style="background-color: #1976d2; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 10px;">View Procedure</a>
          <p style="margin-top: 20px;">Thank you,<br/>CloudAudit Pro Team</p>
        `,
      };

      await this.sendEmail(mailOptions);
    } catch (error) {
      this.logger.error('Failed to send procedure review notification', error.stack);
      throw error;
    }
  }
}