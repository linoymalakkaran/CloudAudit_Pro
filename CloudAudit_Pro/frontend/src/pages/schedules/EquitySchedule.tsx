import React, { useState, useEffect } from 'react';
import {
  Box,
  Paper,
  Typography,
  Button,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Grid,
  Alert,
  Card,
  CardContent,
} from '@mui/material';
import { Add, Edit, Delete } from '@mui/icons-material';
import equityService, {
  Equity,
  CreateEquityDto,
} from '../../services/equityService';

const EquitySchedule: React.FC = () => {
  const [equities, setEquities] = useState<Equity[]>([]);
  const [summary, setSummary] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [editingEquity, setEditingEquity] = useState<Equity | null>(null);
  const [formData, setFormData] = useState<CreateEquityDto>({
    companyId: '',
    periodId: '',
    type: '',
    description: '',
    openingBalance: 0,
    additions: 0,
    reductions: 0,
    closingBalance: 0,
  });

  useEffect(() => {
    loadEquities();
  }, []);

  const loadEquities = async () => {
    try {
      setLoading(true);
      const response = await equityService.getAll();
      setEquities(response.data);
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load equity records');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (equity?: Equity) => {
    if (equity) {
      setEditingEquity(equity);
      setFormData({
        companyId: equity.companyId,
        periodId: equity.periodId,
        type: equity.type,
        description: equity.description,
        openingBalance: equity.openingBalance,
        additions: equity.additions,
        reductions: equity.reductions,
        closingBalance: equity.closingBalance,
        transactionDate: equity.transactionDate?.split('T')[0],
        referenceNumber: equity.referenceNumber,
        notes: equity.notes,
        isFinished: equity.isFinished,
      });
    } else {
      setEditingEquity(null);
      setFormData({
        companyId: '',
        periodId: '',
        type: '',
        description: '',
        openingBalance: 0,
        additions: 0,
        reductions: 0,
        closingBalance: 0,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingEquity(null);
  };

  const handleSubmit = async () => {
    try {
      if (editingEquity) {
        await equityService.update(editingEquity.id, formData);
      } else {
        await equityService.create(formData);
      }
      await loadEquities();
      handleCloseDialog();
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save equity record');
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this equity record?')) {
      try {
        await equityService.delete(id);
        await loadEquities();
        setError('');
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete equity record');
      }
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(value);
  };

  const formatDate = (date?: string) => {
    return date ? new Date(date).toLocaleDateString() : '-';
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Equity Schedule</Typography>
        <Button
          variant="contained"
          startIcon={<Add />}
          onClick={() => handleOpenDialog()}
        >
          Add Equity Entry
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {summary.length > 0 && (
        <Grid container spacing={2} sx={{ mb: 3 }}>
          {summary.map((item, index) => (
            <Grid item xs={12} sm={6} md={3} key={index}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    {item.type}
                  </Typography>
                  <Typography variant="body2">
                    Opening: {formatCurrency(item.totalOpeningBalance)}
                  </Typography>
                  <Typography variant="body2" color="success.main">
                    Additions: {formatCurrency(item.totalAdditions)}
                  </Typography>
                  <Typography variant="body2" color="error.main">
                    Reductions: {formatCurrency(item.totalReductions)}
                  </Typography>
                  <Typography variant="h6">
                    Closing: {formatCurrency(item.totalClosingBalance)}
                  </Typography>
                  <Typography variant="body2" color="textSecondary">
                    Movement: {formatCurrency(item.totalMovement)}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Type</TableCell>
              <TableCell>Description</TableCell>
              <TableCell>Reference</TableCell>
              <TableCell>Transaction Date</TableCell>
              <TableCell align="right">Opening Balance</TableCell>
              <TableCell align="right">Additions</TableCell>
              <TableCell align="right">Reductions</TableCell>
              <TableCell align="right">Movement</TableCell>
              <TableCell align="right">Closing Balance</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {equities.map((equity) => (
              <TableRow key={equity.id}>
                <TableCell>{equity.type}</TableCell>
                <TableCell>{equity.description}</TableCell>
                <TableCell>{equity.referenceNumber}</TableCell>
                <TableCell>{formatDate(equity.transactionDate)}</TableCell>
                <TableCell align="right">{formatCurrency(equity.openingBalance)}</TableCell>
                <TableCell align="right" sx={{ color: 'success.main' }}>
                  {formatCurrency(equity.additions)}
                </TableCell>
                <TableCell align="right" sx={{ color: 'error.main' }}>
                  {formatCurrency(equity.reductions)}
                </TableCell>
                <TableCell align="right">
                  {formatCurrency(equity.movement)}
                </TableCell>
                <TableCell align="right" sx={{ fontWeight: 'bold' }}>
                  {formatCurrency(equity.closingBalance)}
                </TableCell>
                <TableCell>
                  <IconButton size="small" onClick={() => handleOpenDialog(equity)}>
                    <Edit />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleDelete(equity.id)}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{editingEquity ? 'Edit Equity Entry' : 'Add Equity Entry'}</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Type"
                value={formData.type}
                onChange={(e) => setFormData({ ...formData, type: e.target.value })}
                placeholder="e.g., Share Capital, Retained Earnings, Reserves"
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Reference Number"
                value={formData.referenceNumber || ''}
                onChange={(e) => setFormData({ ...formData, referenceNumber: e.target.value })}
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
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Transaction Date"
                type="date"
                value={formData.transactionDate || ''}
                onChange={(e) => setFormData({ ...formData, transactionDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Opening Balance"
                type="number"
                value={formData.openingBalance}
                onChange={(e) => setFormData({ ...formData, openingBalance: parseFloat(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Additions"
                type="number"
                value={formData.additions || 0}
                onChange={(e) => setFormData({ ...formData, additions: parseFloat(e.target.value) })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Reductions"
                type="number"
                value={formData.reductions || 0}
                onChange={(e) => setFormData({ ...formData, reductions: parseFloat(e.target.value) })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Closing Balance"
                type="number"
                value={formData.closingBalance}
                onChange={(e) => setFormData({ ...formData, closingBalance: parseFloat(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Notes"
                value={formData.notes || ''}
                onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSubmit} variant="contained">
            {editingEquity ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default EquitySchedule;
