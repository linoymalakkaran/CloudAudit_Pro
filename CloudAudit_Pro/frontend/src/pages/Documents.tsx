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
  Alert,
  Input
} from '@mui/material'
import {
  CloudUpload as UploadIcon,
  Description as DocumentIcon,
  Download as DownloadIcon,
  Delete as DeleteIcon
} from '@mui/icons-material'
import { documentApi, Document as DocumentType, companyApi } from '../services/api'

function Documents() {
  const [open, setOpen] = useState(false)
  const [documents, setDocuments] = useState<DocumentType[]>([])
  const [companies, setCompanies] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [uploadFile, setUploadFile] = useState<File | null>(null)
  const [stats, setStats] = useState<any>(null)

  const [newDocument, setNewDocument] = useState({
    name: '',
    companyId: '',
    type: 'OTHER',
    description: ''
  })

  useEffect(() => {
    loadDocuments()
    loadCompanies()
    loadStats()
  }, [])

  const loadDocuments = async () => {
    try {
      setLoading(true)
      setError(null)
      const data = await documentApi.getDocuments()
      setDocuments(data)
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load documents')
    } finally {
      setLoading(false)
    }
  }

  const loadCompanies = async () => {
    try {
      const data = await companyApi.getCompanies()
      setCompanies(data)
    } catch (err: any) {
      console.error('Failed to load companies:', err)
    }
  }

  const loadStats = async () => {
    try {
      const data = await documentApi.getDocumentStats()
      setStats(data)
    } catch (err: any) {
      console.error('Failed to load stats:', err)
    }
  }

  const getFileIcon = (type: string) => {
    return <DocumentIcon color="primary" />
  }

  const getCategoryColor = (type: string) => {
    switch (type) {
      case 'BANK_STATEMENT': return 'primary'
      case 'FINANCIAL_STATEMENT': return 'success'
      case 'INVOICE': return 'warning'
      case 'TRIAL_BALANCE': return 'info'
      default: return 'default'
    }
  }

  const handleDownload = async (documentId: string, documentName: string) => {
    try {
      const blob = await documentApi.downloadDocument(documentId)
      const url = window.URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = documentName
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      window.URL.revokeObjectURL(url)
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to download document')
    }
  }

  const handleDelete = async (documentId: string, documentName: string) => {
    const confirmed = window.confirm(`Are you sure you want to delete "${documentName}"?`)
    if (confirmed) {
      try {
        await documentApi.deleteDocument(documentId)
        alert(`Document "${documentName}" deleted successfully`)
        loadDocuments()
        loadStats()
      } catch (err: any) {
        alert(err.response?.data?.message || 'Failed to delete document')
      }
    }
  }

  const handleUploadDocument = async () => {
    if (!newDocument.name || !newDocument.companyId) {
      alert('Please provide document name and select a company')
      return
    }

    try {
      await documentApi.createDocument(newDocument, uploadFile || undefined)
      alert('Document uploaded successfully')
      setOpen(false)
      setNewDocument({
        name: '',
        companyId: '',
        type: 'OTHER',
        description: ''
      })
      setUploadFile(null)
      loadDocuments()
      loadStats()
    } catch (err: any) {
      alert(err.response?.data?.message || 'Failed to upload document')
    }
  }

  const formatFileSize = (bytes?: number) => {
    if (!bytes) return 'N/A'
    if (bytes < 1024) return bytes + ' B'
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(2) + ' KB'
    return (bytes / (1024 * 1024)).toFixed(2) + ' MB'
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString()
  }

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" minHeight="400px">
        <CircularProgress />
      </Box>
    )
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
          Document Management
        </Typography>
        <Button
          variant="contained"
          startIcon={<UploadIcon />}
          onClick={() => setOpen(true)}
        >
          Upload Document
        </Button>
      </Box>

      {/* Statistics */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'primary.main', mb: 1 }} />
              <Typography variant="h4">{stats?.total || documents.length}</Typography>
              <Typography variant="body2">Total Documents</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4">{stats?.thisWeek || 0}</Typography>
              <Typography variant="body2">This Week</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4">{stats?.totalSize || '0 MB'}</Typography>
              <Typography variant="body2">Total Size</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'info.main', mb: 1 }} />
              <Typography variant="h4">{stats?.categories || 8}</Typography>
              <Typography variant="body2">Categories</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Documents Table */}
      <Card>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Document Name</TableCell>
                <TableCell>Type</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Size</TableCell>
                <TableCell>Upload Date</TableCell>
                <TableCell>Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {documents.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} align="center">
                    <Typography variant="body2" color="text.secondary">
                      No documents found. Upload your first document to get started.
                    </Typography>
                  </TableCell>
                </TableRow>
              ) : (
                documents.map((document) => (
                  <TableRow key={document.id}>
                    <TableCell>
                      <Box sx={{ display: 'flex', alignItems: 'center' }}>
                        {getFileIcon(document.type)}
                        <Typography variant="subtitle2" sx={{ ml: 1 }}>
                          {document.name}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={document.type.replace('_', ' ')}
                        color={getCategoryColor(document.type) as any}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={document.status}
                        color={document.status === 'APPROVED' ? 'success' : 'default'}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>{formatFileSize(document.fileSize)}</TableCell>
                    <TableCell>{formatDate(document.createdAt)}</TableCell>
                    <TableCell>
                      <IconButton 
                        color="primary" 
                        onClick={() => handleDownload(document.id, document.fileName || document.name)}
                        disabled={!document.fileUrl}
                      >
                        <DownloadIcon />
                      </IconButton>
                      <IconButton 
                        color="error" 
                        onClick={() => handleDelete(document.id, document.name)}
                      >
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>

      {/* Upload Document Dialog */}
      <Dialog open={open} onClose={() => setOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Upload New Document</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                label="Document Name"
                fullWidth
                value={newDocument.name}
                onChange={(e) => setNewDocument({ ...newDocument, name: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth required>
                <InputLabel>Company</InputLabel>
                <Select
                  value={newDocument.companyId}
                  label="Company"
                  onChange={(e) => setNewDocument({ ...newDocument, companyId: e.target.value })}
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
              <FormControl fullWidth>
                <InputLabel>Document Type</InputLabel>
                <Select
                  value={newDocument.type}
                  label="Document Type"
                  onChange={(e) => setNewDocument({ ...newDocument, type: e.target.value })}
                >
                  <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                  <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                  <MenuItem value="GENERAL_LEDGER">General Ledger</MenuItem>
                  <MenuItem value="BANK_STATEMENT">Bank Statement</MenuItem>
                  <MenuItem value="INVOICE">Invoice</MenuItem>
                  <MenuItem value="RECEIPT">Receipt</MenuItem>
                  <MenuItem value="CONTRACT">Contract</MenuItem>
                  <MenuItem value="CORRESPONDENCE">Correspondence</MenuItem>
                  <MenuItem value="WORKING_PAPER">Working Paper</MenuItem>
                  <MenuItem value="MANAGEMENT_LETTER">Management Letter</MenuItem>
                  <MenuItem value="OTHER">Other</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                label="Description"
                fullWidth
                multiline
                rows={3}
                value={newDocument.description}
                onChange={(e) => setNewDocument({ ...newDocument, description: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                variant="outlined"
                component="label"
                fullWidth
                startIcon={<UploadIcon />}
              >
                {uploadFile ? uploadFile.name : 'Choose File'}
                <Input
                  type="file"
                  hidden
                  onChange={(e: any) => setUploadFile(e.target.files?.[0] || null)}
                />
              </Button>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={handleUploadDocument} variant="contained">
            Upload
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Documents
