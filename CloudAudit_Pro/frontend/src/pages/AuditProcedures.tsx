import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Grid,
  TextField,
  MenuItem,
  Chip,
  IconButton,
  FormControl,
  InputLabel,
  Select,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Alert,
  CircularProgress,
  Checkbox,
  Toolbar,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  DeleteSweep as BulkDeleteIcon,
  Assignment as BulkAssignIcon,
  CheckCircle as BulkStatusIcon,
  ViewKanban as KanbanIcon,
  CalendarToday as CalendarIcon,
} from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';
import apiClient from '../services/api';
import { ProcedureForm } from '../components/forms/ProcedureForm';

interface AuditProcedure {
  id: string;
  name: string;
  description?: string;
  category: string;
  status: string;
  reviewStatus: string;
  priority: string;
  riskLevel: string;
  dueDate?: string;
  company: { name: string; code: string };
  period: { name: string };
  assignedTo?: { firstName: string; lastName: string };
  _count: {
    workpapers: number;
    findings: number;
    comments: number;
  };
}

interface Statistics {
  total: number;
  byStatus: Record<string, number>;
  byPriority: Record<string, number>;
  byRisk: Record<string, number>;
  overdue: number;
}

const statusColors: Record<string, 'default' | 'primary' | 'secondary' | 'error' | 'warning' | 'info' | 'success'> = {
  NOT_STARTED: 'default',
  IN_PROGRESS: 'primary',
  COMPLETED: 'success',
  ON_HOLD: 'warning',
  CANCELLED: 'error',
};

const priorityColors: Record<string, 'default' | 'primary' | 'secondary' | 'error' | 'warning' | 'info' | 'success'> = {
  LOW: 'info',
  MEDIUM: 'primary',
  HIGH: 'warning',
  URGENT: 'error',
};

const AuditProcedures: React.FC = () => {
  const navigate = useNavigate();
  const [procedures, setProcedures] = useState<AuditProcedure[]>([]);
  const [statistics, setStatistics] = useState<Statistics | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  
  // Filters
  const [companyId, setCompanyId] = useState<string>('');
  const [periodId, setPeriodId] = useState<string>('');
  const [status, setStatus] = useState<string>('');
  const [category, setCategory] = useState<string>('');
  const [assignedToId, setAssignedToId] = useState<string>('');
  
  // For dropdowns
  const [companies, setCompanies] = useState<any[]>([]);
  const [periods, setPeriods] = useState<any[]>([]);
  const [users, setUsers] = useState<any[]>([]);
  
  // Dialogs
  const [createFormOpen, setCreateFormOpen] = useState(false);
  const [editFormOpen, setEditFormOpen] = useState(false);
  const [selectedProcedure, setSelectedProcedure] = useState<AuditProcedure | null>(null);
  
  // Bulk operations
  const [selectedIds, setSelectedIds] = useState<string[]>([]);
  const [bulkActionOpen, setBulkActionOpen] = useState(false);
  const [bulkAction, setBulkAction] = useState<'assign' | 'status' | 'delete' | null>(null);

  useEffect(() => {
    loadInitialData();
  }, []);

  useEffect(() => {
    loadProcedures();
    loadStatistics();
  }, [companyId, periodId, status, category, assignedToId]);

  useEffect(() => {
    if (companyId) {
      loadPeriods(companyId);
    }
  }, [companyId]);

  const loadInitialData = async () => {
    try {
      const [companiesRes, usersRes] = await Promise.all([
        apiClient.get('/companies'),
        apiClient.get('/tenant-users'),
      ]);
      setCompanies(companiesRes.data);
      setUsers(usersRes.data);
    } catch (err: any) {
      console.error('Failed to load initial data:', err);
    }
  };

  const loadPeriods = async (companyId: string) => {
    if (!companyId) {
      setPeriods([]);
      return;
    }
    try {
      const response = await apiClient.get(`/periods?companyId=${companyId}`);
      setPeriods(response.data);
    } catch (err: any) {
      console.error('Failed to load periods:', err);
    }
  };

  const loadProcedures = async () => {
    try {
      setLoading(true);
      const params = new URLSearchParams();
      if (companyId) params.append('companyId', companyId);
      if (periodId) params.append('periodId', periodId);
      if (status) params.append('status', status);
      if (category) params.append('category', category);
      if (assignedToId) params.append('assignedToId', assignedToId);

      const response = await apiClient.get(`/procedures?${params}`);
      setProcedures(response.data);
      setError(null);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load procedures');
      console.error('Failed to load procedures:', err);
    } finally {
      setLoading(false);
    }
  };

  const loadStatistics = async () => {
    try {
      const params = new URLSearchParams();
      if (companyId) params.append('companyId', companyId);
      if (periodId) params.append('periodId', periodId);

      const response = await apiClient.get(`/procedures/statistics?${params}`);
      setStatistics(response.data);
    } catch (err: any) {
      console.error('Failed to load statistics:', err);
    }
  };

  const handleCompanyChange = (value: string) => {
    setCompanyId(value);
    setPeriodId('');
    if (value) {
      loadPeriods(value);
    }
  };

  const handleDelete = async (id: string) => {
    if (!window.confirm('Are you sure you want to delete this procedure?')) return;

    try {
      await apiClient.delete(`/procedures/${id}`);
      loadProcedures();
      loadStatistics();
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to delete procedure');
    }
  };
  
  const handleEdit = (procedure: AuditProcedure) => {
    setSelectedProcedure(procedure);
    setEditFormOpen(true);
  };

  // Bulk operations handlers
  const handleSelectAll = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.checked) {
      setSelectedIds(procedures.map(p => p.id));
    } else {
      setSelectedIds([]);
    }
  };

  const handleSelectOne = (id: string) => {
    setSelectedIds(prev => 
      prev.includes(id) ? prev.filter(i => i !== id) : [...prev, id]
    );
  };

  const handleBulkAssign = async (assignedTo: string, dueDate?: string) => {
    try {
      await apiClient.post('/procedures/bulk-assign', {
        procedureIds: selectedIds,
        assignedTo,
        dueDate,
      });
      setSelectedIds([]);
      setBulkActionOpen(false);
      loadProcedures();
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to bulk assign');
    }
  };

  const handleBulkStatusUpdate = async (newStatus: string) => {
    try {
      await Promise.all(
        selectedIds.map(id => 
          apiClient.put(`/procedures/${id}`, { status: newStatus })
        )
      );
      setSelectedIds([]);
      setBulkActionOpen(false);
      loadProcedures();
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to update status');
    }
  };

  const handleBulkDelete = async () => {
    if (!window.confirm(`Are you sure you want to delete ${selectedIds.length} procedures?`)) {
      return;
    }
    try {
      await Promise.all(
        selectedIds.map(id => apiClient.delete(`/procedures/${id}`))
      );
      setSelectedIds([]);
      setBulkActionOpen(false);
      loadProcedures();
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to delete procedures');
    }
  };

  const formatDate = (date?: string) => {
    if (!date) return 'N/A';
    return new Date(date).toLocaleDateString();
  };

  const isOverdue = (dueDate?: string) => {
    if (!dueDate) return false;
    return new Date(dueDate) < new Date();
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Audit Procedures</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button
            variant="outlined"
            startIcon={<KanbanIcon />}
            onClick={() => navigate('/audit/kanban')}
          >
            Kanban View
          </Button>
          <Button
            variant="outlined"
            startIcon={<CalendarIcon />}
            onClick={() => navigate('/audit/calendar')}
          >
            Calendar View
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setCreateFormOpen(true)}
          >
            New Procedure
          </Button>
        </Box>
      </Box>

      {/* Statistics Cards */}
      {statistics && (
        <Grid container spacing={2} sx={{ mb: 3 }}>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Total Procedures
                </Typography>
                <Typography variant="h4">{statistics.total}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  In Progress
                </Typography>
                <Typography variant="h4" color="primary">
                  {statistics.byStatus.IN_PROGRESS || 0}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Completed
                </Typography>
                <Typography variant="h4" color="success.main">
                  {statistics.byStatus.COMPLETED || 0}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card>
              <CardContent>
                <Typography color="textSecondary" gutterBottom>
                  Overdue
                </Typography>
                <Typography variant="h4" color="error">
                  {statistics.overdue}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      )}

      {/* Filters */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Grid container spacing={2}>
            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth size="small">
                <InputLabel>Company</InputLabel>
                <Select
                  value={companyId}
                  onChange={(e) => handleCompanyChange(e.target.value)}
                  label="Company"
                >
                  <MenuItem value="">All Companies</MenuItem>
                  {companies.map((company) => (
                    <MenuItem key={company.id} value={company.id}>
                      {company.name}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth size="small">
                <InputLabel>Period</InputLabel>
                <Select
                  value={periodId}
                  onChange={(e) => setPeriodId(e.target.value)}
                  label="Period"
                  disabled={!companyId}
                >
                  <MenuItem value="">All Periods</MenuItem>
                  {periods.map((period) => (
                    <MenuItem key={period.id} value={period.id}>
                      {period.name}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6} md={2}>
              <FormControl fullWidth size="small">
                <InputLabel>Status</InputLabel>
                <Select
                  value={status}
                  onChange={(e) => setStatus(e.target.value)}
                  label="Status"
                >
                  <MenuItem value="">All Statuses</MenuItem>
                  <MenuItem value="NOT_STARTED">Not Started</MenuItem>
                  <MenuItem value="IN_PROGRESS">In Progress</MenuItem>
                  <MenuItem value="COMPLETED">Completed</MenuItem>
                  <MenuItem value="ON_HOLD">On Hold</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6} md={2}>
              <FormControl fullWidth size="small">
                <InputLabel>Category</InputLabel>
                <Select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  label="Category"
                >
                  <MenuItem value="">All Categories</MenuItem>
                  <MenuItem value="CASH_AND_BANK">Cash & Bank</MenuItem>
                  <MenuItem value="ACCOUNTS_RECEIVABLE">Accounts Receivable</MenuItem>
                  <MenuItem value="INVENTORY">Inventory</MenuItem>
                  <MenuItem value="FIXED_ASSETS">Fixed Assets</MenuItem>
                  <MenuItem value="REVENUE">Revenue</MenuItem>
                  <MenuItem value="EXPENSES">Expenses</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6} md={2}>
              <FormControl fullWidth size="small">
                <InputLabel>Assigned To</InputLabel>
                <Select
                  value={assignedToId}
                  onChange={(e) => setAssignedToId(e.target.value)}
                  label="Assigned To"
                >
                  <MenuItem value="">All Users</MenuItem>
                  {users.map((user) => (
                    <MenuItem key={user.id} value={user.id}>
                      {user.firstName} {user.lastName}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Error Message */}
      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {/* Procedures Table */}
      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', py: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <>
          {/* Bulk Actions Toolbar */}
          {selectedIds.length > 0 && (
            <Toolbar sx={{ bgcolor: 'primary.light', mb: 2, borderRadius: 1 }}>
              <Typography sx={{ flex: '1 1 100%', color: 'white' }} variant="subtitle1">
                {selectedIds.length} selected
              </Typography>
              <Button
                startIcon={<BulkAssignIcon />}
                onClick={() => { setBulkAction('assign'); setBulkActionOpen(true); }}
                sx={{ mr: 1, color: 'white' }}
              >
                Assign
              </Button>
              <Button
                startIcon={<BulkStatusIcon />}
                onClick={() => { setBulkAction('status'); setBulkActionOpen(true); }}
                sx={{ mr: 1, color: 'white' }}
              >
                Update Status
              </Button>
              <Button
                startIcon={<BulkDeleteIcon />}
                onClick={handleBulkDelete}
                sx={{ color: 'white' }}
              >
                Delete
              </Button>
            </Toolbar>
          )}
          
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell padding="checkbox">
                  <Checkbox
                    checked={selectedIds.length === procedures.length && procedures.length > 0}
                    indeterminate={selectedIds.length > 0 && selectedIds.length < procedures.length}
                    onChange={handleSelectAll}
                  />
                </TableCell>
                <TableCell>Procedure</TableCell>
                <TableCell>Company</TableCell>
                <TableCell>Period</TableCell>
                <TableCell>Category</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Priority</TableCell>
                <TableCell>Due Date</TableCell>
                <TableCell>Assigned To</TableCell>
                <TableCell>Items</TableCell>
                <TableCell align="right">Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {procedures.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={11} align="center">
                    No procedures found
                  </TableCell>
                </TableRow>
              ) : (
                procedures.map((procedure) => (
                  <TableRow
                    key={procedure.id}
                    hover
                    selected={selectedIds.includes(procedure.id)}
                  >
                    <TableCell padding="checkbox" onClick={(e) => e.stopPropagation()}>
                      <Checkbox
                        checked={selectedIds.includes(procedure.id)}
                        onChange={() => handleSelectOne(procedure.id)}
                      />
                    </TableCell>
                    <TableCell
                      onClick={() => navigate(`/audit/procedures/${procedure.id}`)}
                      sx={{ cursor: 'pointer' }}
                    >
                      <Typography variant="subtitle2">{procedure.name}</Typography>
                      {procedure.description && (
                        <Typography variant="caption" color="textSecondary">
                          {procedure.description.substring(0, 50)}...
                        </Typography>
                      )}
                    </TableCell>
                    <TableCell>{procedure.company.name}</TableCell>
                    <TableCell>{procedure.period.name}</TableCell>
                    <TableCell>{procedure.category.replace(/_/g, ' ')}</TableCell>
                    <TableCell>
                      <Chip
                        label={procedure.status.replace(/_/g, ' ')}
                        color={statusColors[procedure.status]}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={procedure.priority}
                        color={priorityColors[procedure.priority]}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Typography
                        color={isOverdue(procedure.dueDate) ? 'error' : 'inherit'}
                      >
                        {formatDate(procedure.dueDate)}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      {procedure.assignedTo
                        ? `${procedure.assignedTo.firstName} ${procedure.assignedTo.lastName}`
                        : 'Unassigned'}
                    </TableCell>
                    <TableCell>
                      <Box sx={{ display: 'flex', gap: 1 }}>
                        <Chip label={`${procedure._count.workpapers} WP`} size="small" />
                        <Chip label={`${procedure._count.findings} F`} size="small" color="warning" />
                      </Box>
                    </TableCell>
                    <TableCell align="right">
                      <IconButton
                        size="small"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleEdit(procedure);
                        }}
                      >
                        <EditIcon fontSize="small" />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleDelete(procedure.id);
                        }}
                      >
                        <DeleteIcon fontSize="small" />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </TableContainer>
        </>
      )}
      
      {/* Dialogs */}
      <ProcedureForm
        open={createFormOpen}
        onClose={() => setCreateFormOpen(false)}
        onSuccess={() => {
          loadProcedures();
          loadStatistics();
        }}
      />

      <ProcedureForm
        open={editFormOpen}
        onClose={() => {
          setEditFormOpen(false);
          setSelectedProcedure(null);
        }}
        onSuccess={() => {
          loadProcedures();
          loadStatistics();
        }}
        procedureId={selectedProcedure?.id}
        initialData={selectedProcedure}
      />

      {/* Bulk Action Dialogs */}
      <Dialog open={bulkActionOpen} onClose={() => setBulkActionOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>
          {bulkAction === 'assign' && 'Bulk Assign Procedures'}
          {bulkAction === 'status' && 'Update Status'}
        </DialogTitle>
        <DialogContent>
          {bulkAction === 'assign' && (
            <Box sx={{ mt: 2 }}>
              <FormControl fullWidth sx={{ mb: 2 }}>
                <InputLabel>Assign To</InputLabel>
                <Select
                  value=""
                  onChange={(e) => {
                    const assignedTo = e.target.value;
                    handleBulkAssign(assignedTo);
                  }}
                  label="Assign To"
                >
                  {users.map((user) => (
                    <MenuItem key={user.id} value={user.id}>
                      {user.firstName} {user.lastName}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Box>
          )}
          {bulkAction === 'status' && (
            <Box sx={{ mt: 2 }}>
              <FormControl fullWidth>
                <InputLabel>New Status</InputLabel>
                <Select
                  value=""
                  onChange={(e) => handleBulkStatusUpdate(e.target.value)}
                  label="New Status"
                >
                  <MenuItem value="NOT_STARTED">Not Started</MenuItem>
                  <MenuItem value="IN_PROGRESS">In Progress</MenuItem>
                  <MenuItem value="COMPLETED">Completed</MenuItem>
                  <MenuItem value="ON_HOLD">On Hold</MenuItem>
                  <MenuItem value="REVIEW_REQUIRED">Review Required</MenuItem>
                </Select>
              </FormControl>
            </Box>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setBulkActionOpen(false)}>Cancel</Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default AuditProcedures;
