import React, { useState } from 'react'
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
  InputLabel
} from '@mui/material'
import {
  Add as AddIcon,
  MoreVert as MoreVertIcon,
  PlayArrow as StartIcon,
  CheckCircle as CompleteIcon,
  Pause as PauseIcon
} from '@mui/icons-material'

interface Procedure {
  id: string
  name: string
  company: string
  assignee: string
  status: 'NOT_STARTED' | 'IN_PROGRESS' | 'COMPLETED' | 'ON_HOLD'
  priority: 'LOW' | 'MEDIUM' | 'HIGH'
  dueDate: string
  progress: number
}

function AuditProcedures() {
  const [open, setOpen] = useState(false)
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [selectedProcedure, setSelectedProcedure] = useState<string | null>(null)
  const [procedures] = useState<Procedure[]>([
    {
      id: '1',
      name: 'Bank Confirmation',
      company: 'Acme Corporation',
      assignee: 'John Doe',
      status: 'IN_PROGRESS',
      priority: 'HIGH',
      dueDate: '2024-11-25',
      progress: 75
    },
    {
      id: '2',
      name: 'Inventory Count',
      company: 'Tech Solutions',
      assignee: 'Sarah Wilson',
      status: 'NOT_STARTED',
      priority: 'MEDIUM',
      dueDate: '2024-12-01',
      progress: 0
    },
    {
      id: '3',
      name: 'Cash Flow Analysis',
      company: 'Manufacturing Co',
      assignee: 'Mike Johnson',
      status: 'COMPLETED',
      priority: 'HIGH',
      dueDate: '2024-11-20',
      progress: 100
    }
  ])

  const [newProcedure, setNewProcedure] = useState({
    name: '',
    company: '',
    assignee: '',
    priority: 'MEDIUM' as const,
    dueDate: ''
  })

  const handleMenuClick = (event: React.MouseEvent<HTMLElement>, procedureId: string) => {
    setAnchorEl(event.currentTarget)
    setSelectedProcedure(procedureId)
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

      {/* Statistics */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="primary.main">15</Typography>
              <Typography variant="body2">Total Procedures</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="warning.main">5</Typography>
              <Typography variant="body2">In Progress</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="success.main">8</Typography>
              <Typography variant="body2">Completed</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Typography variant="h4" color="error.main">2</Typography>
              <Typography variant="body2">Overdue</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Procedures Table */}
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
              {procedures.map((procedure) => (
                <TableRow key={procedure.id}>
                  <TableCell>
                    <Typography variant="subtitle2">
                      {procedure.name}
                    </Typography>
                  </TableCell>
                  <TableCell>{procedure.company}</TableCell>
                  <TableCell>{procedure.assignee}</TableCell>
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
                  <TableCell>{procedure.dueDate}</TableCell>
                  <TableCell>
                    <Box sx={{ display: 'flex', alignItems: 'center' }}>
                      <Typography variant="body2" sx={{ mr: 1 }}>
                        {procedure.progress}%
                      </Typography>
                    </Box>
                  </TableCell>
                  <TableCell>
                    <IconButton onClick={(e) => handleMenuClick(e, procedure.id)}>
                      <MoreVertIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>

      {/* Action Menu */}
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleMenuClose}
      >
        <MenuItem onClick={handleMenuClose}>
          <StartIcon sx={{ mr: 1 }} />
          Start Procedure
        </MenuItem>
        <MenuItem onClick={handleMenuClose}>
          <CompleteIcon sx={{ mr: 1 }} />
          Mark Complete
        </MenuItem>
        <MenuItem onClick={handleMenuClose}>
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
                value={newProcedure.name}
                onChange={(e) => setNewProcedure({ ...newProcedure, name: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Company"
                fullWidth
                value={newProcedure.company}
                onChange={(e) => setNewProcedure({ ...newProcedure, company: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Assignee"
                fullWidth
                value={newProcedure.assignee}
                onChange={(e) => setNewProcedure({ ...newProcedure, assignee: e.target.value })}
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
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={() => setOpen(false)} variant="contained">Create Procedure</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default AuditProcedures