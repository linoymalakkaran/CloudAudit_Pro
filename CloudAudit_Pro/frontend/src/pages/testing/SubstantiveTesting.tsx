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
  CheckCircle as CompleteIcon,
  RateReview as ReviewIcon,
  Warning as WarningIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import {
  substantiveTestingService,
  SubstantiveTest,
  TestType,
  TestStatus,
  ExceptionSeverity,
  testTypeLabels,
  testTypeDescriptions,
  testStatusLabels,
  testStatusColors,
  exceptionSeverityLabels,
  exceptionSeverityColors,
  CreateSubstantiveTestDto,
} from '../../services/substantiveTestingService';

const SubstantiveTesting: React.FC = () => {
  const [tests, setTests] = useState<SubstantiveTest[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openExecutionDialog, setOpenExecutionDialog] = useState(false);
  const [selectedTest, setSelectedTest] = useState<SubstantiveTest | null>(null);
  const [formData, setFormData] = useState<Partial<CreateSubstantiveTestDto>>({});
  
  // Filters
  const [statusFilter, setStatusFilter] = useState<TestStatus | ''>('');
  const [testTypeFilter, setTestTypeFilter] = useState<TestType | ''>('');
  const [hasExceptionFilter, setHasExceptionFilter] = useState<boolean | ''>('');

  // Execution state
  const [executionData, setExecutionData] = useState({
    expectedResult: '',
    actualResult: '',
    proceduresPerformed: '',
    hasException: false,
    exceptionDescription: '',
    exceptionSeverity: ExceptionSeverity.LOW,
    exceptionAmount: 0,
    managementResponse: '',
    conclusion: '',
  });

  useEffect(() => {
    loadTests();
  }, [statusFilter, testTypeFilter, hasExceptionFilter]);

  const loadTests = async () => {
    setLoading(true);
    try {
      const data = await substantiveTestingService.getAll(
        undefined,
        undefined,
        statusFilter || undefined,
        testTypeFilter || undefined,
        hasExceptionFilter === '' ? undefined : hasExceptionFilter
      );
      setTests(data);
    } catch (error) {
      console.error('Failed to load substantive tests:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (test?: SubstantiveTest) => {
    if (test) {
      setSelectedTest(test);
      setFormData({
        companyId: test.companyId,
        periodId: test.periodId,
        title: test.title,
        description: test.description,
        testType: test.testType,
        transactionReference: test.transactionReference,
        transactionDate: test.transactionDate,
        transactionAmount: test.transactionAmount,
        sourceDocument: test.sourceDocument,
      });
    } else {
      setSelectedTest(null);
      setFormData({
        testType: TestType.VOUCHING,
        hasException: false,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedTest(null);
    setFormData({});
  };

  const handleOpenExecutionDialog = (test: SubstantiveTest) => {
    setSelectedTest(test);
    setExecutionData({
      expectedResult: test.expectedResult || '',
      actualResult: test.actualResult || '',
      proceduresPerformed: test.proceduresPerformed || '',
      hasException: test.hasException,
      exceptionDescription: test.exceptionDescription || '',
      exceptionSeverity: test.exceptionSeverity || ExceptionSeverity.LOW,
      exceptionAmount: test.exceptionAmount || 0,
      managementResponse: test.managementResponse || '',
      conclusion: test.conclusion || '',
    });
    setOpenExecutionDialog(true);
  };

  const handleCloseExecutionDialog = () => {
    setOpenExecutionDialog(false);
    setSelectedTest(null);
    setExecutionData({
      expectedResult: '',
      actualResult: '',
      proceduresPerformed: '',
      hasException: false,
      exceptionDescription: '',
      exceptionSeverity: ExceptionSeverity.LOW,
      exceptionAmount: 0,
      managementResponse: '',
      conclusion: '',
    });
  };

  const handleSave = async () => {
    try {
      if (selectedTest) {
        await substantiveTestingService.update(selectedTest.id, formData);
      } else {
        await substantiveTestingService.create(formData as CreateSubstantiveTestDto);
      }
      handleCloseDialog();
      loadTests();
    } catch (error) {
      console.error('Failed to save substantive test:', error);
    }
  };

  const handleSaveExecution = async () => {
    if (!selectedTest) return;

    try {
      await substantiveTestingService.update(selectedTest.id, executionData);
      handleCloseExecutionDialog();
      loadTests();
    } catch (error) {
      console.error('Failed to save test execution:', error);
    }
  };

  const handleComplete = async () => {
    if (!selectedTest || !executionData.conclusion) return;

    try {
      await substantiveTestingService.complete(selectedTest.id, executionData.conclusion);
      handleCloseExecutionDialog();
      loadTests();
    } catch (error) {
      console.error('Failed to complete test:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this test?')) {
      try {
        await substantiveTestingService.delete(id);
        loadTests();
      } catch (error) {
        console.error('Failed to delete test:', error);
      }
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
      field: 'testType',
      headerName: 'Test Type',
      width: 180,
      renderCell: (params: GridRenderCellParams) => (
        <Tooltip title={testTypeDescriptions[params.value as TestType]}>
          <span>{testTypeLabels[params.value as TestType]}</span>
        </Tooltip>
      ),
    },
    {
      field: 'transactionReference',
      headerName: 'Transaction Ref',
      width: 140,
    },
    {
      field: 'transactionAmount',
      headerName: 'Amount',
      width: 120,
      type: 'number',
      renderCell: (params: GridRenderCellParams) => (
        params.value ? new Intl.NumberFormat('en-US', {
          style: 'currency',
          currency: 'USD'
        }).format(params.value) : '-'
      ),
    },
    {
      field: 'hasException',
      headerName: 'Exception',
      width: 100,
      renderCell: (params: GridRenderCellParams) => (
        params.value ? (
          <Chip icon={<WarningIcon />} label="Yes" color="error" size="small" />
        ) : (
          <Chip label="No" color="default" size="small" />
        )
      ),
    },
    {
      field: 'exceptionSeverity',
      headerName: 'Severity',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        params.value ? (
          <Chip
            label={exceptionSeverityLabels[params.value as ExceptionSeverity]}
            color={exceptionSeverityColors[params.value as ExceptionSeverity] as any}
            size="small"
          />
        ) : '-'
      ),
    },
    {
      field: 'status',
      headerName: 'Status',
      width: 140,
      renderCell: (params: GridRenderCellParams) => (
        <Chip
          label={testStatusLabels[params.value as TestStatus]}
          color={testStatusColors[params.value as TestStatus] as any}
          size="small"
        />
      ),
    },
    {
      field: 'testDate',
      headerName: 'Test Date',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        params.value ? new Date(params.value).toLocaleDateString() : '-'
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
          <Tooltip title="Execute Test">
            <IconButton size="small" onClick={() => handleOpenExecutionDialog(params.row)}>
              <CompleteIcon fontSize="small" />
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
        <Typography variant="h4">Substantive Testing</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => handleOpenDialog()}
        >
          New Test
        </Button>
      </Box>

      {/* Filters */}
      <Paper sx={{ p: 2, mb: 3 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item xs={12} md={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Test Type</InputLabel>
              <Select
                value={testTypeFilter}
                onChange={(e) => setTestTypeFilter(e.target.value as TestType | '')}
                label="Test Type"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(TestType).map((type) => (
                  <MenuItem key={type} value={type}>
                    {testTypeLabels[type]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Status</InputLabel>
              <Select
                value={statusFilter}
                onChange={(e) => setStatusFilter(e.target.value as TestStatus | '')}
                label="Status"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(TestStatus).map((status) => (
                  <MenuItem key={status} value={status}>
                    {testStatusLabels[status]}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Has Exception</InputLabel>
              <Select
                value={hasExceptionFilter}
                onChange={(e) => setHasExceptionFilter(e.target.value === '' ? '' : e.target.value === 'true')}
                label="Has Exception"
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
              onClick={loadTests}
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
          rows={tests}
          columns={columns}
          loading={loading}
          pageSizeOptions={[10, 25, 50, 100]}
          initialState={{
            pagination: { paginationModel: { pageSize: 25 } },
          }}
          disableRowSelectionOnClick
        />
      </Paper>

      {/* Test Creation/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          {selectedTest ? 'Edit Substantive Test' : 'New Substantive Test'}
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
                <InputLabel>Test Type</InputLabel>
                <Select
                  value={formData.testType || TestType.VOUCHING}
                  onChange={(e) => setFormData({ ...formData, testType: e.target.value as TestType })}
                  label="Test Type"
                >
                  {Object.values(TestType).map((type) => (
                    <MenuItem key={type} value={type}>
                      <Tooltip title={testTypeDescriptions[type]} placement="right">
                        <span>{testTypeLabels[type]}</span>
                      </Tooltip>
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Transaction Reference"
                fullWidth
                value={formData.transactionReference || ''}
                onChange={(e) => setFormData({ ...formData, transactionReference: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Transaction Date"
                type="date"
                fullWidth
                value={formData.transactionDate ? new Date(formData.transactionDate).toISOString().split('T')[0] : ''}
                onChange={(e) => setFormData({ ...formData, transactionDate: new Date(e.target.value) })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                label="Transaction Amount"
                type="number"
                fullWidth
                value={formData.transactionAmount || ''}
                onChange={(e) => setFormData({ ...formData, transactionAmount: parseFloat(e.target.value) })}
                inputProps={{ step: 0.01 }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Source Document"
                fullWidth
                value={formData.sourceDocument || ''}
                onChange={(e) => setFormData({ ...formData, sourceDocument: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained">
            {selectedTest ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Test Execution Dialog */}
      <Dialog open={openExecutionDialog} onClose={handleCloseExecutionDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          Execute Test: {selectedTest?.title}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            {/* Test Information */}
            <Grid item xs={12}>
              <Card variant="outlined">
                <CardContent>
                  <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                    Test Information
                  </Typography>
                  <Grid container spacing={1}>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Type:</strong> {selectedTest && testTypeLabels[selectedTest.testType]}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Reference:</strong> {selectedTest?.transactionReference || '-'}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Amount:</strong> {selectedTest?.transactionAmount 
                          ? new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(selectedTest.transactionAmount)
                          : '-'}
                      </Typography>
                    </Grid>
                    <Grid item xs={6}>
                      <Typography variant="body2">
                        <strong>Date:</strong> {selectedTest?.transactionDate 
                          ? new Date(selectedTest.transactionDate).toLocaleDateString()
                          : '-'}
                      </Typography>
                    </Grid>
                  </Grid>
                </CardContent>
              </Card>
            </Grid>

            {/* Test Execution */}
            <Grid item xs={12}>
              <TextField
                label="Expected Result"
                fullWidth
                multiline
                rows={3}
                value={executionData.expectedResult}
                onChange={(e) => setExecutionData({ ...executionData, expectedResult: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Actual Result"
                fullWidth
                multiline
                rows={3}
                value={executionData.actualResult}
                onChange={(e) => setExecutionData({ ...executionData, actualResult: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Procedures Performed"
                fullWidth
                multiline
                rows={4}
                value={executionData.proceduresPerformed}
                onChange={(e) => setExecutionData({ ...executionData, proceduresPerformed: e.target.value })}
                placeholder="Describe the detailed procedures performed during this test..."
              />
            </Grid>

            {/* Exception */}
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Checkbox
                    checked={executionData.hasException}
                    onChange={(e) => setExecutionData({ ...executionData, hasException: e.target.checked })}
                  />
                }
                label="Exception Identified"
              />
            </Grid>

            {executionData.hasException && (
              <>
                <Grid item xs={12}>
                  <TextField
                    label="Exception Description"
                    fullWidth
                    multiline
                    rows={3}
                    value={executionData.exceptionDescription}
                    onChange={(e) => setExecutionData({ ...executionData, exceptionDescription: e.target.value })}
                    required
                  />
                </Grid>
                <Grid item xs={12} md={6}>
                  <FormControl fullWidth required>
                    <InputLabel>Exception Severity</InputLabel>
                    <Select
                      value={executionData.exceptionSeverity}
                      onChange={(e) => setExecutionData({ ...executionData, exceptionSeverity: e.target.value as ExceptionSeverity })}
                      label="Exception Severity"
                    >
                      {Object.values(ExceptionSeverity).map((severity) => (
                        <MenuItem key={severity} value={severity}>
                          <Chip
                            label={exceptionSeverityLabels[severity]}
                            color={exceptionSeverityColors[severity] as any}
                            size="small"
                          />
                        </MenuItem>
                      ))}
                    </Select>
                  </FormControl>
                </Grid>
                <Grid item xs={12} md={6}>
                  <TextField
                    label="Exception Amount"
                    type="number"
                    fullWidth
                    value={executionData.exceptionAmount}
                    onChange={(e) => setExecutionData({ ...executionData, exceptionAmount: parseFloat(e.target.value) })}
                    inputProps={{ step: 0.01 }}
                  />
                </Grid>
                <Grid item xs={12}>
                  <TextField
                    label="Management Response"
                    fullWidth
                    multiline
                    rows={3}
                    value={executionData.managementResponse}
                    onChange={(e) => setExecutionData({ ...executionData, managementResponse: e.target.value })}
                    helperText={
                      (executionData.exceptionSeverity === ExceptionSeverity.HIGH || 
                       executionData.exceptionSeverity === ExceptionSeverity.CRITICAL)
                        ? 'Management response required for HIGH/CRITICAL exceptions'
                        : ''
                    }
                    required={
                      executionData.exceptionSeverity === ExceptionSeverity.HIGH || 
                      executionData.exceptionSeverity === ExceptionSeverity.CRITICAL
                    }
                  />
                </Grid>
              </>
            )}

            {/* Conclusion */}
            <Grid item xs={12}>
              <TextField
                label="Test Conclusion"
                fullWidth
                multiline
                rows={3}
                value={executionData.conclusion}
                onChange={(e) => setExecutionData({ ...executionData, conclusion: e.target.value })}
                placeholder="Summarize the overall test conclusion and audit implications..."
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseExecutionDialog}>Cancel</Button>
          <Button onClick={handleSaveExecution} variant="outlined">
            Save Progress
          </Button>
          <Button 
            onClick={handleComplete} 
            variant="contained"
            disabled={!executionData.conclusion}
            startIcon={<CompleteIcon />}
          >
            Complete Test
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default SubstantiveTesting;
