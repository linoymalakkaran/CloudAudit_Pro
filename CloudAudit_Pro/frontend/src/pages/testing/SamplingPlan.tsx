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
  TextField,
  Typography,
  Tooltip,
} from '@mui/material';
import { DataGrid, GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import {
  Add as AddIcon,
  Delete as DeleteIcon,
  Edit as EditIcon,
  Calculate as CalculateIcon,
  PlayArrow as GenerateIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import {
  samplingService,
  Sampling,
  SamplingMethod,
  SamplingStatus,
  samplingMethodLabels,
  samplingMethodDescriptions,
  samplingStatusLabels,
  samplingStatusColors,
  CreateSamplingDto,
} from '../../services/samplingService';

const SamplingPlan: React.FC = () => {
  const [samplingPlans, setSamplingPlans] = useState<Sampling[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openCalculatorDialog, setOpenCalculatorDialog] = useState(false);
  const [openGenerateDialog, setOpenGenerateDialog] = useState(false);
  const [selectedPlan, setSelectedPlan] = useState<Sampling | null>(null);
  const [formData, setFormData] = useState<Partial<CreateSamplingDto>>({});
  
  // Filters
  const [statusFilter, setStatusFilter] = useState<SamplingStatus | ''>('');
  const [methodFilter, setMethodFilter] = useState<SamplingMethod | ''>('');
  
  // Calculator state
  const [calculatorParams, setCalculatorParams] = useState({
    populationSize: 0,
    confidenceLevel: 95,
    tolerableError: 5,
    expectedError: 1,
  });
  const [recommendedSampleSize, setRecommendedSampleSize] = useState<number | null>(null);

  // Sample generation state
  const [populationIds, setPopulationIds] = useState<string>('');
  const [selectedIds, setSelectedIds] = useState<string[]>([]);

  useEffect(() => {
    loadSamplingPlans();
  }, [statusFilter, methodFilter]);

  const loadSamplingPlans = async () => {
    setLoading(true);
    try {
      const plans = await samplingService.getAll(
        undefined,
        undefined,
        statusFilter || undefined,
        methodFilter || undefined
      );
      setSamplingPlans(plans);
    } catch (error) {
      console.error('Failed to load sampling plans:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (plan?: Sampling) => {
    if (plan) {
      setSelectedPlan(plan);
      setFormData({
        companyId: plan.companyId,
        periodId: plan.periodId,
        title: plan.title,
        description: plan.description,
        samplingMethod: plan.samplingMethod,
        populationSize: plan.populationSize,
        sampleSize: plan.sampleSize,
        confidenceLevel: plan.confidenceLevel,
        tolerableError: plan.tolerableError,
        expectedError: plan.expectedError,
        selectionCriteria: plan.selectionCriteria,
        stratificationBasis: plan.stratificationBasis,
      });
    } else {
      setSelectedPlan(null);
      setFormData({
        samplingMethod: SamplingMethod.RANDOM,
        populationSize: 0,
        sampleSize: 0,
        confidenceLevel: 95,
        tolerableError: 5,
        expectedError: 1,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedPlan(null);
    setFormData({});
  };

  const handleSave = async () => {
    try {
      if (selectedPlan) {
        await samplingService.update(selectedPlan.id, formData);
      } else {
        await samplingService.create(formData as CreateSamplingDto);
      }
      handleCloseDialog();
      loadSamplingPlans();
    } catch (error) {
      console.error('Failed to save sampling plan:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this sampling plan?')) {
      try {
        await samplingService.delete(id);
        loadSamplingPlans();
      } catch (error) {
        console.error('Failed to delete sampling plan:', error);
      }
    }
  };

  const handleCalculateSampleSize = async () => {
    try {
      const size = await samplingService.calculateSampleSize(
        calculatorParams.populationSize,
        calculatorParams.confidenceLevel,
        calculatorParams.tolerableError,
        calculatorParams.expectedError
      );
      setRecommendedSampleSize(size);
    } catch (error) {
      console.error('Failed to calculate sample size:', error);
    }
  };

  const handleUseCalculatedSize = () => {
    if (recommendedSampleSize) {
      setFormData({ ...formData, sampleSize: recommendedSampleSize });
      setOpenCalculatorDialog(false);
    }
  };

  const handleGenerateSample = async () => {
    if (!selectedPlan) return;
    
    try {
      const ids = populationIds.split('\n').map(id => id.trim()).filter(id => id);
      const result = await samplingService.generateSample(selectedPlan.id, ids);
      setSelectedIds(result.selectedIds);
    } catch (error) {
      console.error('Failed to generate sample:', error);
    }
  };

  const columns: GridColDef[] = [
    {
      field: 'title',
      headerName: 'Title',
      flex: 1,
      minWidth: 200,
    },
    {
      field: 'samplingMethod',
      headerName: 'Method',
      width: 180,
      renderCell: (params: GridRenderCellParams) => (
        <Tooltip title={samplingMethodDescriptions[params.value as SamplingMethod]}>
          <span>{samplingMethodLabels[params.value as SamplingMethod]}</span>
        </Tooltip>
      ),
    },
    {
      field: 'populationSize',
      headerName: 'Population',
      width: 120,
      type: 'number',
    },
    {
      field: 'sampleSize',
      headerName: 'Sample Size',
      width: 120,
      type: 'number',
    },
    {
      field: 'errorsFound',
      headerName: 'Errors',
      width: 100,
      type: 'number',
      renderCell: (params: GridRenderCellParams) => (
        params.value ? <Chip label={params.value} color="error" size="small" /> : '-'
      ),
    },
    {
      field: 'status',
      headerName: 'Status',
      width: 140,
      renderCell: (params: GridRenderCellParams) => (
        <Chip
          label={samplingStatusLabels[params.value as SamplingStatus]}
          color={samplingStatusColors[params.value as SamplingStatus] as any}
          size="small"
        />
      ),
    },
    {
      field: 'createdAt',
      headerName: 'Created',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        new Date(params.value).toLocaleDateString()
      ),
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 180,
      sortable: false,
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <Tooltip title="Edit">
            <IconButton size="small" onClick={() => handleOpenDialog(params.row)}>
              <EditIcon fontSize="small" />
            </IconButton>
          </Tooltip>
          <Tooltip title="Generate Sample">
            <IconButton
              size="small"
              onClick={() => {
                setSelectedPlan(params.row);
                setOpenGenerateDialog(true);
              }}
            >
              <GenerateIcon fontSize="small" />
            </IconButton>
          </Tooltip>
          <Tooltip title="Delete">
            <IconButton size="small" onClick={() => handleDelete(params.row.id)}>
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Tooltip>
        </Box>
      ),
    },
  ];

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Sampling Plans</Typography>
        <Box sx={{ display: 'flex', gap: 2 }}>
          <Button
            variant="outlined"
            startIcon={<CalculateIcon />}
            onClick={() => setOpenCalculatorDialog(true)}
          >
            Sample Size Calculator
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => handleOpenDialog()}
          >
            New Sampling Plan
          </Button>
        </Box>
      </Box>

      {/* Filters */}
      <Paper sx={{ p: 2, mb: 3 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item xs={12} md={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Status</InputLabel>
              <Select
                value={statusFilter}
                onChange={(e) => setStatusFilter(e.target.value as SamplingStatus | '')}
                label="Status"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(SamplingStatus).map((status) => (
                  <MenuItem key={status} value={status}>
                    {samplingStatusLabels[status]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Method</InputLabel>
              <Select
                value={methodFilter}
                onChange={(e) => setMethodFilter(e.target.value as SamplingMethod | '')}
                label="Method"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(SamplingMethod).map((method) => (
                  <MenuItem key={method} value={method}>
                    {samplingMethodLabels[method]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <Button
              variant="outlined"
              startIcon={<RefreshIcon />}
              onClick={loadSamplingPlans}
              fullWidth
            >
              Refresh
            </Button>
          </Grid>
        </Grid>
      </Paper>

      {/* Data Grid */}
      <Paper sx={{ height: 600 }}>
        <DataGrid
          rows={samplingPlans}
          columns={columns}
          loading={loading}
          pageSizeOptions={[10, 25, 50, 100]}
          initialState={{
            pagination: { paginationModel: { pageSize: 25 } },
          }}
          disableRowSelectionOnClick
        />
      </Paper>

      {/* Sampling Plan Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          {selectedPlan ? 'Edit Sampling Plan' : 'New Sampling Plan'}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Title"
                fullWidth
                value={formData.title || ''}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Description"
                fullWidth
                multiline
                rows={2}
                value={formData.description || ''}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth required>
                <InputLabel>Sampling Method</InputLabel>
                <Select
                  value={formData.samplingMethod || SamplingMethod.RANDOM}
                  onChange={(e) => setFormData({ ...formData, samplingMethod: e.target.value as SamplingMethod })}
                  label="Sampling Method"
                >
                  {Object.values(SamplingMethod).map((method) => (
                    <MenuItem key={method} value={method}>
                      <Tooltip title={samplingMethodDescriptions[method]} placement="right">
                        <span>{samplingMethodLabels[method]}</span>
                      </Tooltip>
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Population Size"
                type="number"
                fullWidth
                value={formData.populationSize || ''}
                onChange={(e) => setFormData({ ...formData, populationSize: parseInt(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Sample Size"
                type="number"
                fullWidth
                value={formData.sampleSize || ''}
                onChange={(e) => setFormData({ ...formData, sampleSize: parseInt(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Confidence Level (%)"
                type="number"
                fullWidth
                value={formData.confidenceLevel || ''}
                onChange={(e) => setFormData({ ...formData, confidenceLevel: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100, step: 0.1 }}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Tolerable Error (%)"
                type="number"
                fullWidth
                value={formData.tolerableError || ''}
                onChange={(e) => setFormData({ ...formData, tolerableError: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100, step: 0.1 }}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Expected Error (%)"
                type="number"
                fullWidth
                value={formData.expectedError || ''}
                onChange={(e) => setFormData({ ...formData, expectedError: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100, step: 0.1 }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Selection Criteria"
                fullWidth
                multiline
                rows={2}
                value={formData.selectionCriteria || ''}
                onChange={(e) => setFormData({ ...formData, selectionCriteria: e.target.value })}
              />
            </Grid>
            {formData.samplingMethod === SamplingMethod.STRATIFIED && (
              <Grid item xs={12}>
                <TextField
                  label="Stratification Basis"
                  fullWidth
                  multiline
                  rows={2}
                  value={formData.stratificationBasis || ''}
                  onChange={(e) => setFormData({ ...formData, stratificationBasis: e.target.value })}
                />
              </Grid>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained">
            {selectedPlan ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Sample Size Calculator Dialog */}
      <Dialog open={openCalculatorDialog} onClose={() => setOpenCalculatorDialog(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Sample Size Calculator</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Population Size"
                type="number"
                fullWidth
                value={calculatorParams.populationSize}
                onChange={(e) => setCalculatorParams({ ...calculatorParams, populationSize: parseInt(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Confidence Level (%)"
                type="number"
                fullWidth
                value={calculatorParams.confidenceLevel}
                onChange={(e) => setCalculatorParams({ ...calculatorParams, confidenceLevel: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100 }}
                helperText="Common values: 90%, 95%, 99%"
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Tolerable Error (%)"
                type="number"
                fullWidth
                value={calculatorParams.tolerableError}
                onChange={(e) => setCalculatorParams({ ...calculatorParams, tolerableError: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100, step: 0.1 }}
                helperText="Maximum acceptable error rate"
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Expected Error (%)"
                type="number"
                fullWidth
                value={calculatorParams.expectedError}
                onChange={(e) => setCalculatorParams({ ...calculatorParams, expectedError: parseFloat(e.target.value) })}
                inputProps={{ min: 0, max: 100, step: 0.1 }}
                helperText="Expected error rate in population"
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                variant="contained"
                fullWidth
                onClick={handleCalculateSampleSize}
                startIcon={<CalculateIcon />}
              >
                Calculate
              </Button>
            </Grid>
            {recommendedSampleSize !== null && (
              <Grid item xs={12}>
                <Card variant="outlined">
                  <CardContent>
                    <Typography variant="h6" gutterBottom>
                      Recommended Sample Size
                    </Typography>
                    <Typography variant="h3" color="primary" gutterBottom>
                      {recommendedSampleSize}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      Based on statistical sampling formula
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenCalculatorDialog(false)}>Close</Button>
          {recommendedSampleSize !== null && (
            <Button onClick={handleUseCalculatedSize} variant="contained">
              Use This Size
            </Button>
          )}
        </DialogActions>
      </Dialog>

      {/* Sample Generation Dialog */}
      <Dialog open={openGenerateDialog} onClose={() => setOpenGenerateDialog(false)} maxWidth="md" fullWidth>
        <DialogTitle>Generate Sample Selection</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <Typography variant="body2" gutterBottom>
                Enter population IDs (one per line):
              </Typography>
              <TextField
                fullWidth
                multiline
                rows={10}
                value={populationIds}
                onChange={(e) => setPopulationIds(e.target.value)}
                placeholder="ID001&#10;ID002&#10;ID003&#10;..."
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                variant="contained"
                fullWidth
                onClick={handleGenerateSample}
                startIcon={<GenerateIcon />}
              >
                Generate Sample
              </Button>
            </Grid>
            {selectedIds.length > 0 && (
              <Grid item xs={12}>
                <Card variant="outlined">
                  <CardContent>
                    <Typography variant="h6" gutterBottom>
                      Selected Sample IDs ({selectedIds.length})
                    </Typography>
                    <TextField
                      fullWidth
                      multiline
                      rows={8}
                      value={selectedIds.join('\n')}
                      InputProps={{ readOnly: true }}
                    />
                    <Box sx={{ mt: 2 }}>
                      <Button
                        variant="outlined"
                        onClick={() => {
                          navigator.clipboard.writeText(selectedIds.join('\n'));
                        }}
                      >
                        Copy to Clipboard
                      </Button>
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenGenerateDialog(false)}>Close</Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default SamplingPlan;
