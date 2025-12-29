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
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Select,
  FormControl,
  InputLabel,
  MenuItem,
  CircularProgress,
  Alert
} from '@mui/material'
import {
  Add as AddIcon,
  Assessment as ReportIcon,
  Download as DownloadIcon,
  Visibility as ViewIcon,
  Email as EmailIcon
} from '@mui/icons-material'
import { useNavigate } from 'react-router-dom'
import reportsService, { Report as ServiceReport, CreateReportDto } from '../services/reports.service'
import { companyApi } from '../services/api'
import { ReportType, ReportCategory } from '../types/report.types'

type Report = ServiceReport;

function Reports() {
  const navigate = useNavigate()
  const [open, setOpen] = useState(false)
  const [reports, setReports] = useState<Report[]>([])
  const [companies, setCompanies] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [stats, setStats] = useState({ total: 0, completed: 0, generating: 0, failed: 0 })

  useEffect(() => {
    loadReports()
    loadCompanies()
  }, [])

  const loadReports = async () => {
    try {
      setLoading(true)
      setError(null)
      const data = await reportsService.getReports()
      setReports(data)
      
      // Calculate stats
      setStats({
        total: data.length,
        completed: data.filter(r => r.status === 'COMPLETED').length,
        generating: data.filter(r => r.status === 'GENERATING' || r.status === 'QUEUED').length,
        failed: data.filter(r => r.status === 'FAILED').length
      })
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load reports')
    } finally {
      setLoading(false)
    }
  }

  const loadCompanies = async () => {
    try {
      const data = await companyApi.getCompanies()
      setCompanies(data)
    } catch (err) {
      console.error('Failed to load companies:', err)
    }
  }

  const [newReport, setNewReport] = useState<Partial<CreateReportDto>>({
    name: '',
    reportType: 'TRIAL_BALANCE' as ReportType,
    companyId: '',
    periodId: '',
    category: 'FINANCIAL' as ReportCategory
  })

  const handleTemplateClick = (template: string) => {
    setNewReport(prev => ({ ...prev, name: template }))
    setOpen(true)
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'QUEUED':
        return 'default'
      case 'GENERATING':
        return 'info'
      case 'COMPLETED':
        return 'success'
      case 'FAILED':
        return 'error'
      default:
        return 'default'
    }
  }

  const reportTemplates = [
    'Audit Report',
    'Management Letter',
    'Control Assessment',
    'Financial Statement Analysis',
    'Risk Assessment Report',
    'Compliance Report'
  ]

  const handleViewReport = (reportId: string) => {
    navigate(`/reports/${reportId}`)
  }

  const handleDownloadReport = async (reportId: string, reportName: string) => {
    try {
      // Implementation would download the file
      alert(`Download functionality for "${reportName}" will be implemented with backend endpoint`)
    } catch (err) {
      console.error('Download failed:', err)
    }
  }

  const handleEmailReport = async (reportId: string, reportName: string) => {
    alert(`Email functionality for "${reportName}" will be implemented`)
  }

  const handleGenerateReport = async () => {
    try {
      if (!newReport.name || !newReport.companyId) {
        alert('Please fill in required fields')
        return
      }
      await reportsService.createReport(newReport as CreateReportDto)
      setOpen(false)
      setNewReport({
        name: '',
        reportType: 'TRIAL_BALANCE' as ReportType,
        companyId: '',
        periodId: '',
        category: 'FINANCIAL' as ReportCategory
      })
      loadReports()
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to generate report')
    }
  }

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 4 }}>
        <Typography variant="h4">
          Reports & Analytics
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setOpen(true)}
        >
          Generate Report
        </Button>
      </Box>

      {/* Report Templates */}
      <Card sx={{ mb: 4 }}>
        <CardContent>
          <Typography variant="h6" gutterBottom>
            Quick Report Templates
          </Typography>
          <Grid container spacing={2}>
            {reportTemplates.map((template, index) => (
              <Grid item xs={12} sm={6} md={4} key={index}>
                <Button
                  variant="outlined"
                  fullWidth
                  startIcon={<ReportIcon />}
                  sx={{ justifyContent: 'flex-start', p: 2 }}
                  onClick={() => handleTemplateClick(template)}
                >
                  {template}
                </Button>
              </Grid>
            ))}
          </Grid>
        </CardContent>
      </Card>

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
              <ReportIcon sx={{ fontSize: 40, color: 'primary.main', mb: 1 }} />
              <Typography variant="h4">{stats.total}</Typography>
              <Typography variant="body2">Total Reports</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4">{stats.completed}</Typography>
              <Typography variant="body2">Completed</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4">{stats.generating}</Typography>
              <Typography variant="body2">Generating</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'error.main', mb: 1 }} />
              <Typography variant="h4">{stats.failed}</Typography>
              <Typography variant="body2">Failed</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Reports Table */}
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
                  <TableCell>Report Name</TableCell>
                  <TableCell>Type</TableCell>
                  <TableCell>Company</TableCell>
                  <TableCell>Period</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell>Created By</TableCell>
                  <TableCell>Created Date</TableCell>
                  <TableCell>Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {reports.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={8} align="center">
                      <Typography variant="body2" color="text.secondary" sx={{ py: 3 }}>
                        No reports found. Generate your first report to get started.
                      </Typography>
                    </TableCell>
                  </TableRow>
                ) : (
                  reports.map((report) => (
                    <TableRow key={report.id}>
                      <TableCell>
                        <Typography variant="subtitle2">
                          {report.name}
                        </Typography>
                      </TableCell>
                      <TableCell>{report.reportType}</TableCell>
                      <TableCell>{report.company?.name || '-'}</TableCell>
                      <TableCell>{report.period?.name || '-'}</TableCell>
                      <TableCell>
                        <Chip
                          label={report.status}
                          color={getStatusColor(report.status) as any}
                          size="small"
                        />
                      </TableCell>
                      <TableCell>
                        {report.createdByUser 
                          ? `${report.createdByUser.firstName} ${report.createdByUser.lastName}`
                          : '-'}
                      </TableCell>
                      <TableCell>{new Date(report.createdAt).toLocaleDateString()}</TableCell>
                      <TableCell>
                        <IconButton color="primary" onClick={() => handleViewReport(report.id)}>
                          <ViewIcon />
                        </IconButton>
                        <IconButton 
                          color="success" 
                          onClick={() => handleDownloadReport(report.id, report.name)}
                          disabled={report.status !== 'COMPLETED'}
                        >
                          <DownloadIcon />
                        </IconButton>
                        <IconButton 
                          color="info" 
                          onClick={() => handleEmailReport(report.id, report.name)}
                          disabled={report.status !== 'COMPLETED'}
                        >
                          <EmailIcon />
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

      {/* Generate Report Dialog */}
      <Dialog open={open} onClose={() => setOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Generate New Report</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Report Name"
                fullWidth
                value={newReport.name}
                onChange={(e) => setNewReport({ ...newReport, name: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Report Type</InputLabel>
                <Select
                  value={newReport.reportType}
                  label="Report Type"
                  onChange={(e) => setNewReport({ ...newReport, reportType: e.target.value as ReportType })}
                >
                  <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                  <MenuItem value="GENERAL_LEDGER">General Ledger</MenuItem>
                  <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                  <MenuItem value="AUDIT_REPORT">Audit Report</MenuItem>
                  <MenuItem value="CUSTOM">Custom Report</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={newReport.category}
                  label="Category"
                  onChange={(e) => setNewReport({ ...newReport, category: e.target.value as ReportCategory })}
                >
                  <MenuItem value="FINANCIAL">Financial</MenuItem>
                  <MenuItem value="OPERATIONAL">Operational</MenuItem>
                  <MenuItem value="COMPLIANCE">Compliance</MenuItem>
                  <MenuItem value="MANAGEMENT">Management</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Company</InputLabel>
                <Select
                  value={newReport.companyId}
                  label="Company"
                  onChange={(e) => setNewReport({ ...newReport, companyId: e.target.value })}
                >
                  {companies.map((company) => (
                    <MenuItem key={company.id} value={company.id}>
                      {company.name}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Period ID"
                fullWidth
                placeholder="Enter period ID"
                value={newReport.periodId}
                onChange={(e) => setNewReport({ ...newReport, periodId: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={handleGenerateReport} variant="contained">Generate Report</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Reports