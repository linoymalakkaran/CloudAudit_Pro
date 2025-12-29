import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  FormControlLabel,
  Grid,
  IconButton,
  InputLabel,
  MenuItem,
  Paper,
  Select,
  Switch,
  Tab,
  Tabs,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
  Typography,
  Alert,
  CircularProgress,
  Accordion,
  AccordionSummary,
  AccordionDetails,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Save as SaveIcon,
  Refresh as RefreshIcon,
  CloudUpload as UploadIcon,
  CloudDownload as DownloadIcon,
  ExpandMore as ExpandMoreIcon,
} from '@mui/icons-material';
import systemConfigService, { SystemConfiguration, CreateConfigDto } from '../../services/systemConfigService';

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

const SystemSettings: React.FC = () => {
  const [configs, setConfigs] = useState<SystemConfiguration[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [selectedConfig, setSelectedConfig] = useState<SystemConfiguration | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [error, setError] = useState<string>('');
  const [groupedConfigs, setGroupedConfigs] = useState<{ [key: string]: SystemConfiguration[] }>({});

  const [formData, setFormData] = useState<CreateConfigDto>({
    configKey: '',
    configValue: '',
    category: 'GENERAL',
    description: '',
    dataType: 'STRING',
    isEncrypted: false,
  });

  const categories = [
    'GENERAL',
    'SECURITY',
    'EMAIL',
    'STORAGE',
    'INTEGRATION',
    'NOTIFICATION',
    'AUDIT',
    'PERFORMANCE',
  ];

  const dataTypes = ['STRING', 'NUMBER', 'BOOLEAN', 'JSON', 'ARRAY'];

  useEffect(() => {
    loadConfigs();
  }, []);

  useEffect(() => {
    const grouped = configs.reduce((acc, config) => {
      const cat = config.category;
      if (!acc[cat]) acc[cat] = [];
      acc[cat].push(config);
      return acc;
    }, {} as { [key: string]: SystemConfiguration[] });
    setGroupedConfigs(grouped);
  }, [configs]);

  const loadConfigs = async () => {
    try {
      setLoading(true);
      const data = await systemConfigService.getAll();
      setConfigs(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load configurations');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (config?: SystemConfiguration) => {
    if (config) {
      setSelectedConfig(config);
      setFormData({
        configKey: config.configKey,
        configValue: config.configValue,
        category: config.category,
        description: config.description,
        dataType: config.dataType,
        isEncrypted: config.isEncrypted,
      });
    } else {
      setSelectedConfig(null);
      setFormData({
        configKey: '',
        configValue: '',
        category: 'GENERAL',
        description: '',
        dataType: 'STRING',
        isEncrypted: false,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedConfig(null);
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (selectedConfig) {
        await systemConfigService.update(selectedConfig.configKey, formData);
      } else {
        await systemConfigService.create(formData);
      }
      await loadConfigs();
      handleCloseDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save configuration');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (key: string) => {
    if (window.confirm('Are you sure you want to delete this configuration?')) {
      try {
        setLoading(true);
        await systemConfigService.delete(key);
        await loadConfigs();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete configuration');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleExport = async () => {
    try {
      const blob = await systemConfigService.exportConfigs();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `system-config-${Date.now()}.json`;
      a.click();
      window.URL.revokeObjectURL(url);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to export configurations');
    }
  };

  const handleImport = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;

    try {
      setLoading(true);
      await systemConfigService.importConfigs(file);
      await loadConfigs();
      alert('Configurations imported successfully');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to import configurations');
    } finally {
      setLoading(false);
    }
  };

  const handleResetToDefaults = async () => {
    if (window.confirm('Reset all configurations to defaults? This cannot be undone.')) {
      try {
        setLoading(true);
        await systemConfigService.resetToDefaults();
        await loadConfigs();
        alert('Configurations reset to defaults');
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to reset configurations');
      } finally {
        setLoading(false);
      }
    }
  };

  const renderValue = (config: SystemConfiguration) => {
    if (config.isEncrypted) {
      return '••••••••';
    }
    if (config.dataType === 'BOOLEAN') {
      return config.configValue ? 'Yes' : 'No';
    }
    if (config.dataType === 'JSON' || config.dataType === 'ARRAY') {
      return JSON.stringify(config.configValue).substring(0, 50) + '...';
    }
    return String(config.configValue);
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">System Settings</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button variant="outlined" startIcon={<DownloadIcon />} onClick={handleExport}>
            Export
          </Button>
          <Button variant="outlined" component="label" startIcon={<UploadIcon />}>
            Import
            <input type="file" hidden accept=".json" onChange={handleImport} />
          </Button>
          <Button variant="outlined" startIcon={<RefreshIcon />} onClick={handleResetToDefaults}>
            Reset to Defaults
          </Button>
          <Button variant="contained" startIcon={<AddIcon />} onClick={() => handleOpenDialog()}>
            New Setting
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ mb: 2 }}>
        <Tab label="All Settings" />
        <Tab label="By Category" />
      </Tabs>

      <TabPanel value={tabValue} index={0}>
        {loading ? (
          <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
            <CircularProgress />
          </Box>
        ) : (
          <TableContainer component={Paper}>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>Key</TableCell>
                  <TableCell>Category</TableCell>
                  <TableCell>Value</TableCell>
                  <TableCell>Type</TableCell>
                  <TableCell>Description</TableCell>
                  <TableCell align="center">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {configs.map((config) => (
                  <TableRow key={config.id}>
                    <TableCell>
                      <code>{config.configKey}</code>
                    </TableCell>
                    <TableCell>{config.category}</TableCell>
                    <TableCell>{renderValue(config)}</TableCell>
                    <TableCell>{config.dataType}</TableCell>
                    <TableCell>{config.description || '-'}</TableCell>
                    <TableCell align="center">
                      <IconButton size="small" onClick={() => handleOpenDialog(config)} title="Edit">
                        <EditIcon />
                      </IconButton>
                      <IconButton size="small" onClick={() => handleDelete(config.configKey)} title="Delete">
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
                {configs.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={6} align="center">
                      No configurations found
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        )}
      </TabPanel>

      <TabPanel value={tabValue} index={1}>
        {Object.entries(groupedConfigs).map(([category, categoryConfigs]) => (
          <Accordion key={category} defaultExpanded>
            <AccordionSummary expandIcon={<ExpandMoreIcon />}>
              <Typography variant="h6">
                {category} ({categoryConfigs.length})
              </Typography>
            </AccordionSummary>
            <AccordionDetails>
              <TableContainer>
                <Table size="small">
                  <TableHead>
                    <TableRow>
                      <TableCell>Key</TableCell>
                      <TableCell>Value</TableCell>
                      <TableCell>Type</TableCell>
                      <TableCell>Description</TableCell>
                      <TableCell align="center">Actions</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {categoryConfigs.map((config) => (
                      <TableRow key={config.id}>
                        <TableCell>
                          <code>{config.configKey}</code>
                        </TableCell>
                        <TableCell>{renderValue(config)}</TableCell>
                        <TableCell>{config.dataType}</TableCell>
                        <TableCell>{config.description || '-'}</TableCell>
                        <TableCell align="center">
                          <IconButton size="small" onClick={() => handleOpenDialog(config)} title="Edit">
                            <EditIcon />
                          </IconButton>
                          <IconButton size="small" onClick={() => handleDelete(config.configKey)} title="Delete">
                            <DeleteIcon />
                          </IconButton>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </AccordionDetails>
          </Accordion>
        ))}
      </TabPanel>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="sm" fullWidth>
        <DialogTitle>{selectedConfig ? 'Edit' : 'Create'} Configuration</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Configuration Key"
                value={formData.configKey}
                onChange={(e) => setFormData({ ...formData, configKey: e.target.value })}
                required
                disabled={!!selectedConfig}
                helperText="Use dot notation (e.g., email.smtp.host)"
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={formData.category}
                  label="Category"
                  onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                >
                  {categories.map((cat) => (
                    <MenuItem key={cat} value={cat}>
                      {cat}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Data Type</InputLabel>
                <Select
                  value={formData.dataType}
                  label="Data Type"
                  onChange={(e) => setFormData({ ...formData, dataType: e.target.value })}
                >
                  {dataTypes.map((type) => (
                    <MenuItem key={type} value={type}>
                      {type}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Value"
                value={formData.configValue}
                onChange={(e) => setFormData({ ...formData, configValue: e.target.value })}
                multiline={formData.dataType === 'JSON' || formData.dataType === 'ARRAY'}
                rows={formData.dataType === 'JSON' || formData.dataType === 'ARRAY' ? 4 : 1}
                required
                helperText={
                  formData.dataType === 'JSON' || formData.dataType === 'ARRAY'
                    ? 'Enter valid JSON'
                    : 'Configuration value'
                }
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
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Switch
                    checked={formData.isEncrypted}
                    onChange={(e) => setFormData({ ...formData, isEncrypted: e.target.checked })}
                  />
                }
                label="Encrypt this value"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained" disabled={loading || !formData.configKey}>
            {loading ? <CircularProgress size={24} /> : 'Save'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default SystemSettings;
