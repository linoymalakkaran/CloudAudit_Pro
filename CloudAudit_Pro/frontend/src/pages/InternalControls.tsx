import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Chip,
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
  Tabs,
  Tab,
  Accordion,
  AccordionSummary,
  AccordionDetails,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Assessment as TestIcon,
  ExpandMore as ExpandMoreIcon,
  Warning as DeficiencyIcon,
  CheckCircle as EffectiveIcon,
} from '@mui/icons-material';
import internalControlsService, { InternalControl, CreateInternalControlDto } from '../services/internalControlsService';

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

const InternalControls: React.FC = () => {
  const [controls, setControls] = useState<InternalControl[]>([]);
  const [deficiencies, setDeficiencies] = useState<InternalControl[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openTestDialog, setOpenTestDialog] = useState(false);
  const [selectedControl, setSelectedControl] = useState<InternalControl | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [summary, setSummary] = useState<any>(null);
  const [error, setError] = useState<string>('');
  const [groupedControls, setGroupedControls] = useState<{ [key: string]: InternalControl[] }>({});

  const [formData, setFormData] = useState<CreateInternalControlDto>({
    companyId: localStorage.getItem('selectedCompanyId') || '',
    periodId: localStorage.getItem('selectedPeriodId') || '',
    processArea: '',
    controlId: '',
    title: '',
    controlObjective: '',
    controlType: 'PREVENTIVE',
    controlNature: 'MANUAL',
    controlFrequency: 'DAILY',
    riskAddressed: '',
    riskLevel: 'MEDIUM',
    controlOwner: '',
    isKeyControl: false,
  });

  const [testData, setTestData] = useState({
    testProcedures: '',
    testResult: '',
    controlEffectiveness: 'EFFECTIVE',
    deficiencyIdentified: false,
    deficiencyDescription: '',
  });

  useEffect(() => {
    loadControls();
    loadSummary();
    loadDeficiencies();
  }, []);

  useEffect(() => {
    // Group controls by process area
    const grouped = controls.reduce((acc, control) => {
      const area = control.processArea;
      if (!acc[area]) acc[area] = [];
      acc[area].push(control);
      return acc;
    }, {} as { [key: string]: InternalControl[] });
    setGroupedControls(grouped);
  }, [controls]);

  const loadControls = async () => {
    try {
      setLoading(true);
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await internalControlsService.getAll(companyId, periodId || undefined);
      setControls(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load controls');
    } finally {
      setLoading(false);
    }
  };

  const loadSummary = async () => {
    try {
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await internalControlsService.getSummary(companyId, periodId || undefined);
      setSummary(data);
    } catch (err) {
      console.error('Failed to load summary:', err);
    }
  };

  const loadDeficiencies = async () => {
    try {
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await internalControlsService.getDeficiencies(companyId, periodId || undefined);
      setDeficiencies(data);
    } catch (err) {
      console.error('Failed to load deficiencies:', err);
    }
  };

  const handleOpenDialog = (control?: InternalControl) => {
    if (control) {
      setSelectedControl(control);
      setFormData({
        companyId: control.companyId,
        periodId: control.periodId,
        processArea: control.processArea,
        controlId: control.controlId,
        title: control.title,
        description: control.description,
        controlObjective: control.controlObjective,
        controlType: control.controlType,
        controlNature: control.controlNature,
        controlFrequency: control.controlFrequency,
        riskAddressed: control.riskAddressed,
        riskLevel: control.riskLevel,
        controlOwner: control.controlOwner,
        isKeyControl: control.isKeyControl,
        testProcedures: control.testProcedures,
      });
    } else {
      setSelectedControl(null);
      setFormData({
        companyId: localStorage.getItem('selectedCompanyId') || '',
        periodId: localStorage.getItem('selectedPeriodId') || '',
        processArea: '',
        controlId: '',
        title: '',
        controlObjective: '',
        controlType: 'PREVENTIVE',
        controlNature: 'MANUAL',
        controlFrequency: 'DAILY',
        riskAddressed: '',
        riskLevel: 'MEDIUM',
        controlOwner: '',
        isKeyControl: false,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedControl(null);
  };

  const handleOpenTestDialog = (control: InternalControl) => {
    setSelectedControl(control);
    setTestData({
      testProcedures: control.testProcedures || '',
      testResult: control.testResult || '',
      controlEffectiveness: control.controlEffectiveness || 'EFFECTIVE',
      deficiencyIdentified: control.deficiencyIdentified,
      deficiencyDescription: control.deficiencyDescription || '',
    });
    setOpenTestDialog(true);
  };

  const handleCloseTestDialog = () => {
    setOpenTestDialog(false);
    setSelectedControl(null);
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (selectedControl) {
        await internalControlsService.update(selectedControl.id, formData);
      } else {
        await internalControlsService.create(formData);
      }
      await loadControls();
      await loadSummary();
      handleCloseDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save control');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this control?')) {
      try {
        setLoading(true);
        await internalControlsService.delete(id);
        await loadControls();
        await loadSummary();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete control');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleSaveTest = async () => {
    if (!selectedControl) return;
    try {
      setLoading(true);
      await internalControlsService.testControl(selectedControl.id, testData);
      await loadControls();
      await loadSummary();
      await loadDeficiencies();
      handleCloseTestDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save test results');
    } finally {
      setLoading(false);
    }
  };

  const getEffectivenessColor = (effectiveness?: string) => {
    const colors: any = {
      EFFECTIVE: 'success',
      PARTIALLY_EFFECTIVE: 'warning',
      INEFFECTIVE: 'error',
      NOT_TESTED: 'default',
    };
    return colors[effectiveness || 'NOT_TESTED'] || 'default';
  };

  const getRiskLevelColor = (level: string) => {
    const colors: any = {
      LOW: 'info',
      MEDIUM: 'warning',
      HIGH: 'error',
      CRITICAL: 'error',
    };
    return colors[level] || 'default';
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Internal Controls Assessment</Typography>
        <Button variant="contained" startIcon={<AddIcon />} onClick={() => handleOpenDialog()}>
          New Control
        </Button>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ mb: 2 }}>
        <Tab label="All Controls" />
        <Tab label="Deficiencies" icon={<DeficiencyIcon />} iconPosition="end" />
        <Tab label="Summary" />
      </Tabs>

      <TabPanel value={tabValue} index={0}>
        {loading ? (
          <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
            <CircularProgress />
          </Box>
        ) : (
          <Box>
            {Object.keys(groupedControls).length === 0 ? (
              <Alert severity="info">No controls found. Create your first control to get started.</Alert>
            ) : (
              Object.entries(groupedControls).map(([processArea, areaControls]) => (
                <Accordion key={processArea} defaultExpanded={Object.keys(groupedControls).length === 1}>
                  <AccordionSummary expandIcon={<ExpandMoreIcon />}>
                    <Typography variant="h6">
                      {processArea} ({areaControls.length})
                    </Typography>
                  </AccordionSummary>
                  <AccordionDetails>
                    <TableContainer component={Paper}>
                      <Table size="small">
                        <TableHead>
                          <TableRow>
                            <TableCell>Control ID</TableCell>
                            <TableCell>Title</TableCell>
                            <TableCell>Type</TableCell>
                            <TableCell>Frequency</TableCell>
                            <TableCell>Risk Level</TableCell>
                            <TableCell>Key Control</TableCell>
                            <TableCell>Effectiveness</TableCell>
                            <TableCell align="center">Actions</TableCell>
                          </TableRow>
                        </TableHead>
                        <TableBody>
                          {areaControls.map((control) => (
                            <TableRow key={control.id}>
                              <TableCell>{control.controlId}</TableCell>
                              <TableCell>{control.title}</TableCell>
                              <TableCell>{control.controlType}</TableCell>
                              <TableCell>{control.controlFrequency}</TableCell>
                              <TableCell>
                                <Chip
                                  label={control.riskLevel}
                                  color={getRiskLevelColor(control.riskLevel) as any}
                                  size="small"
                                />
                              </TableCell>
                              <TableCell>{control.isKeyControl ? <EffectiveIcon color="primary" /> : '-'}</TableCell>
                              <TableCell>
                                <Chip
                                  label={control.controlEffectiveness?.replace(/_/g, ' ') || 'NOT TESTED'}
                                  color={getEffectivenessColor(control.controlEffectiveness) as any}
                                  size="small"
                                />
                              </TableCell>
                              <TableCell align="center">
                                <IconButton size="small" onClick={() => handleOpenDialog(control)} title="Edit">
                                  <EditIcon />
                                </IconButton>
                                <IconButton size="small" onClick={() => handleOpenTestDialog(control)} title="Test">
                                  <TestIcon />
                                </IconButton>
                                <IconButton size="small" onClick={() => handleDelete(control.id)} title="Delete">
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
              ))
            )}
          </Box>
        )}
      </TabPanel>

      <TabPanel value={tabValue} index={1}>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Control ID</TableCell>
                <TableCell>Title</TableCell>
                <TableCell>Process Area</TableCell>
                <TableCell>Effectiveness</TableCell>
                <TableCell>Deficiency Description</TableCell>
                <TableCell>Remediation Status</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {deficiencies.map((control) => (
                <TableRow key={control.id}>
                  <TableCell>{control.controlId}</TableCell>
                  <TableCell>{control.title}</TableCell>
                  <TableCell>{control.processArea}</TableCell>
                  <TableCell>
                    <Chip
                      label={control.controlEffectiveness?.replace(/_/g, ' ')}
                      color={getEffectivenessColor(control.controlEffectiveness) as any}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>{control.deficiencyDescription}</TableCell>
                  <TableCell>{control.remediationPlan ? 'Planned' : 'Pending'}</TableCell>
                </TableRow>
              ))}
              {deficiencies.length === 0 && (
                <TableRow>
                  <TableCell colSpan={6} align="center">
                    No deficiencies found
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </TableContainer>
      </TabPanel>

      <TabPanel value={tabValue} index={2}>
        {summary && (
          <Grid container spacing={3}>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Total Controls
                  </Typography>
                  <Typography variant="h4">{summary.totalControls || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Key Controls
                  </Typography>
                  <Typography variant="h4">{summary.keyControls || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Effective Controls
                  </Typography>
                  <Typography variant="h4" color="success.main">
                    {summary.effectiveControls || 0}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Deficiencies
                  </Typography>
                  <Typography variant="h4" color="error">
                    {summary.deficiencies || 0}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        )}
      </TabPanel>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{selectedControl ? 'Edit' : 'Create'} Control</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Process Area"
                value={formData.processArea}
                onChange={(e) => setFormData({ ...formData, processArea: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Control ID"
                value={formData.controlId}
                onChange={(e) => setFormData({ ...formData, controlId: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Title"
                value={formData.title}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Description"
                multiline
                rows={2}
                value={formData.description || ''}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Control Objective"
                value={formData.controlObjective}
                onChange={(e) => setFormData({ ...formData, controlObjective: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <FormControl fullWidth>
                <InputLabel>Control Type</InputLabel>
                <Select
                  value={formData.controlType}
                  label="Control Type"
                  onChange={(e) => setFormData({ ...formData, controlType: e.target.value })}
                >
                  <MenuItem value="PREVENTIVE">Preventive</MenuItem>
                  <MenuItem value="DETECTIVE">Detective</MenuItem>
                  <MenuItem value="CORRECTIVE">Corrective</MenuItem>
                  <MenuItem value="DIRECTIVE">Directive</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={4}>
              <FormControl fullWidth>
                <InputLabel>Control Nature</InputLabel>
                <Select
                  value={formData.controlNature}
                  label="Control Nature"
                  onChange={(e) => setFormData({ ...formData, controlNature: e.target.value })}
                >
                  <MenuItem value="MANUAL">Manual</MenuItem>
                  <MenuItem value="AUTOMATED">Automated</MenuItem>
                  <MenuItem value="IT_DEPENDENT">IT Dependent</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={4}>
              <FormControl fullWidth>
                <InputLabel>Frequency</InputLabel>
                <Select
                  value={formData.controlFrequency}
                  label="Frequency"
                  onChange={(e) => setFormData({ ...formData, controlFrequency: e.target.value })}
                >
                  <MenuItem value="CONTINUOUS">Continuous</MenuItem>
                  <MenuItem value="DAILY">Daily</MenuItem>
                  <MenuItem value="WEEKLY">Weekly</MenuItem>
                  <MenuItem value="MONTHLY">Monthly</MenuItem>
                  <MenuItem value="QUARTERLY">Quarterly</MenuItem>
                  <MenuItem value="ANNUALLY">Annually</MenuItem>
                  <MenuItem value="AD_HOC">Ad Hoc</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Risk Addressed"
                value={formData.riskAddressed}
                onChange={(e) => setFormData({ ...formData, riskAddressed: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Risk Level</InputLabel>
                <Select
                  value={formData.riskLevel}
                  label="Risk Level"
                  onChange={(e) => setFormData({ ...formData, riskLevel: e.target.value })}
                >
                  <MenuItem value="LOW">Low</MenuItem>
                  <MenuItem value="MEDIUM">Medium</MenuItem>
                  <MenuItem value="HIGH">High</MenuItem>
                  <MenuItem value="CRITICAL">Critical</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Control Owner"
                value={formData.controlOwner}
                onChange={(e) => setFormData({ ...formData, controlOwner: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Switch
                    checked={formData.isKeyControl}
                    onChange={(e) => setFormData({ ...formData, isKeyControl: e.target.checked })}
                  />
                }
                label="Key Control"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained" disabled={loading || !formData.title}>
            {loading ? <CircularProgress size={24} /> : 'Save'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Test Control Dialog */}
      <Dialog open={openTestDialog} onClose={handleCloseTestDialog} maxWidth="md" fullWidth>
        <DialogTitle>Test Control</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Test Procedures"
                multiline
                rows={3}
                value={testData.testProcedures}
                onChange={(e) => setTestData({ ...testData, testProcedures: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Test Result"
                multiline
                rows={3}
                value={testData.testResult}
                onChange={(e) => setTestData({ ...testData, testResult: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Control Effectiveness</InputLabel>
                <Select
                  value={testData.controlEffectiveness}
                  label="Control Effectiveness"
                  onChange={(e) => setTestData({ ...testData, controlEffectiveness: e.target.value })}
                >
                  <MenuItem value="EFFECTIVE">Effective</MenuItem>
                  <MenuItem value="PARTIALLY_EFFECTIVE">Partially Effective</MenuItem>
                  <MenuItem value="INEFFECTIVE">Ineffective</MenuItem>
                  <MenuItem value="NOT_TESTED">Not Tested</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControlLabel
                control={
                  <Switch
                    checked={testData.deficiencyIdentified}
                    onChange={(e) => setTestData({ ...testData, deficiencyIdentified: e.target.checked })}
                  />
                }
                label="Deficiency Identified"
              />
            </Grid>
            {testData.deficiencyIdentified && (
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  label="Deficiency Description"
                  multiline
                  rows={3}
                  value={testData.deficiencyDescription}
                  onChange={(e) => setTestData({ ...testData, deficiencyDescription: e.target.value })}
                  required
                />
              </Grid>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseTestDialog}>Cancel</Button>
          <Button onClick={handleSaveTest} variant="contained" disabled={loading}>
            {loading ? <CircularProgress size={24} /> : 'Save Test Results'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default InternalControls;
