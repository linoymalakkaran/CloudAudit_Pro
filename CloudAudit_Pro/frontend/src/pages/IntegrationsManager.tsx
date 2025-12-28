import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Typography,
  Grid,
  TextField,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Switch,
  FormControlLabel,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Alert,
  CircularProgress,
  Tabs,
  Tab,
  List,
  ListItem,
  ListItemText,
  Divider,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  PlayArrow as SyncIcon,
  Stop as DisableIcon,
  CheckCircle as EnableIcon,
  Assessment as StatsIcon,
  Refresh as RefreshIcon,
  Cable as TestIcon,
} from '@mui/icons-material';
import integrationsService, {
  Integration,
  IntegrationLog,
  IntegrationStats,
  CreateIntegrationDto,
} from '../services/integrationsService';

interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

function TabPanel(props: TabPanelProps) {
  const { children, value, index, ...other } = props;
  return (
    <div role="tabpanel" hidden={value !== index} {...other}>
      {value === index && <Box sx={{ py: 3 }}>{children}</Box>}
    </div>
  );
}

const IntegrationsManager: React.FC = () => {
  const [integrations, setIntegrations] = useState<Integration[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string>('');
  const [success, setSuccess] = useState<string>('');
  const [openDialog, setOpenDialog] = useState(false);
  const [selectedIntegration, setSelectedIntegration] = useState<Integration | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [logs, setLogs] = useState<IntegrationLog[]>([]);
  const [stats, setStats] = useState<IntegrationStats | null>(null);
  
  const [formData, setFormData] = useState<CreateIntegrationDto>({
    integrationType: 'ACCOUNTING_SOFTWARE',
    name: '',
    description: '',
    configuration: {},
    syncFrequency: 'HOURLY',
    isActive: true,
  });

  const integrationTypes = [
    'ACCOUNTING_SOFTWARE',
    'ERP',
    'BANK',
    'EMAIL',
    'CLOUD_STORAGE',
    'SSO',
    'API',
    'WEBHOOK',
  ];

  const syncFrequencies = ['REALTIME', 'EVERY_15_MIN', 'HOURLY', 'DAILY', 'WEEKLY', 'MANUAL'];

  useEffect(() => {
    loadIntegrations();
  }, []);

  const loadIntegrations = async () => {
    try {
      setLoading(true);
      const data = await integrationsService.getAll();
      setIntegrations(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load integrations');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (integration?: Integration) => {
    if (integration) {
      setSelectedIntegration(integration);
      setFormData({
        integrationType: integration.integrationType,
        name: integration.name,
        description: integration.description,
        configuration: integration.configuration,
        syncFrequency: integration.syncFrequency,
        isActive: integration.isActive,
      });
    } else {
      setSelectedIntegration(null);
      setFormData({
        integrationType: 'ACCOUNTING_SOFTWARE',
        name: '',
        description: '',
        configuration: {},
        syncFrequency: 'HOURLY',
        isActive: true,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedIntegration(null);
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (selectedIntegration) {
        await integrationsService.update(selectedIntegration.id, formData);
        setSuccess('Integration updated successfully');
      } else {
        await integrationsService.create(formData);
        setSuccess('Integration created successfully');
      }
      handleCloseDialog();
      await loadIntegrations();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save integration');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Delete this integration?')) {
      try {
        await integrationsService.delete(id);
        setSuccess('Integration deleted successfully');
        await loadIntegrations();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete integration');
      }
    }
  };

  const handleTestConnection = async (id: string) => {
    try {
      setLoading(true);
      const result = await integrationsService.testConnection(id);
      if (result.success) {
        setSuccess('Connection test successful');
      } else {
        setError(result.message || 'Connection test failed');
      }
    } catch (err: any) {
      setError(err.response?.data?.message || 'Connection test failed');
    } finally {
      setLoading(false);
    }
  };

  const handleSync = async (id: string) => {
    try {
      setLoading(true);
      await integrationsService.sync(id);
      setSuccess('Sync started successfully');
      await loadIntegrations();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to start sync');
    } finally {
      setLoading(false);
    }
  };

  const handleToggleActive = async (integration: Integration) => {
    try {
      if (integration.isActive) {
        await integrationsService.disable(integration.id);
        setSuccess('Integration disabled');
      } else {
        await integrationsService.enable(integration.id);
        setSuccess('Integration enabled');
      }
      await loadIntegrations();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to toggle integration status');
    }
  };

  const handleViewLogs = async (integration: Integration) => {
    try {
      setLoading(true);
      setSelectedIntegration(integration);
      const logsData = await integrationsService.getLogs(integration.id);
      setLogs(logsData);
      setTabValue(1);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load logs');
    } finally {
      setLoading(false);
    }
  };

  const handleViewStats = async (integration: Integration) => {
    try {
      setLoading(true);
      setSelectedIntegration(integration);
      const statsData = await integrationsService.getStats(integration.id);
      setStats(statsData);
      setTabValue(2);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load stats');
    } finally {
      setLoading(false);
    }
  };

  const getStatusColor = (status: string) => {
    const colors: any = {
      CONNECTED: 'success',
      DISCONNECTED: 'default',
      ERROR: 'error',
      SYNCING: 'info',
    };
    return colors[status] || 'default';
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Integrations Manager</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button variant="outlined" startIcon={<RefreshIcon />} onClick={loadIntegrations}>
            Refresh
          </Button>
          <Button variant="contained" startIcon={<AddIcon />} onClick={() => handleOpenDialog()}>
            Add Integration
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {success && (
        <Alert severity="success" onClose={() => setSuccess('')} sx={{ mb: 2 }}>
          {success}
        </Alert>
      )}

      <Card>
        <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tab label="All Integrations" />
          <Tab label="Activity Logs" disabled={!selectedIntegration} />
          <Tab label="Statistics" disabled={!selectedIntegration} />
        </Tabs>

        <TabPanel value={tabValue} index={0}>
          {renderIntegrationsTable()}
        </TabPanel>
        <TabPanel value={tabValue} index={1}>
          {renderLogs()}
        </TabPanel>
        <TabPanel value={tabValue} index={2}>
          {renderStats()}
        </TabPanel>
      </Card>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{selectedIntegration ? 'Edit Integration' : 'Add Integration'}</DialogTitle>
        <DialogContent>
          <Box sx={{ mt: 2 }}>
            <Grid container spacing={2}>
              <Grid item xs={12} sm={6}>
                <FormControl fullWidth>
                  <InputLabel>Integration Type</InputLabel>
                  <Select
                    value={formData.integrationType}
                    label="Integration Type"
                    onChange={(e) => setFormData({ ...formData, integrationType: e.target.value })}
                  >
                    {integrationTypes.map((type) => (
                      <MenuItem key={type} value={type}>
                        {type.replace('_', ' ')}
                      </MenuItem>
                    ))}
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} sm={6}>
                <TextField
                  fullWidth
                  label="Name"
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
                  rows={2}
                />
              </Grid>
              <Grid item xs={12} sm={6}>
                <FormControl fullWidth>
                  <InputLabel>Sync Frequency</InputLabel>
                  <Select
                    value={formData.syncFrequency}
                    label="Sync Frequency"
                    onChange={(e) => setFormData({ ...formData, syncFrequency: e.target.value })}
                  >
                    {syncFrequencies.map((freq) => (
                      <MenuItem key={freq} value={freq}>
                        {freq.replace('_', ' ')}
                      </MenuItem>
                    ))}
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} sm={6}>
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
                <TextField
                  fullWidth
                  label="Configuration (JSON)"
                  value={JSON.stringify(formData.configuration, null, 2)}
                  onChange={(e) => {
                    try {
                      setFormData({ ...formData, configuration: JSON.parse(e.target.value) });
                    } catch {}
                  }}
                  multiline
                  rows={6}
                  placeholder='{"apiKey": "...", "endpoint": "..."}'
                />
              </Grid>
            </Grid>
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained" disabled={loading || !formData.name}>
            {loading ? <CircularProgress size={24} /> : 'Save'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );

  function renderIntegrationsTable() {
    if (loading && integrations.length === 0) {
      return (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      );
    }

    if (integrations.length === 0) {
      return (
        <Box sx={{ p: 4, textAlign: 'center' }}>
          <Typography variant="h6" color="text.secondary">
            No integrations configured
          </Typography>
        </Box>
      );
    }

    return (
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Name</TableCell>
              <TableCell>Type</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Sync Frequency</TableCell>
              <TableCell>Last Sync</TableCell>
              <TableCell>Active</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {integrations.map((integration) => (
              <TableRow key={integration.id}>
                <TableCell>{integration.name}</TableCell>
                <TableCell>{integration.integrationType.replace('_', ' ')}</TableCell>
                <TableCell>
                  <Chip label={integration.status} color={getStatusColor(integration.status) as any} size="small" />
                </TableCell>
                <TableCell>{integration.syncFrequency?.replace('_', ' ')}</TableCell>
                <TableCell>
                  {integration.lastSyncAt ? new Date(integration.lastSyncAt).toLocaleString() : 'Never'}
                </TableCell>
                <TableCell>
                  <Switch
                    checked={integration.isActive}
                    onChange={() => handleToggleActive(integration)}
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <IconButton size="small" onClick={() => handleTestConnection(integration.id)} title="Test Connection">
                    <TestIcon />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleSync(integration.id)} title="Sync Now">
                    <SyncIcon />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleViewStats(integration)} title="View Stats">
                    <StatsIcon />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleOpenDialog(integration)}>
                    <EditIcon />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleDelete(integration.id)}>
                    <DeleteIcon />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    );
  }

  function renderLogs() {
    if (!selectedIntegration) return null;

    return (
      <Box>
        <Typography variant="h6" sx={{ mb: 2 }}>
          Activity Logs for {selectedIntegration.name}
        </Typography>
        <List>
          {logs.map((log) => (
            <React.Fragment key={log.id}>
              <ListItem>
                <ListItemText
                  primary={log.message}
                  secondary={
                    <>
                      <Typography variant="caption" display="block">
                        {log.logType} - {new Date(log.createdAt).toLocaleString()}
                      </Typography>
                      {log.details && (
                        <Typography variant="caption" color="text.secondary">
                          {JSON.stringify(log.details)}
                        </Typography>
                      )}
                    </>
                  }
                />
              </ListItem>
              <Divider />
            </React.Fragment>
          ))}
        </List>
      </Box>
    );
  }

  function renderStats() {
    if (!selectedIntegration || !stats) return null;

    return (
      <Box>
        <Typography variant="h6" sx={{ mb: 3 }}>
          Statistics for {selectedIntegration.name}
        </Typography>
        <Grid container spacing={3}>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="text.secondary" gutterBottom>
                  Total Syncs
                </Typography>
                <Typography variant="h4">{stats.totalSyncs}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="text.secondary" gutterBottom>
                  Success Rate
                </Typography>
                <Typography variant="h4">{stats.successRate.toFixed(1)}%</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="text.secondary" gutterBottom>
                  Total Records
                </Typography>
                <Typography variant="h4">{stats.totalRecords}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="text.secondary" gutterBottom>
                  Avg Duration
                </Typography>
                <Typography variant="h4">{stats.avgDuration.toFixed(1)}s</Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      </Box>
    );
  }
};

export default IntegrationsManager;
