import React, { useState, useEffect } from 'react'
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
  MenuItem,
  CircularProgress,
  Alert
} from '@mui/material'
import {
  Add as AddIcon,
  Business as BusinessIcon,
  MoreVert as MoreVertIcon,
  Edit as EditIcon,
  Delete as DeleteIcon
} from '@mui/icons-material'
import { companyApi, Company as CompanyType } from '../../services/api'

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
  const [editMode, setEditMode] = useState(false)
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [selectedCompany, setSelectedCompany] = useState<CompanyType | null>(null)
  const [companies, setCompanies] = useState<CompanyType[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [stats, setStats] = useState<any>(null)

  useEffect(() => {
    loadCompanies()
    loadStats()
  }, [])

  const loadCompanies = async () => {
    try {
      setLoading(true)
      const data = await companyApi.getCompanies()
      setCompanies(data)
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load companies')
    } finally {
      setLoading(false)
    }
  }

  const loadStats = async () => {
    try {
      const data = await companyApi.getCompanyStats()
      setStats(data)
    } catch (err: any) {
      console.error('Failed to load stats:', err)
    }
  }

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

  const handleMenuClick = (event: React.MouseEvent<HTMLElement>, company: CompanyType) => {
    setAnchorEl(event.currentTarget)
    setSelectedCompany(company)
  }

  const handleMenuClose = () => {
    setAnchorEl(null)
    setSelectedCompany(null)
  }

  const handleEditCompany = () => {
    if (selectedCompany) {
      setNewCompany({
        name: selectedCompany.name,
        taxId: selectedCompany.taxId || '',
        industry: selectedCompany.industry || '',
        contactName: selectedCompany.contactPerson?.name || '',
        contactEmail: selectedCompany.contactPerson?.email || '',
        contactPhone: selectedCompany.contactPerson?.phone || '',
        street: selectedCompany.address?.street || '',
        city: selectedCompany.address?.city || '',
        state: selectedCompany.address?.state || '',
        country: selectedCompany.address?.country || '',
        zipCode: selectedCompany.address?.zipCode || ''
      })
      setEditMode(true)
      setOpen(true)
    }
    handleMenuClose()
  }

  const handleDeleteCompany = async () => {
    if (selectedCompany) {
      const confirmed = window.confirm(`Are you sure you want to delete "${selectedCompany.name}"?`)
      if (confirmed) {
        try {
          await companyApi.deleteCompany(selectedCompany.id)
          alert(`Company "${selectedCompany.name}" deleted successfully`)
          loadCompanies()
          loadStats()
        } catch (err: any) {
          alert(err.response?.data?.message || 'Failed to delete company')
        }
      }
    }
    handleMenuClose()
  }

  const handleAddCompany = async () => {
    if (!newCompany.name) {
      alert('Company name is required')
      return
    }

    try {
      const companyData = {
        name: newCompany.name,
        taxId: newCompany.taxId || undefined,
        industry: newCompany.industry || undefined,
        contactPersonName: newCompany.contactName || undefined,
        contactPersonEmail: newCompany.contactEmail || undefined,
        contactPersonPhone: newCompany.contactPhone || undefined,
        addressStreet: newCompany.street || undefined,
        addressCity: newCompany.city || undefined,
        addressState: newCompany.state || undefined,
        addressCountry: newCompany.country || undefined,
        addressZipCode: newCompany.zipCode || undefined
      }

      if (editMode && selectedCompany) {
        await companyApi.updateCompany(selectedCompany.id, companyData)
        alert('Company updated successfully')
      } else {
        await companyApi.createCompany(companyData)
        alert('Company created successfully')
      }

      setOpen(false)
      setEditMode(false)
      setSelectedCompany(null)
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
      loadCompanies()
      loadStats()
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to save company')
    }
  }

  return (
    <Box>
      {error && (
        <Alert severity="error" sx={{ mb: 3 }}>
          {error}
        </Alert>
      )}

      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 4 }}>
        <Typography variant="h4">
          Company Management
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => {
            setEditMode(false)
            setSelectedCompany(null)
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
            setOpen(true)
          }}
        >
          Add Company
        </Button>
      </Box>

      {loading ? (
        <Box display="flex" justifyContent="center" alignItems="center" minHeight="400px">
          <CircularProgress />
        </Box>
      ) : (
        <>
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
                        {stats?.activeAudits || 0}
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
                        {stats?.newThisMonth || 0}
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
                  {companies.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={6} align="center">
                        <Typography variant="body2" color="text.secondary">
                          No companies found. Add your first company to get started.
                        </Typography>
                      </TableCell>
                    </TableRow>
                  ) : (
                    companies.map((company) => (
                      <TableRow key={company.id}>
                        <TableCell>
                          <Typography variant="subtitle2">
                            {company.name}
                          </Typography>
                        </TableCell>
                        <TableCell>{company.taxId || 'N/A'}</TableCell>
                        <TableCell>{company.industry || 'N/A'}</TableCell>
                        <TableCell>
                          <Typography variant="body2">
                            {company.contactPerson?.name || 'N/A'}
                          </Typography>
                          <Typography variant="caption" color="text.secondary">
                            {company.contactPerson?.email || ''}
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
                          <IconButton onClick={(e) => handleMenuClick(e, company)}>
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
        </>
      )}

      {/* Action Menu */}
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleMenuClose}
      >
        <MenuItem onClick={handleEditCompany}>
          <EditIcon sx={{ mr: 1 }} />
          Edit Company
        </MenuItem>
        <MenuItem onClick={handleDeleteCompany}>
          <DeleteIcon sx={{ mr: 1 }} />
          Delete Company
        </MenuItem>
      </Menu>

      {/* Add/Edit Company Dialog */}
      <Dialog open={open} onClose={() => setOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>{editMode ? 'Edit Company' : 'Add New Company'}</DialogTitle>
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
          <Button onClick={handleAddCompany} variant="contained">
            {editMode ? 'Update Company' : 'Add Company'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Companies