import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  Grid,
  IconButton,
  InputLabel,
  MenuItem,
  Select,
  TextField,
  Typography,
  Paper,
} from '@mui/material';
import { DataGrid, GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  CheckCircle as CheckCircleIcon,
  Cancel as CancelIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import managerReviewService, {
  ManagerReview,
  ReviewLevel,
  ManagerReviewStatus,
  CreateManagerReviewDto,
  UpdateManagerReviewDto,
} from '../services/managerReviewService';

const ManagerReviewList: React.FC = () => {
  const [reviews, setReviews] = useState<ManagerReview[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openApproveDialog, setOpenApproveDialog] = useState(false);
  const [openRejectDialog, setOpenRejectDialog] = useState(false);
  const [selectedReview, setSelectedReview] = useState<ManagerReview | null>(null);
  const [formData, setFormData] = useState<Partial<CreateManagerReviewDto>>({});
  const [signOffNotes, setSignOffNotes] = useState('');
  const [rejectComments, setRejectComments] = useState('');

  // Filters
  const [filterStatus, setFilterStatus] = useState<ManagerReviewStatus | ''>('');
  const [filterLevel, setFilterLevel] = useState<ReviewLevel | ''>('');

  // Assume these come from context/props
  const companyId = localStorage.getItem('selectedCompanyId') || '';
  const periodId = localStorage.getItem('selectedPeriodId') || '';

  useEffect(() => {
    if (companyId && periodId) {
      loadReviews();
    }
  }, [companyId, periodId, filterStatus, filterLevel]);

  const loadReviews = async () => {
    setLoading(true);
    try {
      const params: any = { companyId, periodId };
      if (filterStatus) params.status = filterStatus;
      if (filterLevel) params.reviewLevel = filterLevel;

      const data = await managerReviewService.getManagerReviews(params);
      setReviews(data);
    } catch (error) {
      console.error('Failed to load manager reviews:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (review?: ManagerReview) => {
    if (review) {
      setSelectedReview(review);
      setFormData({
        title: review.title,
        reviewLevel: review.reviewLevel,
        status: review.status,
        reviewerId: review.reviewerId,
        comments: review.comments,
        findings: review.findings,
        recommendations: review.recommendations,
        dueDate: review.dueDate,
      });
    } else {
      setSelectedReview(null);
      setFormData({
        companyId,
        periodId,
        reviewLevel: ReviewLevel.MANAGER,
        status: ManagerReviewStatus.NOT_STARTED,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedReview(null);
    setFormData({});
  };

  const handleSave = async () => {
    try {
      if (selectedReview) {
        await managerReviewService.updateManagerReview(
          selectedReview.id,
          formData as UpdateManagerReviewDto
        );
      } else {
        await managerReviewService.createManagerReview(formData as CreateManagerReviewDto);
      }
      handleCloseDialog();
      loadReviews();
    } catch (error) {
      console.error('Failed to save manager review:', error);
    }
  };

  const handleOpenApproveDialog = (review: ManagerReview) => {
    setSelectedReview(review);
    setSignOffNotes('');
    setOpenApproveDialog(true);
  };

  const handleApprove = async () => {
    if (!selectedReview) return;

    try {
      await managerReviewService.approveReview(selectedReview.id, { signOffNotes });
      setOpenApproveDialog(false);
      setSignOffNotes('');
      setSelectedReview(null);
      loadReviews();
    } catch (error) {
      console.error('Failed to approve review:', error);
    }
  };

  const handleOpenRejectDialog = (review: ManagerReview) => {
    setSelectedReview(review);
    setRejectComments('');
    setOpenRejectDialog(true);
  };

  const handleReject = async () => {
    if (!selectedReview) return;

    try {
      await managerReviewService.rejectReview(selectedReview.id, { comments: rejectComments });
      setOpenRejectDialog(false);
      setRejectComments('');
      setSelectedReview(null);
      loadReviews();
    } catch (error) {
      console.error('Failed to reject review:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this manager review?')) {
      try {
        await managerReviewService.deleteManagerReview(id);
        loadReviews();
      } catch (error) {
        console.error('Failed to delete manager review:', error);
      }
    }
  };

  const getStatusColor = (status: ManagerReviewStatus) => {
    switch (status) {
      case ManagerReviewStatus.NOT_STARTED:
        return 'default';
      case ManagerReviewStatus.IN_PROGRESS:
        return 'warning';
      case ManagerReviewStatus.COMPLETED:
        return 'info';
      case ManagerReviewStatus.APPROVED:
        return 'success';
      case ManagerReviewStatus.REJECTED:
        return 'error';
      case ManagerReviewStatus.REQUIRES_CHANGES:
        return 'warning';
      default:
        return 'default';
    }
  };

  const getLevelColor = (level: ReviewLevel) => {
    switch (level) {
      case ReviewLevel.MANAGER:
        return 'primary';
      case ReviewLevel.PARTNER:
        return 'secondary';
      case ReviewLevel.QUALITY_CONTROL:
        return 'info';
      default:
        return 'default';
    }
  };

  const columns: GridColDef[] = [
    { field: 'title', headerName: 'Title', width: 250 },
    {
      field: 'reviewLevel',
      headerName: 'Level',
      width: 150,
      renderCell: (params: GridRenderCellParams) => (
        <Chip label={params.value} size="small" color={getLevelColor(params.value)} />
      ),
    },
    {
      field: 'status',
      headerName: 'Status',
      width: 150,
      renderCell: (params: GridRenderCellParams) => (
        <Chip label={params.value} size="small" color={getStatusColor(params.value)} />
      ),
    },
    { field: 'reviewerId', headerName: 'Reviewer ID', width: 150 },
    {
      field: 'dueDate',
      headerName: 'Due Date',
      width: 130,
      valueFormatter: (params) => (params ? new Date(params).toLocaleDateString() : ''),
    },
    {
      field: 'isSignedOff',
      headerName: 'Signed Off',
      width: 120,
      renderCell: (params: GridRenderCellParams) =>
        params.value ? <Chip label="Yes" size="small" color="success" /> : <Chip label="No" size="small" />,
    },
    {
      field: 'createdAt',
      headerName: 'Created',
      width: 130,
      valueFormatter: (params) => new Date(params).toLocaleDateString(),
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 200,
      sortable: false,
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <IconButton size="small" onClick={() => handleOpenDialog(params.row)}>
            <EditIcon fontSize="small" />
          </IconButton>
          {params.row.status !== ManagerReviewStatus.APPROVED && (
            <IconButton size="small" onClick={() => handleOpenApproveDialog(params.row)}>
              <CheckCircleIcon fontSize="small" color="success" />
            </IconButton>
          )}
          {params.row.status !== ManagerReviewStatus.REJECTED &&
            params.row.status !== ManagerReviewStatus.APPROVED && (
              <IconButton size="small" onClick={() => handleOpenRejectDialog(params.row)}>
                <CancelIcon fontSize="small" color="error" />
              </IconButton>
            )}
          <IconButton size="small" onClick={() => handleDelete(params.row.id)}>
            <DeleteIcon fontSize="small" />
          </IconButton>
        </Box>
      ),
    },
  ];

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h4" gutterBottom>
        Manager & Partner Reviews
      </Typography>

      <Paper sx={{ p: 2, mb: 3 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item xs={12} sm={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Status</InputLabel>
              <Select
                value={filterStatus}
                onChange={(e) => setFilterStatus(e.target.value as ManagerReviewStatus)}
                label="Status"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ManagerReviewStatus).map((status) => (
                  <MenuItem key={status} value={status}>
                    {status}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} sm={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Review Level</InputLabel>
              <Select
                value={filterLevel}
                onChange={(e) => setFilterLevel(e.target.value as ReviewLevel)}
                label="Review Level"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ReviewLevel).map((level) => (
                  <MenuItem key={level} value={level}>
                    {level}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Button
              variant="contained"
              startIcon={<AddIcon />}
              onClick={() => handleOpenDialog()}
              fullWidth
            >
              New Review
            </Button>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Button variant="outlined" startIcon={<RefreshIcon />} onClick={loadReviews} fullWidth>
              Refresh
            </Button>
          </Grid>
        </Grid>
      </Paper>

      <Card>
        <CardContent>
          <DataGrid
            rows={reviews}
            columns={columns}
            loading={loading}
            pageSizeOptions={[10, 25, 50]}
            initialState={{
              pagination: { paginationModel: { pageSize: 10 } },
            }}
            autoHeight
            disableRowSelectionOnClick
          />
        </CardContent>
      </Card>

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>{selectedReview ? 'Edit Manager Review' : 'New Manager Review'}</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Title"
                value={formData.title || ''}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth required>
                <InputLabel>Review Level</InputLabel>
                <Select
                  value={formData.reviewLevel || ReviewLevel.MANAGER}
                  onChange={(e) =>
                    setFormData({ ...formData, reviewLevel: e.target.value as ReviewLevel })
                  }
                  label="Review Level"
                >
                  {Object.values(ReviewLevel).map((level) => (
                    <MenuItem key={level} value={level}>
                      {level}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Status</InputLabel>
                <Select
                  value={formData.status || ManagerReviewStatus.NOT_STARTED}
                  onChange={(e) =>
                    setFormData({ ...formData, status: e.target.value as ManagerReviewStatus })
                  }
                  label="Status"
                >
                  {Object.values(ManagerReviewStatus).map((status) => (
                    <MenuItem key={status} value={status}>
                      {status}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Reviewer ID"
                value={formData.reviewerId || ''}
                onChange={(e) => setFormData({ ...formData, reviewerId: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Due Date"
                type="date"
                value={formData.dueDate || ''}
                onChange={(e) => setFormData({ ...formData, dueDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Comments"
                value={formData.comments || ''}
                onChange={(e) => setFormData({ ...formData, comments: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Findings"
                value={formData.findings || ''}
                onChange={(e) => setFormData({ ...formData, findings: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Recommendations"
                value={formData.recommendations || ''}
                onChange={(e) => setFormData({ ...formData, recommendations: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained">
            Save
          </Button>
        </DialogActions>
      </Dialog>

      {/* Approve Dialog */}
      <Dialog open={openApproveDialog} onClose={() => setOpenApproveDialog(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Approve Review</DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            label="Sign-off Notes"
            value={signOffNotes}
            onChange={(e) => setSignOffNotes(e.target.value)}
            multiline
            rows={4}
            required
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenApproveDialog(false)}>Cancel</Button>
          <Button onClick={handleApprove} variant="contained" color="success" disabled={!signOffNotes}>
            Approve
          </Button>
        </DialogActions>
      </Dialog>

      {/* Reject Dialog */}
      <Dialog open={openRejectDialog} onClose={() => setOpenRejectDialog(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Reject Review</DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            label="Rejection Comments"
            value={rejectComments}
            onChange={(e) => setRejectComments(e.target.value)}
            multiline
            rows={4}
            required
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenRejectDialog(false)}>Cancel</Button>
          <Button onClick={handleReject} variant="contained" color="error" disabled={!rejectComments}>
            Reject
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default ManagerReviewList;
