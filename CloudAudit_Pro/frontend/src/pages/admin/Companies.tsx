import React, { useState } from 'react'
import {
  Box,
  Typography,
  Button,
  Card,
  CardContent,
  Grid,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
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
  MenuItem
} from '@mui/material'
import {
  Add as AddIcon,
  Business as BusinessIcon,
  MoreVert as MoreVertIcon,
  Edit as EditIcon,
  Delete as DeleteIcon
} from '@mui/icons-material'

interface Company {
  id: string
  name: string
  taxId: string
  industry: string
  status: 'ACTIVE' | 'INACTIVE'
  contactPerson: {
    name: string
    email: string
    phone: string
  }
  address: {
    street: string
    city: string
    state: string
    country: string
    zipCode: string
  }
}

function Companies() {
  const [open, setOpen] = useState(false)
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [selectedCompany, setSelectedCompany] = useState<string | null>(null)
  const [companies] = useState<Company[]>([
    {
      id: '1',
      name: 'Acme Corporation',
      taxId: '12-3456789',
      industry: 'Manufacturing',
      status: 'ACTIVE',
      contactPerson: {
        name: 'John Smith',
        email: 'john@acme.com',
        phone: '+1-555-0123'
      },
      address: {
        street: '123 Business Ave',
        city: 'Business City',
        state: 'BC',
        country: 'USA',
        zipCode: '12345'
      }
    },
    {
      id: '2',
      name: 'Tech Solutions Ltd',
      taxId: '98-7654321',
      industry: 'Technology',
      status: 'ACTIVE',
      contactPerson: {
        name: 'Jane Doe',
        email: 'jane@techsolutions.com',
        phone: '+1-555-0456'
      },
      address: {
        street: '456 Tech St',
        city: 'Silicon Valley',
        state: 'CA',
        country: 'USA',
        zipCode: '94000'
      }
    }
  ])

  const [newCompany, setNewCompany] = useState({
    name: '',
    taxId: '',
    industry: '',
    contactName: '',
    contactEmail: '',
    contactPhone: '',
    street: '',
    city: '',
    state: '',
    country: '',
    zipCode: ''
  })

  const handleMenuClick = (event: React.MouseEvent<HTMLElement>, companyId: string) => {
    setAnchorEl(event.currentTarget)
    setSelectedCompany(companyId)
  }

  const handleMenuClose = () => {
    setAnchorEl(null)
    setSelectedCompany(null)
  }

  const handleAddCompany = () => {
    // TODO: API call to add company
    console.log('Adding company:', newCompany)
    setOpen(false)
    setNewCompany({
      name: '',
      taxId: '',
      industry: '',
      contactName: '',
      contactEmail: '',
      contactPhone: '',
      street: '',
      city: '',
      state: '',
      country: '',
      zipCode: ''
    })
  }

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 4 }}>
        <Typography variant="h4">
          Company Management
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setOpen(true)}
        >
          Add Company
        </Button>
      </Box>

      {/* Statistics Cards */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <BusinessIcon sx={{ fontSize: 40, color: 'primary.main', mr: 2 }} />
                <Box>
                  <Typography variant="h4">
                    {companies.length}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    Total Companies
                  </Typography>
                </Box>
              </Box>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <BusinessIcon sx={{ fontSize: 40, color: 'success.main', mr: 2 }} />
                <Box>
                  <Typography variant="h4">
                    {companies.filter(c => c.status === 'ACTIVE').length}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    Active Companies
                  </Typography>
                </Box>
              </Box>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <BusinessIcon sx={{ fontSize: 40, color: 'warning.main', mr: 2 }} />
                <Box>
                  <Typography variant="h4">
                    15
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    Active Audits
                  </Typography>
                </Box>
              </Box>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <BusinessIcon sx={{ fontSize: 40, color: 'info.main', mr: 2 }} />
                <Box>
                  <Typography variant="h4">
                    3
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    New This Month
                  </Typography>
                </Box>
              </Box>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Companies Table */}
      <Card>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Company Name</TableCell>
                <TableCell>Tax ID</TableCell>
                <TableCell>Industry</TableCell>
                <TableCell>Contact Person</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {companies.map((company) => (
                <TableRow key={company.id}>
                  <TableCell>
                    <Typography variant="subtitle2">
                      {company.name}
                    </Typography>
                  </TableCell>
                  <TableCell>{company.taxId}</TableCell>
                  <TableCell>{company.industry}</TableCell>
                  <TableCell>
                    <Typography variant="body2">
                      {company.contactPerson.name}
                    </Typography>
                    <Typography variant="caption" color="text.secondary">
                      {company.contactPerson.email}
                    </Typography>
                  </TableCell>
                  <TableCell>
                    <Chip
                      label={company.status}
                      color={company.status === 'ACTIVE' ? 'success' : 'default'}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>
                    <IconButton onClick={(e) => handleMenuClick(e, company.id)}>
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
          <EditIcon sx={{ mr: 1 }} />
          Edit Company
        </MenuItem>
        <MenuItem onClick={handleMenuClose}>
          <DeleteIcon sx={{ mr: 1 }} />
          Delete Company
        </MenuItem>
      </Menu>

      {/* Add Company Dialog */}
      <Dialog open={open} onClose={() => setOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>Add New Company</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12} sm={6}>
              <TextField
                label="Company Name"
                fullWidth
                value={newCompany.name}
                onChange={(e) => setNewCompany({ ...newCompany, name: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                label="Tax ID"
                fullWidth
                value={newCompany.taxId}
                onChange={(e) => setNewCompany({ ...newCompany, taxId: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Industry"
                fullWidth
                value={newCompany.industry}
                onChange={(e) => setNewCompany({ ...newCompany, industry: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <Typography variant="h6" sx={{ mt: 2 }}>Contact Person</Typography>
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="Contact Name"
                fullWidth
                value={newCompany.contactName}
                onChange={(e) => setNewCompany({ ...newCompany, contactName: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="Email"
                fullWidth
                value={newCompany.contactEmail}
                onChange={(e) => setNewCompany({ ...newCompany, contactEmail: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="Phone"
                fullWidth
                value={newCompany.contactPhone}
                onChange={(e) => setNewCompany({ ...newCompany, contactPhone: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <Typography variant="h6" sx={{ mt: 2 }}>Address</Typography>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Street Address"
                fullWidth
                value={newCompany.street}
                onChange={(e) => setNewCompany({ ...newCompany, street: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="City"
                fullWidth
                value={newCompany.city}
                onChange={(e) => setNewCompany({ ...newCompany, city: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="State"
                fullWidth
                value={newCompany.state}
                onChange={(e) => setNewCompany({ ...newCompany, state: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                label="ZIP Code"
                fullWidth
                value={newCompany.zipCode}
                onChange={(e) => setNewCompany({ ...newCompany, zipCode: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={handleAddCompany} variant="contained">Add Company</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Companies