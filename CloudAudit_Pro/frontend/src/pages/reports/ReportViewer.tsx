import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Chip,
  Grid,
  IconButton,
  Menu,
  MenuItem,
  CircularProgress,
  Divider,
} from '@mui/material';
import {
  Download,
  Share,
  Print,
  Email,
  MoreVert,
  Delete,
  Edit,
  FileCopy,
  ArrowBack,
} from '@mui/icons-material';
import reportsService from '../../services/reports.service';
import { ReportStatus, ExportFormat } from '../../types/report.types';

interface Report {
  id: string;
  name: string;
  description?: string;
  reportType: string;
  category: string;
  status: ReportStatus;
  companyId: string;
  periodId?: string;
  filePath?: string;
  fileName?: string;
  fileSize?: number;
  fileType?: string;
  generatedBy: string;
  generatedAt: string;
  parameters?: any;
  filters?: any;
}

const ReportViewer: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [report, setReport] = useState<Report | null>(null);
  const [loading, setLoading] = useState(false);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [previewLoading, setPreviewLoading] = useState(false);

  useEffect(() => {
    if (id) {
      loadReport();
    }
  }, [id]);

  const loadReport = async () => {
    if (!id) return;

    setLoading(true);
    try {
      const data = await reportsService.getReport(id);
      setReport(data);
    } catch (error) {
      console.error('Failed to load report:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDownload = async (format: ExportFormat = 'PDF') => {
    if (!id) return;

    try {
      await reportsService.downloadReport(id, format);
    } catch (error) {
      console.error('Failed to download report:', error);
    }
  };

  const handleDuplicate = async () => {
    if (!id) return;

    try {
      const newReport = await reportsService.duplicateReport(id);
      navigate(`/reports/${newReport.id}`);
    } catch (error) {
      console.error('Failed to duplicate report:', error);
    }
  };

  const handleDelete = async () => {
    if (!id || !window.confirm('Are you sure you want to delete this report?')) return;

    try {
      await reportsService.deleteReport(id);
      navigate('/reports');
    } catch (error) {
      console.error('Failed to delete report:', error);
    }
  };

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
  };

  const getStatusColor = (status: ReportStatus) => {
    switch (status) {
      case 'COMPLETED':
        return 'success';
      case 'GENERATING':
        return 'primary';
      case 'FAILED':
        return 'error';
      default:
        return 'default';
    }
  };

  const formatFileSize = (bytes?: number) => {
    if (!bytes) return 'N/A';
    const kb = bytes / 1024;
    const mb = kb / 1024;
    return mb > 1 ? `${mb.toFixed(2)} MB` : `${kb.toFixed(2)} KB`;
  };

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '50vh' }}>
        <CircularProgress />
      </Box>
    );
  }

  if (!report) {
    return (
      <Box sx={{ p: 3 }}>
        <Typography>Report not found</Typography>
        <Button variant="contained" sx={{ mt: 2 }} onClick={() => navigate('/reports')}>
          Back to Reports
        </Button>
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          <IconButton onClick={() => navigate('/reports')} sx={{ mr: 2 }}>
            <ArrowBack />
          </IconButton>
          <Box>
            <Typography variant="h4">{report.name}</Typography>
            {report.description && (
              <Typography variant="body2" color="textSecondary" sx={{ mt: 0.5 }}>
                {report.description}
              </Typography>
            )}
          </Box>
        </Box>
        <Box>
          <IconButton onClick={handleMenuOpen}>
            <MoreVert />
          </IconButton>
          <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleMenuClose}>
            <MenuItem
              onClick={() => {
                handleMenuClose();
                navigate(`/reports/generate?edit=${id}`);
              }}
            >
              <Edit sx={{ mr: 1 }} fontSize="small" />
              Edit
            </MenuItem>
            <MenuItem
              onClick={() => {
                handleMenuClose();
                handleDuplicate();
              }}
            >
              <FileCopy sx={{ mr: 1 }} fontSize="small" />
              Duplicate
            </MenuItem>
            <Divider />
            <MenuItem
              onClick={() => {
                handleMenuClose();
                handleDelete();
              }}
              sx={{ color: 'error.main' }}
            >
              <Delete sx={{ mr: 1 }} fontSize="small" />
              Delete
            </MenuItem>
          </Menu>
        </Box>
      </Box>

      {/* Report Metadata */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Typography variant="h6" gutterBottom>
            Report Information
          </Typography>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                Status
              </Typography>
              <Chip
                label={report.status}
                color={getStatusColor(report.status)}
                size="small"
                sx={{ mt: 0.5 }}
              />
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                Type
              </Typography>
              <Typography variant="body1">{report.reportType}</Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                Category
              </Typography>
              <Typography variant="body1">{report.category}</Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                Generated
              </Typography>
              <Typography variant="body1">
                {new Date(report.generatedAt).toLocaleDateString()}
              </Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                File Name
              </Typography>
              <Typography variant="body1">{report.fileName || 'N/A'}</Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                File Size
              </Typography>
              <Typography variant="body1">{formatFileSize(report.fileSize)}</Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                File Type
              </Typography>
              <Typography variant="body1">{report.fileType || 'N/A'}</Typography>
            </Grid>
            <Grid item xs={12} md={3}>
              <Typography variant="body2" color="textSecondary">
                Generated By
              </Typography>
              <Typography variant="body1">{report.generatedBy}</Typography>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Action Buttons */}
      {report.status === 'COMPLETED' && (
        <Card sx={{ mb: 3 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Actions
            </Typography>
            <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap', mt: 2 }}>
              <Button
                variant="contained"
                startIcon={<Download />}
                onClick={() => handleDownload('PDF')}
              >
                Download PDF
              </Button>
              <Button
                variant="outlined"
                startIcon={<Download />}
                onClick={() => handleDownload('EXCEL')}
              >
                Download Excel
              </Button>
              <Button variant="outlined" startIcon={<Print />} onClick={() => window.print()}>
                Print
              </Button>
              <Button variant="outlined" startIcon={<Email />}>
                Email
              </Button>
              <Button variant="outlined" startIcon={<Share />}>
                Share
              </Button>
            </Box>
          </CardContent>
        </Card>
      )}

      {/* Report Preview */}
      <Card>
        <CardContent>
          <Typography variant="h6" gutterBottom>
            Report Preview
          </Typography>
          {report.status === 'COMPLETED' && report.filePath ? (
            <Box
              sx={{
                mt: 2,
                height: 600,
                border: '1px solid',
                borderColor: 'divider',
                borderRadius: 1,
                overflow: 'hidden',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                backgroundColor: '#f5f5f5',
              }}
            >
              {previewLoading ? (
                <CircularProgress />
              ) : (
                <Box sx={{ textAlign: 'center', p: 3 }}>
                  <Typography variant="body1" color="textSecondary">
                    Preview available after download
                  </Typography>
                  <Typography variant="body2" color="textSecondary" sx={{ mt: 1 }}>
                    Click "Download PDF" to view the report
                  </Typography>
                </Box>
              )}
            </Box>
          ) : report.status === 'GENERATING' ? (
            <Box
              sx={{
                mt: 2,
                height: 400,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              <CircularProgress sx={{ mb: 2 }} />
              <Typography variant="body1">Generating report...</Typography>
              <Typography variant="body2" color="textSecondary" sx={{ mt: 1 }}>
                This may take a few minutes
              </Typography>
            </Box>
          ) : report.status === 'FAILED' ? (
            <Box
              sx={{
                mt: 2,
                height: 400,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              <Typography variant="body1" color="error">
                Report generation failed
              </Typography>
              <Button variant="contained" sx={{ mt: 2 }} onClick={loadReport}>
                Retry
              </Button>
            </Box>
          ) : (
            <Box
              sx={{
                mt: 2,
                height: 400,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              <Typography variant="body1" color="textSecondary">
                No preview available
              </Typography>
            </Box>
          )}
        </CardContent>
      </Card>
    </Box>
  );
};

export default ReportViewer;
