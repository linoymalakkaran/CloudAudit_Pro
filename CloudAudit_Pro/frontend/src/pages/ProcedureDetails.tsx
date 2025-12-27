import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Grid,
  Chip,
  Tab,
  Tabs,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  IconButton,
  Alert,
  CircularProgress,
  Divider,
} from '@mui/material';
import {
  ArrowBack as BackIcon,
  Edit as EditIcon,
  Assignment as AssignmentIcon,
  Add as AddIcon,
  RateReview as ReviewIcon,
  PlayArrow as StartIcon,
  CheckCircle as CompleteIcon,
  Description as DescriptionIcon,
  Warning as WarningIcon,
  Comment as CommentIcon,
} from '@mui/icons-material';
import { useParams, useNavigate } from 'react-router-dom';
import apiClient from '../services/api';
import { ProcedureForm } from '../components/forms/ProcedureForm';
import { AssignmentDialog } from '../components/dialogs/AssignmentDialog';
import { ReviewDialog } from '../components/dialogs/ReviewDialog';
import { WorkpaperForm } from '../components/forms/WorkpaperForm';
import { FindingForm } from '../components/forms/FindingForm';
import CommentForm from '../components/forms/CommentForm';

interface ProcedureDetails {
  id: string;
  name: string;
  description?: string;
  category: string;
  status: string;
  reviewStatus: string;
  priority: string;
  riskLevel: string;
  dueDate?: string;
  startedAt?: string;
  completedAt?: string;
  actualHours?: number;
  reviewNotes?: string;
  company: { id: string; name: string; code: string };
  period: { id: string; name: string; startDate: string; endDate: string };
  assignedTo?: { 
    id: string; 
    user: {
      firstName: string; 
      lastName: string;
    };
  };
  assigner?: { firstName: string; lastName: string };
  creator: { firstName: string; lastName: string };
  reviewer?: { firstName: string; lastName: string };
  template?: { name: string; category: string };
  workpapers: any[];
  findings: any[];
  comments: any[];
}

const statusColors: Record<string, any> = {
  NOT_STARTED: 'default',
  IN_PROGRESS: 'primary',
  COMPLETED: 'success',
  ON_HOLD: 'warning',
  CANCELLED: 'error',
};

const ProcedureDetails: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [procedure, setProcedure] = useState<ProcedureDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [tabValue, setTabValue] = useState(0);
  
  // Dialogs
  const [editFormOpen, setEditFormOpen] = useState(false);
  const [assignDialogOpen, setAssignDialogOpen] = useState(false);
  const [reviewDialogOpen, setReviewDialogOpen] = useState(false);
  const [workpaperFormOpen, setWorkpaperFormOpen] = useState(false);
  const [findingFormOpen, setFindingFormOpen] = useState(false);
  const [selectedWorkpaper, setSelectedWorkpaper] = useState<any>(null);
  const [selectedFinding, setSelectedFinding] = useState<any>(null);

  useEffect(() => {
    loadProcedure();
  }, [id]);

  const loadProcedure = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get(`/audit-procedures/${id}`);
      setProcedure(response.data);
      setError(null);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load procedure');
    } finally {
      setLoading(false);
    }
  };

  const handleAddComment = async (comment: string) => {
    await apiClient.post(`/audit-procedures/${id}/comments`, { comment });
    // Reload procedure to get updated comments
    loadProcedure();
  };

  const handleStatusUpdate = async (status: string) => {
    try {
      await apiClient.put(`/audit-procedures/${id}`, { status });
      loadProcedure();
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to update status');
    }
  };
  
  const handleStartProcedure = () => {
    handleStatusUpdate('IN_PROGRESS');
  };

  const handleCompleteProcedure = () => {
    handleStatusUpdate('COMPLETED');
  };

  const formatDate = (date?: string) => {
    if (!date) return 'N/A';
    return new Date(date).toLocaleString();
  };

  const formatDateShort = (date?: string) => {
    if (!date) return 'N/A';
    return new Date(date).toLocaleDateString();
  };

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
        <CircularProgress />
      </Box>
    );
  }

  if (error || !procedure) {
    return (
      <Box sx={{ p: 3 }}>
        <Alert severity="error">{error || 'Procedure not found'}</Alert>
        <Button
          startIcon={<BackIcon />}
          onClick={() => navigate('/audit/procedures')}
          sx={{ mt: 2 }}
        >
          Back to Procedures
        </Button>
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 3 }}>
        <Box>
          <Button
            startIcon={<BackIcon />}
            onClick={() => navigate('/audit/procedures')}
            sx={{ mb: 1 }}
          >
            Back to Procedures
          </Button>
          <Typography variant="h4">{procedure.name}</Typography>
          <Typography color="textSecondary">
            {procedure.company.name} - {procedure.period.name}
          </Typography>
        </Box>
        <Box sx={{ display: 'flex', gap: 1 }}>
          {procedure.status === 'NOT_STARTED' && (
            <Button
              variant="contained"
              startIcon={<StartIcon />}
              onClick={handleStartProcedure}
            >
              Start Procedure
            </Button>
          )}
          {procedure.status === 'IN_PROGRESS' && (
            <Button
              variant="contained"
              color="success"
              startIcon={<CompleteIcon />}
              onClick={handleCompleteProcedure}
            >
              Mark Complete
            </Button>
          )}
          {procedure.status === 'COMPLETED' && procedure.reviewStatus === 'NOT_REVIEWED' && (
            <Button
              variant="contained"
              color="primary"
              startIcon={<ReviewIcon />}
              onClick={() => setReviewDialogOpen(true)}
            >
              Review
            </Button>
          )}
          <Button
            variant="outlined"
            startIcon={<AssignmentIcon />}
            onClick={() => setAssignDialogOpen(true)}
          >
            Assign
          </Button>
          <Button
            variant="outlined"
            startIcon={<EditIcon />}
            onClick={() => setEditFormOpen(true)}
          >
            Edit
          </Button>
        </Box>
      </Box>

      {/* Procedure Info Card */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Grid container spacing={3}>
            <Grid item xs={12} md={6}>
              <Typography variant="subtitle2" color="textSecondary">
                Description
              </Typography>
              <Typography>{procedure.description || 'N/A'}</Typography>
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Category
              </Typography>
              <Typography>{procedure.category.replace(/_/g, ' ')}</Typography>
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Risk Level
              </Typography>
              <Chip label={procedure.riskLevel} color={procedure.riskLevel === 'CRITICAL' ? 'error' : 'default'} />
            </Grid>
            
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Status
              </Typography>
              <Chip
                label={procedure.status.replace(/_/g, ' ')}
                color={statusColors[procedure.status]}
              />
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Priority
              </Typography>
              <Chip label={procedure.priority} color={procedure.priority === 'URGENT' ? 'error' : 'primary'} />
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Review Status
              </Typography>
              <Chip label={procedure.reviewStatus.replace(/_/g, ' ')} />
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Due Date
              </Typography>
              <Typography>{formatDateShort(procedure.dueDate)}</Typography>
            </Grid>

            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Assigned To
              </Typography>
              <Typography>
                {procedure.assignedTo
                  ? `${procedure.assignedTo.user.firstName} ${procedure.assignedTo.user.lastName}`
                  : 'Unassigned'}
              </Typography>
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Started At
              </Typography>
              <Typography>{formatDate(procedure.startedAt)}</Typography>
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Completed At
              </Typography>
              <Typography>{formatDate(procedure.completedAt)}</Typography>
            </Grid>
            <Grid item xs={6} md={3}>
              <Typography variant="subtitle2" color="textSecondary">
                Actual Hours
              </Typography>
              <Typography>{procedure.actualHours || 'N/A'}</Typography>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Tabs */}
      <Card>
        <Tabs value={tabValue} onChange={(e, v) => setTabValue(v)}>
          <Tab
            label={`Workpapers (${procedure.workpapers.length})`}
            icon={<DescriptionIcon />}
            iconPosition="start"
          />
          <Tab
            label={`Findings (${procedure.findings.length})`}
            icon={<WarningIcon />}
            iconPosition="start"
          />
          <Tab
            label={`Comments (${procedure.comments.length})`}
            icon={<CommentIcon />}
            iconPosition="start"
          />
        </Tabs>
        <Divider />
        <CardContent>
          {/* Workpapers Tab */}
          {tabValue === 0 && (
            <Box>
              <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 2 }}>
                <Typography variant="h6">Workpapers</Typography>
                <Button
                  startIcon={<AddIcon />}
                  variant="contained"
                  size="small"
                  onClick={() => {
                    setSelectedWorkpaper(null);
                    setWorkpaperFormOpen(true);
                  }}
                >
                  Add Workpaper
                </Button>
              </Box>
              {procedure.workpapers.length === 0 ? (
                <Typography color="textSecondary">No workpapers yet</Typography>
              ) : (
                <TableContainer>
                  <Table>
                    <TableHead>
                      <TableRow>
                        <TableCell>Title</TableCell>
                        <TableCell>Version</TableCell>
                        <TableCell>Prepared By</TableCell>
                        <TableCell>Status</TableCell>
                        <TableCell>Actions</TableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {procedure.workpapers.map((wp) => (
                        <TableRow key={wp.id} hover>
                          <TableCell>{wp.title}</TableCell>
                          <TableCell>
                            <Chip label={`v${wp.version}`} size="small" color="primary" />
                          </TableCell>
                          <TableCell>{wp.preparedBy || 'N/A'}</TableCell>
                          <TableCell>
                            <Chip 
                              label={wp.reviewStatus || 'DRAFT'} 
                              size="small" 
                              color={wp.reviewStatus === 'APPROVED' ? 'success' : 'default'} 
                            />
                          </TableCell>
                          <TableCell>
                            <IconButton
                              size="small"
                              onClick={() => {
                                setSelectedWorkpaper(wp);
                                setWorkpaperFormOpen(true);
                              }}
                            >
                              <EditIcon fontSize="small" />
                            </IconButton>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </TableContainer>
              )}
            </Box>
          )}

          {/* Findings Tab */}
          {tabValue === 1 && (
            <Box>
              <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 2 }}>
                <Typography variant="h6">Findings</Typography>
                <Button
                  startIcon={<AddIcon />}
                  variant="contained"
                  size="small"
                  color="warning"
                  onClick={() => {
                    setSelectedFinding(null);
                    setFindingFormOpen(true);
                  }}
                >
                  Add Finding
                </Button>
              </Box>
              {procedure.findings.length === 0 ? (
                <Typography color="textSecondary">No findings yet</Typography>
              ) : (
                <TableContainer>
                  <Table>
                    <TableHead>
                      <TableRow>
                        <TableCell>Title</TableCell>
                        <TableCell>Severity</TableCell>
                        <TableCell>Status</TableCell>
                        <TableCell>Identified By</TableCell>
                        <TableCell>Identified At</TableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {procedure.findings.map((finding) => (
                        <TableRow key={finding.id} hover>
                          <TableCell>{finding.title}</TableCell>
                          <TableCell>
                            <Chip
                              label={finding.severity}
                              color={
                                finding.severity === 'CRITICAL' || finding.severity === 'MATERIAL'
                                  ? 'error'
                                  : 'warning'
                              }
                              size="small"
                            />
                          </TableCell>
                          <TableCell>
                            <Chip label={finding.status} size="small" />
                          </TableCell>
                          <TableCell>{finding.identifiedBy || 'N/A'}</TableCell>
                          <TableCell>
                            <IconButton
                              size="small"
                              onClick={() => {
                                setSelectedFinding(finding);
                                setFindingFormOpen(true);
                              }}
                            >
                              <EditIcon fontSize="small" />
                            </IconButton>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </TableContainer>
              )}
            </Box>
          )}

          {/* Comments Tab */}
          {tabValue === 2 && (
            <Box>
              <Typography variant="h6" sx={{ mb: 2 }}>
                Comments
              </Typography>
              
              {/* Comment Form */}
              <CommentForm onSubmit={handleAddComment} />
              
              {/* Existing Comments */}
              <Box sx={{ mt: 3 }}>
                {procedure.comments.length === 0 ? (
                  <Typography color="textSecondary">No comments yet. Be the first to comment!</Typography>
                ) : (
                  procedure.comments.map((comment) => (
                    <Card key={comment.id} variant="outlined" sx={{ mb: 2 }}>
                      <CardContent>
                        <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                          <Typography variant="subtitle2">
                            {comment.user.firstName} {comment.user.lastName}
                          </Typography>
                          <Typography variant="caption" color="textSecondary">
                            {formatDate(comment.createdAt)}
                          </Typography>
                        </Box>
                        <Typography>{comment.comment}</Typography>
                      </CardContent>
                    </Card>
                  ))
                )}
              </Box>
            </Box>
          )}
        </CardContent>
      </Card>

      {/* Dialogs */}
      <ProcedureForm
        open={editFormOpen}
        onClose={() => setEditFormOpen(false)}
        onSuccess={loadProcedure}
        procedureId={id}
        initialData={procedure}
      />

      <AssignmentDialog
        open={assignDialogOpen}
        onClose={() => setAssignDialogOpen(false)}
        onSuccess={loadProcedure}
        procedureId={id!}
        currentAssignee={procedure.assignedTo}
      />

      <ReviewDialog
        open={reviewDialogOpen}
        onClose={() => setReviewDialogOpen(false)}
        onSuccess={loadProcedure}
        procedureId={id!}
        procedureTitle={procedure.name}
      />

      <WorkpaperForm
        open={workpaperFormOpen}
        onClose={() => {
          setWorkpaperFormOpen(false);
          setSelectedWorkpaper(null);
        }}
        onSuccess={loadProcedure}
        procedureId={id!}
        workpaperId={selectedWorkpaper?.id}
        initialData={selectedWorkpaper}
      />

      <FindingForm
        open={findingFormOpen}
        onClose={() => {
          setFindingFormOpen(false);
          setSelectedFinding(null);
        }}
        onSuccess={loadProcedure}
        procedureId={id!}
        findingId={selectedFinding?.id}
        initialData={selectedFinding}
      />
    </Box>
  );
};

export default ProcedureDetails;
