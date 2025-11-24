import React from 'react'
import {
  Box,
  Typography,
  Card,
  CardContent,
  Grid,
  Button,
  Chip,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  LinearProgress
} from '@mui/material'
import {
  Assignment as AssignmentIcon,
  Business as BusinessIcon,
  Schedule as ScheduleIcon,
  CheckCircle as CheckIcon
} from '@mui/icons-material'
import { Link } from 'react-router-dom'
import { useAuth } from '../../contexts/AuthContext'

function AuditorPortal() {
  const { user } = useAuth()

  return (
    <Box>
      <Box sx={{ mb: 4 }}>
        <Typography variant="h4" gutterBottom>
          Auditor Portal
        </Typography>
        <Typography variant="body1" color="text.secondary">
          Welcome back, {user?.firstName}! Here's your audit workload.
        </Typography>
        <Chip 
          label={`${user?.role} Access`} 
          color="primary" 
          sx={{ mt: 1 }}
        />
      </Box>

      {/* My Workload Overview */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <AssignmentIcon sx={{ fontSize: 40, color: 'primary.main', mb: 1 }} />
              <Typography variant="h4">8</Typography>
              <Typography variant="body2" color="text.secondary">
                Assigned Procedures
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ScheduleIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4">3</Typography>
              <Typography variant="body2" color="text.secondary">
                In Progress
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <CheckIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4">5</Typography>
              <Typography variant="body2" color="text.secondary">
                Completed Today
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <BusinessIcon sx={{ fontSize: 40, color: 'info.main', mb: 1 }} />
              <Typography variant="h4">3</Typography>
              <Typography variant="body2" color="text.secondary">
                Active Clients
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Current Assignments */}
      <Grid container spacing={3}>
        <Grid item xs={12} md={8}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                My Current Assignments
              </Typography>
              <List>
                <ListItem>
                  <ListItemIcon>
                    <AssignmentIcon color="warning" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Bank Confirmation - Acme Corp"
                    secondary="Due: Nov 25, 2024 | Priority: High"
                  />
                  <Box>
                    <Chip label="In Progress" color="warning" size="small" sx={{ mr: 1 }} />
                    <LinearProgress variant="determinate" value={60} sx={{ width: 100, display: 'inline-block' }} />
                  </Box>
                </ListItem>
                <ListItem>
                  <ListItemIcon>
                    <AssignmentIcon color="info" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Inventory Count - Tech Solutions"
                    secondary="Due: Dec 1, 2024 | Priority: Medium"
                  />
                  <Box>
                    <Chip label="Not Started" color="default" size="small" sx={{ mr: 1 }} />
                    <LinearProgress variant="determinate" value={0} sx={{ width: 100, display: 'inline-block' }} />
                  </Box>
                </ListItem>
                <ListItem>
                  <ListItemIcon>
                    <AssignmentIcon color="success" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Cash Flow Analysis - Manufacturing Co"
                    secondary="Due: Nov 20, 2024 | Priority: High"
                  />
                  <Box>
                    <Chip label="Review Required" color="success" size="small" sx={{ mr: 1 }} />
                    <LinearProgress variant="determinate" value={100} sx={{ width: 100, display: 'inline-block' }} />
                  </Box>
                </ListItem>
              </List>
              <Button
                component={Link}
                to="/procedures"
                variant="contained"
                fullWidth
                sx={{ mt: 2 }}
              >
                View All Procedures
              </Button>
            </CardContent>
          </Card>
        </Grid>
        
        <Grid item xs={12} md={4}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Quick Actions
              </Typography>
              <Button
                component={Link}
                to="/procedures"
                variant="outlined"
                fullWidth
                sx={{ mb: 2 }}
              >
                Start New Procedure
              </Button>
              <Button
                component={Link}
                to="/documents"
                variant="outlined"
                fullWidth
                sx={{ mb: 2 }}
              >
                Upload Documents
              </Button>
              <Button
                component={Link}
                to="/reports"
                variant="outlined"
                fullWidth
                sx={{ mb: 2 }}
              >
                Generate Report
              </Button>
              
              <Typography variant="h6" gutterBottom sx={{ mt: 3 }}>
                This Week's Schedule
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Monday: Acme Corp site visit
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Wednesday: Tech Solutions inventory
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Friday: Team review meeting
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  )
}

export default AuditorPortal