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
  CloudUpload as UploadIcon,
  Description as DocumentIcon,
  Download as DownloadIcon,
  Delete as DeleteIcon
} from '@mui/icons-material'

interface Document {
  id: string
  name: string
  type: string
  size: string
  uploadedBy: string
  uploadDate: string
  company: string
  category: string
}

function Documents() {
  const [open, setOpen] = useState(false)
  const [documents] = useState<Document[]>([
    {
      id: '1',
      name: 'Bank Statement - Oct 2024.pdf',
      type: 'PDF',
      size: '2.1 MB',
      uploadedBy: 'John Doe',
      uploadDate: '2024-11-20',
      company: 'Acme Corporation',
      category: 'Bank Documents'
    },
    {
      id: '2',
      name: 'Trial Balance - Q3 2024.xlsx',
      type: 'Excel',
      size: '856 KB',
      uploadedBy: 'Sarah Wilson',
      uploadDate: '2024-11-18',
      company: 'Tech Solutions',
      category: 'Financial Statements'
    },
    {
      id: '3',
      name: 'Inventory List - Nov 2024.csv',
      type: 'CSV',
      size: '124 KB',
      uploadedBy: 'Mike Johnson',
      uploadDate: '2024-11-15',
      company: 'Manufacturing Co',
      category: 'Inventory'
    }
  ])

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
                    <IconButton color="primary">
                      <DownloadIcon />
                    </IconButton>
                    <IconButton color="error">
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