import React from 'react'
import {
  Box,
  Typography,
  Card,
  CardContent,
  Grid,
  LinearProgress,
  Chip,
  Button,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Divider
} from '@mui/material'
import {
  Assignment as AssignmentIcon,
  CheckCircle as CheckIcon,
  Schedule as ScheduleIcon,
  Warning as WarningIcon,
  Description as DocumentIcon
} from '@mui/icons-material'

function ClientPortal() {
  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Client Portal
      </Typography>
      <Typography variant="body1" color="text.secondary" sx={{ mb: 4 }}>
        Welcome! Track your audit progress and review findings here.
      </Typography>

      {/* Audit Progress Overview */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={8}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Current Audit Progress
              </Typography>
              <Box sx={{ mb: 2 }}>
                <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                  <Typography variant="body2">Overall Progress</Typography>
                  <Typography variant="body2">75%</Typography>
                </Box>
                <LinearProgress variant="determinate" value={75} sx={{ height: 8, borderRadius: 4 }} />
              </Box>
              
              <Grid container spacing={2}>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="success.main">12</Typography>
                    <Typography variant="body2">Completed</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="warning.main">3</Typography>
                    <Typography variant="body2">In Progress</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="info.main">1</Typography>
                    <Typography variant="body2">Pending</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="error.main">0</Typography>
                    <Typography variant="body2">Issues</Typography>
                  </Box>
                </Grid>
              </Grid>
            </CardContent>
          </Card>
        </Grid>
        
        <Grid item xs={12} md={4}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Key Information
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Audit Period: 2024 Financial Year
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Lead Auditor: Sarah Wilson
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Expected Completion: Dec 15, 2024
              </Typography>
              <Button variant="outlined" fullWidth sx={{ mt: 2 }}>
                Contact Auditor
              </Button>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Recent Activities */}
      <Grid container spacing={3}>
        <Grid item xs={12} md={6}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Recent Activities
              </Typography>
              <List>
                <ListItem>
                  <ListItemIcon>
                    <CheckIcon color="success" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Cash Confirmation Completed"
                    secondary="Nov 20, 2024 - All bank confirmations received"
                  />
                </ListItem>
                <Divider variant="inset" component="li" />
                <ListItem>
                  <ListItemIcon>
                    <ScheduleIcon color="warning" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Inventory Count Scheduled"
                    secondary="Nov 18, 2024 - Scheduled for Nov 25, 2024"
                  />
                </ListItem>
                <Divider variant="inset" component="li" />
                <ListItem>
                  <ListItemIcon>
                    <DocumentIcon color="info" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Document Request Submitted"
                    secondary="Nov 15, 2024 - Accounts receivable aging"
                  />
                </ListItem>
              </List>
            </CardContent>
          </Card>
        </Grid>
        
        <Grid item xs={12} md={6}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Outstanding Items
              </Typography>
              <List>
                <ListItem>
                  <ListItemIcon>
                    <WarningIcon color="warning" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Fixed Asset Register"
                    secondary="Due: Nov 25, 2024 - Please provide updated register"
                  />
                  <Chip label="High Priority" color="warning" size="small" />
                </ListItem>
                <Divider variant="inset" component="li" />
                <ListItem>
                  <ListItemIcon>
                    <AssignmentIcon color="info" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Management Representation Letter"
                    secondary="Due: Dec 1, 2024 - To be signed by management"
                  />
                  <Chip label="Medium" color="info" size="small" />
                </ListItem>
              </List>
              <Button variant="contained" fullWidth sx={{ mt: 2 }}>
                View All Items
              </Button>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  )
}

export default ClientPortal