import React, { useState, useEffect } from 'react';
import {
  Box,
  Paper,
  Typography,
  Button,
  TextField,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Card,
  CardContent,
  CardActions,
  Chip,
  IconButton,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Switch,
  FormControlLabel,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  PlayArrow as GenerateIcon,
  CloudUpload as UploadIcon,
  Description as TemplateIcon,
} from '@mui/icons-material';
import { documentTemplatesService, DocumentTemplate } from '../../services/documentTemplates.service';

export default function DocumentTemplates() {
  const [templates, setTemplates] = useState<DocumentTemplate[]>([]);
  const [loading, setLoading] = useState(false);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [generateDialogOpen, setGenerateDialogOpen] = useState(false);
  const [selectedTemplate, setSelectedTemplate] = useState<DocumentTemplate | null>(null);
  const [categoryFilter, setCategoryFilter] = useState('');
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    category: '',
    templateType: 'MEMO',
    isActive: true,
    fields: {},
  });
  const [generateData, setGenerateData] = useState({
    name: '',
    companyId: '',
    periodId: '',
    fieldValues: {},
  });
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  useEffect(() => {
    loadTemplates();
  }, [categoryFilter]);

  const loadTemplates = async () => {
    setLoading(true);
    try {
      const data = await documentTemplatesService.getAll(
        categoryFilter || undefined,
        undefined,
        undefined
      );
      setTemplates(data);
    } catch (error) {
      console.error('Error loading templates:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSaveTemplate = async () => {
    try {
      if (selectedTemplate) {
        await documentTemplatesService.update(selectedTemplate.id, formData, selectedFile || undefined);
      } else {
        await documentTemplatesService.create(formData, selectedFile || undefined);
      }
      setDialogOpen(false);
      resetForm();
      loadTemplates();
    } catch (error) {
      console.error('Error saving template:', error);
    }
  };

  const handleDeleteTemplate = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this template?')) {
      try {
        await documentTemplatesService.delete(id);
        loadTemplates();
      } catch (error) {
        console.error('Error deleting template:', error);
      }
    }
  };

  const handleToggleActive = async (id: string) => {
    try {
      await documentTemplatesService.toggleActive(id);
      loadTemplates();
    } catch (error) {
      console.error('Error toggling template status:', error);
    }
  };

  const handleGenerateDocument = async () => {
    if (selectedTemplate) {
      try {
        await documentTemplatesService.generateFromTemplate(selectedTemplate.id, generateData);
        setGenerateDialogOpen(false);
        setGenerateData({
          name: '',
          companyId: '',
          periodId: '',
          fieldValues: {},
        });
      } catch (error) {
        console.error('Error generating document:', error);
      }
    }
  };

  const handleEditTemplate = (template: DocumentTemplate) => {
    setSelectedTemplate(template);
    setFormData({
      name: template.name,
      description: template.description || '',
      category: template.category,
      templateType: template.templateType,
      isActive: template.isActive,
      fields: template.fields || {},
    });
    setDialogOpen(true);
  };

  const handleGenerateFromTemplate = (template: DocumentTemplate) => {
    setSelectedTemplate(template);
    setGenerateData({
      name: '',
      companyId: '',
      periodId: '',
      fieldValues: {},
    });
    setGenerateDialogOpen(true);
  };

  const resetForm = () => {
    setSelectedTemplate(null);
    setFormData({
      name: '',
      description: '',
      category: '',
      templateType: 'MEMO',
      isActive: true,
      fields: {},
    });
    setSelectedFile(null);
  };

  const getTemplateTypeColor = (type: string) => {
    const colors: Record<string, any> = {
      ENGAGEMENT: 'primary',
      REPORTING: 'success',
      CHECKLIST: 'warning',
      MEMO: 'info',
      SCHEDULE: 'secondary',
    };
    return colors[type] || 'default';
  };

  return (
    <Box sx={{ p: 3 }}>
      <Paper sx={{ p: 2, mb: 2 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
          <Typography variant="h4">Document Templates</Typography>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setDialogOpen(true)}
          >
            New Template
          </Button>
        </Box>

        <Grid container spacing={2} sx={{ mb: 3 }}>
          <Grid item xs={12} md={3}>
            <FormControl fullWidth>
              <InputLabel>Category</InputLabel>
              <Select
                value={categoryFilter}
                label="Category"
                onChange={(e) => setCategoryFilter(e.target.value)}
              >
                <MenuItem value="">All Categories</MenuItem>
                <MenuItem value="PLANNING">Planning</MenuItem>
                <MenuItem value="EXECUTION">Execution</MenuItem>
                <MenuItem value="REVIEW">Review</MenuItem>
                <MenuItem value="FINALIZATION">Finalization</MenuItem>
                <MenuItem value="PERMANENT_FILE">Permanent File</MenuItem>
              </Select>
            </FormControl>
          </Grid>
        </Grid>

        <Grid container spacing={3}>
          {templates.map((template) => (
            <Grid item xs={12} sm={6} md={4} key={template.id}>
              <Card>
                <CardContent>
                  <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                    <TemplateIcon sx={{ mr: 1, fontSize: 40, color: 'primary.main' }} />
                    <Box sx={{ flexGrow: 1 }}>
                      <Typography variant="h6" noWrap>
                        {template.name}
                      </Typography>
                      <Chip
                        label={template.templateType}
                        size="small"
                        color={getTemplateTypeColor(template.templateType)}
                        sx={{ mt: 0.5 }}
                      />
                    </Box>
                  </Box>

                  <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                    {template.description || 'No description'}
                  </Typography>

                  <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap' }}>
                    <Chip label={template.category} size="small" variant="outlined" />
                    <Chip
                      label={template.isActive ? 'Active' : 'Inactive'}
                      size="small"
                      color={template.isActive ? 'success' : 'default'}
                    />
                  </Box>
                </CardContent>

                <CardActions sx={{ justifyContent: 'space-between' }}>
                  <Box>
                    <IconButton
                      size="small"
                      color="primary"
                      onClick={() => handleEditTemplate(template)}
                    >
                      <EditIcon />
                    </IconButton>
                    <IconButton
                      size="small"
                      color="error"
                      onClick={() => handleDeleteTemplate(template.id)}
                    >
                      <DeleteIcon />
                    </IconButton>
                  </Box>
                  <Button
                    size="small"
                    startIcon={<GenerateIcon />}
                    onClick={() => handleGenerateFromTemplate(template)}
                    disabled={!template.isActive}
                  >
                    Generate
                  </Button>
                </CardActions>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Paper>

      {/* Template Dialog */}
      <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>{selectedTemplate ? 'Edit Template' : 'New Template'}</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Template Name"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Description"
                value={formData.description}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={formData.category}
                  label="Category"
                  onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                >
                  <MenuItem value="PLANNING">Planning</MenuItem>
                  <MenuItem value="EXECUTION">Execution</MenuItem>
                  <MenuItem value="REVIEW">Review</MenuItem>
                  <MenuItem value="FINALIZATION">Finalization</MenuItem>
                  <MenuItem value="PERMANENT_FILE">Permanent File</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Template Type</InputLabel>
                <Select
                  value={formData.templateType}
                  label="Template Type"
                  onChange={(e) => setFormData({ ...formData, templateType: e.target.value })}
                >
                  <MenuItem value="ENGAGEMENT">Engagement</MenuItem>
                  <MenuItem value="REPORTING">Reporting</MenuItem>
                  <MenuItem value="CHECKLIST">Checklist</MenuItem>
                  <MenuItem value="MEMO">Memo</MenuItem>
                  <MenuItem value="SCHEDULE">Schedule</MenuItem>
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
            <Grid item xs={12}>
              <Button variant="outlined" component="label" startIcon={<UploadIcon />} fullWidth>
                Upload Template File
                <input
                  type="file"
                  hidden
                  onChange={(e) => setSelectedFile(e.target.files?.[0] || null)}
                />
              </Button>
              {selectedFile && (
                <Typography variant="body2" sx={{ mt: 1 }}>
                  Selected: {selectedFile.name}
                </Typography>
              )}
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleSaveTemplate} variant="contained">
            Save Template
          </Button>
        </DialogActions>
      </Dialog>

      {/* Generate Dialog */}
      <Dialog open={generateDialogOpen} onClose={() => setGenerateDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Generate Document from Template</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Document Name"
                value={generateData.name}
                onChange={(e) => setGenerateData({ ...generateData, name: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Company ID"
                value={generateData.companyId}
                onChange={(e) => setGenerateData({ ...generateData, companyId: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Period ID (Optional)"
                value={generateData.periodId}
                onChange={(e) => setGenerateData({ ...generateData, periodId: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setGenerateDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleGenerateDocument} variant="contained">
            Generate
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
}
