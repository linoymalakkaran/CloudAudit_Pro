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
  Chip,
  Card,
  CardContent,
} from '@mui/material';
import { Add, Edit, Delete } from '@mui/icons-material';
import liabilityService, {
  Liability,
  CreateLiabilityDto,
} from '../../services/liabilityService';

const LiabilitySchedule: React.FC = () => {
  const [liabilities, setLiabilities] = useState<Liability[]>([]);
  const [agingSummary, setAgingSummary] = useState<any>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [editingLiability, setEditingLiability] = useState<Liability | null>(null);
  const [formData, setFormData] = useState<CreateLiabilityDto>({
    companyId: '',
    periodId: '',
    type: '',
    creditorName: '',
    description: '',
    originalAmount: 0,
    outstandingBalance: 0,
    dueDate: new Date().toISOString().split('T')[0],
    isCurrent: true,
  });

  useEffect(() => {
    loadLiabilities();
  }, []);

  const loadLiabilities = async () => {
    try {
      setLoading(true);
      const response = await liabilityService.getAll();
      setLiabilities(response.data);
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load liabilities');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (liability?: Liability) => {
    if (liability) {
      setEditingLiability(liability);
      setFormData({
        companyId: liability.companyId,
        periodId: liability.periodId,
        type: liability.type,
        creditorName: liability.creditorName,
        description: liability.description,
        referenceNumber: liability.referenceNumber,
        originalAmount: liability.originalAmount,
        outstandingBalance: liability.outstandingBalance,
        dueDate: liability.dueDate.split('T')[0],
        interestRate: liability.interestRate,
        paymentTerms: liability.paymentTerms,
        collateral: liability.collateral,
        notes: liability.notes,
        isCurrent: liability.isCurrent,
        isFinished: liability.isFinished,
      });
    } else {
      setEditingLiability(null);
      setFormData({
        companyId: '',
        periodId: '',
        type: '',
        creditorName: '',
        description: '',
        originalAmount: 0,
        outstandingBalance: 0,
        dueDate: new Date().toISOString().split('T')[0],
        isCurrent: true,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingLiability(null);
  };

  const handleSubmit = async () => {
    try {
      if (editingLiability) {
        await liabilityService.update(editingLiability.id, formData);
      } else {
        await liabilityService.create(formData);
      }
      await loadLiabilities();
      handleCloseDialog();
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save liability');
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this liability?')) {
      try {
        await liabilityService.delete(id);
        await loadLiabilities();
        setError('');
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete liability');
      }
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(value);
  };

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString();
  };

  const getAgingColor = (category: string) => {
    switch (category) {
      case 'CURRENT':
        return 'success';
      case '1-30':
        return 'info';
      case '31-60':
        return 'warning';
      case '61-90':
        return 'error';
      case 'OVER_90':
        return 'error';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Liability Schedule</Typography>
        <Button
          variant="contained"
          startIcon={<Add />}
          onClick={() => handleOpenDialog()}
        >
          Add Liability
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {agingSummary && (
        <Grid container spacing={2} sx={{ mb: 3 }}>
          {Object.entries(agingSummary).map(([category, amount]: [string, any]) => (
            <Grid item xs={12} sm={6} md={2.4} key={category}>
              <Card>
                <CardContent>
                  <Typography color="textSecondary" gutterBottom>
                    {category.replace('_', ' ')}
                  </Typography>
                  <Typography variant="h6">
                    {formatCurrency(amount)}
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
              <TableCell>Creditor</TableCell>
              <TableCell>Description</TableCell>
              <TableCell>Reference</TableCell>
              <TableCell align="right">Original Amount</TableCell>
              <TableCell align="right">Outstanding Balance</TableCell>
              <TableCell>Due Date</TableCell>
              <TableCell>Days Overdue</TableCell>
              <TableCell>Aging</TableCell>
              <TableCell>Current/Non-Current</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {liabilities.map((liability) => (
              <TableRow key={liability.id}>
                <TableCell>{liability.type}</TableCell>
                <TableCell>{liability.creditorName}</TableCell>
                <TableCell>{liability.description}</TableCell>
                <TableCell>{liability.referenceNumber}</TableCell>
                <TableCell align="right">{formatCurrency(liability.originalAmount)}</TableCell>
                <TableCell align="right">{formatCurrency(liability.outstandingBalance)}</TableCell>
                <TableCell>{formatDate(liability.dueDate)}</TableCell>
                <TableCell align="center">{liability.daysOverdue}</TableCell>
                <TableCell>
                  <Chip
                    label={liability.agingCategory}
                    color={getAgingColor(liability.agingCategory)}
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <Chip
                    label={liability.isCurrent ? 'Current' : 'Non-Current'}
                    color={liability.isCurrent ? 'success' : 'warning'}
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <IconButton size="small" onClick={() => handleOpenDialog(liability)}>
                    <Edit />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleDelete(liability.id)}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{editingLiability ? 'Edit Liability' : 'Add Liability'}</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Type"
                value={formData.type}
                onChange={(e) => setFormData({ ...formData, type: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Creditor Name"
                value={formData.creditorName}
                onChange={(e) => setFormData({ ...formData, creditorName: e.target.value })}
                required
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
                label="Reference Number"
                value={formData.referenceNumber || ''}
                onChange={(e) => setFormData({ ...formData, referenceNumber: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Due Date"
                type="date"
                value={formData.dueDate}
                onChange={(e) => setFormData({ ...formData, dueDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Original Amount"
                type="number"
                value={formData.originalAmount}
                onChange={(e) => setFormData({ ...formData, originalAmount: parseFloat(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Outstanding Balance"
                type="number"
                value={formData.outstandingBalance}
                onChange={(e) => setFormData({ ...formData, outstandingBalance: parseFloat(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Interest Rate (%)"
                type="number"
                value={formData.interestRate || ''}
                onChange={(e) => setFormData({ ...formData, interestRate: parseFloat(e.target.value) })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Payment Terms"
                value={formData.paymentTerms || ''}
                onChange={(e) => setFormData({ ...formData, paymentTerms: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Collateral"
                value={formData.collateral || ''}
                onChange={(e) => setFormData({ ...formData, collateral: e.target.value })}
                multiline
                rows={2}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Notes"
                value={formData.notes || ''}
                onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
                multiline
                rows={2}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSubmit} variant="contained">
            {editingLiability ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default LiabilitySchedule;
