import React, { useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Grid,
  Paper,
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
  Divider,
} from '@mui/material';
import {
  Add,
  Delete,
  DragIndicator,
  Settings,
  Save,
  Preview,
} from '@mui/icons-material';
import dashboardsService from '../../services/dashboards.service';

interface WidgetConfig {
  id: string;
  type: string;
  title: string;
  size: {
    width: number;
    height: number;
  };
  position: {
    x: number;
    y: number;
  };
  dataSource?: any;
  settings?: any;
}

const WIDGET_TYPES = [
  { value: 'financial-summary', label: 'Financial Summary' },
  { value: 'audit-progress', label: 'Audit Progress' },
  { value: 'recent-activities', label: 'Recent Activities' },
  { value: 'outstanding-items', label: 'Outstanding Items' },
  { value: 'document-stats', label: 'Document Statistics' },
  { value: 'team-workload', label: 'Team Workload' },
];

const DashboardBuilder: React.FC = () => {
  const [dashboardName, setDashboardName] = useState('');
  const [dashboardDescription, setDashboardDescription] = useState('');
  const [widgets, setWidgets] = useState<WidgetConfig[]>([]);
  const [selectedWidget, setSelectedWidget] = useState<WidgetConfig | null>(null);
  const [widgetDialogOpen, setWidgetDialogOpen] = useState(false);
  const [configDialogOpen, setConfigDialogOpen] = useState(false);
  const [saving, setSaving] = useState(false);

  const [newWidget, setNewWidget] = useState({
    type: 'financial-summary',
    title: '',
    width: 6,
    height: 4,
  });

  const handleAddWidget = () => {
    const widget: WidgetConfig = {
      id: `widget-${Date.now()}`,
      type: newWidget.type,
      title: newWidget.title || WIDGET_TYPES.find((w) => w.value === newWidget.type)?.label || 'Widget',
      size: {
        width: newWidget.width,
        height: newWidget.height,
      },
      position: {
        x: 0,
        y: widgets.length * 4,
      },
      dataSource: {},
      settings: {},
    };

    setWidgets([...widgets, widget]);
    setWidgetDialogOpen(false);
    setNewWidget({
      type: 'financial-summary',
      title: '',
      width: 6,
      height: 4,
    });
  };

  const handleRemoveWidget = (widgetId: string) => {
    setWidgets(widgets.filter((w) => w.id !== widgetId));
  };

  const handleConfigureWidget = (widget: WidgetConfig) => {
    setSelectedWidget(widget);
    setConfigDialogOpen(true);
  };

  const handleSaveWidgetConfig = () => {
    if (!selectedWidget) return;

    setWidgets(
      widgets.map((w) =>
        w.id === selectedWidget.id ? selectedWidget : w
      )
    );
    setConfigDialogOpen(false);
    setSelectedWidget(null);
  };

  const handleSaveDashboard = async () => {
    if (!dashboardName) {
      alert('Please enter a dashboard name');
      return;
    }

    setSaving(true);
    try {
      const dashboard = {
        name: dashboardName,
        description: dashboardDescription,
        widgets: widgets,
        layout: {
          columns: 12,
          rowHeight: 100,
        },
        isDefault: false,
      };

      await dashboardsService.createDashboard(dashboard);
      alert('Dashboard saved successfully!');
      
      // Reset form
      setDashboardName('');
      setDashboardDescription('');
      setWidgets([]);
    } catch (error) {
      console.error('Failed to save dashboard:', error);
      alert('Failed to save dashboard');
    } finally {
      setSaving(false);
    }
  };

  const getWidgetColor = (type: string) => {
    const colors: Record<string, string> = {
      'financial-summary': '#1976d2',
      'audit-progress': '#2e7d32',
      'recent-activities': '#ed6c02',
      'outstanding-items': '#d32f2f',
      'document-stats': '#9c27b0',
      'team-workload': '#0288d1',
    };
    return colors[type] || '#757575';
  };

  return (
    <Box sx={{ p: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Dashboard Builder</Typography>
        <Box>
          <Button
            variant="outlined"
            startIcon={<Preview />}
            sx={{ mr: 2 }}
            disabled={widgets.length === 0}
          >
            Preview
          </Button>
          <Button
            variant="contained"
            startIcon={<Save />}
            onClick={handleSaveDashboard}
            disabled={saving || !dashboardName}
          >
            Save Dashboard
          </Button>
        </Box>
      </Box>

      {/* Dashboard Info */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Typography variant="h6" gutterBottom>
            Dashboard Information
          </Typography>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Dashboard Name"
                value={dashboardName}
                onChange={(e) => setDashboardName(e.target.value)}
                required
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Description"
                value={dashboardDescription}
                onChange={(e) => setDashboardDescription(e.target.value)}
              />
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Widget Library */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
            <Typography variant="h6">Widgets</Typography>
            <Button
              variant="contained"
              startIcon={<Add />}
              onClick={() => setWidgetDialogOpen(true)}
            >
              Add Widget
            </Button>
          </Box>

          {widgets.length === 0 ? (
            <Box
              sx={{
                p: 4,
                textAlign: 'center',
                border: '2px dashed',
                borderColor: 'divider',
                borderRadius: 1,
              }}
            >
              <Typography color="textSecondary">
                No widgets added yet. Click "Add Widget" to get started.
              </Typography>
            </Box>
          ) : (
            <Grid container spacing={2}>
              {widgets.map((widget) => (
                <Grid item xs={12} md={widget.size.width} key={widget.id}>
                  <Paper
                    sx={{
                      p: 2,
                      borderLeft: 4,
                      borderColor: getWidgetColor(widget.type),
                      '&:hover': {
                        boxShadow: 4,
                      },
                    }}
                  >
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <Box sx={{ display: 'flex', alignItems: 'center' }}>
                        <DragIndicator sx={{ mr: 1, color: 'text.secondary', cursor: 'grab' }} />
                        <Box>
                          <Typography variant="subtitle1">{widget.title}</Typography>
                          <Typography variant="caption" color="textSecondary">
                            {WIDGET_TYPES.find((w) => w.value === widget.type)?.label}
                          </Typography>
                        </Box>
                      </Box>
                      <Box>
                        <IconButton
                          size="small"
                          onClick={() => handleConfigureWidget(widget)}
                        >
                          <Settings fontSize="small" />
                        </IconButton>
                        <IconButton
                          size="small"
                          onClick={() => handleRemoveWidget(widget.id)}
                        >
                          <Delete fontSize="small" />
                        </IconButton>
                      </Box>
                    </Box>
                    <Divider sx={{ my: 1 }} />
                    <Typography variant="body2" color="textSecondary">
                      Size: {widget.size.width} x {widget.size.height}
                    </Typography>
                  </Paper>
                </Grid>
              ))}
            </Grid>
          )}
        </CardContent>
      </Card>

      {/* Add Widget Dialog */}
      <Dialog open={widgetDialogOpen} onClose={() => setWidgetDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Add Widget</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Widget Type</InputLabel>
                <Select
                  value={newWidget.type}
                  onChange={(e) => setNewWidget({ ...newWidget, type: e.target.value })}
                  label="Widget Type"
                >
                  {WIDGET_TYPES.map((type) => (
                    <MenuItem key={type.value} value={type.value}>
                      {type.label}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Widget Title"
                value={newWidget.title}
                onChange={(e) => setNewWidget({ ...newWidget, title: e.target.value })}
                helperText="Leave empty to use default title"
              />
            </Grid>
            <Grid item xs={6}>
              <FormControl fullWidth>
                <InputLabel>Width (columns)</InputLabel>
                <Select
                  value={newWidget.width}
                  onChange={(e) => setNewWidget({ ...newWidget, width: Number(e.target.value) })}
                  label="Width (columns)"
                >
                  <MenuItem value={3}>3 (Quarter)</MenuItem>
                  <MenuItem value={4}>4 (Third)</MenuItem>
                  <MenuItem value={6}>6 (Half)</MenuItem>
                  <MenuItem value={8}>8 (Two-thirds)</MenuItem>
                  <MenuItem value={12}>12 (Full)</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={6}>
              <FormControl fullWidth>
                <InputLabel>Height (rows)</InputLabel>
                <Select
                  value={newWidget.height}
                  onChange={(e) => setNewWidget({ ...newWidget, height: Number(e.target.value) })}
                  label="Height (rows)"
                >
                  <MenuItem value={2}>2 (Small)</MenuItem>
                  <MenuItem value={4}>4 (Medium)</MenuItem>
                  <MenuItem value={6}>6 (Large)</MenuItem>
                  <MenuItem value={8}>8 (Extra Large)</MenuItem>
                </Select>
              </FormControl>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setWidgetDialogOpen(false)}>Cancel</Button>
          <Button variant="contained" onClick={handleAddWidget}>
            Add Widget
          </Button>
        </DialogActions>
      </Dialog>

      {/* Configure Widget Dialog */}
      <Dialog open={configDialogOpen} onClose={() => setConfigDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Configure Widget</DialogTitle>
        <DialogContent>
          {selectedWidget && (
            <Grid container spacing={2} sx={{ mt: 1 }}>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  label="Widget Title"
                  value={selectedWidget.title}
                  onChange={(e) =>
                    setSelectedWidget({ ...selectedWidget, title: e.target.value })
                  }
                />
              </Grid>
              <Grid item xs={6}>
                <FormControl fullWidth>
                  <InputLabel>Width (columns)</InputLabel>
                  <Select
                    value={selectedWidget.size.width}
                    onChange={(e) =>
                      setSelectedWidget({
                        ...selectedWidget,
                        size: { ...selectedWidget.size, width: Number(e.target.value) },
                      })
                    }
                    label="Width (columns)"
                  >
                    <MenuItem value={3}>3 (Quarter)</MenuItem>
                    <MenuItem value={4}>4 (Third)</MenuItem>
                    <MenuItem value={6}>6 (Half)</MenuItem>
                    <MenuItem value={8}>8 (Two-thirds)</MenuItem>
                    <MenuItem value={12}>12 (Full)</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={6}>
                <FormControl fullWidth>
                  <InputLabel>Height (rows)</InputLabel>
                  <Select
                    value={selectedWidget.size.height}
                    onChange={(e) =>
                      setSelectedWidget({
                        ...selectedWidget,
                        size: { ...selectedWidget.size, height: Number(e.target.value) },
                      })
                    }
                    label="Height (rows)"
                  >
                    <MenuItem value={2}>2 (Small)</MenuItem>
                    <MenuItem value={4}>4 (Medium)</MenuItem>
                    <MenuItem value={6}>6 (Large)</MenuItem>
                    <MenuItem value={8}>8 (Extra Large)</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
            </Grid>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setConfigDialogOpen(false)}>Cancel</Button>
          <Button variant="contained" onClick={handleSaveWidgetConfig}>
            Save
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default DashboardBuilder;
