import React, { useEffect, useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Grid,
  Typography,
  CircularProgress,
  LinearProgress,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
} from '@mui/material';
import {
  TrendingUp,
  TrendingDown,
  Assessment,
  Description,
  Warning,
  CheckCircle,
} from '@mui/icons-material';
import analyticsService, {
  AnalyticsOverview as AnalyticsOverviewType,
  FinancialRatios,
} from '../../services/analytics.service';

interface StatCardProps {
  title: string;
  value: string | number;
  icon: React.ReactNode;
  color: string;
  subtitle?: string;
}

const StatCard: React.FC<StatCardProps> = ({ title, value, icon, color, subtitle }) => (
  <Card>
    <CardContent>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
        <Box>
          <Typography color="textSecondary" gutterBottom variant="body2">
            {title}
          </Typography>
          <Typography variant="h4" component="div">
            {value}
          </Typography>
          {subtitle && (
            <Typography variant="body2" color="textSecondary" sx={{ mt: 1 }}>
              {subtitle}
            </Typography>
          )}
        </Box>
        <Box
          sx={{
            backgroundColor: `${color}20`,
            borderRadius: '50%',
            p: 1,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          {icon}
        </Box>
      </Box>
    </CardContent>
  </Card>
);

const AnalyticsOverview: React.FC = () => {
  const [loading, setLoading] = useState(false);
  const [overview, setOverview] = useState<AnalyticsOverviewType | null>(null);
  const [ratios, setRatios] = useState<FinancialRatios | null>(null);
  const [selectedCompany, setSelectedCompany] = useState<string>('');
  const [selectedPeriod, setSelectedPeriod] = useState<string>('');

  useEffect(() => {
    if (selectedCompany) {
      loadAnalytics();
    }
  }, [selectedCompany, selectedPeriod]);

  const loadAnalytics = async () => {
    setLoading(true);
    try {
      const [overviewData, ratiosData] = await Promise.all([
        analyticsService.getOverview(selectedCompany, selectedPeriod),
        analyticsService.getFinancialRatios(selectedCompany, selectedPeriod),
      ]);
      setOverview(overviewData);
      setRatios(ratiosData);
    } catch (error) {
      console.error('Failed to load analytics:', error);
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(value);
  };

  const formatPercentage = (value: number) => {
    return `${value.toFixed(2)}%`;
  };

  if (!selectedCompany) {
    return (
      <Box sx={{ p: 3 }}>
        <Typography variant="h4" gutterBottom>
          Analytics Overview
        </Typography>
        <Card sx={{ mt: 3 }}>
          <CardContent>
            <Typography>Please select a company to view analytics</Typography>
            <FormControl fullWidth sx={{ mt: 2 }}>
              <InputLabel>Select Company</InputLabel>
              <Select
                value={selectedCompany}
                onChange={(e) => setSelectedCompany(e.target.value)}
                label="Select Company"
              >
                <MenuItem value="company1">Company 1</MenuItem>
                <MenuItem value="company2">Company 2</MenuItem>
              </Select>
            </FormControl>
          </CardContent>
        </Card>
      </Box>
    );
  }

  if (loading) {
    return (
      <Box sx={{ p: 3, display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '50vh' }}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h4" gutterBottom>
        Analytics Overview
      </Typography>

      {/* Key Metrics */}
      {overview && (
        <Grid container spacing={3} sx={{ mt: 2 }}>
          <Grid item xs={12} sm={6} md={3}>
            <StatCard
              title="Total Transactions"
              value={overview.summary.totalTransactions.toLocaleString()}
              icon={<Assessment style={{ color: '#1976d2' }} />}
              color="#1976d2"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatCard
              title="Total Documents"
              value={overview.summary.totalDocuments.toLocaleString()}
              icon={<Description style={{ color: '#2e7d32' }} />}
              color="#2e7d32"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatCard
              title="Total Findings"
              value={overview.summary.totalFindings.toLocaleString()}
              icon={<Warning style={{ color: '#ed6c02' }} />}
              color="#ed6c02"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatCard
              title="Audit Completion"
              value={formatPercentage(overview.summary.auditCompletion)}
              icon={<CheckCircle style={{ color: '#2e7d32' }} />}
              color="#2e7d32"
            />
          </Grid>
        </Grid>
      )}

      {/* Financial Summary */}
      {overview && (
        <Card sx={{ mt: 3 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Financial Summary
            </Typography>
            <Grid container spacing={2} sx={{ mt: 1 }}>
              <Grid item xs={12} md={3}>
                <Typography color="textSecondary" variant="body2">
                  Total Revenue
                </Typography>
                <Typography variant="h5">
                  {formatCurrency(overview.financial.totalRevenue)}
                </Typography>
              </Grid>
              <Grid item xs={12} md={3}>
                <Typography color="textSecondary" variant="body2">
                  Total Expenses
                </Typography>
                <Typography variant="h5">
                  {formatCurrency(overview.financial.totalExpenses)}
                </Typography>
              </Grid>
              <Grid item xs={12} md={3}>
                <Typography color="textSecondary" variant="body2">
                  Net Income
                </Typography>
                <Typography variant="h5" color={overview.financial.netIncome >= 0 ? 'success.main' : 'error.main'}>
                  {formatCurrency(overview.financial.netIncome)}
                </Typography>
              </Grid>
              <Grid item xs={12} md={3}>
                <Typography color="textSecondary" variant="body2">
                  Profit Margin
                </Typography>
                <Typography variant="h5">
                  {formatPercentage(overview.financial.profitMargin)}
                </Typography>
              </Grid>
            </Grid>
          </CardContent>
        </Card>
      )}

      {/* Financial Ratios */}
      {ratios && (
        <Card sx={{ mt: 3 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Financial Ratios
            </Typography>
            <Grid container spacing={3} sx={{ mt: 1 }}>
              <Grid item xs={12} md={4}>
                <Typography variant="subtitle2" gutterBottom>
                  Liquidity Ratios
                </Typography>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Current Ratio
                  </Typography>
                  <Typography variant="h6">
                    {ratios.liquidityRatios.currentRatio.toFixed(2)}
                  </Typography>
                </Box>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Quick Ratio
                  </Typography>
                  <Typography variant="h6">
                    {ratios.liquidityRatios.quickRatio.toFixed(2)}
                  </Typography>
                </Box>
              </Grid>

              <Grid item xs={12} md={4}>
                <Typography variant="subtitle2" gutterBottom>
                  Profitability Ratios
                </Typography>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Return on Assets (ROA)
                  </Typography>
                  <Typography variant="h6">
                    {formatPercentage(ratios.profitabilityRatios.returnOnAssets)}
                  </Typography>
                </Box>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Return on Equity (ROE)
                  </Typography>
                  <Typography variant="h6">
                    {formatPercentage(ratios.profitabilityRatios.returnOnEquity)}
                  </Typography>
                </Box>
              </Grid>

              <Grid item xs={12} md={4}>
                <Typography variant="subtitle2" gutterBottom>
                  Leverage Ratios
                </Typography>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Debt to Assets
                  </Typography>
                  <Typography variant="h6">
                    {formatPercentage(ratios.leverageRatios.debtToAssets)}
                  </Typography>
                </Box>
                <Box sx={{ mt: 2 }}>
                  <Typography variant="body2" color="textSecondary">
                    Equity Ratio
                  </Typography>
                  <Typography variant="h6">
                    {formatPercentage(ratios.leverageRatios.equityRatio)}
                  </Typography>
                </Box>
              </Grid>
            </Grid>
          </CardContent>
        </Card>
      )}

      {/* Audit Progress */}
      {overview && (
        <Card sx={{ mt: 3 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Audit Progress
            </Typography>
            <Box sx={{ mt: 2 }}>
              <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                <Typography variant="body2">
                  {overview.auditProgress.completed} of {overview.auditProgress.total} items completed
                </Typography>
                <Typography variant="body2" fontWeight="bold">
                  {formatPercentage(overview.auditProgress.completionPercentage)}
                </Typography>
              </Box>
              <LinearProgress
                variant="determinate"
                value={overview.auditProgress.completionPercentage}
                sx={{ height: 8, borderRadius: 4 }}
              />
            </Box>
          </CardContent>
        </Card>
      )}
    </Box>
  );
};

export default AnalyticsOverview;
