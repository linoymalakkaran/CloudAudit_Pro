import React, { useEffect, useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Grid,
  IconButton,
  Menu,
  MenuItem,
  Typography,
  CircularProgress,
  Button,
} from '@mui/material';
import { MoreVert, Edit, Refresh, Share } from '@mui/icons-material';
import dashboardsService, { Dashboard, WidgetConfig } from '../../services/dashboards.service';

interface WidgetProps {
  config: WidgetConfig;
  companyId?: string;
  periodId?: string;
}

const Widget: React.FC<WidgetProps> = ({ config, companyId, periodId }) => {
  const [data, setData] = useState<any>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    loadWidgetData();
  }, [config.type, companyId, periodId]);

  const loadWidgetData = async () => {
    if (!companyId) return;

    setLoading(true);
    try {
      const widgetData = await dashboardsService.getWidgetData({
        widgetType: config.type,
        companyId,
        periodId,
        ...config.dataSource,
      });
      setData(widgetData);
    } catch (error) {
      console.error('Failed to load widget data:', error);
    } finally {
      setLoading(false);
    }
  };

  const renderWidgetContent = () => {
    if (loading) {
      return (
        <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: 200 }}>
          <CircularProgress />
        </Box>
      );
    }

    if (!data) {
      return <Typography>No data available</Typography>;
    }

    switch (config.type) {
      case 'financial-summary':
        return (
          <Grid container spacing={2}>
            <Grid item xs={6}>
              <Typography variant="body2" color="textSecondary">
                Total Debit
              </Typography>
              <Typography variant="h6">
                ${data.totalDebit?.toLocaleString() || 0}
              </Typography>
            </Grid>
            <Grid item xs={6}>
              <Typography variant="body2" color="textSecondary">
                Total Credit
              </Typography>
              <Typography variant="h6">
                ${data.totalCredit?.toLocaleString() || 0}
              </Typography>
            </Grid>
            <Grid item xs={6}>
              <Typography variant="body2" color="textSecondary">
                Transactions
              </Typography>
              <Typography variant="h6">{data.totalTransactions || 0}</Typography>
            </Grid>
            <Grid item xs={6}>
              <Typography variant="body2" color="textSecondary">
                Balanced
              </Typography>
              <Typography variant="h6" color={data.isBalanced ? 'success.main' : 'error.main'}>
                {data.isBalanced ? 'Yes' : 'No'}
              </Typography>
            </Grid>
          </Grid>
        );

      case 'audit-progress':
        return (
          <Box>
            <Typography variant="h4" gutterBottom>
              {data.completionPercentage?.toFixed(1)}%
            </Typography>
            <Typography variant="body2" color="textSecondary">
              {data.statusBreakdown?.COMPLETED || 0} of {data.totalItems || 0} items completed
            </Typography>
          </Box>
        );

      case 'document-stats':
        return (
          <Box>
            <Typography variant="h4" gutterBottom>
              {data.totalDocuments || 0}
            </Typography>
            <Typography variant="body2" color="textSecondary">
              Total Documents
            </Typography>
            {data.byStatus && (
              <Box sx={{ mt: 2 }}>
                {Object.entries(data.byStatus).map(([status, count]: [string, any]) => (
                  <Typography key={status} variant="body2">
                    {status}: {count}
                  </Typography>
                ))}
              </Box>
            )}
          </Box>
        );

      default:
        return <Typography>Widget type: {config.type}</Typography>;
    }
  };

  return (
    <Card sx={{ height: '100%' }}>
      <CardContent>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
          <Typography variant="h6">{config.title}</Typography>
          <IconButton size="small" onClick={loadWidgetData}>
            <Refresh fontSize="small" />
          </IconButton>
        </Box>
        {renderWidgetContent()}
      </CardContent>
    </Card>
  );
};

const DashboardViewer: React.FC<{ dashboardId?: string }> = ({ dashboardId }) => {
  const [dashboard, setDashboard] = useState<Dashboard | null>(null);
  const [loading, setLoading] = useState(false);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  useEffect(() => {
    loadDashboard();
  }, [dashboardId]);

  const loadDashboard = async () => {
    setLoading(true);
    try {
      if (dashboardId) {
        const data = await dashboardsService.getDashboard(dashboardId);
        setDashboard(data);
      } else {
        const data = await dashboardsService.getDefaultDashboard();
        setDashboard(data);
      }
    } catch (error) {
      console.error('Failed to load dashboard:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
  };

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '50vh' }}>
        <CircularProgress />
      </Box>
    );
  }

  if (!dashboard) {
    return (
      <Box sx={{ p: 3 }}>
        <Typography>No dashboard found. Please create one first.</Typography>
        <Button variant="contained" sx={{ mt: 2 }} href="/dashboards/new">
          Create Dashboard
        </Button>
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Box>
          <Typography variant="h4">{dashboard.name}</Typography>
          {dashboard.description && (
            <Typography variant="body2" color="textSecondary" sx={{ mt: 1 }}>
              {dashboard.description}
            </Typography>
          )}
        </Box>
        <Box>
          <IconButton onClick={loadDashboard}>
            <Refresh />
          </IconButton>
          <IconButton onClick={handleMenuOpen}>
            <MoreVert />
          </IconButton>
          <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleMenuClose}>
            <MenuItem onClick={handleMenuClose}>
              <Edit sx={{ mr: 1 }} fontSize="small" />
              Edit Dashboard
            </MenuItem>
            <MenuItem onClick={handleMenuClose}>
              <Share sx={{ mr: 1 }} fontSize="small" />
              Share Dashboard
            </MenuItem>
          </Menu>
        </Box>
      </Box>

      <Grid container spacing={3}>
        {dashboard.widgets && dashboard.widgets.length > 0 ? (
          dashboard.widgets.map((widget, index) => (
            <Grid
              item
              xs={12}
              md={widget.size?.width || 6}
              key={index}
            >
              <Widget
                config={widget}
                companyId={dashboard.companyId}
                periodId={dashboard.periodId}
              />
            </Grid>
          ))
        ) : (
          <Grid item xs={12}>
            <Card>
              <CardContent>
                <Typography>No widgets configured. Please edit the dashboard to add widgets.</Typography>
              </CardContent>
            </Card>
          </Grid>
        )}
      </Grid>
    </Box>
  );
};

export default DashboardViewer;
