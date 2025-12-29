import React from 'react'
import {
  Box,
  Typography,
  Card,
  CardContent,
  Grid,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Chip,
  LinearProgress,
  Button
} from '@mui/material'
import {
  Assessment as AssessmentIcon,
  Business as BusinessIcon,
  Person as PersonIcon,
  Assignment as AssignmentIcon,
  TrendingUp as TrendingUpIcon,
  Schedule as ScheduleIcon,
  CheckCircle as CheckCircleIcon,
  Warning as WarningIcon
} from '@mui/icons-material'
import { useAuth } from '../contexts/AuthContext'
import { useNavigate } from 'react-router-dom'

function Dashboard() {
  const { user } = useAuth()
  const navigate = useNavigate()

  // Mock data for dashboard
  const stats = {
    totalCompanies: 24,
    activeAudits: 8,
    completedProcedures: 156,
    pendingReports: 5
  }

  const recentActivity = [
    {
      id: 1,
      action: 'Bank confirmation completed',
      company: 'Acme Corporation',
      user: 'John Doe',
      time: '2 hours ago',
      type: 'success'
    },
    {
      id: 2,
      action: 'New audit procedure assigned',
      company: 'Tech Solutions',
      user: 'Sarah Wilson',
      time: '4 hours ago',
      type: 'info'
    },
    {
      id: 3,
      action: 'Report generated',
      company: 'Manufacturing Co',
      user: 'Mike Johnson',
      time: '6 hours ago',
      type: 'success'
    },
    {
      id: 4,
      action: 'Document upload failed',
      company: 'Retail Corp',
      user: 'Emily Davis',
      time: '1 day ago',
      type: 'error'
    }
  ]

  const upcomingTasks = [
    {
      id: 1,
      task: 'Complete cash flow analysis',
      company: 'Acme Corporation',
      dueDate: '2024-11-25',
      priority: 'HIGH'
    },
    {
      id: 2,
      task: 'Review inventory count',
      company: 'Tech Solutions',
      dueDate: '2024-11-26',
      priority: 'MEDIUM'
    },
    {
      id: 3,
      task: 'Prepare management letter',
      company: 'Manufacturing Co',
      dueDate: '2024-11-28',
      priority: 'LOW'
    }
  ]

  const auditProgress = [
    {
      company: 'Acme Corporation',
      progress: 85,
      status: 'On Track'
    },
    {
      company: 'Tech Solutions',
      progress: 60,
      status: 'In Progress'
    },
    {
      company: 'Manufacturing Co',
      progress: 95,
      status: 'Near Completion'
    }
  ]

  const getActivityIcon = (type: string) => {
    switch (type) {
      case 'success':
        return <CheckCircleIcon color="success" />
      case 'error':
        return <WarningIcon color="error" />
      default:
        return <AssignmentIcon color="primary" />
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'HIGH':
        return 'error'
      case 'MEDIUM':
        return 'warning'
      case 'LOW':
        return 'info'
      default:
        return 'default'
    }
  }

  const handleAddCompany = () => {
    if (user?.role === 'ADMIN' || user?.role === 'MANAGER') {
      navigate('/admin/companies')
    } else {
      alert('Only administrators can add companies')
    }
  }

  const handleCreateProcedure = () => {
    navigate('/audit/procedures')
  }

  const handleGenerateReport = () => {
    navigate('/reports')
  }

  const handleAddTeamMember = () => {
    if (user?.role === 'ADMIN' || user?.role === 'MANAGER') {
      navigate('/admin/users')
    } else {
      alert('Only administrators can add team members')
    }
  }

  return (
    <Box>
      <Typography variant="h4" sx={{ mb: 4 }}>
        Welcome back, {user?.firstName || 'User'}!
      </Typography>

      {/* Statistics Cards */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} sm={6} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <BusinessIcon sx={{ fontSize: 40, color: 'primary.main', mb: 1 }} />
              <Typography variant="h4" color="primary.main">
                {stats.totalCompanies}
              </Typography>
              <Typography variant="body2">Total Companies</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <AssessmentIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4" color="warning.main">
                {stats.activeAudits}
              </Typography>
              <Typography variant="body2">Active Audits</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <CheckCircleIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4" color="success.main">
                {stats.completedProcedures}
              </Typography>
              <Typography variant="body2">Completed Procedures</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <AssignmentIcon sx={{ fontSize: 40, color: 'info.main', mb: 1 }} />
              <Typography variant="h4" color="info.main">
                {stats.pendingReports}
              </Typography>
              <Typography variant="body2">Pending Reports</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      <Grid container spacing={3}>
        {/* Audit Progress */}
        <Grid item xs={12} md={6}>
          <Card sx={{ height: '400px' }}>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Audit Progress
              </Typography>
              {auditProgress.map((audit, index) => (
                <Box key={index} sx={{ mb: 3 }}>
                  <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                    <Typography variant="subtitle2">
                      {audit.company}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      {audit.progress}%
                    </Typography>
                  </Box>
                  <LinearProgress
                    variant="determinate"
                    value={audit.progress}
                    sx={{ mb: 1 }}
                  />
                  <Typography variant="caption" color="text.secondary">
                    {audit.status}
                  </Typography>
                </Box>
              ))}
            </CardContent>
          </Card>
        </Grid>

        {/* Upcoming Tasks */}
        <Grid item xs={12} md={6}>
          <Card sx={{ height: '400px' }}>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Upcoming Tasks
              </Typography>
              <List>
                {upcomingTasks.map((task) => (
                  <ListItem key={task.id} sx={{ px: 0 }}>
                    <ListItemIcon>
                      <ScheduleIcon color="primary" />
                    </ListItemIcon>
                    <ListItemText
                      primary={task.task}
                      secondary={
                        <Box>
                          <Typography variant="body2" component="span">
                            {task.company} • Due: {task.dueDate}
                          </Typography>
                          <Box sx={{ mt: 1 }}>
                            <Chip
                              label={task.priority}
                              size="small"
                              color={getPriorityColor(task.priority) as any}
                            />
                          </Box>
                        </Box>
                      }
                    />
                  </ListItem>
                ))}
              </List>
            </CardContent>
          </Card>
        </Grid>

        {/* Recent Activity */}
        <Grid item xs={12}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Recent Activity
              </Typography>
              <List>
                {recentActivity.map((activity) => (
                  <ListItem key={activity.id}>
                    <ListItemIcon>
                      {getActivityIcon(activity.type)}
                    </ListItemIcon>
                    <ListItemText
                      primary={activity.action}
                      secondary={
                        <Typography variant="body2" color="text.secondary">
                          {activity.company} • {activity.user} • {activity.time}
                        </Typography>
                      }
                    />
                  </ListItem>
                ))}
              </List>
            </CardContent>
          </Card>
        </Grid>

        {/* Quick Actions */}
        <Grid item xs={12}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Quick Actions
              </Typography>
              <Grid container spacing={2}>
                <Grid item xs={12} sm={6} md={3}>
                  <Button
                    variant="outlined"
                    fullWidth
                    startIcon={<BusinessIcon />}
                    sx={{ height: '60px' }}
                    onClick={handleAddCompany}
                  >
                    Add New Company
                  </Button>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <Button
                    variant="outlined"
                    fullWidth
                    startIcon={<AssignmentIcon />}
                    sx={{ height: '60px' }}
                    onClick={handleCreateProcedure}
                  >
                    Create Procedure
                  </Button>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <Button
                    variant="outlined"
                    fullWidth
                    startIcon={<AssessmentIcon />}
                    sx={{ height: '60px' }}
                    onClick={handleGenerateReport}
                  >
                    Generate Report
                  </Button>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <Button
                    variant="outlined"
                    fullWidth
                    startIcon={<PersonIcon />}
                    sx={{ height: '60px' }}
                    onClick={handleAddTeamMember}
                  >
                    Add Team Member
                  </Button>
                </Grid>
              </Grid>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  )
}

export default Dashboard