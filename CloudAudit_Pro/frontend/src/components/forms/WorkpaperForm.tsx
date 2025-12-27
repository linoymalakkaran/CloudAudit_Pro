import React, { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  CircularProgress,
  Alert,
  Typography,
  Box,
  Chip,
} from '@mui/material';
import DescriptionIcon from '@mui/icons-material/Description';
import apiClient from '../../services/api';

interface WorkpaperFormProps {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
  procedureId: string;
  workpaperId?: string;
  initialData?: any;
}

export const WorkpaperForm: React.FC<WorkpaperFormProps> = ({
  open,
  onClose,
  onSuccess,
  procedureId,
  workpaperId,
  initialData,
}) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [formData, setFormData] = useState({
    title: initialData?.title || '',
    description: initialData?.description || '',
    content: initialData?.content || '',
    preparedBy: initialData?.preparedBy || '',
  });

  React.useEffect(() => {
    if (initialData) {
      setFormData({
        title: initialData.title || '',
        description: initialData.description || '',
        content: initialData.content || '',
        preparedBy: initialData.preparedBy || '',
      });
    }
  }, [initialData]);

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = async () => {
    if (!formData.title.trim()) {
      setError('Title is required');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const payload = {
        ...formData,
        procedureId,
      };

      if (workpaperId) {
        await apiClient.put(`/workpapers/${workpaperId}`, payload);
      } else {
        await apiClient.post('/workpapers', payload);
      }

      onSuccess();
      handleClose();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save workpaper');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setFormData({
      title: '',
      description: '',
      content: '',
      preparedBy: '',
    });
    setError(null);
    onClose();
  };

  return (
    <Dialog open={open} onClose={handleClose} maxWidth="md" fullWidth>
      <DialogTitle>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          <DescriptionIcon />
          {workpaperId ? 'Edit Workpaper' : 'Create New Workpaper'}
        </Box>
      </DialogTitle>
      <DialogContent>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        {workpaperId && initialData && (
          <Box sx={{ mb: 2, display: 'flex', gap: 1, alignItems: 'center' }}>
            <Chip label={`Version ${initialData.version}`} size="small" color="primary" />
            <Typography variant="caption" color="text.secondary">
              A new version will be created when you save changes
            </Typography>
          </Box>
        )}

        <TextField
          fullWidth
          label="Title"
          value={formData.title}
          onChange={(e) => handleChange('title', e.target.value)}
          required
          sx={{ mt: 2 }}
          placeholder="e.g., Cash Reconciliation Workpaper"
        />

        <TextField
          fullWidth
          label="Description"
          value={formData.description}
          onChange={(e) => handleChange('description', e.target.value)}
          multiline
          rows={2}
          sx={{ mt: 2 }}
          placeholder="Brief description of the workpaper purpose and scope"
        />

        <TextField
          fullWidth
          label="Content"
          value={formData.content}
          onChange={(e) => handleChange('content', e.target.value)}
          multiline
          rows={10}
          sx={{ mt: 2 }}
          placeholder="Enter the detailed workpaper content...

You can include:
- Procedures performed
- Samples selected
- Test results
- Observations
- Calculations
- References to supporting documents"
          helperText="Provide detailed documentation of work performed"
        />

        <TextField
          fullWidth
          label="Prepared By"
          value={formData.preparedBy}
          onChange={(e) => handleChange('preparedBy', e.target.value)}
          sx={{ mt: 2 }}
          placeholder="Name of the person who prepared this workpaper"
        />

        <Box sx={{ mt: 2, p: 2, bgcolor: 'info.lighter', borderRadius: 1 }}>
          <Typography variant="caption" color="info.dark">
            <strong>Tip:</strong> Include all relevant details, calculations, and references. 
            Attach supporting documents separately using the attachment feature.
          </Typography>
        </Box>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleClose} disabled={loading}>
          Cancel
        </Button>
        <Button
          onClick={handleSubmit}
          variant="contained"
          disabled={loading || !formData.title.trim()}
          startIcon={loading ? <CircularProgress size={20} /> : <DescriptionIcon />}
        >
          {workpaperId ? 'Update' : 'Create'} Workpaper
        </Button>
      </DialogActions>
    </Dialog>
  );
};
