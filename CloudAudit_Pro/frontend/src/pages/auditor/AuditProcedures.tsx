import React, { useState, useEffect } from 'react'
import {
  Box,
  Typography,
  Button,
  Card,
  CardContent,
  Grid,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  IconButton,
  Menu,
  MenuItem,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Select,
  FormControl,
  InputLabel,
  CircularProgress,
  Alert
} from '@mui/material'
import {
  Add as AddIcon,
  MoreVert as MoreVertIcon,
  PlayArrow as StartIcon,
  CheckCircle as CompleteIcon,
  Pause as PauseIcon,
  Visibility as ViewIcon
} from '@mui/icons-material'
import { useNavigate } from 'react-router-dom'
import apiClient from '../../services/api'

interface Procedure {
  id: string
  name: string
  company: { id: string; name: string }
  period: { id: string; name: string }
  assignee?: { id: string; firstName: string; lastName: string; email: string }
  status: 'NOT_STARTED' | 'IN_PROGRESS' | 'COMPLETED' | 'ON_HOLD' | 'REVIEW_REQUIRED'
  priority: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL'
  dueDate?: string
  progress: number
  procedureType: string
  riskLevel: string
}

function AuditProcedures() {
  const navigate = useNavigate()
  const [open, setOpen] = useState(false)
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [selectedProcedure, setSelectedProcedure] = useState<Procedure | null>(null)
  const [procedures, setProcedures] = useState<Procedure[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [stats, setStats] = useState({
    total: 0,
    inProgress: 0,
    completed: 0,
    overdue: 0
  })

  const [newProcedure, setNewProcedure] = useState({
    name: '',
    companyId: '',
    periodId: '',
    assignedTo: '',
    priority: 'MEDIUM' as const,
    dueDate: '',
    description: '',
    procedureType: 'SUBSTANTIVE_TEST',
    riskLevel: 'MEDIUM'
  })

  useEffect(() => {
    loadProcedures()
    loadStats()
  }, [])

  const loadProcedures = async () => {
    try {
      setLoading(true)
      setError(null)
      const response = await apiClient.get('/procedures')
      const data = Array.isArray(response.data) ? response.data : response.data.data || []
      setProcedures(data)
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load procedures')
    } finally {
      setLoading(false)
    }
  }

  const loadStats = async () => {
    try {
      const response = await apiClient.get('/procedures/statistics')
      const data = response.data
      setStats({
        total: data.totalProcedures || 0,
        inProgress: data.statusBreakdown?.inProgress || 0,
        completed: data.statusBreakdown?.completed || 0,
        overdue: data.overdueProcedures || 0
      })
    } catch (err) {
      console.error('Failed to load stats:', err)
    }
  }

  const handleCreateProcedure = async () => {
    try {
      await apiClient.post('/procedures', newProcedure)
      setOpen(false)
      setNewProcedure({
        name: '',
        companyId: '',
        periodId: '',
        assignedTo: '',
        priority: 'MEDIUM',
        dueDate: '',
        description: '',
        procedureType: 'SUBSTANTIVE_TEST',
        riskLevel: 'MEDIUM'
      })
      loadProcedures()
      loadStats()
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to create procedure')
    }
  }

  const handleUpdateStatus = async (procedureId: string, status: string) => {
    try {
      await apiClient.patch(`/procedures/${procedureId}`, { status })
      loadProcedures()
      loadStats()
      handleMenuClose()
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to update procedure')
    }
  }

  const handleViewProcedure = (procedureId: string) => {
    navigate(`/audit/procedures/${procedureId}`)
    handleMenuClose()
  }

  const handleMenuClick = (event: React.MouseEvent<HTMLElement>, procedure: Procedure) => {
    setAnchorEl(event.currentTarget)
    setSelectedProcedure(procedure)
  }

  const handleMenuClose = () => {
    setAnchorEl(null)
    setSelectedProcedure(null)
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'NOT_STARTED': return 'default'
      case 'IN_PROGRESS': return 'warning'
      case 'COMPLETED': return 'success'
      case 'ON_HOLD': return 'error'
      default: return 'default'
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'LOW': return 'info'
      case 'MEDIUM': return 'warning'
      case 'HIGH': return 'error'
      default: return 'default'
    }
  }

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 4 }}>
        <Typography variant="h4">
          Audit Procedures
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setOpen(true)}
        >
          Create Procedure
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 3 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {/* Statistics */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="primary.main">{stats.total}</Typography>
              <Typography variant="body2">Total Procedures</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="warning.main">{stats.inProgress}</Typography>
              <Typography variant="body2">In Progress</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="success.main">{stats.completed}</Typography>
              <Typography variant="body2">Completed</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="error.main">{stats.overdue}</Typography>
              <Typography variant="body2">Overdue</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Procedures Table */}
      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <Card>
          <TableContainer component={Paper}>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>Procedure Name</TableCell>
                  <TableCell>Company</TableCell>
                  <TableCell>Assignee</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell>Priority</TableCell>
                  <TableCell>Due Date</TableCell>
                  <TableCell>Progress</TableCell>
                  <TableCell>Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {procedures.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={8} align="center">
                      <Typography variant="body2" color="text.secondary" sx={{ py: 3 }}>
                        No procedures found. Create your first procedure to get started.
                      </Typography>
                    </TableCell>
                  </TableRow>
                ) : (
                  procedures.map((procedure) => (
                    <TableRow key={procedure.id}>
                      <TableCell>
                        <Typography variant="subtitle2">
                          {procedure.name}
                        </Typography>
                      </TableCell>
                      <TableCell>{procedure.company?.name || '-'}</TableCell>
                      <TableCell>
                        {procedure.assignee 
                          ? `${procedure.assignee.firstName} ${procedure.assignee.lastName}`
                          : 'Unassigned'}
                      </TableCell>
                      <TableCell>
                        <Chip
                          label={procedure.status.replace('_', ' ')}
                          color={getStatusColor(procedure.status) as any}
                          size="small"
                        />
                      </TableCell>
                      <TableCell>
                        <Chip
                          label={procedure.priority}
                          color={getPriorityColor(procedure.priority) as any}
                          size="small"
                        />
                      </TableCell>
                      <TableCell>
                        {procedure.dueDate ? new Date(procedure.dueDate).toLocaleDateString() : '-'}
                      </TableCell>
                      <TableCell>
                        <Box sx={{ display: 'flex', alignItems: 'center' }}>
                          <Typography variant="body2" sx={{ mr: 1 }}>
                            {procedure.progress || 0}%
                          </Typography>
                        </Box>
                      </TableCell>
                      <TableCell>
                        <IconButton onClick={(e) => handleMenuClick(e, procedure)}>
                          <MoreVertIcon />
                        </IconButton>
                      </TableCell>
                    </TableRow>
                  ))
                )}
              </TableBody>
            </Table>
          </TableContainer>
        </Card>
      )}

      {/* Action Menu */}
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleMenuClose}
      >
        <MenuItem onClick={() => selectedProcedure && handleViewProcedure(selectedProcedure.id)}>
          <ViewIcon sx={{ mr: 1 }} />
          View Details
        </MenuItem>
        <MenuItem onClick={() => selectedProcedure && handleUpdateStatus(selectedProcedure.id, 'IN_PROGRESS')}>
          <StartIcon sx={{ mr: 1 }} />
          Start Procedure
        </MenuItem>
        <MenuItem onClick={() => selectedProcedure && handleUpdateStatus(selectedProcedure.id, 'COMPLETED')}>
          <CompleteIcon sx={{ mr: 1 }} />
          Mark Complete
        </MenuItem>
        <MenuItem onClick={() => selectedProcedure && handleUpdateStatus(selectedProcedure.id, 'ON_HOLD')}>
          <PauseIcon sx={{ mr: 1 }} />
          Put on Hold
        </MenuItem>
      </Menu>

      {/* Create Procedure Dialog */}
      <Dialog open={open} onClose={() => setOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Create New Audit Procedure</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Procedure Name"
                fullWidth
                required
                value={newProcedure.name}
                onChange={(e) => setNewProcedure({ ...newProcedure, name: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Description"
                fullWidth
                multiline
                rows={3}
                value={newProcedure.description}
                onChange={(e) => setNewProcedure({ ...newProcedure, description: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                label="Company ID"
                fullWidth
                required
                value={newProcedure.companyId}
                onChange={(e) => setNewProcedure({ ...newProcedure, companyId: e.target.value })}
                helperText="Enter the company UUID"
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                label="Period ID"
                fullWidth
                required
                value={newProcedure.periodId}
                onChange={(e) => setNewProcedure({ ...newProcedure, periodId: e.target.value })}
                helperText="Enter the period UUID"
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Assigned To (User ID)"
                fullWidth
                value={newProcedure.assignedTo}
                onChange={(e) => setNewProcedure({ ...newProcedure, assignedTo: e.target.value })}
                helperText="Enter the user UUID (optional)"
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Priority</InputLabel>
                <Select
                  value={newProcedure.priority}
                  label="Priority"
                  onChange={(e) => setNewProcedure({ ...newProcedure, priority: e.target.value as any })}
                >
                  <MenuItem value="LOW">Low</MenuItem>
                  <MenuItem value="MEDIUM">Medium</MenuItem>
                  <MenuItem value="HIGH">High</MenuItem>
                  <MenuItem value="CRITICAL">Critical</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                label="Due Date"
                type="date"
                fullWidth
                InputLabelProps={{ shrink: true }}
                value={newProcedure.dueDate}
                onChange={(e) => setNewProcedure({ ...newProcedure, dueDate: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Procedure Type</InputLabel>
                <Select
                  value={newProcedure.procedureType}
                  label="Procedure Type"
                  onChange={(e) => setNewProcedure({ ...newProcedure, procedureType: e.target.value })}
                >
                  <MenuItem value="SUBSTANTIVE_TEST">Substantive Test</MenuItem>
                  <MenuItem value="CONTROL_TEST">Control Test</MenuItem>
                  <MenuItem value="ANALYTICAL_PROCEDURE">Analytical Procedure</MenuItem>
                  <MenuItem value="INQUIRY">Inquiry</MenuItem>
                  <MenuItem value="OBSERVATION">Observation</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Risk Level</InputLabel>
                <Select
                  value={newProcedure.riskLevel}
                  label="Risk Level"
                  onChange={(e) => setNewProcedure({ ...newProcedure, riskLevel: e.target.value })}
                >
                  <MenuItem value="LOW">Low</MenuItem>
                  <MenuItem value="MEDIUM">Medium</MenuItem>
                  <MenuItem value="HIGH">High</MenuItem>
                  <MenuItem value="CRITICAL">Critical</MenuItem>
                </Select>
              </FormControl>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button 
            onClick={handleCreateProcedure} 
            variant="contained"
            disabled={!newProcedure.name || !newProcedure.companyId || !newProcedure.periodId}
          >
            Create Procedure
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default AuditProcedures