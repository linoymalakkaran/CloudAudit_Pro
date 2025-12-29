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
  Grid,
  CircularProgress,
  Alert,
  Tabs,
  Tab,
  Stack,
  Divider,
} from '@mui/material';
import {
  Download as DownloadIcon,
  Refresh as RefreshIcon,
  Print as PrintIcon,
} from '@mui/icons-material';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import apiClient from '../../services/api';

interface StatementLineItem {
  id: string;
  accountCode?: string;
  accountName: string;
  amount: string;
  level: number;
  isSubtotal: boolean;
  isTotal: boolean;
}

interface FinancialStatement {
  id: string;
  companyName: string;
  periodName: string;
  statementType: string;
  asOfDate?: Date;
  startDate?: Date;
  endDate?: Date;
  lineItems: StatementLineItem[];
  totals: {
    [key: string]: string;
  };
}

interface Company {
  id: string;
  name: string;
}

interface Period {
  id: string;
  name: string;
}

const FinancialStatements: React.FC = () => {
  const [companies, setCompanies] = useState<Company[]>([]);
  const [periods, setPeriods] = useState<Period[]>([]);
  const [selectedCompany, setSelectedCompany] = useState<string>('');
  const [selectedPeriod, setSelectedPeriod] = useState<string>('');
  const [statementType, setStatementType] = useState<string>('BALANCE_SHEET');
  const [statement, setStatement] = useState<FinancialStatement | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState(0);

  useEffect(() => {
    loadCompanies();
  }, []);

  useEffect(() => {
    if (selectedCompany) {
      loadPeriods(selectedCompany);
    }
  }, [selectedCompany]);

  const loadCompanies = async () => {
    try {
      const response = await apiClient.get('/companies');
      setCompanies(response.data);
    } catch (err: any) {
      setError('Failed to load companies');
    }
  };

  const loadPeriods = async (companyId: string) => {
    try {
      const response = await apiClient.get(`/periods?companyId=${companyId}`);
      setPeriods(response.data);
    } catch (err: any) {
      setError('Failed to load periods');
    }
  };

  const loadStatement = async () => {
    if (!selectedCompany || !selectedPeriod) {
      setError('Please select company and period');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await apiClient.post('/financial-statements/generate', {
        companyId: selectedCompany,
        periodId: selectedPeriod,
        statementType,
        format: 'DETAILED',
        includeZeroBalances: false,
      });
      setStatement(response.data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to generate statement');
    } finally {
      setLoading(false);
    }
  };

  const exportStatement = async (format: 'EXCEL' | 'PDF') => {
    if (!statement) return;

    try {
      const response = await apiClient.post(
        '/financial-statements/export',
        {
          companyId: selectedCompany,
          periodId: selectedPeriod,
          statementType,
          format: 'DETAILED',
          exportFormat: format,
        },
        { responseType: 'blob' }
      );

      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute(
        'download',
        `${statementType.toLowerCase()}-${Date.now()}.${format === 'EXCEL' ? 'xlsx' : 'pdf'}`
      );
      document.body.appendChild(link);
      link.click();
      link.remove();
    } catch (err: any) {
      setError('Failed to export statement');
    }
  };

  const formatCurrency = (amount: string) => {
    const num = parseFloat(amount);
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 2,
    }).format(num);
  };

  const getStatementTitle = () => {
    switch (statementType) {
      case 'BALANCE_SHEET':
        return 'Balance Sheet';
      case 'INCOME_STATEMENT':
        return 'Income Statement';
      case 'CASH_FLOW':
        return 'Cash Flow Statement';
      default:
        return 'Financial Statement';
    }
  };

  const renderLineItem = (item: StatementLineItem) => {
    const indent = (item.level - 1) * 20;
    
    return (
      <TableRow
        key={item.id}
        sx={{
          backgroundColor: item.isTotal
            ? '#e3f2fd'
            : item.isSubtotal
            ? '#f5f5f5'
            : 'transparent',
        }}
      >
        <TableCell
          sx={{
            paddingLeft: `${indent + 16}px`,
            fontWeight: item.isTotal || item.isSubtotal ? 'bold' : 'normal',
            borderTop: item.isTotal ? '2px solid #000' : undefined,
            borderBottom: item.isTotal ? '3px double #000' : undefined,
          }}
        >
          {item.accountCode && `${item.accountCode} - `}
          {item.accountName}
        </TableCell>
        <TableCell
          align="right"
          sx={{
            fontWeight: item.isTotal || item.isSubtotal ? 'bold' : 'normal',
            borderTop: item.isTotal ? '2px solid #000' : undefined,
            borderBottom: item.isTotal ? '3px double #000' : undefined,
          }}
        >
          {item.amount ? formatCurrency(item.amount) : ''}
        </TableCell>
      </TableRow>
    );
  };

  return (
    <LocalizationProvider dateAdapter={AdapterDateFns}>
      <Box sx={{ p: 3 }}>
        <Typography variant="h4" gutterBottom>
          Financial Statements
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
                      {company.name}
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
              <FormControl fullWidth>
                <InputLabel>Statement Type</InputLabel>
                <Select
                  value={statementType}
                  onChange={(e) => setStatementType(e.target.value)}
                  label="Statement Type"
                >
                  <MenuItem value="BALANCE_SHEET">Balance Sheet</MenuItem>
                  <MenuItem value="INCOME_STATEMENT">Income Statement</MenuItem>
                  <MenuItem value="CASH_FLOW">Cash Flow Statement</MenuItem>
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12}>
              <Stack direction="row" spacing={2}>
                <Button
                  variant="contained"
                  onClick={loadStatement}
                  disabled={!selectedCompany || !selectedPeriod || loading}
                  startIcon={loading ? <CircularProgress size={20} /> : <RefreshIcon />}
                >
                  Generate Statement
                </Button>
                <Button
                  variant="outlined"
                  onClick={() => exportStatement('EXCEL')}
                  disabled={!statement}
                  startIcon={<DownloadIcon />}
                >
                  Export Excel
                </Button>
                <Button
                  variant="outlined"
                  onClick={() => window.print()}
                  disabled={!statement}
                  startIcon={<PrintIcon />}
                >
                  Print
                </Button>
              </Stack>
            </Grid>
          </Grid>
        </Paper>

        {/* Statement Display */}
        {statement && (
          <Paper sx={{ p: 3 }}>
            {/* Header */}
            <Box sx={{ mb: 3, textAlign: 'center' }}>
              <Typography variant="h5" gutterBottom>
                {statement.companyName}
              </Typography>
              <Typography variant="h6" gutterBottom>
                {getStatementTitle()}
              </Typography>
              <Typography variant="subtitle1" color="text.secondary">
                {statement.periodName}
                {statement.asOfDate &&
                  ` - As of ${new Date(statement.asOfDate).toLocaleDateString()}`}
              </Typography>
            </Box>

            <Divider sx={{ mb: 2 }} />

            {/* Line Items */}
            <TableContainer>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>
                      <strong>Account</strong>
                    </TableCell>
                    <TableCell align="right">
                      <strong>Amount</strong>
                    </TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {statement.lineItems.map((item) => renderLineItem(item))}
                </TableBody>
              </Table>
            </TableContainer>

            {statement.lineItems.length === 0 && (
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

export default FinancialStatements;
