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
  CloudUpload as UploadIcon,
  Description as DocumentIcon,
  Download as DownloadIcon,
  Delete as DeleteIcon
} from '@mui/icons-material'
import { documentApi, Document as DocumentType } from '../services/api'

function Documents() {
  const [open, setOpen] = useState(false)
  const [documents, setDocuments] = useState<DocumentType[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [uploadFile, setUploadFile] = useState<File | null>(null)

  const [newDocument, setNewDocument] = useState({
    name: '',
    company: '',
    category: '',
    description: ''
  })

  const getFileIcon = (type: string) => {
    return <DocumentIcon color="primary" />
  }

  const getCategoryColor = (category: string) => {
    switch (category) {
      case 'Bank Documents': return 'primary'
      case 'Financial Statements': return 'success'
      case 'Inventory': return 'warning'
      default: return 'default'
    }
  }

  const handleDownload = (documentId: string, documentName: string) => {
    // TODO: API call to download document
    console.log('Downloading document:', documentId)
    alert(`Downloading "${documentName}"...\nThis will be implemented with proper file download from backend`)
  }

  const handleDelete = (documentId: string, documentName: string) => {
    const confirmed = window.confirm(`Are you sure you want to delete "${documentName}"?`)
    if (confirmed) {
      // TODO: API call to delete document
      console.log('Deleting document:', documentId)
      alert(`Document "${documentName}" will be deleted.\nAPI integration pending.`)
    }
  }

  return (
    <Box>
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
              <Typography variant="h4">156</Typography>
              <Typography variant="body2">Total Documents</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'success.main', mb: 1 }} />
              <Typography variant="h4">12</Typography>
              <Typography variant="body2">This Week</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'warning.main', mb: 1 }} />
              <Typography variant="h4">2.8 GB</Typography>
              <Typography variant="body2">Total Size</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <DocumentIcon sx={{ fontSize: 40, color: 'info.main', mb: 1 }} />
              <Typography variant="h4">8</Typography>
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
                <TableCell>Company</TableCell>
                <TableCell>Category</TableCell>
                <TableCell>Size</TableCell>
                <TableCell>Uploaded By</TableCell>
                <TableCell>Upload Date</TableCell>
                <TableCell>Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {documents.map((document) => (
                <TableRow key={document.id}>
                  <TableCell>
                    <Box sx={{ display: 'flex', alignItems: 'center' }}>
                      {getFileIcon(document.type)}
                      <Typography variant="subtitle2" sx={{ ml: 1 }}>
                        {document.name}
                      </Typography>
                    </Box>
                  </TableCell>
                  <TableCell>{document.type}</TableCell>
                  <TableCell>{document.company}</TableCell>
                  <TableCell>
                    <Chip
                      label={document.category}
                      color={getCategoryColor(document.category) as any}
                      size="small"
                    />
                  </TableCell>
                  <TableCell>{document.size}</TableCell>
                  <TableCell>{document.uploadedBy}</TableCell>
                  <TableCell>{document.uploadDate}</TableCell>
                  <TableCell>
                    <IconButton color="primary" onClick={() => handleDownload(document.id, document.name)}>
                      <DownloadIcon />
                    </IconButton>
                    <IconButton color="error" onClick={() => handleDelete(document.id, document.name)}>
                      <DeleteIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
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
              />
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Company</InputLabel>
                <Select
                  value={newDocument.company}
                  label="Company"
                  onChange={(e) => setNewDocument({ ...newDocument, company: e.target.value })}
                >
                  <MenuItem value="Acme Corporation">Acme Corporation</MenuItem>
                  <MenuItem value="Tech Solutions">Tech Solutions</MenuItem>
                  <MenuItem value="Manufacturing Co">Manufacturing Co</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={newDocument.category}
                  label="Category"
                  onChange={(e) => setNewDocument({ ...newDocument, category: e.target.value })}
                >
                  <MenuItem value="Bank Documents">Bank Documents</MenuItem>
                  <MenuItem value="Financial Statements">Financial Statements</MenuItem>
                  <MenuItem value="Inventory">Inventory</MenuItem>
                  <MenuItem value="Legal Documents">Legal Documents</MenuItem>
                  <MenuItem value="Tax Documents">Tax Documents</MenuItem>
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
                fullWidth
                component="label"
                startIcon={<UploadIcon />}
                sx={{ height: 60 }}
              >
                Choose File to Upload
                <input type="file" hidden />
              </Button>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={() => setOpen(false)} variant="contained">Upload Document</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Documents