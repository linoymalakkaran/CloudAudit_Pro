import React, { useState, useEffect } from 'react'
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
  Divider,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Alert,
  CircularProgress,
  Tabs,
  Tab,
} from '@mui/material'
import {
  Assignment as AssignmentIcon,
  CheckCircle as CheckIcon,
  Schedule as ScheduleIcon,
  Warning as WarningIcon,
  Description as DocumentIcon,
  Email as EmailIcon,
  Upload as UploadIcon,
} from '@mui/icons-material'
import { useNavigate } from 'react-router-dom'
import { clientPortalService, type ClientAuditOverview } from '../../services/clientPortal.service'
import { useAuth } from '../../contexts/AuthContext'

function ClientPortal() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [auditData, setAuditData] = useState<ClientAuditOverview | null>(null)
  const [contactDialogOpen, setContactDialogOpen] = useState(false)
  const [message, setMessage] = useState('')
  const [sendingMessage, setSendingMessage] = useState(false)

  useEffect(() => {
    loadAuditData()
  }, [user])

  const loadAuditData = async () => {
    if (!user?.companyId) {
      setError('No company associated with your account')
      setLoading(false)
      return
    }

    try {
      setLoading(true)
      setError(null)
      const data = await clientPortalService.getAuditOverview(user.companyId)
      setAuditData(data)
    } catch (err) {
      console.error('Failed to load audit data:', err)
      setError('Failed to load audit information. Please try again later.')
    } finally {
      setLoading(false)
    }
  }

  const handleContactAuditor = async () => {
    if (!message.trim() || !user?.companyId) return

    try {
      setSendingMessage(true)
      await clientPortalService.sendMessage(user.companyId, message)
      setContactDialogOpen(false)
      setMessage('')
      alert('Message sent successfully!')
    } catch (err) {
      console.error('Failed to send message:', err)
      alert('Failed to send message. Please try again.')
    } finally {
      setSendingMessage(false)
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high':
        return 'error'
      case 'medium':
        return 'warning'
      case 'low':
        return 'success'
      default:
        return 'default'
    }
  }

  const getActivityIcon = (type: string) => {
    switch (type) {
      case 'document':
        return <DocumentIcon color="info" />
      case 'procedure':
        return <CheckIcon color="success" />
      case 'finding':
        return <WarningIcon color="warning" />
      default:
        return <AssignmentIcon color="primary" />
    }
  }

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '400px' }}>
        <CircularProgress />
      </Box>
    )
  }

  if (error || !auditData) {
    return (
      <Box sx={{ p: 3 }}>
        <Alert severity="error">{error || 'Failed to load audit data'}</Alert>
        <Button onClick={loadAuditData} sx={{ mt: 2 }}>
          Retry
        </Button>
      </Box>
    )
  }

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
                  <Typography variant="body2">{auditData.progress.overall}%</Typography>
                </Box>
                <LinearProgress 
                  variant="determinate" 
                  value={auditData.progress.overall} 
                  sx={{ height: 8, borderRadius: 4 }} 
                />
              </Box>
              
              <Grid container spacing={2}>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="success.main">
                      {auditData.progress.completed}
                    </Typography>
                    <Typography variant="body2">Completed</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="warning.main">
                      {auditData.progress.inProgress}
                    </Typography>
                    <Typography variant="body2">In Progress</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="info.main">
                      {auditData.progress.pending}
                    </Typography>
                    <Typography variant="body2">Pending</Typography>
                  </Box>
                </Grid>
                <Grid item xs={6} sm={3}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" color="error.main">
                      {auditData.progress.issues}
                    </Typography>
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
                Quick Actions
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Company: {user?.companyName || 'N/A'}
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                User: {user?.firstName} {user?.lastName}
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Role: {user?.role || 'Client'}
              </Typography>
              <Box sx={{ mt: 2, display: 'flex', flexDirection: 'column', gap: 1 }}>
                <Button 
                  variant="contained" 
                  fullWidth 
                  startIcon={<EmailIcon />}
                  onClick={() => navigate('/messages')}
                >
                  Messages
                </Button>
                <Button 
                  variant="contained" 
                  fullWidth 
                  startIcon={<UploadIcon />}
                  onClick={() => navigate('/client/documents')}
                  color="secondary"
                >
                  Upload Documents
                </Button>
                <Button 
                  variant="outlined" 
                  fullWidth 
                  onClick={() => setContactDialogOpen(true)}
                >
                  Contact Auditor
                </Button>
              </Box>
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
              {auditData.recentActivities.length === 0 ? (
                <Typography variant="body2" color="text.secondary">
                  No recent activities
                </Typography>
              ) : (
                <List>
                  {auditData.recentActivities.map((activity, index) => (
                    <React.Fragment key={activity.id}>
                      {index > 0 && <Divider variant="inset" component="li" />}
                      <ListItem>
                        <ListItemIcon>
                          {getActivityIcon(activity.type)}
                        </ListItemIcon>
                        <ListItemText
                          primary={activity.title}
                          secondary={`${new Date(activity.date).toLocaleDateString()} - ${activity.description}`}
                        />
                      </ListItem>
                    </React.Fragment>
                  ))}
                </List>
              )}
            </CardContent>
          </Card>
        </Grid>
        
        <Grid item xs={12} md={6}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Outstanding Items
              </Typography>
              {auditData.outstandingItems.length === 0 ? (
                <Typography variant="body2" color="text.secondary">
                  No outstanding items
                </Typography>
              ) : (
                <List>
                  {auditData.outstandingItems.map((item, index) => (
                    <React.Fragment key={item.id}>
                      {index > 0 && <Divider variant="inset" component="li" />}
                      <ListItem>
                        <ListItemIcon>
                          <WarningIcon color={item.priority === 'high' ? 'error' : 'warning'} />
                        </ListItemIcon>
                        <ListItemText
                          primary={item.title}
                          secondary={`Due: ${new Date(item.dueDate).toLocaleDateString()} - ${item.description}`}
                        />
                        <Chip 
                          label={item.priority} 
                          color={getPriorityColor(item.priority) as any}
                          size="small" 
                        />
                      </ListItem>
                    </React.Fragment>
                  ))}
                </List>
              )}
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Contact Auditor Dialog */}
      <Dialog 
        open={contactDialogOpen} 
        onClose={() => setContactDialogOpen(false)}
        maxWidth="sm"
        fullWidth
      >
        <DialogTitle>Contact Auditor</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Your Message"
            fullWidth
            multiline
            rows={4}
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            placeholder="Type your message here..."
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setContactDialogOpen(false)}>Cancel</Button>
          <Button 
            onClick={handleContactAuditor} 
            variant="contained"
            disabled={!message.trim() || sendingMessage}
          >
            {sendingMessage ? 'Sending...' : 'Send Message'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default ClientPortal