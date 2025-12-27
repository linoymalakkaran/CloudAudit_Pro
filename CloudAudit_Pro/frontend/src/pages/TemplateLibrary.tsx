import React, { useState, useEffect } from 'react';
import {
  Box,
  Typography,
  Button,
  Card,
  CardContent,
  CardActions,
  Grid,
  Chip,
  TextField,
  MenuItem,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Alert,
  CircularProgress,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  FileCopy as CopyIcon,
} from '@mui/icons-material';
import apiClient from '../services/api';
import TemplateForm from '../components/forms/TemplateForm';

interface ProcedureTemplate {
  id: string;
  name: string;
  description: string | null;
  category: string | null;
  procedureText: string;
  isMandatory: boolean | null;
  estimatedHours: number | null;
  requiredSkills: any;
  isActive: boolean | null;
  usageCount: number | null;
  createdAt: string;
}

interface Statistics {
  total: number;
  active: number;
  mandatory: number;
  byCategory: Array<{ category: string; count: number }>;
}

const TemplateLibrary: React.FC = () => {
  const [templates, setTemplates] = useState<ProcedureTemplate[]>([]);
  const [statistics, setStatistics] = useState<Statistics | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [formOpen, setFormOpen] = useState(false);
  const [editingTemplate, setEditingTemplate] = useState<ProcedureTemplate | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);

  // Filters
  const [categoryFilter, setCategoryFilter] = useState<string>('');
  const [activeFilter, setActiveFilter] = useState<string>('');
  const [searchTerm, setSearchTerm] = useState<string>('');

  useEffect(() => {
    loadTemplates();
    loadStatistics();
  }, [categoryFilter, activeFilter, searchTerm]);

  const loadTemplates = async () => {
    try {
      setLoading(true);
      setError(null);
      const params: any = {};
      if (categoryFilter) params.category = categoryFilter;
      if (activeFilter) params.isActive = activeFilter === 'true';
      if (searchTerm) params.search = searchTerm;

      const response = await apiClient.get('/procedure-templates', { params });
      setTemplates(response.data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load templates');
    } finally {
      setLoading(false);
    }
  };

  const loadStatistics = async () => {
    try {
      const response = await apiClient.get('/procedure-templates/statistics');
      setStatistics(response.data);
    } catch (err) {
      console.error('Failed to load statistics', err);
    }
  };

  const handleCreate = () => {
    setEditingTemplate(null);
    setFormOpen(true);
  };

  const handleEdit = (template: ProcedureTemplate) => {
    setEditingTemplate(template);
    setFormOpen(true);
  };

  const handleFormClose = () => {
    setFormOpen(false);
    setEditingTemplate(null);
  };

  const handleFormSuccess = () => {
    handleFormClose();
    loadTemplates();
    loadStatistics();
  };

  const handleDeleteClick = (id: string) => {
    setDeletingId(id);
    setDeleteDialogOpen(true);
  };

  const handleDeleteConfirm = async () => {
    if (!deletingId) return;
    try {
      await apiClient.delete(`/procedure-templates/${deletingId}`);
      setDeleteDialogOpen(false);
      setDeletingId(null);
      loadTemplates();
      loadStatistics();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to delete template');
    }
  };

  const handleDeleteCancel = () => {
    setDeleteDialogOpen(false);
    setDeletingId(null);
  };

  const categories = statistics?.byCategory?.map((c) => c.category) || [];

  return (
    <Box>
      <Box display="flex" justifyContent="space-between" alignItems="center" mb={3}>
        <Typography variant="h4">Procedure Template Library</Typography>
        <Button variant="contained" color="primary" startIcon={<AddIcon />} onClick={handleCreate}>
          Create Template
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {/* Statistics */}
      {statistics && (
        <Grid container spacing={2} sx={{ mb: 3 }}>
          <Grid item xs={12} sm={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Total Templates
                </Typography>
                <Typography variant="h4">{statistics.total}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Active Templates
                </Typography>
                <Typography variant="h4">{statistics.active}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Mandatory Templates
                </Typography>
                <Typography variant="h4">{statistics.mandatory}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Categories
                </Typography>
                <Typography variant="h4">{statistics.byCategory.length}</Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      )}

      {/* Filters */}
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} sm={4}>
          <TextField
            fullWidth
            label="Search"
            variant="outlined"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </Grid>
        <Grid item xs={12} sm={4}>
          <TextField
            fullWidth
            select
            label="Category"
            variant="outlined"
            value={categoryFilter}
            onChange={(e) => setCategoryFilter(e.target.value)}
          >
            <MenuItem value="">All Categories</MenuItem>
            {categories.map((category) => (
              <MenuItem key={category} value={category}>
                {category}
              </MenuItem>
            ))}
          </TextField>
        </Grid>
        <Grid item xs={12} sm={4}>
          <TextField
            fullWidth
            select
            label="Status"
            variant="outlined"
            value={activeFilter}
            onChange={(e) => setActiveFilter(e.target.value)}
          >
            <MenuItem value="">All Statuses</MenuItem>
            <MenuItem value="true">Active</MenuItem>
            <MenuItem value="false">Inactive</MenuItem>
          </TextField>
        </Grid>
      </Grid>

      {/* Templates Grid */}
      {loading ? (
        <Box display="flex" justifyContent="center" p={4}>
          <CircularProgress />
        </Box>
      ) : (
        <Grid container spacing={2}>
          {templates.map((template) => (
            <Grid item xs={12} sm={6} md={4} key={template.id}>
              <Card>
                <CardContent>
                  <Box display="flex" justifyContent="space-between" alignItems="start" mb={1}>
                    <Typography variant="h6" gutterBottom>
                      {template.name}
                    </Typography>
                    {!template.isActive && <Chip label="Inactive" size="small" color="default" />}
                  </Box>

                  <Typography variant="body2" color="textSecondary" gutterBottom>
                    {template.description || 'No description'}
                  </Typography>

                  <Box mt={2} display="flex" gap={1} flexWrap="wrap">
                    {template.category && <Chip label={template.category} size="small" />}
                    {template.isMandatory && <Chip label="Mandatory" size="small" color="error" />}
                    {template.estimatedHours && (
                      <Chip label={`${template.estimatedHours}h`} size="small" color="info" />
                    )}
                  </Box>

                  {template.usageCount !== null && template.usageCount > 0 && (
                    <Typography variant="caption" color="textSecondary" display="block" mt={1}>
                      Used {template.usageCount} times
                    </Typography>
                  )}
                </CardContent>
                <CardActions>
                  <IconButton size="small" color="primary" onClick={() => handleEdit(template)}>
                    <EditIcon fontSize="small" />
                  </IconButton>
                  <IconButton size="small" color="error" onClick={() => handleDeleteClick(template.id)}>
                    <DeleteIcon fontSize="small" />
                  </IconButton>
                </CardActions>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      {templates.length === 0 && !loading && (
        <Box textAlign="center" p={4}>
          <Typography variant="body1" color="textSecondary">
            No templates found. Create your first template to get started.
          </Typography>
        </Box>
      )}

      {/* Template Form Dialog */}
      <Dialog open={formOpen} onClose={handleFormClose} maxWidth="md" fullWidth>
        <DialogTitle>{editingTemplate ? 'Edit Template' : 'Create Template'}</DialogTitle>
        <DialogContent>
          <TemplateForm template={editingTemplate} onSuccess={handleFormSuccess} onCancel={handleFormClose} />
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={deleteDialogOpen} onClose={handleDeleteCancel}>
        <DialogTitle>Delete Template</DialogTitle>
        <DialogContent>
          <Typography>Are you sure you want to delete this template? This action cannot be undone.</Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleDeleteCancel}>Cancel</Button>
          <Button onClick={handleDeleteConfirm} color="error" variant="contained">
            Delete
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default TemplateLibrary;
