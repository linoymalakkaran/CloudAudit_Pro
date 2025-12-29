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
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Select,
  FormControl,
  InputLabel,
  MenuItem
} from '@mui/material'
import {
  Add as AddIcon,
  Assessment as ReportIcon,
  Download as DownloadIcon,
  Visibility as ViewIcon,
  Email as EmailIcon
} from '@mui/icons-material'

interface Report {
  id: string
  name: string
  type: string
  company: string
  status: 'DRAFT' | 'GENERATED' | 'REVIEWED' | 'FINAL'
  createdBy: string
  createdDate: string
  period: string
}

function Reports() {
  const [open, setOpen] = useState(false)
  const [reports] = useState<Report[]>([
    {
      id: '1',
      name: 'Annual Audit Report',
      type: 'Audit Report',
      company: 'Acme Corporation',
      status: 'FINAL',
      createdBy: 'Sarah Wilson',
      createdDate: '2024-11-20',
      period: '2024'
    },
    {
      id: '2',
      name: 'Management Letter',
      type: 'Management Letter',
      company: 'Tech Solutions',
      status: 'REVIEWED',
      createdBy: 'John Doe',
      createdDate: '2024-11-18',
      period: 'Q3 2024'
    },
    {
      id: '3',
      name: 'Internal Control Assessment',
      type: 'Control Assessment',
      company: 'Manufacturing Co',
      status: 'DRAFT',
      createdBy: 'Mike Johnson',
      createdDate: '2024-11-15',
      period: '2024'
    }
  ])

  const [newReport, setNewReport] = useState({
    name: '',
    type: '',
    company: '',
    period: ''
  })

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'DRAFT': return 'default'
      case 'GENERATED': return 'info'
      case 'REVIEWED': return 'warning'
      case 'FINAL': return 'success'
      default: return 'default'
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

  const handleViewReport = (reportId: string, reportName: string) => {
    console.log('Viewing report:', reportId)
    alert(`Opening "${reportName}"...\nReport viewer will be implemented`)
  }

  const handleDownloadReport = (reportId: string, reportName: string) => {
    console.log('Downloading report:', reportId)
    alert(`Downloading "${reportName}"...\nFile download will be implemented`)
  }

  const handleEmailReport = (reportId: string, reportName: string) => {
    console.log('Emailing report:', reportId)
    alert(`Email dialog for "${reportName}"...\nEmail functionality will be implemented`)
  }

  const handleTemplateClick = (template: string) => {
    console.log('Generating report from template:', template)
    alert(`Creating new ${template}...\nReport generation will be implemented`)
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

      {/* Statistics */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'primary.main', mb: 1 }} />
              <Typography variant="h4">24</Typography>
              <Typography variant="body2">Total Reports</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4">18</Typography>
              <Typography variant="body2">Final Reports</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4">4</Typography>
              <Typography variant="body2">Under Review</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <ReportIcon sx={{ fontSize: 40, color: 'info.main', mb: 1 }} />
              <Typography variant="h4">2</Typography>
              <Typography variant="body2">In Progress</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Reports Table */}
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
              {reports.map((report) => (
                <TableRow key={report.id}>
                  <TableCell>
                    <Typography variant="subtitle2">
                      {report.name}
                    </Typography>
                  </TableCell>
                  <TableCell>{report.type}</TableCell>
                  <TableCell>{report.company}</TableCell>
                  <TableCell>{report.period}</TableCell>
                  <TableCell>
                    <Chip
                      label={report.status}
                      color={getStatusColor(report.status) as any}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>{report.createdBy}</TableCell>
                  <TableCell>{report.createdDate}</TableCell>
                  <TableCell>
                    <IconButton color="primary" onClick={() => handleViewReport(report.id, report.name)}>
                      <ViewIcon />
                    </IconButton>
                    <IconButton color="success" onClick={() => handleDownloadReport(report.id, report.name)}>
                      <DownloadIcon />
                    </IconButton>
                    <IconButton color="info" onClick={() => handleEmailReport(report.id, report.name)}>
                      <EmailIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>

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
                  value={newReport.type}
                  label="Report Type"
                  onChange={(e) => setNewReport({ ...newReport, type: e.target.value })}
                >
                  {reportTemplates.map((template, index) => (
                    <MenuItem key={index} value={template}>{template}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Company</InputLabel>
                <Select
                  value={newReport.company}
                  label="Company"
                  onChange={(e) => setNewReport({ ...newReport, company: e.target.value })}
                >
                  <MenuItem value="Acme Corporation">Acme Corporation</MenuItem>
                  <MenuItem value="Tech Solutions">Tech Solutions</MenuItem>
                  <MenuItem value="Manufacturing Co">Manufacturing Co</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Period"
                fullWidth
                placeholder="e.g., 2024, Q3 2024, Jan-Dec 2024"
                value={newReport.period}
                onChange={(e) => setNewReport({ ...newReport, period: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={() => setOpen(false)} variant="contained">Generate Report</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Reports