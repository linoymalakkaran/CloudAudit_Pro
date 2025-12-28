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
  Refresh as RefreshIcon,
} from '@mui/icons-material';
import reviewPointService, {
  ReviewPoint,
  ReviewCategory,
  ReviewPriority,
  ReviewPointStatus,
  CreateReviewPointDto,
  UpdateReviewPointDto,
} from '../services/reviewPointService';

const ReviewPointManagement: React.FC = () => {
  const [reviewPoints, setReviewPoints] = useState<ReviewPoint[]>([]);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [openClearDialog, setOpenClearDialog] = useState(false);
  const [selectedReviewPoint, setSelectedReviewPoint] = useState<ReviewPoint | null>(null);
  const [formData, setFormData] = useState<Partial<CreateReviewPointDto>>({});
  const [clearanceNotes, setClearanceNotes] = useState('');
  
  // Filters
  const [filterStatus, setFilterStatus] = useState<ReviewPointStatus | ''>('');
  const [filterCategory, setFilterCategory] = useState<ReviewCategory | ''>('');
  const [filterPriority, setFilterPriority] = useState<ReviewPriority | ''>('');

  // Assume these come from context/props
  const companyId = localStorage.getItem('selectedCompanyId') || '';
  const periodId = localStorage.getItem('selectedPeriodId') || '';

  useEffect(() => {
    if (companyId && periodId) {
      loadReviewPoints();
    }
  }, [companyId, periodId, filterStatus, filterCategory]);

  const loadReviewPoints = async () => {
    setLoading(true);
    try {
      const params: any = { companyId, periodId };
      if (filterStatus) params.status = filterStatus;
      if (filterCategory) params.category = filterCategory;
      
      const data = await reviewPointService.getReviewPoints(params);
      setReviewPoints(data);
    } catch (error) {
      console.error('Failed to load review points:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleOpenDialog = (reviewPoint?: ReviewPoint) => {
    if (reviewPoint) {
      setSelectedReviewPoint(reviewPoint);
      setFormData({
        title: reviewPoint.title,
        description: reviewPoint.description,
        category: reviewPoint.category,
        priority: reviewPoint.priority,
        status: reviewPoint.status,
        assignedTo: reviewPoint.assignedTo,
        dueDate: reviewPoint.dueDate,
        targetDate: reviewPoint.targetDate,
        impact: reviewPoint.impact,
      });
    } else {
      setSelectedReviewPoint(null);
      setFormData({
        companyId,
        periodId,
        category: ReviewCategory.AUDIT_FINDING,
        priority: ReviewPriority.MEDIUM,
        status: ReviewPointStatus.OUTSTANDING,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setSelectedReviewPoint(null);
    setFormData({});
  };

  const handleSave = async () => {
    try {
      if (selectedReviewPoint) {
        await reviewPointService.updateReviewPoint(
          selectedReviewPoint.id,
          formData as UpdateReviewPointDto
        );
      } else {
        await reviewPointService.createReviewPoint(formData as CreateReviewPointDto);
      }
      handleCloseDialog();
      loadReviewPoints();
    } catch (error) {
      console.error('Failed to save review point:', error);
    }
  };

  const handleOpenClearDialog = (reviewPoint: ReviewPoint) => {
    setSelectedReviewPoint(reviewPoint);
    setClearanceNotes('');
    setOpenClearDialog(true);
  };

  const handleClearReviewPoint = async () => {
    if (!selectedReviewPoint) return;
    
    try {
      await reviewPointService.clearReviewPoint(selectedReviewPoint.id, {
        clearanceNotes,
      });
      setOpenClearDialog(false);
      setClearanceNotes('');
      setSelectedReviewPoint(null);
      loadReviewPoints();
    } catch (error) {
      console.error('Failed to clear review point:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this review point?')) {
      try {
        await reviewPointService.deleteReviewPoint(id);
        loadReviewPoints();
      } catch (error) {
        console.error('Failed to delete review point:', error);
      }
    }
  };

  const getStatusColor = (status: ReviewPointStatus) => {
    switch (status) {
      case ReviewPointStatus.OUTSTANDING:
        return 'error';
      case ReviewPointStatus.IN_PROGRESS:
        return 'warning';
      case ReviewPointStatus.PENDING_CLEARANCE:
        return 'info';
      case ReviewPointStatus.CLEARED:
        return 'success';
      case ReviewPointStatus.CARRIED_FORWARD:
        return 'default';
      default:
        return 'default';
    }
  };

  const getPriorityColor = (priority: ReviewPriority) => {
    switch (priority) {
      case ReviewPriority.URGENT:
        return 'error';
      case ReviewPriority.HIGH:
        return 'warning';
      case ReviewPriority.MEDIUM:
        return 'info';
      case ReviewPriority.LOW:
        return 'default';
      default:
        return 'default';
    }
  };

  const columns: GridColDef[] = [
    { field: 'reviewNumber', headerName: 'Review #', width: 130 },
    { field: 'title', headerName: 'Title', width: 200 },
    { field: 'description', headerName: 'Description', width: 250 },
    {
      field: 'category',
      headerName: 'Category',
      width: 150,
      renderCell: (params: GridRenderCellParams) => (
        <Chip label={params.value} size="small" />
      ),
    },
    {
      field: 'priority',
      headerName: 'Priority',
      width: 120,
      renderCell: (params: GridRenderCellParams) => (
        <Chip label={params.value} size="small" color={getPriorityColor(params.value)} />
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
    {
      field: 'raisedAt',
      headerName: 'Raised Date',
      width: 130,
      valueFormatter: (params) => new Date(params).toLocaleDateString(),
    },
    { field: 'assignedTo', headerName: 'Assigned To', width: 130 },
    {
      field: 'dueDate',
      headerName: 'Due Date',
      width: 130,
      valueFormatter: (params) => params ? new Date(params).toLocaleDateString() : '',
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 180,
      sortable: false,
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <IconButton size="small" onClick={() => handleOpenDialog(params.row)}>
            <EditIcon fontSize="small" />
          </IconButton>
          {params.row.status !== ReviewPointStatus.CLEARED && (
            <IconButton size="small" onClick={() => handleOpenClearDialog(params.row)}>
              <CheckCircleIcon fontSize="small" color="success" />
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
        Review Points Management
      </Typography>

      <Paper sx={{ p: 2, mb: 3 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item xs={12} sm={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Status</InputLabel>
              <Select
                value={filterStatus}
                onChange={(e) => setFilterStatus(e.target.value as ReviewPointStatus)}
                label="Status"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ReviewPointStatus).map((status) => (
                  <MenuItem key={status} value={status}>
                    {status}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} sm={3}>
            <FormControl fullWidth size="small">
              <InputLabel>Category</InputLabel>
              <Select
                value={filterCategory}
                onChange={(e) => setFilterCategory(e.target.value as ReviewCategory)}
                label="Category"
              >
                <MenuItem value="">All</MenuItem>
                {Object.values(ReviewCategory).map((category) => (
                  <MenuItem key={category} value={category}>
                    {category}
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
              New Review Point
            </Button>
          </Grid>
          <Grid item xs={12} sm={3}>
            <Button
              variant="outlined"
              startIcon={<RefreshIcon />}
              onClick={loadReviewPoints}
              fullWidth
            >
              Refresh
            </Button>
          </Grid>
        </Grid>
      </Paper>

      <Card>
        <CardContent>
          <DataGrid
            rows={reviewPoints}
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
        <DialogTitle>
          {selectedReviewPoint ? 'Edit Review Point' : 'New Review Point'}
        </DialogTitle>
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
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Description"
                value={formData.description || ''}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth required>
                <InputLabel>Category</InputLabel>
                <Select
                  value={formData.category || ReviewCategory.AUDIT_FINDING}
                  onChange={(e) =>
                    setFormData({ ...formData, category: e.target.value as ReviewCategory })
                  }
                  label="Category"
                >
                  {Object.values(ReviewCategory).map((category) => (
                    <MenuItem key={category} value={category}>
                      {category}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth required>
                <InputLabel>Priority</InputLabel>
                <Select
                  value={formData.priority || ReviewPriority.MEDIUM}
                  onChange={(e) =>
                    setFormData({ ...formData, priority: e.target.value as ReviewPriority })
                  }
                  label="Priority"
                >
                  {Object.values(ReviewPriority).map((priority) => (
                    <MenuItem key={priority} value={priority}>
                      {priority}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Status</InputLabel>
                <Select
                  value={formData.status || ReviewPointStatus.OUTSTANDING}
                  onChange={(e) =>
                    setFormData({ ...formData, status: e.target.value as ReviewPointStatus })
                  }
                  label="Status"
                >
                  {Object.values(ReviewPointStatus).map((status) => (
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
                label="Assigned To (User ID)"
                value={formData.assignedTo || ''}
                onChange={(e) => setFormData({ ...formData, assignedTo: e.target.value })}
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
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Target Date"
                type="date"
                value={formData.targetDate || ''}
                onChange={(e) => setFormData({ ...formData, targetDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Impact"
                value={formData.impact || ''}
                onChange={(e) => setFormData({ ...formData, impact: e.target.value })}
                multiline
                rows={2}
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

      {/* Clear Review Point Dialog */}
      <Dialog open={openClearDialog} onClose={() => setOpenClearDialog(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Clear Review Point</DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            label="Clearance Notes"
            value={clearanceNotes}
            onChange={(e) => setClearanceNotes(e.target.value)}
            multiline
            rows={4}
            required
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenClearDialog(false)}>Cancel</Button>
          <Button
            onClick={handleClearReviewPoint}
            variant="contained"
            color="success"
            disabled={!clearanceNotes}
          >
            Clear Review Point
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default ReviewPointManagement;
