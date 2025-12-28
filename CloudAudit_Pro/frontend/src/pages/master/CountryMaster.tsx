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
  Alert,
  CircularProgress,
  Tooltip,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Refresh as RefreshIcon,
  CloudDownload as SeedIcon,
} from '@mui/icons-material';
import countryService, { Country, CreateCountryDto, UpdateCountryDto } from '../../services/countryService';

const CountryMaster: React.FC = () => {
  const [countries, setCountries] = useState<Country[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [openDialog, setOpenDialog] = useState(false);
  const [editingCountry, setEditingCountry] = useState<Country | null>(null);
  const [formData, setFormData] = useState<CreateCountryDto>({
    name: '',
    code: '',
    dialCode: '',
    isActive: true,
  });

  useEffect(() => {
    loadCountries();
  }, []);

  const loadCountries = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await countryService.getAllCountries();
      setCountries(response.data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load countries');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (country?: Country) => {
    if (country) {
      setEditingCountry(country);
      setFormData({
        name: country.name,
        code: country.code,
        dialCode: country.dialCode || '',
        isActive: country.isActive,
      });
    } else {
      setEditingCountry(null);
      setFormData({
        name: '',
        code: '',
        dialCode: '',
        isActive: true,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingCountry(null);
    setFormData({
      name: '',
      code: '',
      dialCode: '',
      isActive: true,
    });
    setError(null);
  };

  const handleSave = async () => {
    setError(null);
    try {
      if (editingCountry) {
        await countryService.updateCountry(editingCountry.id, formData);
        setSuccess('Country updated successfully');
      } else {
        await countryService.createCountry(formData);
        setSuccess('Country created successfully');
      }
      handleCloseDialog();
      loadCountries();
      setTimeout(() => setSuccess(null), 3000);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save country');
    }
  };

  const handleDelete = async (id: number) => {
    if (!window.confirm('Are you sure you want to delete this country?')) {
      return;
    }

    setError(null);
    try {
      await countryService.deleteCountry(id);
      setSuccess('Country deleted successfully');
      loadCountries();
      setTimeout(() => setSuccess(null), 3000);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to delete country');
    }
  };

  const handleSeedCountries = async () => {
    if (!window.confirm('This will seed the database with common countries. Continue?')) {
      return;
    }

    setLoading(true);
    setError(null);
    try {
      const response = await countryService.seedCountries();
      setSuccess(`Seeded ${response.data.seeded} countries successfully`);
      loadCountries();
      setTimeout(() => setSuccess(null), 5000);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to seed countries');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Country Master</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Tooltip title="Seed common countries">
            <Button
              variant="outlined"
              startIcon={<SeedIcon />}
              onClick={handleSeedCountries}
              disabled={loading}
            >
              Seed Data
            </Button>
          </Tooltip>
          <Button
            variant="outlined"
            startIcon={<RefreshIcon />}
            onClick={loadCountries}
            disabled={loading}
          >
            Refresh
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => handleOpenDialog()}
          >
            New Country
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {success && (
        <Alert severity="success" sx={{ mb: 2 }} onClose={() => setSuccess(null)}>
          {success}
        </Alert>
      )}

      {loading && !openDialog ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 3 }}>
          <CircularProgress />
        </Box>
      ) : (
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Country Name</TableCell>
                <TableCell>Code</TableCell>
                <TableCell>Dial Code</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Created At</TableCell>
                <TableCell align="right">Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {countries.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} align="center" sx={{ py: 3 }}>
                    <Typography color="text.secondary">
                      No countries found. Click "Seed Data" to add common countries.
                    </Typography>
                  </TableCell>
                </TableRow>
              ) : (
                countries.map((country) => (
                  <TableRow key={country.id} hover>
                    <TableCell>{country.name}</TableCell>
                    <TableCell>
                      <Chip label={country.code} size="small" variant="outlined" />
                    </TableCell>
                    <TableCell>{country.dialCode || '-'}</TableCell>
                    <TableCell>
                      <Chip
                        label={country.isActive ? 'Active' : 'Inactive'}
                        color={country.isActive ? 'success' : 'default'}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      {new Date(country.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell align="right">
                      <IconButton
                        size="small"
                        onClick={() => handleOpenDialog(country)}
                        color="primary"
                      >
                        <EditIcon fontSize="small" />
                      </IconButton>
                      <IconButton
                        size="small"
                        onClick={() => handleDelete(country.id)}
                        color="error"
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
      )}

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="sm" fullWidth>
        <DialogTitle>
          {editingCountry ? 'Edit Country' : 'New Country'}
        </DialogTitle>
        <DialogContent>
          <Box sx={{ mt: 2, display: 'flex', flexDirection: 'column', gap: 2 }}>
            <TextField
              label="Country Name"
              fullWidth
              required
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              placeholder="e.g., United States"
            />
            <TextField
              label="Country Code"
              fullWidth
              required
              value={formData.code}
              onChange={(e) => setFormData({ ...formData, code: e.target.value.toUpperCase() })}
              placeholder="e.g., US"
              inputProps={{ maxLength: 2 }}
              helperText="ISO 3166-1 alpha-2 code (2 letters)"
            />
            <TextField
              label="Dial Code"
              fullWidth
              value={formData.dialCode}
              onChange={(e) => setFormData({ ...formData, dialCode: e.target.value })}
              placeholder="e.g., +1"
              helperText="Phone country code (optional)"
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
          {error && (
            <Alert severity="error" sx={{ mt: 2 }}>
              {error}
            </Alert>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button
            onClick={handleSave}
            variant="contained"
            disabled={!formData.name || !formData.code || formData.code.length !== 2}
          >
            {editingCountry ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default CountryMaster;
