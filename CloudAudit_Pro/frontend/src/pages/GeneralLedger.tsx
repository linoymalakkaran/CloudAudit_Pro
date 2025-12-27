import React, { useState, useEffect } from 'react';
import {
  Box,
  Paper,
  Typography,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Button,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  TextField,
  Grid,
  CircularProgress,
  Alert,
  Chip,
  Stack,
} from '@mui/material';
import {
  Download as DownloadIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import apiClient from '../services/api';

interface LedgerEntry {
  id: string;
  transactionDate: string;
  journalNumber: string;
  description: string;
  reference: string;
  debitAmount: number;
  creditAmount: number;
  runningBalance: number;
  account: {
    name: string;
    code: string;
    accountType: {
      name: string;
      normalBalance: string;
    };
  };
}

interface LedgerData {
  openingBalance: number;
  entries: LedgerEntry[];
  closingBalance: number;
}

interface Company {
  id: string;
  name: string;
  code: string;
}

interface Period {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
}

interface Account {
  id: string;
  name: string;
  code: string;
  accountType: {
    name: string;
  };
}

const GeneralLedger: React.FC = () => {
  const [companies, setCompanies] = useState<Company[]>([]);
  const [periods, setPeriods] = useState<Period[]>([]);
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [selectedCompany, setSelectedCompany] = useState<string>('');
  const [selectedPeriod, setSelectedPeriod] = useState<string>('');
  const [selectedAccount, setSelectedAccount] = useState<string>('');
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);
  const [ledgerData, setLedgerData] = useState<LedgerData | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Load companies on mount
  useEffect(() => {
    loadCompanies();
  }, []);

  // Load periods when company changes
  useEffect(() => {
    if (selectedCompany) {
      loadPeriods(selectedCompany);
      loadAccounts(selectedCompany);
    }
  }, [selectedCompany]);

  const loadCompanies = async () => {
    try {
      const response = await apiClient.get('/companies');
      setCompanies(response.data);
    } catch (err: any) {
      setError('Failed to load companies');
      console.error(err);
    }
  };

  const loadPeriods = async (companyId: string) => {
    try {
      const response = await apiClient.get(`/periods?companyId=${companyId}`);
      setPeriods(response.data);
    } catch (err: any) {
      setError('Failed to load periods');
      console.error(err);
    }
  };

  const loadAccounts = async (companyId: string) => {
    try {
      const response = await apiClient.get(`/accounts?companyId=${companyId}`);
      setAccounts(response.data);
    } catch (err: any) {
      setError('Failed to load accounts');
      console.error(err);
    }
  };

  const loadLedger = async () => {
    if (!selectedCompany || !selectedPeriod || !selectedAccount) {
      setError('Please select company, period, and account');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const params = new URLSearchParams({
        companyId: selectedCompany,
        periodId: selectedPeriod,
        accountId: selectedAccount,
      });

      if (startDate) {
        params.append('startDate', startDate.toISOString());
      }
      if (endDate) {
        params.append('endDate', endDate.toISOString());
      }

      const response = await apiClient.get(`/ledger?${params.toString()}`);
      setLedgerData(response.data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load ledger');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const exportLedger = async (format: 'EXCEL' | 'CSV') => {
    if (!selectedCompany || !selectedPeriod || !selectedAccount) {
      setError('Please select company, period, and account first');
      return;
    }

    try {
      const params = new URLSearchParams({
        companyId: selectedCompany,
        periodId: selectedPeriod,
        accountId: selectedAccount,
        format,
      });

      if (startDate) {
        params.append('startDate', startDate.toISOString());
      }
      if (endDate) {
        params.append('endDate', endDate.toISOString());
      }

      const response = await apiClient.get(`/ledger/export?${params.toString()}`, {
        responseType: 'blob',
      });

      // Create download link
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute(
        'download',
        `ledger-${Date.now()}.${format === 'EXCEL' ? 'xlsx' : 'csv'}`
      );
      document.body.appendChild(link);
      link.click();
      link.remove();
    } catch (err: any) {
      setError('Failed to export ledger');
      console.error(err);
    }
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 2,
    }).format(amount);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  };

  const selectedAccountData = accounts.find(a => a.id === selectedAccount);

  return (
    <LocalizationProvider dateAdapter={AdapterDateFns}>
      <Box sx={{ p: 3 }}>
        <Typography variant="h4" gutterBottom>
          General Ledger
        </Typography>

        {error && (
          <Alert severity="error" onClose={() => setError(null)} sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        {/* Filters */}
        <Paper sx={{ p: 3, mb: 3 }}>
          <Grid container spacing={2}>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth>
                <InputLabel>Company</InputLabel>
                <Select
                  value={selectedCompany}
                  onChange={(e) => setSelectedCompany(e.target.value)}
                  label="Company"
                >
                  {companies.map((company) => (
                    <MenuItem key={company.id} value={company.id}>
                      {company.name} ({company.code})
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} md={4}>
              <FormControl fullWidth disabled={!selectedCompany}>
                <InputLabel>Period</InputLabel>
                <Select
                  value={selectedPeriod}
                  onChange={(e) => setSelectedPeriod(e.target.value)}
                  label="Period"
                >
                  {periods.map((period) => (
                    <MenuItem key={period.id} value={period.id}>
                      {period.name}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} md={4}>
              <FormControl fullWidth disabled={!selectedCompany}>
                <InputLabel>Account</InputLabel>
                <Select
                  value={selectedAccount}
                  onChange={(e) => setSelectedAccount(e.target.value)}
                  label="Account"
                >
                  {accounts.map((account) => (
                    <MenuItem key={account.id} value={account.id}>
                      {account.code} - {account.name}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} md={6}>
              <DatePicker
                label="Start Date"
                value={startDate}
                onChange={(newValue) => setStartDate(newValue)}
                slotProps={{ textField: { fullWidth: true } }}
              />
            </Grid>

            <Grid item xs={12} md={6}>
              <DatePicker
                label="End Date"
                value={endDate}
                onChange={(newValue) => setEndDate(newValue)}
                slotProps={{ textField: { fullWidth: true } }}
              />
            </Grid>

            <Grid item xs={12}>
              <Stack direction="row" spacing={2}>
                <Button
                  variant="contained"
                  onClick={loadLedger}
                  disabled={!selectedCompany || !selectedPeriod || !selectedAccount || loading}
                  startIcon={loading ? <CircularProgress size={20} /> : <RefreshIcon />}
                >
                  Load Ledger
                </Button>
                <Button
                  variant="outlined"
                  onClick={() => exportLedger('EXCEL')}
                  disabled={!ledgerData}
                  startIcon={<DownloadIcon />}
                >
                  Export Excel
                </Button>
                <Button
                  variant="outlined"
                  onClick={() => exportLedger('CSV')}
                  disabled={!ledgerData}
                  startIcon={<DownloadIcon />}
                >
                  Export CSV
                </Button>
              </Stack>
            </Grid>
          </Grid>
        </Paper>

        {/* Ledger Table */}
        {ledgerData && (
          <Paper sx={{ p: 3 }}>
            {/* Header */}
            <Box sx={{ mb: 3 }}>
              <Typography variant="h5" gutterBottom>
                {selectedAccountData?.name} ({selectedAccountData?.code})
              </Typography>
              <Typography variant="subtitle2" color="text.secondary">
                {selectedAccountData?.accountType?.name}
              </Typography>
            </Box>

            {/* Summary */}
            <Grid container spacing={2} sx={{ mb: 3 }}>
              <Grid item xs={12} md={4}>
                <Chip
                  label={`Opening Balance: ${formatCurrency(ledgerData.openingBalance)}`}
                  color="info"
                  sx={{ fontSize: '1rem', p: 2 }}
                />
              </Grid>
              <Grid item xs={12} md={4}>
                <Chip
                  label={`Entries: ${ledgerData.entries.length}`}
                  color="default"
                  sx={{ fontSize: '1rem', p: 2 }}
                />
              </Grid>
              <Grid item xs={12} md={4}>
                <Chip
                  label={`Closing Balance: ${formatCurrency(ledgerData.closingBalance)}`}
                  color="success"
                  sx={{ fontSize: '1rem', p: 2 }}
                />
              </Grid>
            </Grid>

            {/* Table */}
            <TableContainer>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>Date</TableCell>
                    <TableCell>Journal No.</TableCell>
                    <TableCell>Description</TableCell>
                    <TableCell>Reference</TableCell>
                    <TableCell align="right">Debit</TableCell>
                    <TableCell align="right">Credit</TableCell>
                    <TableCell align="right">Balance</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {/* Opening Balance */}
                  <TableRow sx={{ backgroundColor: '#f5f5f5' }}>
                    <TableCell colSpan={6}>
                      <strong>Opening Balance</strong>
                    </TableCell>
                    <TableCell align="right">
                      <strong>{formatCurrency(ledgerData.openingBalance)}</strong>
                    </TableCell>
                  </TableRow>

                  {/* Transactions */}
                  {ledgerData.entries.map((entry) => (
                    <TableRow key={entry.id} hover>
                      <TableCell>{formatDate(entry.transactionDate)}</TableCell>
                      <TableCell>{entry.journalNumber}</TableCell>
                      <TableCell>{entry.description}</TableCell>
                      <TableCell>{entry.reference}</TableCell>
                      <TableCell align="right">
                        {entry.debitAmount > 0 ? formatCurrency(entry.debitAmount) : '-'}
                      </TableCell>
                      <TableCell align="right">
                        {entry.creditAmount > 0 ? formatCurrency(entry.creditAmount) : '-'}
                      </TableCell>
                      <TableCell align="right">
                        {formatCurrency(entry.runningBalance)}
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* Closing Balance */}
                  <TableRow sx={{ backgroundColor: '#f5f5f5' }}>
                    <TableCell colSpan={6}>
                      <strong>Closing Balance</strong>
                    </TableCell>
                    <TableCell align="right">
                      <strong>{formatCurrency(ledgerData.closingBalance)}</strong>
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </TableContainer>

            {ledgerData.entries.length === 0 && (
              <Box sx={{ textAlign: 'center', py: 4 }}>
                <Typography color="text.secondary">
                  No transactions found for the selected period
                </Typography>
              </Box>
            )}
          </Paper>
        )}

        {loading && (
          <Box sx={{ display: 'flex', justifyContent: 'center', py: 4 }}>
            <CircularProgress />
          </Box>
        )}
      </Box>
    </LocalizationProvider>
  );
};

export default GeneralLedger;
