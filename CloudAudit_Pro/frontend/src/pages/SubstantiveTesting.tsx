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
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  PlayArrow as StartIcon,
  CheckCircle as CompleteIcon,
  Warning as ExceptionIcon,
} from '@mui/icons-material';
import substantiveTestingService, { SubstantiveTest, CreateSubstantiveTestDto } from '../services/substantiveTestingService';

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

const SubstantiveTesting: React.FC = () => {
  const [tests, setTests] = useState<SubstantiveTest[]>([]);
  const [exceptions, setExceptions] = useState<SubstantiveTest[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openResultsDialog, setOpenResultsDialog] = useState(false);
  const [selectedTest, setSelectedTest] = useState<SubstantiveTest | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [summary, setSummary] = useState<any>(null);
  const [error, setError] = useState<string>('');

  const [formData, setFormData] = useState<CreateSubstantiveTestDto>({
    companyId: localStorage.getItem('selectedCompanyId') || '',
    periodId: localStorage.getItem('selectedPeriodId') || '',
    title: '',
    testType: 'VOUCHING',
  });

  const [resultsData, setResultsData] = useState({
    actualResult: '',
    proceduresPerformed: '',
    hasException: false,
    exceptionDescription: '',
    exceptionSeverity: 'LOW' as any,
    exceptionAmount: 0,
  });

  useEffect(() => {
    loadTests();
    loadSummary();
    loadExceptions();
  }, []);

  const loadTests = async () => {
    try {
      setLoading(true);
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await substantiveTestingService.getAll(companyId, periodId || undefined);
      setTests(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load tests');
    } finally {
      setLoading(false);
    }
  };

  const loadSummary = async () => {
    try {
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await substantiveTestingService.getSummary(companyId, periodId || undefined);
      setSummary(data);
    } catch (err) {
      console.error('Failed to load summary:', err);
    }
  };

  const loadExceptions = async () => {
    try {
      const companyId = localStorage.getItem('selectedCompanyId') || '';
      const periodId = localStorage.getItem('selectedPeriodId');
      const data = await substantiveTestingService.getExceptions(companyId, periodId || undefined);
      setExceptions(data);
    } catch (err) {
      console.error('Failed to load exceptions:', err);
    }
  };

  const handleOpenDialog = (test?: SubstantiveTest) => {
    if (test) {
      setSelectedTest(test);
      setFormData({
        companyId: test.companyId,
        periodId: test.periodId,
        procedureId: test.procedureId,
        accountId: test.accountId,
        samplingId: test.samplingId,
        title: test.title,
        description: test.description,
        testType: test.testType,
        transactionReference: test.transactionReference,
        transactionDate: test.transactionDate ? new Date(test.transactionDate).toISOString().split('T')[0] : undefined,
        transactionAmount: test.transactionAmount,
        sourceDocument: test.sourceDocument,
        expectedResult: test.expectedResult,
      });
    } else {
      setSelectedTest(null);
      setFormData({
        companyId: localStorage.getItem('selectedCompanyId') || '',
        periodId: localStorage.getItem('selectedPeriodId') || '',
        title: '',
        testType: 'VOUCHING',
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedTest(null);
  };

  const handleOpenResultsDialog = (test: SubstantiveTest) => {
    setSelectedTest(test);
    setResultsData({
      actualResult: test.actualResult || '',
      proceduresPerformed: test.proceduresPerformed || '',
      hasException: test.hasException,
      exceptionDescription: test.exceptionDescription || '',
      exceptionSeverity: test.exceptionSeverity || 'LOW',
      exceptionAmount: test.exceptionAmount || 0,
    });
    setOpenResultsDialog(true);
  };

  const handleCloseResultsDialog = () => {
    setOpenResultsDialog(false);
    setSelectedTest(null);
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      if (selectedTest) {
        await substantiveTestingService.update(selectedTest.id, formData);
      } else {
        await substantiveTestingService.create(formData);
      }
      await loadTests();
      await loadSummary();
      handleCloseDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save test');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this test?')) {
      try {
        setLoading(true);
        await substantiveTestingService.delete(id);
        await loadTests();
        await loadSummary();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete test');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleStartTest = async (id: string) => {
    try {
      setLoading(true);
      await substantiveTestingService.startTest(id);
      await loadTests();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to start test');
    } finally {
      setLoading(false);
    }
  };

  const handleSaveResults = async () => {
    if (!selectedTest) return;
    try {
      setLoading(true);
      await substantiveTestingService.recordResults(selectedTest.id, resultsData);
      await loadTests();
      await loadSummary();
      await loadExceptions();
      handleCloseResultsDialog();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save results');
    } finally {
      setLoading(false);
    }
  };

  const handleCompleteTest = async (id: string) => {
    const conclusion = prompt('Enter test conclusion:');
    if (conclusion) {
      try {
        setLoading(true);
        await substantiveTestingService.complete(id, { conclusion });
        await loadTests();
        await loadSummary();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to complete test');
      } finally {
        setLoading(false);
      }
    }
  };

  const getStatusColor = (status: string) => {
    const colors: any = {
      PLANNED: 'default',
      IN_PROGRESS: 'warning',
      COMPLETED: 'success',
      REVIEWED: 'info',
    };
    return colors[status] || 'default';
  };

  const getSeverityColor = (severity: string) => {
    const colors: any = {
      LOW: 'info',
      MEDIUM: 'warning',
      HIGH: 'error',
      CRITICAL: 'error',
    };
    return colors[severity] || 'default';
  };

  const getTestTypeLabel = (type: string) => {
    const labels: any = {
      VOUCHING: 'Vouching',
      TRACING: 'Tracing',
      RECALCULATION: 'Recalculation',
      REPERFORMANCE: 'Reperformance',
      OBSERVATION: 'Observation',
      INSPECTION: 'Inspection',
      CONFIRMATION: 'Confirmation',
      ANALYTICAL: 'Analytical',
    };
    return labels[type] || type;
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Substantive Testing</Typography>
        <Button variant="contained" startIcon={<AddIcon />} onClick={() => handleOpenDialog()}>
          New Test
        </Button>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ mb: 2 }}>
        <Tab label="All Tests" />
        <Tab label="Exceptions" icon={<ExceptionIcon />} iconPosition="end" />
        <Tab label="Summary" />
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
                  <TableCell>Test Type</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell>Transaction Ref</TableCell>
                  <TableCell align="right">Amount</TableCell>
                  <TableCell>Exception</TableCell>
                  <TableCell align="center">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {tests.map((test) => (
                  <TableRow key={test.id}>
                    <TableCell>{test.title}</TableCell>
                    <TableCell>{getTestTypeLabel(test.testType)}</TableCell>
                    <TableCell>
                      <Chip label={test.status.replace(/_/g, ' ')} color={getStatusColor(test.status) as any} size="small" />
                    </TableCell>
                    <TableCell>{test.transactionReference || '-'}</TableCell>
                    <TableCell align="right">
                      {test.transactionAmount ? test.transactionAmount.toLocaleString() : '-'}
                    </TableCell>
                    <TableCell>
                      {test.hasException ? (
                        <Chip
                          label={test.exceptionSeverity}
                          color={getSeverityColor(test.exceptionSeverity!) as any}
                          size="small"
                          icon={<ExceptionIcon />}
                        />
                      ) : (
                        '-'
                      )}
                    </TableCell>
                    <TableCell align="center">
                      <IconButton size="small" onClick={() => handleOpenDialog(test)} title="Edit">
                        <EditIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleStartTest(test.id)}
                        disabled={test.status !== 'PLANNED'}
                        title="Start Test"
                      >
                        <StartIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleOpenResultsDialog(test)}
                        disabled={test.status !== 'IN_PROGRESS'}
                        title="Record Results"
                      >
                        <EditIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleCompleteTest(test.id)}
                        disabled={test.status !== 'IN_PROGRESS'}
                        title="Complete"
                      >
                        <CompleteIcon />
                      </IconButton>
                      <IconButton size="small" onClick={() => handleDelete(test.id)} title="Delete">
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
                {tests.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={7} align="center">
                      No tests found
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        )}
      </TabPanel>

      <TabPanel value={tabValue} index={1}>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Title</TableCell>
                <TableCell>Severity</TableCell>
                <TableCell>Exception Description</TableCell>
                <TableCell align="right">Exception Amount</TableCell>
                <TableCell>Management Response</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {exceptions.map((test) => (
                <TableRow key={test.id}>
                  <TableCell>{test.title}</TableCell>
                  <TableCell>
                    <Chip
                      label={test.exceptionSeverity}
                      color={getSeverityColor(test.exceptionSeverity!) as any}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>{test.exceptionDescription}</TableCell>
                  <TableCell align="right">
                    {test.exceptionAmount ? test.exceptionAmount.toLocaleString() : '-'}
                  </TableCell>
                  <TableCell>{test.managementResponse || 'Pending'}</TableCell>
                </TableRow>
              ))}
              {exceptions.length === 0 && (
                <TableRow>
                  <TableCell colSpan={5} align="center">
                    No exceptions found
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
                    Total Tests
                  </Typography>
                  <Typography variant="h4">{summary.totalTests || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Completed
                  </Typography>
                  <Typography variant="h4">{summary.completedTests || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    In Progress
                  </Typography>
                  <Typography variant="h4">{summary.inProgressTests || 0}</Typography>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={3}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    Exceptions
                  </Typography>
                  <Typography variant="h4" color="error">
                    {summary.totalExceptions || 0}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        )}
      </TabPanel>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{selectedTest ? 'Edit' : 'Create'} Test</DialogTitle>
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
                <InputLabel>Test Type</InputLabel>
                <Select
                  value={formData.testType}
                  label="Test Type"
                  onChange={(e) => setFormData({ ...formData, testType: e.target.value })}
                >
                  <MenuItem value="VOUCHING">Vouching</MenuItem>
                  <MenuItem value="TRACING">Tracing</MenuItem>
                  <MenuItem value="RECALCULATION">Recalculation</MenuItem>
                  <MenuItem value="REPERFORMANCE">Reperformance</MenuItem>
                  <MenuItem value="OBSERVATION">Observation</MenuItem>
                  <MenuItem value="INSPECTION">Inspection</MenuItem>
                  <MenuItem value="CONFIRMATION">Confirmation</MenuItem>
                  <MenuItem value="ANALYTICAL">Analytical</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Transaction Reference"
                value={formData.transactionReference || ''}
                onChange={(e) => setFormData({ ...formData, transactionReference: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Transaction Date"
                type="date"
                InputLabelProps={{ shrink: true }}
                value={formData.transactionDate || ''}
                onChange={(e) => setFormData({ ...formData, transactionDate: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Transaction Amount"
                type="number"
                value={formData.transactionAmount || ''}
                onChange={(e) => setFormData({ ...formData, transactionAmount: Number(e.target.value) })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Source Document"
                value={formData.sourceDocument || ''}
                onChange={(e) => setFormData({ ...formData, sourceDocument: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Expected Result"
                multiline
                rows={2}
                value={formData.expectedResult || ''}
                onChange={(e) => setFormData({ ...formData, expectedResult: e.target.value })}
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

      {/* Record Results Dialog */}
      <Dialog open={openResultsDialog} onClose={handleCloseResultsDialog} maxWidth="md" fullWidth>
        <DialogTitle>Record Test Results</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Procedures Performed"
                multiline
                rows={3}
                value={resultsData.proceduresPerformed}
                onChange={(e) => setResultsData({ ...resultsData, proceduresPerformed: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Actual Result"
                multiline
                rows={3}
                value={resultsData.actualResult}
                onChange={(e) => setResultsData({ ...resultsData, actualResult: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Switch
                    checked={resultsData.hasException}
                    onChange={(e) => setResultsData({ ...resultsData, hasException: e.target.checked })}
                  />
                }
                label="Exception Identified"
              />
            </Grid>
            {resultsData.hasException && (
              <>
                <Grid item xs={12} sm={6}>
                  <FormControl fullWidth>
                    <InputLabel>Exception Severity</InputLabel>
                    <Select
                      value={resultsData.exceptionSeverity}
                      label="Exception Severity"
                      onChange={(e) => setResultsData({ ...resultsData, exceptionSeverity: e.target.value as any })}
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
                    label="Exception Amount"
                    type="number"
                    value={resultsData.exceptionAmount}
                    onChange={(e) => setResultsData({ ...resultsData, exceptionAmount: Number(e.target.value) })}
                  />
                </Grid>
                <Grid item xs={12}>
                  <TextField
                    fullWidth
                    label="Exception Description"
                    multiline
                    rows={3}
                    value={resultsData.exceptionDescription}
                    onChange={(e) => setResultsData({ ...resultsData, exceptionDescription: e.target.value })}
                    required
                  />
                </Grid>
              </>
            )}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseResultsDialog}>Cancel</Button>
          <Button onClick={handleSaveResults} variant="contained" disabled={loading}>
            {loading ? <CircularProgress size={24} /> : 'Save Results'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default SubstantiveTesting;
