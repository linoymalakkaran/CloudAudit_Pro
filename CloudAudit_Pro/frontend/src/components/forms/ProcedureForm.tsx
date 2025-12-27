import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  Grid,
  MenuItem,
  FormControl,
  InputLabel,
  Select,
  FormControlLabel,
  Checkbox,
  CircularProgress,
  Alert,
} from '@mui/material';
import apiClient from '../../services/api';

interface Company {
  id: string;
  name: string;
}

interface Period {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
}

interface ProcedureTemplate {
  id: string;
  name: string;
}

interface TenantUser {
  id: string;
  user: {
    firstName: string;
    lastName: string;
  };
}

interface ProcedureFormProps {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
  procedureId?: string;
  initialData?: any;
}

const categories = [
  { value: 'FINANCIAL_STATEMENT_AUDIT', label: 'Financial Statement Audit' },
  { value: 'INTERNAL_CONTROLS', label: 'Internal Controls' },
  { value: 'COMPLIANCE', label: 'Compliance' },
  { value: 'SUBSTANTIVE_TESTING', label: 'Substantive Testing' },
  { value: 'ANALYTICAL_PROCEDURES', label: 'Analytical Procedures' },
  { value: 'RISK_ASSESSMENT', label: 'Risk Assessment' },
  { value: 'FRAUD_DETECTION', label: 'Fraud Detection' },
  { value: 'IT_AUDIT', label: 'IT Audit' },
  { value: 'OPERATIONAL_AUDIT', label: 'Operational Audit' },
  { value: 'TAX_AUDIT', label: 'Tax Audit' },
  { value: 'PAYROLL_AUDIT', label: 'Payroll Audit' },
  { value: 'INVENTORY_AUDIT', label: 'Inventory Audit' },
  { value: 'OTHER', label: 'Other' },
];

const priorities = [
  { value: 'LOW', label: 'Low' },
  { value: 'MEDIUM', label: 'Medium' },
  { value: 'HIGH', label: 'High' },
  { value: 'CRITICAL', label: 'Critical' },
];

const riskLevels = [
  { value: 'LOW', label: 'Low' },
  { value: 'MEDIUM', label: 'Medium' },
  { value: 'HIGH', label: 'High' },
  { value: 'VERY_HIGH', label: 'Very High' },
];

export const ProcedureForm: React.FC<ProcedureFormProps> = ({
  open,
  onClose,
  onSuccess,
  procedureId,
  initialData,
}) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [companies, setCompanies] = useState<Company[]>([]);
  const [periods, setPeriods] = useState<Period[]>([]);
  const [templates, setTemplates] = useState<ProcedureTemplate[]>([]);
  const [users, setUsers] = useState<TenantUser[]>([]);

  const [formData, setFormData] = useState({
    title: '',
    description: '',
    category: 'FINANCIAL_STATEMENT_AUDIT',
    priority: 'MEDIUM',
    riskLevel: 'MEDIUM',
    companyId: '',
    periodId: '',
    templateId: '',
    assignedToId: '',
    dueDate: '',
    objectives: '',
    scope: '',
    methodology: '',
    expectedEvidence: '',
    controlsDocumented: false,
    controlsTested: false,
    substantiveTesting: false,
    analyticalProcedures: false,
    notes: '',
  });

  useEffect(() => {
    if (open) {
      loadInitialData();
    }
  }, [open]);

  useEffect(() => {
    if (initialData) {
      setFormData({
        title: initialData.title || '',
        description: initialData.description || '',
        category: initialData.category || 'FINANCIAL_STATEMENT_AUDIT',
        priority: initialData.priority || 'MEDIUM',
        riskLevel: initialData.riskLevel || 'MEDIUM',
        companyId: initialData.companyId || '',
        periodId: initialData.periodId || '',
        templateId: initialData.templateId || '',
        assignedToId: initialData.assignedToId || '',
        dueDate: initialData.dueDate ? initialData.dueDate.split('T')[0] : '',
        objectives: initialData.objectives || '',
        scope: initialData.scope || '',
        methodology: initialData.methodology || '',
        expectedEvidence: initialData.expectedEvidence || '',
        controlsDocumented: initialData.controlsDocumented || false,
        controlsTested: initialData.controlsTested || false,
        substantiveTesting: initialData.substantiveTesting || false,
        analyticalProcedures: initialData.analyticalProcedures || false,
        notes: initialData.notes || '',
      });
    }
  }, [initialData]);

  const loadInitialData = async () => {
    try {
      const [companiesRes, templatesRes, usersRes] = await Promise.all([
        apiClient.get('/companies'),
        apiClient.get('/procedure-templates'),
        apiClient.get('/tenant-users'),
      ]);
      setCompanies(companiesRes.data);
      setTemplates(templatesRes.data);
      setUsers(usersRes.data);
    } catch (err: any) {
      setError('Failed to load form data');
    }
  };

  useEffect(() => {
    if (formData.companyId) {
      loadPeriods(formData.companyId);
    }
  }, [formData.companyId]);

  useEffect(() => {
    if (formData.templateId) {
      loadTemplateData(formData.templateId);
    }
  }, [formData.templateId]);

  const loadPeriods = async (companyId: string) => {
    try {
      const response = await apiClient.get(`/periods?companyId=${companyId}`);
      setPeriods(response.data);
    } catch (err: any) {
      console.error('Failed to load periods', err);
    }
  };

  const loadTemplateData = async (templateId: string) => {
    try {
      const response = await apiClient.get(`/procedure-templates/${templateId}`);
      const template = response.data;
      
      // Populate form with template data
      setFormData(prev => ({
        ...prev,
        title: template.name || prev.title,
        description: template.description || prev.description,
        category: template.category || prev.category,
        objectives: template.procedureText || prev.objectives,
        methodology: template.procedureText || prev.methodology,
      }));
    } catch (err: any) {
      console.error('Failed to load template', err);
    }
  };

  const handleChange = (field: string, value: any) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = async () => {
    setLoading(true);
    setError(null);

    try {
      const payload = {
        ...formData,
        dueDate: formData.dueDate ? new Date(formData.dueDate).toISOString() : undefined,
      };

      if (procedureId) {
        await apiClient.put(`/audit-procedures/${procedureId}`, payload);
      } else {
        await apiClient.post('/audit-procedures', payload);
      }

      onSuccess();
      handleClose();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save procedure');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setFormData({
      title: '',
      description: '',
      category: 'FINANCIAL_STATEMENT_AUDIT',
      priority: 'MEDIUM',
      riskLevel: 'MEDIUM',
      companyId: '',
      periodId: '',
      templateId: '',
      assignedToId: '',
      dueDate: '',
      objectives: '',
      scope: '',
      methodology: '',
      expectedEvidence: '',
      controlsDocumented: false,
      controlsTested: false,
      substantiveTesting: false,
      analyticalProcedures: false,
      notes: '',
    });
    setError(null);
    onClose();
  };

  return (
    <Dialog open={open} onClose={handleClose} maxWidth="md" fullWidth>
      <DialogTitle>{procedureId ? 'Edit Procedure' : 'Create New Procedure'}</DialogTitle>
      <DialogContent>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        <Grid container spacing={2} sx={{ mt: 1 }}>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Title"
              value={formData.title}
              onChange={(e) => handleChange('title', e.target.value)}
              required
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Description"
              value={formData.description}
              onChange={(e) => handleChange('description', e.target.value)}
              multiline
              rows={3}
            />
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth required>
              <InputLabel>Category</InputLabel>
              <Select
                value={formData.category}
                onChange={(e) => handleChange('category', e.target.value)}
                label="Category"
              >
                {categories.map((cat) => (
                  <MenuItem key={cat.value} value={cat.value}>
                    {cat.label}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth required>
              <InputLabel>Priority</InputLabel>
              <Select
                value={formData.priority}
                onChange={(e) => handleChange('priority', e.target.value)}
                label="Priority"
              >
                {priorities.map((p) => (
                  <MenuItem key={p.value} value={p.value}>
                    {p.label}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth required>
              <InputLabel>Risk Level</InputLabel>
              <Select
                value={formData.riskLevel}
                onChange={(e) => handleChange('riskLevel', e.target.value)}
                label="Risk Level"
              >
                {riskLevels.map((r) => (
                  <MenuItem key={r.value} value={r.value}>
                    {r.label}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth required>
              <InputLabel>Company</InputLabel>
              <Select
                value={formData.companyId}
                onChange={(e) => handleChange('companyId', e.target.value)}
                label="Company"
              >
                {companies.map((company) => (
                  <MenuItem key={company.id} value={company.id}>
                    {company.name}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth required disabled={!formData.companyId}>
              <InputLabel>Period</InputLabel>
              <Select
                value={formData.periodId}
                onChange={(e) => handleChange('periodId', e.target.value)}
                label="Period"
              >
                {periods.map((period) => (
                  <MenuItem key={period.id} value={period.id}>
                    {period.name}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth>
              <InputLabel>Template (Optional)</InputLabel>
              <Select
                value={formData.templateId}
                onChange={(e) => handleChange('templateId', e.target.value)}
                label="Template (Optional)"
              >
                <MenuItem value="">
                  <em>None</em>
                </MenuItem>
                {templates.map((template) => (
                  <MenuItem key={template.id} value={template.id}>
                    {template.name}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControl fullWidth>
              <InputLabel>Assign To</InputLabel>
              <Select
                value={formData.assignedToId}
                onChange={(e) => handleChange('assignedToId', e.target.value)}
                label="Assign To"
              >
                <MenuItem value="">
                  <em>Unassigned</em>
                </MenuItem>
                {users.map((user) => (
                  <MenuItem key={user.id} value={user.id}>
                    {user.user.firstName} {user.user.lastName}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={6}>
            <TextField
              fullWidth
              type="date"
              label="Due Date"
              value={formData.dueDate}
              onChange={(e) => handleChange('dueDate', e.target.value)}
              InputLabelProps={{ shrink: true }}
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Objectives"
              value={formData.objectives}
              onChange={(e) => handleChange('objectives', e.target.value)}
              multiline
              rows={2}
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Scope"
              value={formData.scope}
              onChange={(e) => handleChange('scope', e.target.value)}
              multiline
              rows={2}
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Methodology"
              value={formData.methodology}
              onChange={(e) => handleChange('methodology', e.target.value)}
              multiline
              rows={2}
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Expected Evidence"
              value={formData.expectedEvidence}
              onChange={(e) => handleChange('expectedEvidence', e.target.value)}
              multiline
              rows={2}
            />
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControlLabel
              control={
                <Checkbox
                  checked={formData.controlsDocumented}
                  onChange={(e) => handleChange('controlsDocumented', e.target.checked)}
                />
              }
              label="Controls Documented"
            />
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControlLabel
              control={
                <Checkbox
                  checked={formData.controlsTested}
                  onChange={(e) => handleChange('controlsTested', e.target.checked)}
                />
              }
              label="Controls Tested"
            />
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControlLabel
              control={
                <Checkbox
                  checked={formData.substantiveTesting}
                  onChange={(e) => handleChange('substantiveTesting', e.target.checked)}
                />
              }
              label="Substantive Testing"
            />
          </Grid>

          <Grid item xs={12} md={6}>
            <FormControlLabel
              control={
                <Checkbox
                  checked={formData.analyticalProcedures}
                  onChange={(e) => handleChange('analyticalProcedures', e.target.checked)}
                />
              }
              label="Analytical Procedures"
            />
          </Grid>

          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Notes"
              value={formData.notes}
              onChange={(e) => handleChange('notes', e.target.value)}
              multiline
              rows={3}
            />
          </Grid>
        </Grid>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleClose} disabled={loading}>
          Cancel
        </Button>
        <Button
          onClick={handleSubmit}
          variant="contained"
          disabled={loading || !formData.title || !formData.companyId || !formData.periodId}
          startIcon={loading ? <CircularProgress size={20} /> : null}
        >
          {procedureId ? 'Update' : 'Create'}
        </Button>
      </DialogActions>
    </Dialog>
  );
};
