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
  Tab,
  Tabs,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Alert,
  CircularProgress,
  LinearProgress,
  Stepper,
  Step,
  StepLabel,
} from '@mui/material';
import {
  Upload as UploadIcon,
  Download as DownloadIcon,
  Delete as DeleteIcon,
  Refresh as RefreshIcon,
  CheckCircle as SuccessIcon,
  Error as ErrorIcon,
  Description as FileIcon,
  Undo as RollbackIcon,
} from '@mui/icons-material';
import { dataImportService, dataExportService, DataImport, DataExport } from '../../services/dataTransferService';

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

const DataImportExport: React.FC = () => {
  const [tabValue, setTabValue] = useState(0);
  const [imports, setImports] = useState<DataImport[]>([]);
  const [exports, setExports] = useState<DataExport[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string>('');
  const [success, setSuccess] = useState<string>('');

  // Import dialog state
  const [importDialog, setImportDialog] = useState(false);
  const [importStep, setImportStep] = useState(0);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [importType, setImportType] = useState('ACCOUNTS');
  const [companyId, setCompanyId] = useState('');

  // Export dialog state
  const [exportDialog, setExportDialog] = useState(false);
  const [exportType, setExportType] = useState('ACCOUNTS');
  const [exportFormat, setExportFormat] = useState('EXCEL');

  const importTypes = [
    'ACCOUNTS',
    'TRANSACTIONS',
    'FIXED_ASSETS',
    'LIABILITIES',
    'EQUITY',
    'DOCUMENTS',
    'USERS',
    'OPENING_BALANCES',
    'BUDGETS',
    'CUSTOM',
  ];

  const exportTypes = [
    'ACCOUNTS',
    'TRANSACTIONS',
    'FINANCIAL_STATEMENTS',
    'AUDIT_TRAIL',
    'REPORTS',
    'DOCUMENTS',
    'FULL_BACKUP',
    'CUSTOM',
  ];

  const exportFormats = ['EXCEL', 'CSV', 'JSON'];

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      const [importsData, exportsData] = await Promise.all([
        dataImportService.getAll(),
        dataExportService.getAll(),
      ]);
      setImports(importsData);
      setExports(exportsData);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load data');
    } finally {
      setLoading(false);
    }
  };

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      setSelectedFile(file);
      setImportStep(1);
    }
  };

  const handleImportUpload = async () => {
    if (!selectedFile || !companyId) return;

    try {
      setLoading(true);
      const importRecord = await dataImportService.upload(selectedFile, {
        companyId,
        importType,
      });
      
      // Validate
      await dataImportService.validate(importRecord.id);
      
      // Process
      await dataImportService.process(importRecord.id);
      
      setSuccess('Import completed successfully');
      setImportDialog(false);
      resetImportDialog();
      await loadData();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Import failed');
    } finally {
      setLoading(false);
    }
  };

  const handleExportCreate = async () => {
    if (!companyId) return;

    try {
      setLoading(true);
      const blob = await dataExportService.quickExport({
        companyId,
        exportType,
        format: exportFormat,
      });

      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      const ext = exportFormat === 'EXCEL' ? 'xlsx' : exportFormat.toLowerCase();
      link.download = `${exportType.toLowerCase()}_${new Date().toISOString().split('T')[0]}.${ext}`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);

      setSuccess('Export completed successfully');
      setExportDialog(false);
      await loadData();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Export failed');
    } finally {
      setLoading(false);
    }
  };

  const handleImportDelete = async (id: string) => {
    if (window.confirm('Delete this import record?')) {
      try {
        await dataImportService.delete(id);
        setSuccess('Import deleted successfully');
        await loadData();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete import');
      }
    }
  };

  const handleImportRollback = async (id: string) => {
    if (window.confirm('Rollback this import? This will delete all imported records.')) {
      try {
        await dataImportService.rollback(id);
        setSuccess('Import rolled back successfully');
        await loadData();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to rollback import');
      }
    }
  };

  const handleExportDelete = async (id: string) => {
    if (window.confirm('Delete this export record?')) {
      try {
        await dataExportService.delete(id);
        setSuccess('Export deleted successfully');
        await loadData();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete export');
      }
    }
  };

  const handleDownloadTemplate = async () => {
    try {
      const blob = await dataImportService.getTemplate(importType);
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `${importType.toLowerCase()}_template.csv`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to download template');
    }
  };

  const handleDownloadExport = async (exportRecord: DataExport) => {
    try {
      const blob = await dataExportService.download(exportRecord.id);
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = exportRecord.fileName || `export_${exportRecord.id}`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to download export');
    }
  };

  const handleDownloadErrors = async (id: string) => {
    try {
      const blob = await dataImportService.downloadErrors(id);
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `import_errors_${id}.csv`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to download errors');
    }
  };

  const resetImportDialog = () => {
    setImportStep(0);
    setSelectedFile(null);
    setImportType('ACCOUNTS');
    setCompanyId('');
  };

  const getStatusColor = (status: string) => {
    const colors: any = {
      PENDING: 'default',
      PROCESSING: 'info',
      COMPLETED: 'success',
      FAILED: 'error',
      VALIDATED: 'warning',
    };
    return colors[status] || 'default';
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Data Import/Export</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button variant="outlined" startIcon={<RefreshIcon />} onClick={loadData}>
            Refresh
          </Button>
          <Button variant="outlined" startIcon={<DownloadIcon />} onClick={() => setExportDialog(true)}>
            Export Data
          </Button>
          <Button variant="contained" startIcon={<UploadIcon />} onClick={() => setImportDialog(true)}>
            Import Data
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
          <Tab label="Import History" />
          <Tab label="Export History" />
        </Tabs>

        <TabPanel value={tabValue} index={0}>
          {renderImportsTable()}
        </TabPanel>
        <TabPanel value={tabValue} index={1}>
          {renderExportsTable()}
        </TabPanel>
      </Card>

      {/* Import Dialog */}
      <Dialog open={importDialog} onClose={() => setImportDialog(false)} maxWidth="md" fullWidth>
        <DialogTitle>Import Data</DialogTitle>
        <DialogContent>
          <Box sx={{ mt: 2 }}>
            <Stepper activeStep={importStep} sx={{ mb: 3 }}>
              <Step><StepLabel>Select File</StepLabel></Step>
              <Step><StepLabel>Configure</StepLabel></Step>
              <Step><StepLabel>Process</StepLabel></Step>
            </Stepper>

            {importStep === 0 && (
              <Box>
                <FormControl fullWidth sx={{ mb: 2 }}>
                  <InputLabel>Import Type</InputLabel>
                  <Select value={importType} label="Import Type" onChange={(e) => setImportType(e.target.value)}>
                    {importTypes.map((type) => (
                      <MenuItem key={type} value={type}>{type}</MenuItem>
                    ))}
                  </Select>
                </FormControl>
                <Button variant="outlined" onClick={handleDownloadTemplate} fullWidth sx={{ mb: 2 }}>
                  Download Template
                </Button>
                <Button variant="contained" component="label" fullWidth>
                  Select File
                  <input type="file" accept=".csv,.xlsx,.xls" hidden onChange={handleFileSelect} />
                </Button>
              </Box>
            )}

            {importStep === 1 && (
              <Box>
                <Typography variant="body2" sx={{ mb: 2 }}>
                  File: {selectedFile?.name}
                </Typography>
                <TextField
                  fullWidth
                  label="Company ID"
                  value={companyId}
                  onChange={(e) => setCompanyId(e.target.value)}
                  required
                  sx={{ mb: 2 }}
                />
              </Box>
            )}
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setImportDialog(false)}>Cancel</Button>
          {importStep === 1 && (
            <Button onClick={handleImportUpload} variant="contained" disabled={loading || !companyId}>
              {loading ? <CircularProgress size={24} /> : 'Import'}
            </Button>
          )}
        </DialogActions>
      </Dialog>

      {/* Export Dialog */}
      <Dialog open={exportDialog} onClose={() => setExportDialog(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Export Data</DialogTitle>
        <DialogContent>
          <Box sx={{ mt: 2 }}>
            <FormControl fullWidth sx={{ mb: 2 }}>
              <InputLabel>Export Type</InputLabel>
              <Select value={exportType} label="Export Type" onChange={(e) => setExportType(e.target.value)}>
                {exportTypes.map((type) => (
                  <MenuItem key={type} value={type}>{type}</MenuItem>
                ))}
              </Select>
            </FormControl>
            <FormControl fullWidth sx={{ mb: 2 }}>
              <InputLabel>Format</InputLabel>
              <Select value={exportFormat} label="Format" onChange={(e) => setExportFormat(e.target.value)}>
                {exportFormats.map((format) => (
                  <MenuItem key={format} value={format}>{format}</MenuItem>
                ))}
              </Select>
            </FormControl>
            <TextField
              fullWidth
              label="Company ID"
              value={companyId}
              onChange={(e) => setCompanyId(e.target.value)}
              required
            />
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setExportDialog(false)}>Cancel</Button>
          <Button onClick={handleExportCreate} variant="contained" disabled={loading || !companyId}>
            {loading ? <CircularProgress size={24} /> : 'Export'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );

  function renderImportsTable() {
    if (loading && imports.length === 0) {
      return <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}><CircularProgress /></Box>;
    }

    return (
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Type</TableCell>
              <TableCell>File Name</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Records</TableCell>
              <TableCell>Date</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {imports.map((imp) => (
              <TableRow key={imp.id}>
                <TableCell>{imp.importType}</TableCell>
                <TableCell>{imp.fileName}</TableCell>
                <TableCell>
                  <Chip label={imp.status} color={getStatusColor(imp.status) as any} size="small" />
                </TableCell>
                <TableCell>
                  {imp.recordsProcessed}/{imp.recordsTotal}
                  {imp.recordsFailed > 0 && <Chip label={`${imp.recordsFailed} failed`} color="error" size="small" sx={{ ml: 1 }} />}
                </TableCell>
                <TableCell>{new Date(imp.createdAt).toLocaleString()}</TableCell>
                <TableCell>
                  {imp.status === 'COMPLETED' && imp.recordsFailed > 0 && (
                    <IconButton size="small" onClick={() => handleDownloadErrors(imp.id)} title="Download Errors">
                      <ErrorIcon />
                    </IconButton>
                  )}
                  {imp.status === 'COMPLETED' && (
                    <IconButton size="small" onClick={() => handleImportRollback(imp.id)} title="Rollback">
                      <RollbackIcon />
                    </IconButton>
                  )}
                  <IconButton size="small" onClick={() => handleImportDelete(imp.id)}>
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

  function renderExportsTable() {
    if (loading && exports.length === 0) {
      return <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}><CircularProgress /></Box>;
    }

    return (
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Type</TableCell>
              <TableCell>Format</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Records</TableCell>
              <TableCell>Date</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {exports.map((exp) => (
              <TableRow key={exp.id}>
                <TableCell>{exp.exportType}</TableCell>
                <TableCell>{exp.format}</TableCell>
                <TableCell>
                  <Chip label={exp.status} color={getStatusColor(exp.status) as any} size="small" />
                </TableCell>
                <TableCell>{exp.recordsCount || 0}</TableCell>
                <TableCell>{new Date(exp.createdAt).toLocaleString()}</TableCell>
                <TableCell>
                  {exp.status === 'COMPLETED' && (
                    <IconButton size="small" onClick={() => handleDownloadExport(exp)} title="Download">
                      <DownloadIcon />
                    </IconButton>
                  )}
                  <IconButton size="small" onClick={() => handleExportDelete(exp.id)}>
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
};

export default DataImportExport;
