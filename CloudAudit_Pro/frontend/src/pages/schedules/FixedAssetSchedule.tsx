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
  MenuItem,
  Grid,
  Alert,
  Chip,
} from '@mui/material';
import { Add, Edit, Delete, Visibility } from '@mui/icons-material';
import fixedAssetService, {
  FixedAsset,
  CreateFixedAssetDto,
  DepreciationMethod,
  AssetStatus,
} from '../../services/fixedAssetService';

const FixedAssetSchedule: React.FC = () => {
  const [assets, setAssets] = useState<FixedAsset[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [editingAsset, setEditingAsset] = useState<FixedAsset | null>(null);
  const [formData, setFormData] = useState<CreateFixedAssetDto>({
    companyId: '',
    periodId: '',
    category: '',
    description: '',
    purchaseDate: new Date().toISOString().split('T')[0],
    originalCost: 0,
    depreciationMethod: DepreciationMethod.STRAIGHT_LINE,
    usefulLife: 5,
    salvageValue: 0,
    status: AssetStatus.ACTIVE,
  });

  useEffect(() => {
    loadAssets();
  }, []);

  const loadAssets = async () => {
    try {
      setLoading(true);
      const response = await fixedAssetService.getAll();
      setAssets(response.data);
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load fixed assets');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (asset?: FixedAsset) => {
    if (asset) {
      setEditingAsset(asset);
      setFormData({
        companyId: asset.companyId,
        periodId: asset.periodId,
        category: asset.category,
        description: asset.description,
        referenceNumber: asset.referenceNumber,
        purchaseDate: asset.purchaseDate.split('T')[0],
        originalCost: asset.originalCost,
        accumulatedDepreciation: asset.accumulatedDepreciation,
        depreciationMethod: asset.depreciationMethod,
        usefulLife: asset.usefulLife,
        salvageValue: asset.salvageValue,
        location: asset.location,
        notes: asset.notes,
        status: asset.status,
        disposalDate: asset.disposalDate?.split('T')[0],
        disposalAmount: asset.disposalAmount,
        isFinished: asset.isFinished,
      });
    } else {
      setEditingAsset(null);
      setFormData({
        companyId: '',
        periodId: '',
        category: '',
        description: '',
        purchaseDate: new Date().toISOString().split('T')[0],
        originalCost: 0,
        depreciationMethod: DepreciationMethod.STRAIGHT_LINE,
        usefulLife: 5,
        salvageValue: 0,
        status: AssetStatus.ACTIVE,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingAsset(null);
  };

  const handleSubmit = async () => {
    try {
      if (editingAsset) {
        await fixedAssetService.update(editingAsset.id, formData);
      } else {
        await fixedAssetService.create(formData);
      }
      await loadAssets();
      handleCloseDialog();
      setError('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save fixed asset');
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this asset?')) {
      try {
        await fixedAssetService.delete(id);
        await loadAssets();
        setError('');
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete fixed asset');
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

  const getStatusColor = (status: AssetStatus) => {
    switch (status) {
      case AssetStatus.ACTIVE:
        return 'success';
      case AssetStatus.DISPOSED:
        return 'error';
      case AssetStatus.FULLY_DEPRECIATED:
        return 'warning';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Fixed Asset Schedule</Typography>
        <Button
          variant="contained"
          startIcon={<Add />}
          onClick={() => handleOpenDialog()}
        >
          Add Asset
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Category</TableCell>
              <TableCell>Description</TableCell>
              <TableCell>Reference</TableCell>
              <TableCell>Purchase Date</TableCell>
              <TableCell align="right">Original Cost</TableCell>
              <TableCell align="right">Accumulated Depreciation</TableCell>
              <TableCell align="right">Depreciation Expense</TableCell>
              <TableCell align="right">Net Book Value</TableCell>
              <TableCell>Method</TableCell>
              <TableCell>Life (Years)</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {assets.map((asset) => (
              <TableRow key={asset.id}>
                <TableCell>{asset.category}</TableCell>
                <TableCell>{asset.description}</TableCell>
                <TableCell>{asset.referenceNumber}</TableCell>
                <TableCell>{formatDate(asset.purchaseDate)}</TableCell>
                <TableCell align="right">{formatCurrency(asset.originalCost)}</TableCell>
                <TableCell align="right">{formatCurrency(asset.accumulatedDepreciation)}</TableCell>
                <TableCell align="right">{formatCurrency(asset.depreciationExpense)}</TableCell>
                <TableCell align="right">{formatCurrency(asset.netBookValue)}</TableCell>
                <TableCell>{asset.depreciationMethod.replace('_', ' ')}</TableCell>
                <TableCell align="center">{asset.usefulLife}</TableCell>
                <TableCell>
                  <Chip
                    label={asset.status}
                    color={getStatusColor(asset.status)}
                    size="small"
                  />
                </TableCell>
                <TableCell>
                  <IconButton size="small" onClick={() => handleOpenDialog(asset)}>
                    <Edit />
                  </IconButton>
                  <IconButton size="small" onClick={() => handleDelete(asset.id)}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{editingAsset ? 'Edit Fixed Asset' : 'Add Fixed Asset'}</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Category"
                value={formData.category}
                onChange={(e) => setFormData({ ...formData, category: e.target.value })}
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
                label="Purchase Date"
                type="date"
                value={formData.purchaseDate}
                onChange={(e) => setFormData({ ...formData, purchaseDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Original Cost"
                type="number"
                value={formData.originalCost}
                onChange={(e) => setFormData({ ...formData, originalCost: parseFloat(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                select
                label="Depreciation Method"
                value={formData.depreciationMethod}
                onChange={(e) => setFormData({ ...formData, depreciationMethod: e.target.value as DepreciationMethod })}
                required
              >
                <MenuItem value={DepreciationMethod.STRAIGHT_LINE}>Straight Line</MenuItem>
                <MenuItem value={DepreciationMethod.DECLINING_BALANCE}>Declining Balance</MenuItem>
                <MenuItem value={DepreciationMethod.UNITS_OF_PRODUCTION}>Units of Production</MenuItem>
              </TextField>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Useful Life (Years)"
                type="number"
                value={formData.usefulLife}
                onChange={(e) => setFormData({ ...formData, usefulLife: parseInt(e.target.value) })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Salvage Value"
                type="number"
                value={formData.salvageValue || 0}
                onChange={(e) => setFormData({ ...formData, salvageValue: parseFloat(e.target.value) })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                select
                label="Status"
                value={formData.status || AssetStatus.ACTIVE}
                onChange={(e) => setFormData({ ...formData, status: e.target.value as AssetStatus })}
                required
              >
                <MenuItem value={AssetStatus.ACTIVE}>Active</MenuItem>
                <MenuItem value={AssetStatus.DISPOSED}>Disposed</MenuItem>
                <MenuItem value={AssetStatus.FULLY_DEPRECIATED}>Fully Depreciated</MenuItem>
              </TextField>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Location"
                value={formData.location || ''}
                onChange={(e) => setFormData({ ...formData, location: e.target.value })}
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
            {editingAsset ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default FixedAssetSchedule;
