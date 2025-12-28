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
  Grid,
  IconButton,
  InputLabel,
  MenuItem,
  Paper,
  Select,
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
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Calculate as CalculateIcon,
  PlayArrow as GenerateIcon,
  Assessment as AssessmentIcon,
} from '@mui/icons-material';
import samplingService, { Sampling, CreateSamplingDto } from '../services/samplingService';

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

const SamplingPlan: React.FC = () => {
  const [samplings, setSamplings] = useState<Sampling[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [selectedSampling, setSelectedSampling] = useState<Sampling | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [summary, setSummary] = useState<any>(null);
  const [error, setError] = useState<string>('');
  const [calculatedSampleSize, setCalculatedSampleSize] = useState<number | null>(null);

  const [formData, setFormData] = useState<CreateSamplingDto>({
    companyId: localStorage.getItem('selectedCompanyId') || '',
    periodId: localStorage.getItem('selectedPeriodId') || '',
    title: '',
    samplingMethod: 'RANDOM',
    populationSize: 0,
    confidenceLevel: 95,
    tolerableError: 5,
    expectedError: 1,
  });

  useEffect(() => {
    loadSamplings();
    loadSummary();
  }, []);

  const loadSamplings = async () => {
    try {
      setLoading(true);
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await samplingService.getAll(companyId, periodId || undefined);
      setSamplings(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load sampling plans');
    } finally {
      setLoading(false);
    }
  };

  const loadSummary = async () => {
    try {
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await samplingService.getSummary(companyId, periodId || undefined);
      setSummary(data);
    } catch (err) {
      console.error('Failed to load summary:', err);
    }
  };

  const handleOpenDialog = (sampling?: Sampling) => {
    if (sampling) {
      setSelectedSampling(sampling);
      setFormData({
        companyId: sampling.companyId,
        periodId: sampling.periodId,
        procedureId: sampling.procedureId,
        accountId: sampling.accountId,
        title: sampling.title,
        description: sampling.description,
        samplingMethod: sampling.samplingMethod,
        populationSize: sampling.populationSize,
        confidenceLevel: sampling.confidenceLevel,
        tolerableError: sampling.tolerableError,
        expectedError: sampling.expectedError,
        stratificationBasis: sampling.stratificationBasis,
      });
    } else {
      setSelectedSampling(null);
      setFormData({
        companyId: localStorage.getItem('selectedCompanyId') || '',
        periodId: localStorage.getItem('selectedPeriodId') || '',
        title: '',
        samplingMethod: 'RANDOM',
        populationSize: 0,
        confidenceLevel: 95,
        tolerableError: 5,
        expectedError: 1,
      });
      setCalculatedSampleSize(null);
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedSampling(null);
    setCalculatedSampleSize(null);
  };

  const handleCalculateSampleSize = async () => {
    try {
      const result = await samplingService.calculateSampleSize({
        populationSize: formData.populationSize,
        confidenceLevel: formData.confidenceLevel,
        tolerableError: formData.tolerableError,
        expectedError: formData.expectedError,
      });
      setCalculatedSampleSize(result.sampleSize);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to calculate sample size');
    }
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (selectedSampling) {
        await samplingService.update(selectedSampling.id, formData);
      } else {
        await samplingService.create(formData);
      }
      await loadSamplings();
      await loadSummary();
      handleCloseDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save sampling plan');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this sampling plan?')) {
      try {
        setLoading(true);
        await samplingService.delete(id);
        await loadSamplings();
        await loadSummary();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete sampling plan');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleGenerateSample = async (id: string) => {
    try {
      setLoading(true);
      await samplingService.generateSample(id);
      await loadSamplings();
      alert('Sample generated successfully!');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to generate sample');
    } finally {
      setLoading(false);
    }
  };

  const getStatusColor = (status: string) => {
    const colors: any = {
      DRAFT: 'default',
      IN_PLANNING: 'info',
      SAMPLE_SELECTED: 'primary',
      TESTING_IN_PROGRESS: 'warning',
      COMPLETED: 'success',
    };
    return colors[status] || 'default';
  };

  const getMethodLabel = (method: string) => {
    const labels: any = {
      RANDOM: 'Random',
      SYSTEMATIC: 'Systematic',
      STRATIFIED: 'Stratified',
      MUS: 'Monetary Unit Sampling',
      JUDGMENTAL: 'Judgmental',
      HAPHAZARD: 'Haphazard',
    };
    return labels[method] || method;
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Statistical Sampling</Typography>
        <Button variant="contained" startIcon={<AddIcon />} onClick={() => handleOpenDialog()}>
          New Sampling Plan
        </Button>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ mb: 2 }}>
        <Tab label="Sampling Plans" />
        <Tab label="Summary Dashboard" />
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
                  <TableCell>Title</TableCell>
                  <TableCell>Method</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell align="right">Population</TableCell>
                  <TableCell align="right">Sample Size</TableCell>
                  <TableCell align="right">Confidence</TableCell>
                  <TableCell align="right">Tested</TableCell>
                  <TableCell align="right">Errors</TableCell>
                  <TableCell align="center">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {samplings.map((sampling) => (
                  <TableRow key={sampling.id}>
                    <TableCell>{sampling.title}</TableCell>
                    <TableCell>{getMethodLabel(sampling.samplingMethod)}</TableCell>
                    <TableCell>
                      <Chip
                        label={sampling.status.replace(/_/g, ' ')}
                        color={getStatusColor(sampling.status) as any}
                        size="small"
                      />
                    </TableCell>
                    <TableCell align="right">{sampling.populationSize.toLocaleString()}</TableCell>
                    <TableCell align="right">{sampling.sampleSize.toLocaleString()}</TableCell>
                    <TableCell align="right">{sampling.confidenceLevel}%</TableCell>
                    <TableCell align="right">{sampling.itemsTested}</TableCell>
                    <TableCell align="right">{sampling.errorsFound}</TableCell>
                    <TableCell align="center">
                      <IconButton size="small" onClick={() => handleOpenDialog(sampling)} title="Edit">
                        <EditIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleGenerateSample(sampling.id)}
                        disabled={sampling.status !== 'IN_PLANNING'}
                        title="Generate Sample"
                      >
                        <GenerateIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleDelete(sampling.id)}
                        disabled={sampling.status === 'COMPLETED'}
                        title="Delete"
                      >
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
                {samplings.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={9} align="center">
                      No sampling plans found
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        )}
      </TabPanel>

      <TabPanel value={tabValue} index={1}>
        {summary && (
          <Grid container spacing={3}>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Total Plans
                  </Typography>
                  <Typography variant="h4">{summary.totalPlans || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Completed
                  </Typography>
                  <Typography variant="h4">{summary.completedPlans || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Total Items Tested
                  </Typography>
                  <Typography variant="h4">{summary.totalItemsTested || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Total Errors
                  </Typography>
                  <Typography variant="h4" color="error">
                    {summary.totalErrors || 0}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        )}
      </TabPanel>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{selectedSampling ? 'Edit' : 'Create'} Sampling Plan</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
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
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Sampling Method</InputLabel>
                <Select
                  value={formData.samplingMethod}
                  label="Sampling Method"
                  onChange={(e) => setFormData({ ...formData, samplingMethod: e.target.value })}
                >
                  <MenuItem value="RANDOM">Random</MenuItem>
                  <MenuItem value="SYSTEMATIC">Systematic</MenuItem>
                  <MenuItem value="STRATIFIED">Stratified</MenuItem>
                  <MenuItem value="MUS">Monetary Unit Sampling</MenuItem>
                  <MenuItem value="JUDGMENTAL">Judgmental</MenuItem>
                  <MenuItem value="HAPHAZARD">Haphazard</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Population Size"
                type="number"
                value={formData.populationSize}
                onChange={(e) => setFormData({ ...formData, populationSize: Number(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Confidence Level (%)"
                type="number"
                value={formData.confidenceLevel}
                onChange={(e) => setFormData({ ...formData, confidenceLevel: Number(e.target.value) })}
                inputProps={{ min: 50, max: 99.9 }}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Tolerable Error (%)"
                type="number"
                value={formData.tolerableError}
                onChange={(e) => setFormData({ ...formData, tolerableError: Number(e.target.value) })}
                inputProps={{ min: 0.1, max: 100 }}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Expected Error (%)"
                type="number"
                value={formData.expectedError}
                onChange={(e) => setFormData({ ...formData, expectedError: Number(e.target.value) })}
                inputProps={{ min: 0, max: 100 }}
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                fullWidth
                variant="outlined"
                startIcon={<CalculateIcon />}
                onClick={handleCalculateSampleSize}
                disabled={formData.populationSize === 0}
              >
                Calculate Sample Size
              </Button>
            </Grid>
            {calculatedSampleSize !== null && (
              <Grid item xs={12}>
                <Alert severity="info">
                  <strong>Recommended Sample Size: {calculatedSampleSize}</strong>
                </Alert>
              </Grid>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained" disabled={loading || !formData.title}>
            {loading ? <CircularProgress size={24} /> : 'Save'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default SamplingPlan;
