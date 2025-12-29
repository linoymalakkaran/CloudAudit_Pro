import apiClient from './api';

export interface AuditProgress {
  overall: number;
  completed: number;
  inProgress: number;
  pending: number;
  issues: number;
}

export interface Activity {
  id: string;
  title: string;
  description: string;
  date: string;
  type: 'document' | 'procedure' | 'finding' | 'general';
}

export interface OutstandingItem {
  id: string;
  title: string;
  description: string;
  dueDate: string;
  priority: 'high' | 'medium' | 'low';
  type: 'document' | 'action' | 'review';
}

export interface ClientAuditOverview {
  progress: AuditProgress;
  recentActivities: Activity[];
  outstandingItems: OutstandingItem[];
}

class ClientPortalService {
  async getAuditOverview(companyId: string): Promise<ClientAuditOverview> {
    try {
      const response = await apiClient.get(`/dashboard/company/${companyId}/audit`);
      const auditData = response.data;

      // Transform backend data to client portal format
      const progress: AuditProgress = {
        overall: this.calculateOverallProgress(auditData),
        completed: auditData.procedureStats?.completed || 0,
        inProgress: auditData.procedureStats?.inProgress || 0,
        pending: auditData.procedureStats?.notStarted || 0,
        issues: auditData.findingsStats?.high || 0,
      };

      const recentActivities: Activity[] = this.mapActivities(auditData);
      const outstandingItems: OutstandingItem[] = this.mapOutstandingItems(auditData);

      return {
        progress,
        recentActivities,
        outstandingItems,
      };
    } catch (error) {
      console.error('Failed to fetch audit overview:', error);
      throw error;
    }
  }

  async sendMessage(companyId: string, message: string): Promise<void> {
    try {
      await apiClient.post(`/notifications/contact-auditor`, {
        companyId,
        message,
        subject: 'Message from Client Portal',
      });
    } catch (error) {
      console.error('Failed to send message:', error);
      throw error;
    }
  }

  private calculateOverallProgress(auditData: any): number {
    const stats = auditData.procedureStats;
    if (!stats) return 0;
    
    const total = (stats.completed || 0) + (stats.inProgress || 0) + (stats.notStarted || 0);
    if (total === 0) return 0;
    
    // Weighted calculation: completed = 100%, in progress = 50%
    const weightedProgress = ((stats.completed || 0) * 100 + (stats.inProgress || 0) * 50) / total;
    return Math.round(weightedProgress);
  }

  private mapActivities(auditData: any): Activity[] {
    const activities: Activity[] = [];
    
    // Map recent procedures
    if (auditData.recentProcedures) {
      auditData.recentProcedures.slice(0, 5).forEach((proc: any) => {
        activities.push({
          id: proc.id,
          title: proc.name || proc.procedureType,
          description: `Status: ${proc.status}`,
          date: proc.updatedAt || proc.createdAt,
          type: 'procedure',
        });
      });
    }

    // Map recent findings
    if (auditData.recentFindings) {
      auditData.recentFindings.slice(0, 3).forEach((finding: any) => {
        activities.push({
          id: finding.id,
          title: finding.title,
          description: finding.description,
          date: finding.createdAt,
          type: 'finding',
        });
      });
    }

    return activities.sort((a, b) => 
      new Date(b.date).getTime() - new Date(a.date).getTime()
    ).slice(0, 10);
  }

  private mapOutstandingItems(auditData: any): OutstandingItem[] {
    const items: OutstandingItem[] = [];
    
    // Map pending procedures
    if (auditData.pendingProcedures) {
      auditData.pendingProcedures.forEach((proc: any) => {
        items.push({
          id: proc.id,
          title: proc.name || proc.procedureType,
          description: 'Pending completion',
          dueDate: proc.dueDate || proc.targetDate,
          priority: proc.riskLevel === 'HIGH' ? 'high' : 'medium',
          type: 'action',
        });
      });
    }

    // Map document requests
    if (auditData.documentRequests) {
      auditData.documentRequests.forEach((req: any) => {
        items.push({
          id: req.id,
          title: req.documentName || 'Document Request',
          description: req.description || 'Document required',
          dueDate: req.dueDate,
          priority: 'high',
          type: 'document',
        });
      });
    }

    return items;
  }
}

export const clientPortalService = new ClientPortalService();
