import React, { useEffect, useState } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  Grid,
  IconButton,
  MenuItem,
  Select,
  TextField,
  Typography,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
} from '@mui/material';
import { Add, Delete, Edit, PlayArrow, ContentCopy, Download } from '@mui/icons-material';
import reportsService, { Report } from '../../services/reports.service';
import { ReportType, ReportCategory, ReportStatus } from '../../types/report.types';

const ReportsDashboard: React.FC = () => {
  const [reports, setReports] = useState<Report[]>([]);
  const [loading, setLoading] = useState(false);
  const [filterType, setFilterType] = useState<string>('');
  const [filterStatus, setFilterStatus] = useState<string>('');
  const [selectedCompany, setSelectedCompany] = useState<string>('');
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [reportToDelete, setReportToDelete] = useState<string | null>(null);

  useEffect(() => {
    loadReports();
  }, [filterType, filterStatus, selectedCompany]);

  const loadReports = async () => {
    setLoading(true);
    try {
      const filters: any = {};
      if (selectedCompany) filters.companyId = selectedCompany;
      if (filterType) filters.reportType = filterType as ReportType;
      if (filterStatus) filters.status = filterStatus as ReportStatus;

      const data = await reportsService.getReports(filters);
      setReports(data);
    } catch (error) {
      console.error('Failed to load reports:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!reportToDelete) return;
    
    try {
      await reportsService.deleteReport(reportToDelete);
      loadReports();
      setDeleteDialogOpen(false);
      setReportToDelete(null);
    } catch (error) {
      console.error('Failed to delete report:', error);
    }
  };

  const handleDuplicate = async (id: string) => {
    try {
      await reportsService.duplicateReport(id);
      loadReports();
    } catch (error) {
      console.error('Failed to duplicate report:', error);
    }
  };

  const getStatusColor = (status: ReportStatus): 'default' | 'primary' | 'success' | 'error' => {
    switch (status) {
      case ReportStatus.COMPLETED:
        return 'success';
      case ReportStatus.GENERATING:
        return 'primary';
      case ReportStatus.FAILED:
        return 'error';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ mb: 3, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Typography variant="h4">Reports Dashboard</Typography>
        <Button variant="contained" startIcon={<Add />} href="/reports/generate">
          New Report
        </Button>
      </Box>

      {/* Filters */}
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} md={4}>
          <Select
            fullWidth
            value={filterType}
            onChange={(e) => setFilterType(e.target.value)}
            displayEmpty
          >
            <MenuItem value="">All Report Types</MenuItem>
            {Object.values(ReportType).map((type) => (
              <MenuItem key={type} value={type}>
                {type.replace(/_/g, ' ')}
              </MenuItem>
            ))}
          </Select>
        </Grid>
        <Grid item xs={12} md={4}>
          <Select
            fullWidth
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            displayEmpty
          >
            <MenuItem value="">All Statuses</MenuItem>
            {Object.values(ReportStatus).map((status) => (
              <MenuItem key={status} value={status}>
                {status}
              </MenuItem>
            ))}
          </Select>
        </Grid>
        <Grid item xs={12} md={4}>
          <Button fullWidth variant="outlined" onClick={loadReports}>
            Refresh
          </Button>
        </Grid>
      </Grid>

      {/* Reports Table */}
      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Report Name</TableCell>
              <TableCell>Type</TableCell>
              <TableCell>Category</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Company</TableCell>
              <TableCell>Generated</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={7} align="center">
                  Loading...
                </TableCell>
              </TableRow>
            ) : reports.length === 0 ? (
              <TableRow>
                <TableCell colSpan={7} align="center">
                  No reports found
                </TableCell>
              </TableRow>
            ) : (
              reports.map((report) => (
                <TableRow key={report.id} hover>
                  <TableCell>{report.name}</TableCell>
                  <TableCell>{report.reportType.replace(/_/g, ' ')}</TableCell>
                  <TableCell>{report.category}</TableCell>
                  <TableCell>
                    <Chip
                      label={report.status}
                      color={getStatusColor(report.status)}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>{report.company?.name || '-'}</TableCell>
                  <TableCell>
                    {report.generatedAt
                      ? new Date(report.generatedAt).toLocaleDateString()
                      : '-'}
                  </TableCell>
                  <TableCell>
                    <IconButton
                      size="small"
                      onClick={() => handleDuplicate(report.id)}
                      title="Duplicate"
                    >
                      <ContentCopy fontSize="small" />
                    </IconButton>
                    <IconButton
                      size="small"
                      disabled={report.status !== ReportStatus.COMPLETED}
                      title="Download"
                    >
                      <Download fontSize="small" />
                    </IconButton>
                    <IconButton
                      size="small"
                      onClick={() => {
                        setReportToDelete(report.id);
                        setDeleteDialogOpen(true);
                      }}
                      title="Delete"
                      color="error"
                    >
                      <Delete fontSize="small" />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </TableContainer>

      {/* Delete Confirmation Dialog */}
      <Dialog open={deleteDialogOpen} onClose={() => setDeleteDialogOpen(false)}>
        <DialogTitle>Confirm Delete</DialogTitle>
        <DialogContent>
          Are you sure you want to delete this report? This action cannot be undone.
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDeleteDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleDelete} color="error" variant="contained">
            Delete
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default ReportsDashboard;
