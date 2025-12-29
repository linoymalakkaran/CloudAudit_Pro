import React, { useState, useEffect } from 'react'
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Alert,
  CircularProgress,
} from '@mui/material'
import {
  PersonAdd as InviteIcon,
  Email as EmailIcon,
  Delete as DeleteIcon,
  Refresh as RefreshIcon,
} from '@mui/icons-material'
import { invitationService, type Invitation } from '../../services/invitation.service'
import { companyApi } from '../../services/api'
import { useAuth } from '../../contexts/AuthContext'

const InviteManagement: React.FC = () => {
  const { user } = useAuth()
  const [loading, setLoading] = useState(true)
  const [invitations, setInvitations] = useState<Invitation[]>([])
  const [companies, setCompanies] = useState<any[]>([])
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [formData, setFormData] = useState({
    email: '',
    firstName: '',
    lastName: '',
    role: 'CLIENT' as 'AUDITOR' | 'CLIENT' | 'MANAGER' | 'ADMIN',
    companyId: '',
    message: '',
  })

  useEffect(() => {
    loadData()
  }, [])

  const loadData = async () => {
    try {
      setLoading(true)
      const [invitationsData, companiesData] = await Promise.all([
        invitationService.getInvitations(),
        companyApi.getCompanies(),
      ])
      setInvitations(invitationsData)
      const companiesArray = Array.isArray(companiesData) 
        ? companiesData 
        : (companiesData && typeof companiesData === 'object' && 'data' in companiesData)
          ? (companiesData as any).data 
          : []
      setCompanies(companiesArray || [])
    } catch (err) {
      console.error('Failed to load data:', err)
      setError('Failed to load invitations')
    } finally {
      setLoading(false)
    }
  }

  const handleSendInvitation = async () => {
    if (!formData.email || !formData.role) {
      setError('Email and role are required')
      return
    }

    try {
      await invitationService.createInvitation({
        email: formData.email,
        firstName: formData.firstName || undefined,
        lastName: formData.lastName || undefined,
        role: formData.role,
        companyId: formData.companyId || user?.companyId || undefined,
        message: formData.message || undefined,
      })

      setDialogOpen(false)
      setFormData({
        email: '',
        firstName: '',
        lastName: '',
        role: 'CLIENT',
        companyId: '',
        message: '',
      })
      setSuccess('Invitation sent successfully!')
      loadData()
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to send invitation')
    }
  }

  const handleResend = async (invitationId: string) => {
    try {
      await invitationService.resendInvitation(invitationId)
      setSuccess('Invitation resent successfully!')
    } catch (err) {
      setError('Failed to resend invitation')
    }
  }

  const handleCancel = async (invitationId: string) => {
    if (!confirm('Are you sure you want to cancel this invitation?')) return

    try {
      await invitationService.cancelInvitation(invitationId)
      setSuccess('Invitation cancelled successfully!')
      loadData()
    } catch (err) {
      setError('Failed to cancel invitation')
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING':
        return 'warning'
      case 'ACCEPTED':
        return 'success'
      case 'EXPIRED':
        return 'error'
      default:
        return 'default'
    }
  }

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Invite Users</Typography>
        <Box>
          <IconButton onClick={loadData} disabled={loading}>
            <RefreshIcon />
          </IconButton>
          <Button
            variant="contained"
            startIcon={<InviteIcon />}
            onClick={() => setDialogOpen(true)}
          >
            Send Invitation
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 3 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {success && (
        <Alert severity="success" sx={{ mb: 3 }} onClose={() => setSuccess(null)}>
          {success}
        </Alert>
      )}

      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <Card>
          <CardContent>
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>Email</TableCell>
                    <TableCell>Name</TableCell>
                    <TableCell>Role</TableCell>
                    <TableCell>Status</TableCell>
                    <TableCell>Sent By</TableCell>
                    <TableCell>Expires</TableCell>
                    <TableCell>Actions</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {invitations.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={7} align="center">
                        <Typography variant="body2" color="text.secondary">
                          No invitations sent yet
                        </Typography>
                      </TableCell>
                    </TableRow>
                  ) : (
                    invitations.map((invitation) => (
                      <TableRow key={invitation.id}>
                        <TableCell>{invitation.email}</TableCell>
                        <TableCell>
                          {invitation.firstName || invitation.lastName
                            ? `${invitation.firstName || ''} ${invitation.lastName || ''}`
                            : '-'}
                        </TableCell>
                        <TableCell>
                          <Chip label={invitation.role} size="small" />
                        </TableCell>
                        <TableCell>
                          <Chip
                            label={invitation.status}
                            color={getStatusColor(invitation.status) as any}
                            size="small"
                          />
                        </TableCell>
                        <TableCell>
                          {invitation.createdBy
                            ? `${invitation.createdBy.firstName} ${invitation.createdBy.lastName}`
                            : '-'}
                        </TableCell>
                        <TableCell>
                          {new Date(invitation.expiresAt).toLocaleDateString()}
                        </TableCell>
                        <TableCell>
                          {invitation.status === 'PENDING' && (
                            <>
                              <IconButton
                                size="small"
                                color="primary"
                                onClick={() => handleResend(invitation.id)}
                                title="Resend invitation"
                              >
                                <EmailIcon />
                              </IconButton>
                              <IconButton
                                size="small"
                                color="error"
                                onClick={() => handleCancel(invitation.id)}
                                title="Cancel invitation"
                              >
                                <DeleteIcon />
                              </IconButton>
                            </>
                          )}
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </TableContainer>
          </CardContent>
        </Card>
      )}

      {/* Invite Dialog */}
      <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Send Invitation</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Email Address"
            type="email"
            fullWidth
            required
            value={formData.email}
            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
            sx={{ mb: 2 }}
          />
          <TextField
            margin="dense"
            label="First Name (Optional)"
            fullWidth
            value={formData.firstName}
            onChange={(e) => setFormData({ ...formData, firstName: e.target.value })}
            sx={{ mb: 2 }}
          />
          <TextField
            margin="dense"
            label="Last Name (Optional)"
            fullWidth
            value={formData.lastName}
            onChange={(e) => setFormData({ ...formData, lastName: e.target.value })}
            sx={{ mb: 2 }}
          />
          <FormControl fullWidth sx={{ mb: 2 }}>
            <InputLabel>Role</InputLabel>
            <Select
              value={formData.role}
              label="Role"
              onChange={(e) => setFormData({ ...formData, role: e.target.value as any })}
            >
              <MenuItem value="CLIENT">Client</MenuItem>
              <MenuItem value="AUDITOR">Auditor</MenuItem>
              <MenuItem value="MANAGER">Manager</MenuItem>
              <MenuItem value="ADMIN">Admin</MenuItem>
            </Select>
          </FormControl>
          <FormControl fullWidth sx={{ mb: 2 }}>
            <InputLabel>Company (Optional)</InputLabel>
            <Select
              value={formData.companyId}
              label="Company (Optional)"
              onChange={(e) => setFormData({ ...formData, companyId: e.target.value })}
            >
              <MenuItem value="">
                <em>None (Use default)</em>
              </MenuItem>
              {companies.map((company) => (
                <MenuItem key={company.id} value={company.id}>
                  {company.name}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
          <TextField
            margin="dense"
            label="Personal Message (Optional)"
            fullWidth
            multiline
            rows={3}
            value={formData.message}
            onChange={(e) => setFormData({ ...formData, message: e.target.value })}
            placeholder="Add a personal message to the invitation email..."
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleSendInvitation} variant="contained">
            Send Invitation
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default InviteManagement
