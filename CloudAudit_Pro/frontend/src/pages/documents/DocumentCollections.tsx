import React, { useState, useEffect } from 'react';
import {
  Box,
  Paper,
  Typography,
  Button,
  TextField,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Chip,
  LinearProgress,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  IconButton,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Card,
  CardContent,
  CardActions,
} from '@mui/material';
import {
  Add as AddIcon,
  Delete as DeleteIcon,
  CloudUpload as UploadIcon,
  CheckCircle as CompleteIcon,
  PlayArrow as StartIcon,
  Folder as FolderIcon,
} from '@mui/icons-material';
import { DataGrid, GridColDef } from '@mui/x-data-grid';
import {
  documentCollectionsService,
  DocumentCollection,
  CreateCollectionItemDto,
} from '../../services/documentCollections.service';

export default function DocumentCollections() {
  const [collections, setCollections] = useState<DocumentCollection[]>([]);
  const [selectedCollection, setSelectedCollection] = useState<DocumentCollection | null>(null);
  const [loading, setLoading] = useState(false);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [itemDialogOpen, setItemDialogOpen] = useState(false);
  const [detailsDialogOpen, setDetailsDialogOpen] = useState(false);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    companyId: '',
    periodId: '',
    collectionType: 'CLIENT_REQUEST',
    dueDate: '',
    assignedTo: '',
  });
  const [itemFormData, setItemFormData] = useState<CreateCollectionItemDto>({
    documentType: '',
    requiredDocument: '',
    notes: '',
  });

  useEffect(() => {
    loadCollections();
  }, []);

  const loadCollections = async () => {
    setLoading(true);
    try {
      const data = await documentCollectionsService.getAll();
      setCollections(data);
    } catch (error) {
      console.error('Error loading collections:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSaveCollection = async () => {
    try {
      if (selectedCollection) {
        await documentCollectionsService.update(selectedCollection.id, formData);
      } else {
        await documentCollectionsService.create(formData);
      }
      setDialogOpen(false);
      resetForm();
      loadCollections();
    } catch (error) {
      console.error('Error saving collection:', error);
    }
  };

  const handleDeleteCollection = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this collection?')) {
      try {
        await documentCollectionsService.delete(id);
        loadCollections();
      } catch (error) {
        console.error('Error deleting collection:', error);
      }
    }
  };

  const handleUpdateStatus = async (id: string, status: string) => {
    try {
      await documentCollectionsService.updateStatus(id, status);
      loadCollections();
      if (selectedCollection && selectedCollection.id === id) {
        const updated = await documentCollectionsService.getById(id);
        setSelectedCollection(updated);
      }
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };

  const handleAddItem = async () => {
    if (selectedCollection) {
      try {
        await documentCollectionsService.addItem(selectedCollection.id, itemFormData);
        setItemDialogOpen(false);
        setItemFormData({ documentType: '', requiredDocument: '', notes: '' });
        const updated = await documentCollectionsService.getById(selectedCollection.id);
        setSelectedCollection(updated);
      } catch (error) {
        console.error('Error adding item:', error);
      }
    }
  };

  const handleRemoveItem = async (itemId: string) => {
    try {
      await documentCollectionsService.removeItem(itemId);
      if (selectedCollection) {
        const updated = await documentCollectionsService.getById(selectedCollection.id);
        setSelectedCollection(updated);
      }
    } catch (error) {
      console.error('Error removing item:', error);
    }
  };

  const handleViewDetails = async (collection: DocumentCollection) => {
    try {
      const details = await documentCollectionsService.getById(collection.id);
      setSelectedCollection(details);
      setDetailsDialogOpen(true);
    } catch (error) {
      console.error('Error loading collection details:', error);
    }
  };

  const resetForm = () => {
    setSelectedCollection(null);
    setFormData({
      name: '',
      description: '',
      companyId: '',
      periodId: '',
      collectionType: 'CLIENT_REQUEST',
      dueDate: '',
      assignedTo: '',
    });
  };

  const getStatusColor = (status: string) => {
    const colors: Record<string, any> = {
      DRAFT: 'default',
      IN_PROGRESS: 'primary',
      SENT: 'info',
      COMPLETED: 'success',
      OVERDUE: 'error',
    };
    return colors[status] || 'default';
  };

  const getItemStatusColor = (status: string) => {
    const colors: Record<string, any> = {
      PENDING: 'default',
      UPLOADED: 'success',
      UNDER_REVIEW: 'warning',
      APPROVED: 'success',
      REJECTED: 'error',
    };
    return colors[status] || 'default';
  };

  const calculateProgress = (collection: DocumentCollection) => {
    if (!collection.items || collection.items.length === 0) return 0;
    const completed = collection.items.filter(
      (item) => item.status === 'UPLOADED' || item.status === 'APPROVED'
    ).length;
    return Math.round((completed / collection.items.length) * 100);
  };

  const columns: GridColDef[] = [
    { field: 'name', headerName: 'Collection Name', flex: 1 },
    { field: 'collectionType', headerName: 'Type', width: 150 },
    {
      field: 'status',
      headerName: 'Status',
      width: 130,
      renderCell: (params) => (
        <Chip label={params.value} size="small" color={getStatusColor(params.value)} />
      ),
    },
    {
      field: 'items',
      headerName: 'Items',
      width: 100,
      valueGetter: (params) => params.value?.length || 0,
    },
    {
      field: 'progress',
      headerName: 'Progress',
      width: 150,
      renderCell: (params) => {
        const progress = calculateProgress(params.row);
        return (
          <Box sx={{ display: 'flex', alignItems: 'center', width: '100%' }}>
            <LinearProgress
              variant="determinate"
              value={progress}
              sx={{ flexGrow: 1, mr: 1 }}
            />
            <Typography variant="body2">{progress}%</Typography>
          </Box>
        );
      },
    },
    {
      field: 'dueDate',
      headerName: 'Due Date',
      width: 120,
      valueFormatter: (params) =>
        params.value ? new Date(params.value).toLocaleDateString() : '-',
    },
    {
      field: 'actions',
      type: 'actions',
      headerName: 'Actions',
      width: 150,
      getActions: (params) => [
        <Button
          size="small"
          onClick={() => handleViewDetails(params.row)}
        >
          View
        </Button>,
        <IconButton
          size="small"
          color="error"
          onClick={() => handleDeleteCollection(params.row.id)}
        >
          <DeleteIcon />
        </IconButton>,
      ],
    },
  ];

  return (
    <Box sx={{ p: 3 }}>
      <Paper sx={{ p: 2 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
          <Typography variant="h4">Document Collections</Typography>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setDialogOpen(true)}
          >
            New Collection
          </Button>
        </Box>

        <DataGrid
          rows={collections}
          columns={columns}
          loading={loading}
          autoHeight
          pageSizeOptions={[10, 25, 50]}
          initialState={{
            pagination: { paginationModel: { pageSize: 25 } },
          }}
        />
      </Paper>

      {/* Collection Dialog */}
      <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>New Document Collection</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Collection Name"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Description"
                value={formData.description}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Collection Type</InputLabel>
                <Select
                  value={formData.collectionType}
                  label="Collection Type"
                  onChange={(e) => setFormData({ ...formData, collectionType: e.target.value })}
                >
                  <MenuItem value="CLIENT_REQUEST">Client Request</MenuItem>
                  <MenuItem value="INTERNAL_CHECKLIST">Internal Checklist</MenuItem>
                  <MenuItem value="REGULATORY_REQUIREMENT">Regulatory Requirement</MenuItem>
                  <MenuItem value="CUSTOM">Custom</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Due Date"
                type="date"
                value={formData.dueDate}
                onChange={(e) => setFormData({ ...formData, dueDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Company ID"
                value={formData.companyId}
                onChange={(e) => setFormData({ ...formData, companyId: e.target.value })}
                required
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleSaveCollection} variant="contained">
            Create Collection
          </Button>
        </DialogActions>
      </Dialog>

      {/* Collection Details Dialog */}
      <Dialog
        open={detailsDialogOpen}
        onClose={() => setDetailsDialogOpen(false)}
        maxWidth="md"
        fullWidth
      >
        {selectedCollection && (
          <>
            <DialogTitle>
              <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <Box>
                  <Typography variant="h6">{selectedCollection.name}</Typography>
                  <Chip
                    label={selectedCollection.status}
                    size="small"
                    color={getStatusColor(selectedCollection.status)}
                    sx={{ mt: 1 }}
                  />
                </Box>
                <Box>
                  <Typography variant="body2" color="text.secondary">
                    {calculateProgress(selectedCollection)}% Complete
                  </Typography>
                  <LinearProgress
                    variant="determinate"
                    value={calculateProgress(selectedCollection)}
                    sx={{ width: 200, mt: 1 }}
                  />
                </Box>
              </Box>
            </DialogTitle>
            <DialogContent>
              <Box sx={{ mb: 3 }}>
                <Typography variant="subtitle2" color="text.secondary">
                  Description
                </Typography>
                <Typography>{selectedCollection.description || 'No description'}</Typography>
              </Box>

              <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
                <Typography variant="h6">Required Documents</Typography>
                <Button
                  size="small"
                  startIcon={<AddIcon />}
                  onClick={() => setItemDialogOpen(true)}
                >
                  Add Item
                </Button>
              </Box>

              <List>
                {selectedCollection.items?.map((item) => (
                  <ListItem key={item.id} divider>
                    <ListItemText
                      primary={item.requiredDocument}
                      secondary={
                        <>
                          <Typography variant="body2" component="span">
                            Type: {item.documentType}
                          </Typography>
                          <br />
                          <Chip
                            label={item.status}
                            size="small"
                            color={getItemStatusColor(item.status)}
                            sx={{ mt: 0.5 }}
                          />
                        </>
                      }
                    />
                    <ListItemSecondaryAction>
                      <IconButton
                        edge="end"
                        onClick={() => handleRemoveItem(item.id)}
                      >
                        <DeleteIcon />
                      </IconButton>
                    </ListItemSecondaryAction>
                  </ListItem>
                ))}
              </List>
            </DialogContent>
            <DialogActions>
              {selectedCollection.status === 'DRAFT' && (
                <Button
                  startIcon={<StartIcon />}
                  onClick={() => handleUpdateStatus(selectedCollection.id, 'IN_PROGRESS')}
                >
                  Start Collection
                </Button>
              )}
              {selectedCollection.status === 'IN_PROGRESS' && (
                <Button
                  startIcon={<CompleteIcon />}
                  onClick={() => handleUpdateStatus(selectedCollection.id, 'COMPLETED')}
                  color="success"
                >
                  Mark Complete
                </Button>
              )}
              <Button onClick={() => setDetailsDialogOpen(false)}>Close</Button>
            </DialogActions>
          </>
        )}
      </Dialog>

      {/* Add Item Dialog */}
      <Dialog open={itemDialogOpen} onClose={() => setItemDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Add Required Document</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Document Type"
                value={itemFormData.documentType}
                onChange={(e) =>
                  setItemFormData({ ...itemFormData, documentType: e.target.value })
                }
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Required Document"
                value={itemFormData.requiredDocument}
                onChange={(e) =>
                  setItemFormData({ ...itemFormData, requiredDocument: e.target.value })
                }
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Notes"
                value={itemFormData.notes}
                onChange={(e) =>
                  setItemFormData({ ...itemFormData, notes: e.target.value })
                }
                multiline
                rows={2}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setItemDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleAddItem} variant="contained">
            Add Item
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
}
