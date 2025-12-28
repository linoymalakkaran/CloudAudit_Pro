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
  IconButton,
  Menu,
  MenuItem,
  Select,
  FormControl,
  InputLabel,
  Tabs,
  Tab,
} from '@mui/material';
import {
  DataGrid,
  GridColDef,
  GridActionsCellItem,
} from '@mui/x-data-grid';
import {
  Add as AddIcon,
  CloudUpload as UploadIcon,
  Download as DownloadIcon,
  Delete as DeleteIcon,
  Edit as EditIcon,
  MoreVert as MoreIcon,
  Lock as LockIcon,
  LockOpen as UnlockIcon,
  FileCopy as DuplicateIcon,
  Archive as ArchiveIcon,
  Search as SearchIcon,
  Link as LinkIcon,
  History as HistoryIcon,
} from '@mui/icons-material';
import { documentService, Document } from '../../services/document.service';
import { documentLinksService } from '../../services/documentLinks.service';

interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

function TabPanel(props: TabPanelProps) {
  const { children, value, index, ...other } = props;
  return (
    <div hidden={value !== index} {...other}>
      {value === index && <Box sx={{ p: 3 }}>{children}</Box>}
    </div>
  );
}

export default function DocumentManager() {
  const [documents, setDocuments] = useState<Document[]>([]);
  const [loading, setLoading] = useState(false);
  const [uploadDialogOpen, setUploadDialogOpen] = useState(false);
  const [selectedDocument, setSelectedDocument] = useState<Document | null>(null);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [tabValue, setTabValue] = useState(0);
  const [searchTerm, setSearchTerm] = useState('');
  const [filters, setFilters] = useState({
    companyId: '',
    type: '',
    status: '',
  });
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    type: 'OTHER',
    companyId: '',
    periodId: '',
    tags: [] as string[],
  });
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  useEffect(() => {
    loadDocuments();
  }, [filters]);

  const loadDocuments = async () => {
    setLoading(true);
    try {
      const data = await documentService.getAll(
        filters.companyId,
        undefined,
        filters.type,
        filters.status
      );
      setDocuments(data);
    } catch (error) {
      console.error('Error loading documents:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleUploadDocument = async () => {
    try {
      await documentService.create(formData, selectedFile || undefined);
      setUploadDialogOpen(false);
      resetForm();
      loadDocuments();
    } catch (error) {
      console.error('Error uploading document:', error);
    }
  };

  const handleDownload = async (doc: Document) => {
    try {
      await documentService.download(doc.id, doc.fileName || doc.name);
    } catch (error) {
      console.error('Error downloading document:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this document?')) {
      try {
        await documentService.delete(id);
        loadDocuments();
      } catch (error) {
        console.error('Error deleting document:', error);
      }
    }
  };

  const handleCheckout = async (id: string) => {
    try {
      await documentService.checkout(id);
      loadDocuments();
    } catch (error) {
      console.error('Error checking out document:', error);
    }
  };

  const handleCheckin = async (id: string) => {
    try {
      await documentService.checkin(id);
      loadDocuments();
    } catch (error) {
      console.error('Error checking in document:', error);
    }
  };

  const handleDuplicate = async (id: string) => {
    try {
      await documentService.duplicate(id);
      loadDocuments();
    } catch (error) {
      console.error('Error duplicating document:', error);
    }
  };

  const handleArchive = async (id: string) => {
    try {
      await documentService.archive(id);
      loadDocuments();
    } catch (error) {
      console.error('Error archiving document:', error);
    }
  };

  const handleSearch = async () => {
    if (searchTerm.trim()) {
      setLoading(true);
      try {
        const data = await documentService.search(searchTerm, filters);
        setDocuments(data);
      } catch (error) {
        console.error('Error searching documents:', error);
      } finally {
        setLoading(false);
      }
    } else {
      loadDocuments();
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      description: '',
      type: 'OTHER',
      companyId: '',
      periodId: '',
      tags: [],
    });
    setSelectedFile(null);
  };

  const columns: GridColDef[] = [
    { field: 'name', headerName: 'Name', flex: 1 },
    { field: 'type', headerName: 'Type', width: 150 },
    { field: 'status', headerName: 'Status', width: 120 },
    {
      field: 'tags',
      headerName: 'Tags',
      width: 200,
      renderCell: (params) =>
        params.value?.map((tag: string) => (
          <Chip key={tag} label={tag} size="small" sx={{ mr: 0.5 }} />
        )),
    },
    {
      field: 'isLocked',
      headerName: 'Locked',
      width: 100,
      renderCell: (params) =>
        params.value ? <LockIcon color="error" /> : <UnlockIcon color="success" />,
    },
    {
      field: 'createdAt',
      headerName: 'Created',
      width: 150,
      valueFormatter: (params) => new Date(params.value).toLocaleDateString(),
    },
    {
      field: 'actions',
      type: 'actions',
      headerName: 'Actions',
      width: 150,
      getActions: (params) => [
        <GridActionsCellItem
          icon={<DownloadIcon />}
          label="Download"
          onClick={() => handleDownload(params.row)}
        />,
        <GridActionsCellItem
          icon={<EditIcon />}
          label="Edit"
          onClick={() => setSelectedDocument(params.row)}
        />,
        <GridActionsCellItem
          icon={<DeleteIcon />}
          label="Delete"
          onClick={() => handleDelete(params.row.id)}
        />,
        <GridActionsCellItem
          icon={<MoreIcon />}
          label="More"
          onClick={(e) => {
            setSelectedDocument(params.row);
            setAnchorEl(e.currentTarget as HTMLElement);
          }}
        />,
      ],
    },
  ];

  return (
    <Box sx={{ p: 3 }}>
      <Paper sx={{ p: 2, mb: 2 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
          <Typography variant="h4">Document Manager</Typography>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setUploadDialogOpen(true)}
          >
            Upload Document
          </Button>
        </Box>

        <Tabs value={tabValue} onChange={(e, v) => setTabValue(v)} sx={{ mb: 2 }}>
          <Tab label="All Documents" />
          <Tab label="Recent" />
          <Tab label="Archived" />
        </Tabs>

        <Grid container spacing={2} sx={{ mb: 2 }}>
          <Grid item xs={12} md={6}>
            <TextField
              fullWidth
              placeholder="Search documents..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleSearch()}
              InputProps={{
                endAdornment: (
                  <IconButton onClick={handleSearch}>
                    <SearchIcon />
                  </IconButton>
                ),
              }}
            />
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth>
              <InputLabel>Type</InputLabel>
              <Select
                value={filters.type}
                label="Type"
                onChange={(e) => setFilters({ ...filters, type: e.target.value })}
              >
                <MenuItem value="">All</MenuItem>
                <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                <MenuItem value="INVOICE">Invoice</MenuItem>
                <MenuItem value="CONTRACT">Contract</MenuItem>
                <MenuItem value="OTHER">Other</MenuItem>
              </Select>
            </FormControl>
          </Grid>
          <Grid item xs={12} md={2}>
            <FormControl fullWidth>
              <InputLabel>Status</InputLabel>
              <Select
                value={filters.status}
                label="Status"
                onChange={(e) => setFilters({ ...filters, status: e.target.value })}
              >
                <MenuItem value="">All</MenuItem>
                <MenuItem value="DRAFT">Draft</MenuItem>
                <MenuItem value="UNDER_REVIEW">Under Review</MenuItem>
                <MenuItem value="APPROVED">Approved</MenuItem>
                <MenuItem value="ARCHIVED">Archived</MenuItem>
              </Select>
            </FormControl>
          </Grid>
        </Grid>

        <DataGrid
          rows={documents}
          columns={columns}
          loading={loading}
          autoHeight
          pageSizeOptions={[10, 25, 50]}
          initialState={{
            pagination: { paginationModel: { pageSize: 25 } },
          }}
        />
      </Paper>

      {/* Upload Dialog */}
      <Dialog open={uploadDialogOpen} onClose={() => setUploadDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>Upload Document</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Document Name"
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
                <InputLabel>Type</InputLabel>
                <Select
                  value={formData.type}
                  label="Type"
                  onChange={(e) => setFormData({ ...formData, type: e.target.value })}
                >
                  <MenuItem value="FINANCIAL_STATEMENT">Financial Statement</MenuItem>
                  <MenuItem value="TRIAL_BALANCE">Trial Balance</MenuItem>
                  <MenuItem value="INVOICE">Invoice</MenuItem>
                  <MenuItem value="CONTRACT">Contract</MenuItem>
                  <MenuItem value="OTHER">Other</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <Button variant="outlined" component="label" startIcon={<UploadIcon />} fullWidth>
                Select File
                <input
                  type="file"
                  hidden
                  onChange={(e) => setSelectedFile(e.target.files?.[0] || null)}
                />
              </Button>
              {selectedFile && (
                <Typography variant="body2" sx={{ mt: 1 }}>
                  Selected: {selectedFile.name}
                </Typography>
              )}
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setUploadDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleUploadDocument} variant="contained">
            Upload
          </Button>
        </DialogActions>
      </Dialog>

      {/* Actions Menu */}
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={() => setAnchorEl(null)}
      >
        {selectedDocument && (
          <>
            <MenuItem onClick={() => handleCheckout(selectedDocument.id)}>
              <LockIcon sx={{ mr: 1 }} /> Checkout
            </MenuItem>
            <MenuItem onClick={() => handleCheckin(selectedDocument.id)}>
              <UnlockIcon sx={{ mr: 1 }} /> Checkin
            </MenuItem>
            <MenuItem onClick={() => handleDuplicate(selectedDocument.id)}>
              <DuplicateIcon sx={{ mr: 1 }} /> Duplicate
            </MenuItem>
            <MenuItem onClick={() => handleArchive(selectedDocument.id)}>
              <ArchiveIcon sx={{ mr: 1 }} /> Archive
            </MenuItem>
            <MenuItem>
              <HistoryIcon sx={{ mr: 1 }} /> View Versions
            </MenuItem>
            <MenuItem>
              <LinkIcon sx={{ mr: 1 }} /> Manage Links
            </MenuItem>
          </>
        )}
      </Menu>
    </Box>
  );
}
