import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Typography,
  IconButton,
  Chip,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControlLabel,
  Checkbox,
  MenuItem,
  Alert,
  CircularProgress,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import bankService, { Bank, CreateBankDto, UpdateBankDto, BankType } from '../../services/bankService';

const BankMaster: React.FC = () => {
  const [banks, setBanks] = useState<Bank[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [openDialog, setOpenDialog] = useState(false);
  const [editingBank, setEditingBank] = useState<Bank | null>(null);
  const [formData, setFormData] = useState<CreateBankDto>({
    name: '',
    code: '',
    type: BankType.COMMERCIAL,
    address: '',
    contactNumber: '',
    email: '',
    website: '',
    isActive: true,
  });

  useEffect(() => {
    loadBanks();
  }, []);

  const loadBanks = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await bankService.getAllBanks();
      setBanks(response.data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load banks');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (bank?: Bank) => {
    if (bank) {
      setEditingBank(bank);
      setFormData({
        name: bank.name,
        code: bank.code || '',
        type: bank.type || BankType.COMMERCIAL,
        address: bank.address || '',
        contactNumber: bank.contactNumber || '',
        email: bank.email || '',
        website: bank.website || '',
        isActive: bank.isActive,
      });
    } else {
      setEditingBank(null);
      setFormData({
        name: '',
        code: '',
        type: BankType.COMMERCIAL,
        address: '',
        contactNumber: '',
        email: '',
        website: '',
        isActive: true,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingBank(null);
  };

  const handleSubmit = async () => {
    try {
      setError(null);
      if (editingBank) {
        await bankService.updateBank(editingBank.id, formData);
      } else {
        await bankService.createBank(formData);
      }
      handleCloseDialog();
      loadBanks();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save bank');
    }
  };

  const handleDelete = async (id: number) => {
    if (window.confirm('Are you sure you want to delete this bank?')) {
      try {
        setError(null);
        await bankService.deleteBank(id);
        loadBanks();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete bank');
      }
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Bank Master</Typography>
        <Box>
          <Button
            variant="outlined"
            startIcon={<RefreshIcon />}
            onClick={loadBanks}
            sx={{ mr: 1 }}
          >
            Refresh
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => handleOpenDialog()}
          >
            Add Bank
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Bank Name</TableCell>
                <TableCell>Code</TableCell>
                <TableCell>Type</TableCell>
                <TableCell>Contact</TableCell>
                <TableCell>Status</TableCell>
                <TableCell align="right">Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {banks.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} align="center">
                    No banks found
                  </TableCell>
                </TableRow>
              ) : (
                banks.map((bank) => (
                  <TableRow key={bank.id}>
                    <TableCell>{bank.name}</TableCell>
                    <TableCell>{bank.code || '-'}</TableCell>
                    <TableCell>{bank.type || '-'}</TableCell>
                    <TableCell>{bank.contactNumber || '-'}</TableCell>
                    <TableCell>
                      <Chip
                        label={bank.isActive ? 'Active' : 'Inactive'}
                        color={bank.isActive ? 'success' : 'default'}
                        size="small"
                      />
                    </TableCell>
                    <TableCell align="right">
                      <IconButton
                        size="small"
                        onClick={() => handleOpenDialog(bank)}
                        color="primary"
                      >
                        <EditIcon />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleDelete(bank.id)}
                        color="error"
                      >
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </TableContainer>
      )}

      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          {editingBank ? 'Edit Bank' : 'Add Bank'}
        </DialogTitle>
        <DialogContent>
          <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2, mt: 2 }}>
            <TextField
              label="Bank Name"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              fullWidth
              required
            />
            <Box sx={{ display: 'flex', gap: 2 }}>
              <TextField
                label="Bank Code / SWIFT"
                value={formData.code}
                onChange={(e) => setFormData({ ...formData, code: e.target.value.toUpperCase() })}
                fullWidth
              />
              <TextField
                label="Bank Type"
                value={formData.type}
                onChange={(e) => setFormData({ ...formData, type: e.target.value as BankType })}
                select
                fullWidth
              >
                {Object.values(BankType).map((type) => (
                  <MenuItem key={type} value={type}>
                    {type}
                  </MenuItem>
                ))}
              </TextField>
            </Box>
            <TextField
              label="Address"
              value={formData.address}
              onChange={(e) => setFormData({ ...formData, address: e.target.value })}
              fullWidth
              multiline
              rows={2}
            />
            <Box sx={{ display: 'flex', gap: 2 }}>
              <TextField
                label="Contact Number"
                value={formData.contactNumber}
                onChange={(e) => setFormData({ ...formData, contactNumber: e.target.value })}
                fullWidth
              />
              <TextField
                label="Email"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                type="email"
                fullWidth
              />
            </Box>
            <TextField
              label="Website"
              value={formData.website}
              onChange={(e) => setFormData({ ...formData, website: e.target.value })}
              fullWidth
            />
            <FormControlLabel
              control={
                <Checkbox
                  checked={formData.isActive}
                  onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                />
              }
              label="Active"
            />
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button
            onClick={handleSubmit}
            variant="contained"
            disabled={!formData.name}
          >
            {editingBank ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default BankMaster;
