import React, { useState, useEffect } from 'react'
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Grid,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  CircularProgress,
  Alert,
  LinearProgress,
  Divider,
} from '@mui/material'
import {
  CloudUpload as UploadIcon,
  Description as DocumentIcon,
  Delete as DeleteIcon,
  Download as DownloadIcon,
  CheckCircle as CheckIcon,
  Schedule as PendingIcon,
  Error as ErrorIcon,
  Visibility as ViewIcon,
} from '@mui/icons-material'
import { documentService } from '../../services/document.service'
import { useAuth } from '../../contexts/AuthContext'

interface DocumentRequest {
  id: string;
  title: string;
  description: string;
  dueDate: string;
  status: 'PENDING' | 'SUBMITTED' | 'APPROVED' | 'REJECTED';
  priority: 'HIGH' | 'MEDIUM' | 'LOW';
  uploadedFiles?: Array<{
    id: string;
    name: string;
    size: number;
    uploadedAt: string;
    version: number;
  }>;
}

const ClientDocuments: React.FC = () => {
  const { user } = useAuth()
  const [loading, setLoading] = useState(true)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [documentRequests, setDocumentRequests] = useState<DocumentRequest[]>([])
  const [uploadDialogOpen, setUploadDialogOpen] = useState(false)
  const [selectedRequest, setSelectedRequest] = useState<DocumentRequest | null>(null)
  const [uploadProgress, setUploadProgress] = useState(0)
  const [selectedFiles, setSelectedFiles] = useState<File[]>([])
  const [notes, setNotes] = useState('')

  useEffect(() => {
    loadDocumentRequests()
  }, [user])

  const loadDocumentRequests = async () => {
    if (!user?.companyId) return

    try {
      setLoading(true)
      // Fetch document requests for the client
      const response = await documentService.getDocuments({
        companyId: user.companyId,
        type: 'REQUEST',
      })
      setDocumentRequests(response as any)
    } catch (err) {
      console.error('Failed to load document requests:', err)
      setError('Failed to load document requests')
    } finally {
      setLoading(false)
    }
  }

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files
    if (files) {
      setSelectedFiles(Array.from(files))
    }
  }

  const handleUpload = async () => {
    if (selectedFiles.length === 0 || !selectedRequest || !user?.companyId) return

    try {
      setUploading(true)
      setUploadProgress(0)

      for (let i = 0; i < selectedFiles.length; i++) {
        const file = selectedFiles[i]
        const formData = new FormData()
        formData.append('file', file)
        formData.append('companyId', user.companyId)
        formData.append('requestId', selectedRequest.id)
        formData.append('type', 'CLIENT_SUBMISSION')
        if (notes) {
          formData.append('notes', notes)
        }

        await documentService.uploadDocument(formData)
        setUploadProgress(((i + 1) / selectedFiles.length) * 100)
      }

      setUploadDialogOpen(false)
      setSelectedFiles([])
      setNotes('')
      setSelectedRequest(null)
      loadDocumentRequests()
      
      alert('Documents uploaded successfully!')
    } catch (err) {
      console.error('Failed to upload documents:', err)
      setError('Failed to upload documents. Please try again.')
    } finally {
      setUploading(false)
      setUploadProgress(0)
    }
  }

  const handleDownload = async (documentId: string, fileName: string) => {
    try {
      const blob = await documentService.downloadDocument(documentId)
      const url = window.URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = fileName
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      window.URL.revokeObjectURL(url)
    } catch (err) {
      console.error('Failed to download document:', err)
      setError('Failed to download document')
    }
  }

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'PENDING':
        return <PendingIcon color="warning" />
      case 'SUBMITTED':
        return <CheckIcon color="info" />
      case 'APPROVED':
        return <CheckIcon color="success" />
      case 'REJECTED':
        return <ErrorIcon color="error" />
      default:
        return <DocumentIcon />
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING':
        return 'warning'
      case 'SUBMITTED':
        return 'info'
      case 'APPROVED':
        return 'success'
      case 'REJECTED':
        return 'error'
      default:
        return 'default'
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'HIGH':
        return 'error'
      case 'MEDIUM':
        return 'warning'
      case 'LOW':
        return 'success'
      default:
        return 'default'
    }
  }

  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes'
    const k = 1024
    const sizes = ['Bytes', 'KB', 'MB', 'GB']
    const i = Math.floor(Math.log(bytes) / Math.log(k))
    return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i]
  }

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
        <CircularProgress />
      </Box>
    )
  }

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Document Requests</Typography>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 3 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      {documentRequests.length === 0 ? (
        <Card>
          <CardContent sx={{ textAlign: 'center', py: 6 }}>
            <DocumentIcon sx={{ fontSize: 60, color: 'text.secondary', mb: 2 }} />
            <Typography variant="h6" color="text.secondary">
              No document requests at this time
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Your auditor will notify you when documents are needed
            </Typography>
          </CardContent>
        </Card>
      ) : (
        <Grid container spacing={3}>
          {documentRequests.map((request) => (
            <Grid item xs={12} key={request.id}>
              <Card>
                <CardContent>
                  <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 2 }}>
                    <Box sx={{ flex: 1 }}>
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                        {getStatusIcon(request.status)}
                        <Typography variant="h6">{request.title}</Typography>
                        <Chip
                          label={request.status}
                          color={getStatusColor(request.status) as any}
                          size="small"
                        />
                        <Chip
                          label={`${request.priority} Priority`}
                          color={getPriorityColor(request.priority) as any}
                          size="small"
                        />
                      </Box>
                      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                        {request.description}
                      </Typography>
                      <Typography variant="caption" color="text.secondary">
                        Due Date: {new Date(request.dueDate).toLocaleDateString()}
                      </Typography>
                    </Box>
                    {request.status === 'PENDING' && (
                      <Button
                        variant="contained"
                        startIcon={<UploadIcon />}
                        onClick={() => {
                          setSelectedRequest(request)
                          setUploadDialogOpen(true)
                        }}
                      >
                        Upload
                      </Button>
                    )}
                  </Box>

                  {request.uploadedFiles && request.uploadedFiles.length > 0 && (
                    <>
                      <Divider sx={{ my: 2 }} />
                      <Typography variant="subtitle2" gutterBottom>
                        Uploaded Files ({request.uploadedFiles.length})
                      </Typography>
                      <List dense>
                        {request.uploadedFiles.map((file) => (
                          <ListItem
                            key={file.id}
                            secondaryAction={
                              <Box>
                                <IconButton
                                  edge="end"
                                  onClick={() => handleDownload(file.id, file.name)}
                                >
                                  <DownloadIcon />
                                </IconButton>
                              </Box>
                            }
                          >
                            <ListItemIcon>
                              <DocumentIcon />
                            </ListItemIcon>
                            <ListItemText
                              primary={file.name}
                              secondary={`${formatFileSize(file.size)} • Version ${file.version} • ${new Date(file.uploadedAt).toLocaleDateString()}`}
                            />
                          </ListItem>
                        ))}
                      </List>
                    </>
                  )}
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      {/* Upload Dialog */}
      <Dialog open={uploadDialogOpen} onClose={() => !uploading && setUploadDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Upload Documents</DialogTitle>
        <DialogContent>
          {selectedRequest && (
            <Box sx={{ mb: 3 }}>
              <Typography variant="subtitle2" gutterBottom>
                Request: {selectedRequest.title}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                {selectedRequest.description}
              </Typography>
            </Box>
          )}

          <Button
            variant="outlined"
            component="label"
            fullWidth
            startIcon={<UploadIcon />}
            sx={{ mb: 2 }}
            disabled={uploading}
          >
            Select Files
            <input
              type="file"
              hidden
              multiple
              onChange={handleFileSelect}
            />
          </Button>

          {selectedFiles.length > 0 && (
            <Box sx={{ mb: 2 }}>
              <Typography variant="subtitle2" gutterBottom>
                Selected Files ({selectedFiles.length}):
              </Typography>
              <List dense>
                {selectedFiles.map((file, index) => (
                  <ListItem key={index}>
                    <ListItemIcon>
                      <DocumentIcon />
                    </ListItemIcon>
                    <ListItemText
                      primary={file.name}
                      secondary={formatFileSize(file.size)}
                    />
                  </ListItem>
                ))}
              </List>
            </Box>
          )}

          <TextField
            fullWidth
            multiline
            rows={3}
            label="Notes (Optional)"
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            disabled={uploading}
          />

          {uploading && (
            <Box sx={{ mt: 2 }}>
              <LinearProgress variant="determinate" value={uploadProgress} />
              <Typography variant="caption" color="text.secondary" align="center" display="block" sx={{ mt: 1 }}>
                Uploading... {Math.round(uploadProgress)}%
              </Typography>
            </Box>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setUploadDialogOpen(false)} disabled={uploading}>
            Cancel
          </Button>
          <Button
            onClick={handleUpload}
            variant="contained"
            disabled={selectedFiles.length === 0 || uploading}
          >
            {uploading ? 'Uploading...' : 'Upload'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default ClientDocuments
