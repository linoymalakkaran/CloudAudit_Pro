import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Checkbox,
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
  TextField,
  Typography,
  Tooltip,
} from '@mui/material';
import { DataGrid, GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import {
  Add as AddIcon,
  Delete as DeleteIcon,
  Edit as EditIcon,
  Science as TestIcon,
  Warning as DeficiencyIcon,
  Star as StarIcon,
  StarBorder as StarBorderIcon,
  Refresh as RefreshIcon,
  RateReview as ReviewIcon,
} from '@mui/icons-material';
import {
  internalControlsService,
  InternalControl,
  ControlType,
  ControlNature,
  ControlFrequency,
  ControlEffectiveness,
  RiskLevel,
  controlTypeLabels,
  controlTypeDescriptions,
  controlNatureLabels,
  controlFrequencyLabels,
  controlEffectivenessLabels,
  controlEffectivenessColors,
  riskLevelLabels,
  riskLevelColors,
  CreateInternalControlDto,
} from '../../services/internalControlsService';

const InternalControls: React.FC = () => {
  const [controls, setControls] = useState<InternalControl[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openTestDialog, setOpenTestDialog] = useState(false);
  const [openDeficiencyDialog, setOpenDeficiencyDialog] = useState(false);
  const [selectedControl, setSelectedControl] = useState<InternalControl | null>(null);
  const [formData, setFormData] = useState<Partial<CreateInternalControlDto>>({});
  
  // Filters
  const [processAreaFilter, setProcessAreaFilter] = useState<string>('');
  const [controlTypeFilter, setControlTypeFilter] = useState<ControlType | ''>('');
  const [effectivenessFilter, setEffectivenessFilter] = useState<ControlEffectiveness | ''>('');
  const [keyControlFilter, setKeyControlFilter] = useState<boolean | ''>('');
  const [deficiencyFilter, setDeficiencyFilter] = useState<boolean | ''>('');

  // Test state
  const [testData, setTestData] = useState({
    testProcedures: '',
    testResult: '',
    controlEffectiveness: ControlEffectiveness.NOT_TESTED,
    evidence: '',
  });

  // Deficiency state
  const [deficiencyData, setDeficiencyData] = useState({
    deficiencyDescription: '',
    remediationPlan: '',
    remediationDeadline: '',
  });

  // Get unique process areas for filter
  const processAreas = Array.from(new Set(controls.map(c => c.processArea))).sort();

  useEffect(() => {
    loadControls();
  }, [processAreaFilter, controlTypeFilter, effectivenessFilter, keyControlFilter, deficiencyFilter]);

  const loadControls = async () => {
    setLoading(true);
    try {
      const data = await internalControlsService.getAll(
        undefined,
        undefined,
        processAreaFilter || undefined,
        controlTypeFilter || undefined,
        effectivenessFilter || undefined,
        keyControlFilter === '' ? undefined : keyControlFilter,
        deficiencyFilter === '' ? undefined : deficiencyFilter
      );
      setControls(data);
    } catch (error) {
      console.error('Failed to load internal controls:', error);
    } finally {
      setLoading(false);
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
      });
    } else {
      setSelectedControl(null);
      setFormData({
        controlType: ControlType.PREVENTIVE,
        controlNature: ControlNature.MANUAL,
        controlFrequency: ControlFrequency.MONTHLY,
        isKeyControl: false,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedControl(null);
    setFormData({});
  };

  const handleOpenTestDialog = (control: InternalControl) => {
    setSelectedControl(control);
    setTestData({
      testProcedures: control.testProcedures || '',
      testResult: control.testResult || '',
      controlEffectiveness: control.controlEffectiveness || ControlEffectiveness.NOT_TESTED,
      evidence: control.evidence || '',
    });
    setOpenTestDialog(true);
  };

  const handleCloseTestDialog = () => {
    setOpenTestDialog(false);
    setSelectedControl(null);
    setTestData({
      testProcedures: '',
      testResult: '',
      controlEffectiveness: ControlEffectiveness.NOT_TESTED,
      evidence: '',
    });
  };

  const handleOpenDeficiencyDialog = (control: InternalControl) => {
    setSelectedControl(control);
    setDeficiencyData({
      deficiencyDescription: control.deficiencyDescription || '',
      remediationPlan: control.remediationPlan || '',
      remediationDeadline: control.remediationDeadline 
        ? new Date(control.remediationDeadline).toISOString().split('T')[0]
        : '',
    });
    setOpenDeficiencyDialog(true);
  };

  const handleCloseDeficiencyDialog = () => {
    setOpenDeficiencyDialog(false);
    setSelectedControl(null);
    setDeficiencyData({
      deficiencyDescription: '',
      remediationPlan: '',
      remediationDeadline: '',
    });
  };

  const handleSave = async () => {
    try {
      if (selectedControl) {
        await internalControlsService.update(selectedControl.id, formData);
      } else {
        await internalControlsService.create(formData as CreateInternalControlDto);
      }
      handleCloseDialog();
      loadControls();
    } catch (error) {
      console.error('Failed to save internal control:', error);
    }
  };

  const handleTestControl = async () => {
    if (!selectedControl) return;

    try {
      await internalControlsService.test(
        selectedControl.id,
        testData.testProcedures,
        testData.testResult,
        testData.controlEffectiveness
      );
      handleCloseTestDialog();
      loadControls();
    } catch (error) {
      console.error('Failed to test control:', error);
    }
  };

  const handleIdentifyDeficiency = async () => {
    if (!selectedControl) return;

    try {
      await internalControlsService.identifyDeficiency(
        selectedControl.id,
        deficiencyData.deficiencyDescription,
        deficiencyData.remediationPlan,
        new Date(deficiencyData.remediationDeadline)
      );
      handleCloseDeficiencyDialog();
      loadControls();
    } catch (error) {
      console.error('Failed to identify deficiency:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this control?')) {
      try {
        await internalControlsService.delete(id);
        loadControls();
      } catch (error) {
        console.error('Failed to delete control:', error);
      }
    }
  };

  const columns: GridColDef[] = [
    {
      field: 'isKeyControl',
      headerName: '',
      width: 50,
      renderCell: (params: GridRenderCellParams) => (
        params.value ? (
          <Tooltip title="Key Control">
            <StarIcon color="primary" fontSize="small" />
          </Tooltip>
        ) : (
          <StarBorderIcon fontSize="small" sx={{ color: 'grey.300' }} />
        )
      ),
    },
    {
      field: 'processArea',
      headerName: 'Process Area',
      width: 150,
    },
    {
      field: 'controlId',
      headerName: 'Control ID',
      width: 120,
    },
    {
      field: 'title',
      headerName: 'Title',
      flex: 1,
      minWidth: 200,
    },
    {
      field: 'controlType',
      headerName: 'Type',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        <Tooltip title={controlTypeDescriptions[params.value as ControlType]}>
          <span>{controlTypeLabels[params.value as ControlType]}</span>
        </Tooltip>
      ),
    },
    {
      field: 'controlNature',
      headerName: 'Nature',
      width: 140,
      renderCell: (params: GridRenderCellParams) => (
        controlNatureLabels[params.value as ControlNature]
      ),
    },
    {
      field: 'controlFrequency',
      headerName: 'Frequency',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        controlFrequencyLabels[params.value as ControlFrequency]
      ),
    },
    {
      field: 'controlEffectiveness',
      headerName: 'Effectiveness',
      width: 150,
      renderCell: (params: GridRenderCellParams) => (
        <Chip
          label={controlEffectivenessLabels[params.value as ControlEffectiveness]}
          color={controlEffectivenessColors[params.value as ControlEffectiveness] as any}
          size="small"
        />
      ),
    },
    {
      field: 'deficiencyIdentified',
      headerName: 'Deficiency',
      width: 100,
      renderCell: (params: GridRenderCellParams) => (
        params.value ? (
          <Chip icon={<DeficiencyIcon />} label="Yes" color="warning" size="small" />
        ) : (
          <Chip label="No" color="default" size="small" />
        )
      ),
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 200,
      sortable: false,
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <Tooltip title="Edit">
            <IconButton size="small" onClick={() => handleOpenDialog(params.row)}>
              <EditIcon fontSize="small" />
            </IconButton>
          </Tooltip>
          <Tooltip title="Test Control">
            <IconButton size="small" onClick={() => handleOpenTestDialog(params.row)}>
              <TestIcon fontSize="small" />
            </IconButton>
          </Tooltip>
          <Tooltip title="Identify Deficiency">
            <IconButton size="small" onClick={() => handleOpenDeficiencyDialog(params.row)}>
              <DeficiencyIcon fontSize="small" />
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
        <Typography variant="h4">Internal Controls</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => handleOpenDialog()}
        >
          New Control
        </Button>
      </Box>

      {/* Filters */}
      <Paper sx={{ p: 2, mb: 3 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item xs={12} md={2}>
            <FormControl fullWidth size="small">
              <InputLabel>Process Area</InputLabel>
              <Select
                value={processAreaFilter}
                onChange={(e) => setProcessAreaFilter(e.target.value)}
                label="Process Area"
              >
                <MenuItem value="">All</MenuItem>
                {processAreas.map((area) => (
                  <MenuItem key={area} value={area}>
                    {area}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth size="small">
              <InputLabel>Type</InputLabel>
              <Select
                value={controlTypeFilter}
                onChange={(e) => setControlTypeFilter(e.target.value as ControlType | '')}
                label="Type"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ControlType).map((type) => (
                  <MenuItem key={type} value={type}>
                    {controlTypeLabels[type]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth size="small">
              <InputLabel>Effectiveness</InputLabel>
              <Select
                value={effectivenessFilter}
                onChange={(e) => setEffectivenessFilter(e.target.value as ControlEffectiveness | '')}
                label="Effectiveness"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ControlEffectiveness).map((eff) => (
                  <MenuItem key={eff} value={eff}>
                    {controlEffectivenessLabels[eff]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth size="small">
              <InputLabel>Key Control</InputLabel>
              <Select
                value={keyControlFilter}
                onChange={(e) => setKeyControlFilter(e.target.value === '' ? '' : e.target.value === 'true')}
                label="Key Control"
              >
                <MenuItem value="">All</MenuItem>
                <MenuItem value="true">Yes</MenuItem>
                <MenuItem value="false">No</MenuItem>
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth size="small">
              <InputLabel>Deficiency</InputLabel>
              <Select
                value={deficiencyFilter}
                onChange={(e) => setDeficiencyFilter(e.target.value === '' ? '' : e.target.value === 'true')}
                label="Deficiency"
              >
                <MenuItem value="">All</MenuItem>
                <MenuItem value="true">Yes</MenuItem>
                <MenuItem value="false">No</MenuItem>
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <Button
              variant="outlined"
              startIcon={<RefreshIcon />}
              onClick={loadControls}
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
          rows={controls}
          columns={columns}
          loading={loading}
          pageSizeOptions={[10, 25, 50, 100]}
          initialState={{
            pagination: { paginationModel: { pageSize: 25 } },
          }}
          disableRowSelectionOnClick
        />
      </Paper>

      {/* Control Creation/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          {selectedControl ? 'Edit Internal Control' : 'New Internal Control'}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} md={6}>
              <TextField
                label="Process Area"
                fullWidth
                value={formData.processArea || ''}
                onChange={(e) => setFormData({ ...formData, processArea: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Control ID"
                fullWidth
                value={formData.controlId || ''}
                onChange={(e) => setFormData({ ...formData, controlId: e.target.value })}
                required
                helperText="Unique control identifier"
              />
            </Grid>
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
                rows={3}
                value={formData.description || ''}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Control Objective"
                fullWidth
                multiline
                rows={2}
                value={formData.controlObjective || ''}
                onChange={(e) => setFormData({ ...formData, controlObjective: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth required>
                <InputLabel>Control Type</InputLabel>
                <Select
                  value={formData.controlType || ControlType.PREVENTIVE}
                  onChange={(e) => setFormData({ ...formData, controlType: e.target.value as ControlType })}
                  label="Control Type"
                >
                  {Object.values(ControlType).map((type) => (
                    <MenuItem key={type} value={type}>
                      <Tooltip title={controlTypeDescriptions[type]} placement="right">
                        <span>{controlTypeLabels[type]}</span>
                      </Tooltip>
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth required>
                <InputLabel>Control Nature</InputLabel>
                <Select
                  value={formData.controlNature || ControlNature.MANUAL}
                  onChange={(e) => setFormData({ ...formData, controlNature: e.target.value as ControlNature })}
                  label="Control Nature"
                >
                  {Object.values(ControlNature).map((nature) => (
                    <MenuItem key={nature} value={nature}>
                      {controlNatureLabels[nature]}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth required>
                <InputLabel>Frequency</InputLabel>
                <Select
                  value={formData.controlFrequency || ControlFrequency.MONTHLY}
                  onChange={(e) => setFormData({ ...formData, controlFrequency: e.target.value as ControlFrequency })}
                  label="Frequency"
                >
                  {Object.values(ControlFrequency).map((freq) => (
                    <MenuItem key={freq} value={freq}>
                      {controlFrequencyLabels[freq]}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Risk Addressed"
                fullWidth
                multiline
                rows={2}
                value={formData.riskAddressed || ''}
                onChange={(e) => setFormData({ ...formData, riskAddressed: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Risk Level</InputLabel>
                <Select
                  value={formData.riskLevel || ''}
                  onChange={(e) => setFormData({ ...formData, riskLevel: e.target.value as RiskLevel })}
                  label="Risk Level"
                >
                  <MenuItem value="">Not Specified</MenuItem>
                  {Object.values(RiskLevel).map((level) => (
                    <MenuItem key={level} value={level}>
                      <Chip
                        label={riskLevelLabels[level]}
                        color={riskLevelColors[level] as any}
                        size="small"
                      />
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Control Owner"
                fullWidth
                value={formData.controlOwner || ''}
                onChange={(e) => setFormData({ ...formData, controlOwner: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Checkbox
                    checked={formData.isKeyControl || false}
                    onChange={(e) => setFormData({ ...formData, isKeyControl: e.target.checked })}
                  />
                }
                label="This is a Key Control"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained">
            {selectedControl ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Test Control Dialog */}
      <Dialog open={openTestDialog} onClose={handleCloseTestDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          Test Control: {selectedControl?.title}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            {/* Control Information */}
            <Grid item xs={12}>
              <Card variant="outlined">
                <CardContent>
                  <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                    Control Information
                  </Typography>
                  <Grid container spacing={1}>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Control ID:</strong> {selectedControl?.controlId}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Type:</strong> {selectedControl && controlTypeLabels[selectedControl.controlType]}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Nature:</strong> {selectedControl && controlNatureLabels[selectedControl.controlNature]}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Frequency:</strong> {selectedControl && controlFrequencyLabels[selectedControl.controlFrequency]}
                      </Typography>
                    </Grid>
                  </Grid>
                </CardContent>
              </Card>
            </Grid>

            <Grid item xs={12}>
              <TextField
                label="Test Procedures"
                fullWidth
                multiline
                rows={4}
                value={testData.testProcedures}
                onChange={(e) => setTestData({ ...testData, testProcedures: e.target.value })}
                placeholder="Describe the procedures performed to test this control..."
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Test Result"
                fullWidth
                multiline
                rows={4}
                value={testData.testResult}
                onChange={(e) => setTestData({ ...testData, testResult: e.target.value })}
                placeholder="Describe the test results and findings..."
                required
              />
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth required>
                <InputLabel>Control Effectiveness Assessment</InputLabel>
                <Select
                  value={testData.controlEffectiveness}
                  onChange={(e) => setTestData({ ...testData, controlEffectiveness: e.target.value as ControlEffectiveness })}
                  label="Control Effectiveness Assessment"
                >
                  {Object.values(ControlEffectiveness).map((eff) => (
                    <MenuItem key={eff} value={eff}>
                      <Chip
                        label={controlEffectivenessLabels[eff]}
                        color={controlEffectivenessColors[eff] as any}
                        size="small"
                      />
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Evidence/Documentation"
                fullWidth
                multiline
                rows={2}
                value={testData.evidence}
                onChange={(e) => setTestData({ ...testData, evidence: e.target.value })}
                placeholder="Reference to supporting evidence and documentation..."
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseTestDialog}>Cancel</Button>
          <Button 
            onClick={handleTestControl} 
            variant="contained"
            disabled={!testData.testProcedures || !testData.testResult}
          >
            Save Test Results
          </Button>
        </DialogActions>
      </Dialog>

      {/* Deficiency Dialog */}
      <Dialog open={openDeficiencyDialog} onClose={handleCloseDeficiencyDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          Identify Control Deficiency: {selectedControl?.title}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Deficiency Description"
                fullWidth
                multiline
                rows={4}
                value={deficiencyData.deficiencyDescription}
                onChange={(e) => setDeficiencyData({ ...deficiencyData, deficiencyDescription: e.target.value })}
                placeholder="Describe the control deficiency identified..."
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Remediation Plan"
                fullWidth
                multiline
                rows={4}
                value={deficiencyData.remediationPlan}
                onChange={(e) => setDeficiencyData({ ...deficiencyData, remediationPlan: e.target.value })}
                placeholder="Describe the plan to remediate this deficiency..."
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Remediation Deadline"
                type="date"
                fullWidth
                value={deficiencyData.remediationDeadline}
                onChange={(e) => setDeficiencyData({ ...deficiencyData, remediationDeadline: e.target.value })}
                InputLabelProps={{ shrink: true }}
                required
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDeficiencyDialog}>Cancel</Button>
          <Button 
            onClick={handleIdentifyDeficiency} 
            variant="contained"
            color="warning"
            disabled={!deficiencyData.deficiencyDescription || !deficiencyData.remediationPlan || !deficiencyData.remediationDeadline}
          >
            Identify Deficiency
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default InternalControls;
