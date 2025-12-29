import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Grid,
  Chip,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Alert,
  CircularProgress,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Divider,
  Button,
} from '@mui/material';
import {
  Assignment as AssignmentIcon,
  Warning as WarningIcon,
  CheckCircle as CheckIcon,
  Schedule as ScheduleIcon,
  RateReview as ReviewIcon,
  ViewList as ListIcon,
  ViewKanban as KanbanIcon,
  CalendarToday as CalendarIcon,
} from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';
import apiClient from '../services/api';
import { useAuth } from '../contexts/AuthContext';

interface MyWorkStats {
  assigned: number;
  inProgress: number;
  completed: number;
  overdue: number;
  pendingReview: number;
}

interface Procedure {
  id: string;
  name: string;
  status: string;
  priority: string;
  dueDate?: string;
  company: { name: string };
  period: { name: string };
}

const MyWork: React.FC = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [stats, setStats] = useState<MyWorkStats | null>(null);
  const [myProcedures, setMyProcedures] = useState<Procedure[]>([]);
  const [reviewQueue, setReviewQueue] = useState<Procedure[]>([]);
  const [overdueProcedures, setOverdueProcedures] = useState<Procedure[]>([]);

  useEffect(() => {
    loadMyWork();
  }, [user]);

  const loadMyWork = async () => {
    if (!user?.id) return;
    
    try {
      setLoading(true);
      setError(null);

      // Get my assigned procedures
      const myProcsRes = await apiClient.get('/procedures', {
        params: { assignedTo: user.id },
      });
      const myProcs = myProcsRes.data;
      setMyProcedures(myProcs);

      // Calculate statistics
      const now = new Date();
      const statsData: MyWorkStats = {
        assigned: myProcs.length,
        inProgress: myProcs.filter((p: Procedure) => p.status === 'IN_PROGRESS').length,
        completed: myProcs.filter((p: Procedure) => p.status === 'COMPLETED').length,
        overdue: myProcs.filter(
          (p: Procedure) => p.dueDate && new Date(p.dueDate) < now && p.status !== 'COMPLETED'
        ).length,
        pendingReview: myProcs.filter((p: Procedure) => p.status === 'REVIEW_REQUIRED').length,
      };
      setStats(statsData);

      // Filter overdue procedures
      const overdue = myProcs.filter(
        (p: Procedure) =>
          p.dueDate && new Date(p.dueDate) < now && p.status !== 'COMPLETED'
      );
      setOverdueProcedures(overdue);

      // Get review queue (if manager/admin)
      if (user.role === 'ADMIN' || user.role === 'MANAGER' || user.role === 'SENIOR_AUDITOR') {
        const reviewRes = await apiClient.get('/procedures', {
          params: { status: 'COMPLETED' },
        });
        setReviewQueue(reviewRes.data.slice(0, 5)); // Show top 5
      }
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load work items');
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (date?: string) => {
    if (!date) return 'N/A';
    return new Date(date).toLocaleDateString();
  };

  const isOverdue = (dueDate?: string) => {
    if (!dueDate) return false;
    return new Date(dueDate) < new Date();
  };

  const statusColors: Record<string, 'default' | 'primary' | 'success' | 'warning' | 'error'> = {
    NOT_STARTED: 'default',
    IN_PROGRESS: 'primary',
    COMPLETED: 'success',
    ON_HOLD: 'warning',
    REVIEW_REQUIRED: 'warning',
  };

  const priorityColors: Record<string, 'default' | 'info' | 'warning' | 'error'> = {
    LOW: 'default',
    MEDIUM: 'info',
    HIGH: 'warning',
    CRITICAL: 'error',
  };

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
        <CircularProgress />
      </Box>
    );
  }

  if (error) {
    return (
      <Box sx={{ p: 3 }}>
        <Alert severity="error">{error}</Alert>
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
        <Box>
          <Typography variant="h4">
            My Work Dashboard
          </Typography>
          <Typography variant="body2" color="textSecondary">
            Welcome back, {user?.firstName}! Here's your work overview.
          </Typography>
        </Box>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button
            variant="outlined"
            startIcon={<ListIcon />}
            onClick={() => navigate('/audit/procedures')}
          >
            List View
          </Button>
          <Button
            variant="outlined"
            startIcon={<KanbanIcon />}
            onClick={() => navigate('/audit/kanban')}
          >
            Kanban
          </Button>
          <Button
            variant="outlined"
            startIcon={<CalendarIcon />}
            onClick={() => navigate('/audit/calendar')}
          >
            Calendar
          </Button>
        </Box>
      </Box>

      {/* Statistics Cards */}
      {stats && (
        <Grid container spacing={2} sx={{ mt: 2, mb: 3 }}>
          <Grid item xs={12} sm={6} md={2.4}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <AssignmentIcon color="primary" sx={{ mr: 1 }} />
                  <Typography color="textSecondary" variant="body2">
                    Assigned
                  </Typography>
                </Box>
                <Typography variant="h4">{stats.assigned}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={2.4}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <ScheduleIcon color="info" sx={{ mr: 1 }} />
                  <Typography color="textSecondary" variant="body2">
                    In Progress
                  </Typography>
                </Box>
                <Typography variant="h4">{stats.inProgress}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={2.4}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <CheckIcon color="success" sx={{ mr: 1 }} />
                  <Typography color="textSecondary" variant="body2">
                    Completed
                  </Typography>
                </Box>
                <Typography variant="h4">{stats.completed}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={2.4}>
            <Card sx={{ bgcolor: stats.overdue > 0 ? 'error.light' : 'background.paper' }}>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <WarningIcon color="error" sx={{ mr: 1 }} />
                  <Typography color="textSecondary" variant="body2">
                    Overdue
                  </Typography>
                </Box>
                <Typography variant="h4">{stats.overdue}</Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={2.4}>
            <Card>
              <CardContent>
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <ReviewIcon color="warning" sx={{ mr: 1 }} />
                  <Typography color="textSecondary" variant="body2">
                    Pending Review
                  </Typography>
                </Box>
                <Typography variant="h4">{stats.pendingReview}</Typography>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      )}

      <Grid container spacing={3}>
        {/* Overdue Items */}
        {overdueProcedures.length > 0 && (
          <Grid item xs={12} md={6}>
            <Card>
              <CardContent>
                <Typography variant="h6" color="error" gutterBottom>
                  ⚠️ Overdue Items
                </Typography>
                <List>
                  {overdueProcedures.slice(0, 5).map((proc) => (
                    <React.Fragment key={proc.id}>
                      <ListItem
                        button
                        onClick={() => navigate(`/audit/procedures/${proc.id}`)}
                      >
                        <ListItemIcon>
                          <WarningIcon color="error" />
                        </ListItemIcon>
                        <ListItemText
                          primary={proc.name}
                          secondary={`Due: ${formatDate(proc.dueDate)} • ${proc.company.name}`}
                        />
                        <Chip
                          label={proc.priority}
                          color={priorityColors[proc.priority]}
                          size="small"
                        />
                      </ListItem>
                      <Divider />
                    </React.Fragment>
                  ))}
                </List>
              </CardContent>
            </Card>
          </Grid>
        )}

        {/* My Active Procedures */}
        <Grid item xs={12} md={overdueProcedures.length > 0 ? 6 : 12}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                My Active Procedures
              </Typography>
              <TableContainer>
                <Table size="small">
                  <TableHead>
                    <TableRow>
                      <TableCell>Procedure</TableCell>
                      <TableCell>Status</TableCell>
                      <TableCell>Priority</TableCell>
                      <TableCell>Due Date</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {myProcedures
                      .filter((p) => p.status !== 'COMPLETED')
                      .slice(0, 10)
                      .map((proc) => (
                        <TableRow
                          key={proc.id}
                          hover
                          onClick={() => navigate(`/audit/procedures/${proc.id}`)}
                          sx={{ cursor: 'pointer' }}
                        >
                          <TableCell>
                            <Typography variant="body2">{proc.name}</Typography>
                            <Typography variant="caption" color="textSecondary">
                              {proc.company.name} • {proc.period.name}
                            </Typography>
                          </TableCell>
                          <TableCell>
                            <Chip
                              label={proc.status.replace(/_/g, ' ')}
                              color={statusColors[proc.status]}
                              size="small"
                            />
                          </TableCell>
                          <TableCell>
                            <Chip
                              label={proc.priority}
                              color={priorityColors[proc.priority]}
                              size="small"
                            />
                          </TableCell>
                          <TableCell>
                            <Typography
                              variant="body2"
                              color={isOverdue(proc.dueDate) ? 'error' : 'inherit'}
                            >
                              {formatDate(proc.dueDate)}
                            </Typography>
                          </TableCell>
                        </TableRow>
                      ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </CardContent>
          </Card>
        </Grid>

        {/* Review Queue (for managers/admins) */}
        {reviewQueue.length > 0 && (
          <Grid item xs={12}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom>
                  Review Queue
                </Typography>
                <TableContainer>
                  <Table size="small">
                    <TableHead>
                      <TableRow>
                        <TableCell>Procedure</TableCell>
                        <TableCell>Company</TableCell>
                        <TableCell>Period</TableCell>
                        <TableCell>Priority</TableCell>
                        <TableCell align="right">Actions</TableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {reviewQueue.map((proc) => (
                        <TableRow
                          key={proc.id}
                          hover
                          onClick={() => navigate(`/audit/procedures/${proc.id}`)}
                          sx={{ cursor: 'pointer' }}
                        >
                          <TableCell>{proc.name}</TableCell>
                          <TableCell>{proc.company.name}</TableCell>
                          <TableCell>{proc.period.name}</TableCell>
                          <TableCell>
                            <Chip
                              label={proc.priority}
                              color={priorityColors[proc.priority]}
                              size="small"
                            />
                          </TableCell>
                          <TableCell align="right">
                            <Chip label="Review" color="warning" size="small" />
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </TableContainer>
              </CardContent>
            </Card>
          </Grid>
        )}
      </Grid>
    </Box>
  );
};

export default MyWork;
