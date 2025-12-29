import React, { useEffect, useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  CardActions,
  Grid,
  Typography,
  Button,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Switch,
  FormControlLabel,
  CircularProgress,
} from '@mui/material';
import {
  Add,
  Edit,
  Delete,
  FileCopy,
  Visibility,
  Star,
  StarBorder,
} from '@mui/icons-material';
import reportingService from '../../services/reporting.service';
import { ReportType, ReportCategory } from '../../types/report.types';

interface ReportTemplate {
  id: string;
  name: string;
  description?: string;
  reportType: string;
  category: string;
  isStandard: boolean;
  isActive: boolean;
  templateDefinition?: any;
  dataSource?: any;
  formatting?: any;
  parameters?: any;
  createdAt: string | Date;
  updatedAt: string | Date;
}

const ReportTemplates: React.FC = () => {
  const [templates, setTemplates] = useState<ReportTemplate[]>([]);
  const [loading, setLoading] = useState(false);
  const [filterType, setFilterType] = useState<string>('all');
  const [filterStandard, setFilterStandard] = useState<string>('all');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [viewDialogOpen, setViewDialogOpen] = useState(false);
  const [selectedTemplate, setSelectedTemplate] = useState<ReportTemplate | null>(null);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    reportType: 'TRIAL_BALANCE' as ReportType,
    category: 'FINANCIAL' as ReportCategory,
    isActive: true,
    templateDefinition: '{}',
    dataSource: '{}',
    formatting: '{}',
    parameters: '{}',
  });

  useEffect(() => {
    loadTemplates();
  }, [filterType, filterStandard]);

  const loadTemplates = async () => {
    setLoading(true);
    try {
      let data: ReportTemplate[];
      if (filterStandard === 'standard') {
        data = await reportingService.getStandardTemplates();
      } else {
        data = await reportingService.getTemplates(
          filterType !== 'all' ? (filterType as ReportType) : undefined
        );
      }
      setTemplates(data);
    } catch (error) {
      console.error('Failed to load templates:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = () => {
    setSelectedTemplate(null);
    setFormData({
      name: '',
      description: '',
      reportType: 'TRIAL_BALANCE' as any,
      category: 'FINANCIAL' as any,
      isActive: true,
      templateDefinition: '{}',
      dataSource: '{}',
      formatting: '{}',
      parameters: '{}',
    });
    setDialogOpen(true);
  };

  const handleEdit = (template: ReportTemplate) => {
    setSelectedTemplate(template);
    setFormData({
      name: template.name,
      description: template.description || '',
      reportType: template.reportType as ReportType,
      category: template.category as ReportCategory,
      isActive: template.isActive,
      templateDefinition: JSON.stringify(template.templateDefinition || {}, null, 2),
      dataSource: JSON.stringify(template.dataSource || {}, null, 2),
      formatting: JSON.stringify(template.formatting || {}, null, 2),
      parameters: JSON.stringify(template.parameters || {}, null, 2),
    });
    setDialogOpen(true);
  };

  const handleView = (template: ReportTemplate) => {
    setSelectedTemplate(template);
    setViewDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      const payload = {
        ...formData,
        templateDefinition: JSON.parse(formData.templateDefinition),
        dataSource: JSON.parse(formData.dataSource),
        formatting: JSON.parse(formData.formatting),
        parameters: JSON.parse(formData.parameters),
      };

      if (selectedTemplate) {
        await reportingService.updateTemplate(selectedTemplate.id, payload);
      } else {
        await reportingService.createTemplate(payload);
      }

      setDialogOpen(false);
      loadTemplates();
    } catch (error) {
      console.error('Failed to save template:', error);
    }
  };

  const handleDuplicate = async (id: string) => {
    try {
      await reportingService.duplicateTemplate(id);
      loadTemplates();
    } catch (error) {
      console.error('Failed to duplicate template:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (!window.confirm('Are you sure you want to delete this template?')) return;

    try {
      await reportingService.deleteTemplate(id);
      loadTemplates();
    } catch (error) {
      console.error('Failed to delete template:', error);
    }
  };

  const handleToggleActive = async (id: string) => {
    try {
      await reportingService.toggleTemplateActive(id);
      loadTemplates();
    } catch (error) {
      console.error('Failed to toggle template:', error);
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Report Templates</Typography>
        <Button variant="contained" startIcon={<Add />} onClick={handleCreate}>
          Create Template
        </Button>
      </Box>

      {/* Filters */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Grid container spacing={2} alignItems="center">
            <Grid item xs={12} md={4}>
              <FormControl fullWidth>
                <InputLabel>Report Type</InputLabel>
                <Select
                  value={filterType}
                  onChange={(e) => setFilterType(e.target.value)}
                  label="Report Type"
                >
                  <MenuItem value="all">All Types</MenuItem>
                  <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                  <MenuItem value="GENERAL_LEDGER">General Ledger</MenuItem>
                  <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                  <MenuItem value="AUDIT_SUMMARY">Audit Summary</MenuItem>
                  <MenuItem value="CUSTOM">Custom</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth>
                <InputLabel>Template Type</InputLabel>
                <Select
                  value={filterStandard}
                  onChange={(e) => setFilterStandard(e.target.value)}
                  label="Template Type"
                >
                  <MenuItem value="all">All Templates</MenuItem>
                  <MenuItem value="standard">Standard Templates</MenuItem>
                  <MenuItem value="custom">Custom Templates</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={4}>
              <Button fullWidth variant="outlined" onClick={loadTemplates}>
                Refresh
              </Button>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Templates Grid */}
      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      ) : templates.length === 0 ? (
        <Card>
          <CardContent>
            <Typography textAlign="center" color="textSecondary">
              No templates found
            </Typography>
          </CardContent>
        </Card>
      ) : (
        <Grid container spacing={3}>
          {templates.map((template) => (
            <Grid item xs={12} md={6} lg={4} key={template.id}>
              <Card sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
                <CardContent sx={{ flexGrow: 1 }}>
                  <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 2 }}>
                    <Typography variant="h6" component="div">
                      {template.name}
                    </Typography>
                    {template.isStandard && (
                      <Chip
                        icon={<Star />}
                        label="Standard"
                        size="small"
                        color="primary"
                      />
                    )}
                  </Box>
                  {template.description && (
                    <Typography variant="body2" color="textSecondary" sx={{ mb: 2 }}>
                      {template.description}
                    </Typography>
                  )}
                  <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap', mb: 1 }}>
                    <Chip label={template.reportType} size="small" variant="outlined" />
                    <Chip label={template.category} size="small" variant="outlined" />
                    <Chip
                      label={template.isActive ? 'Active' : 'Inactive'}
                      size="small"
                      color={template.isActive ? 'success' : 'default'}
                    />
                  </Box>
                  <Typography variant="caption" color="textSecondary">
                    Updated: {new Date(template.updatedAt).toLocaleDateString()}
                  </Typography>
                </CardContent>
                <CardActions>
                  <IconButton size="small" onClick={() => handleView(template)}>
                    <Visibility fontSize="small" />
                  </IconButton>
                  {!template.isStandard && (
                    <>
                      <IconButton size="small" onClick={() => handleEdit(template)}>
                        <Edit fontSize="small" />
                      </IconButton>
                      <IconButton size="small" onClick={() => handleDelete(template.id)}>
                        <Delete fontSize="small" />
                      </IconButton>
                    </>
                  )}
                  <IconButton size="small" onClick={() => handleDuplicate(template.id)}>
                    <FileCopy fontSize="small" />
                  </IconButton>
                  <IconButton
                    size="small"
                    onClick={() => handleToggleActive(template.id)}
                    sx={{ ml: 'auto' }}
                  >
                    {template.isActive ? <Star color="primary" /> : <StarBorder />}
                  </IconButton>
                </CardActions>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      {/* Create/Edit Dialog */}
      <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>
          {selectedTemplate ? 'Edit Template' : 'Create Template'}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Name"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Description"
                multiline
                rows={2}
                value={formData.description}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Report Type</InputLabel>
                <Select
                  value={formData.reportType}
                  onChange={(e) => setFormData({ ...formData, reportType: e.target.value as ReportType })}
                  label="Report Type"
                >
                  <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                  <MenuItem value="GENERAL_LEDGER">General Ledger</MenuItem>
                  <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                  <MenuItem value="AUDIT_SUMMARY">Audit Summary</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={formData.category}
                  onChange={(e) => setFormData({ ...formData, category: e.target.value as ReportCategory })}
                  label="Category"
                >
                  <MenuItem value="FINANCIAL">Financial</MenuItem>
                  <MenuItem value="OPERATIONAL">Operational</MenuItem>
                  <MenuItem value="COMPLIANCE">Compliance</MenuItem>
                  <MenuItem value="AUDIT_WORKPAPER">Audit Workpaper</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Switch
                    checked={formData.isActive}
                    onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                  />
                }
                label="Active"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDialogOpen(false)}>Cancel</Button>
          <Button variant="contained" onClick={handleSave}>
            Save
          </Button>
        </DialogActions>
      </Dialog>

      {/* View Dialog */}
      <Dialog open={viewDialogOpen} onClose={() => setViewDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>Template Details</DialogTitle>
        <DialogContent>
          {selectedTemplate && (
            <Grid container spacing={2} sx={{ mt: 1 }}>
              <Grid item xs={12}>
                <Typography variant="subtitle2">Name</Typography>
                <Typography variant="body1">{selectedTemplate.name}</Typography>
              </Grid>
              {selectedTemplate.description && (
                <Grid item xs={12}>
                  <Typography variant="subtitle2">Description</Typography>
                  <Typography variant="body1">{selectedTemplate.description}</Typography>
                </Grid>
              )}
              <Grid item xs={6}>
                <Typography variant="subtitle2">Type</Typography>
                <Typography variant="body1">{selectedTemplate.reportType}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="subtitle2">Category</Typography>
                <Typography variant="body1">{selectedTemplate.category}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="subtitle2">Standard Template</Typography>
                <Typography variant="body1">{selectedTemplate.isStandard ? 'Yes' : 'No'}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="subtitle2">Active</Typography>
                <Typography variant="body1">{selectedTemplate.isActive ? 'Yes' : 'No'}</Typography>
              </Grid>
            </Grid>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setViewDialogOpen(false)}>Close</Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default ReportTemplates;
