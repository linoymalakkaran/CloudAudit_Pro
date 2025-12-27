import React, { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  CircularProgress,
  Alert,
  Typography,
  Box,
  Chip,
} from '@mui/material';
import WarningIcon from '@mui/icons-material/Warning';
import apiClient from '../../services/api';

interface FindingFormProps {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
  procedureId: string;
  findingId?: string;
  initialData?: any;
}

const severities = [
  { value: 'MINOR', label: 'Minor', color: 'info', description: 'Low impact, minor improvement needed' },
  { value: 'MODERATE', label: 'Moderate', color: 'warning', description: 'Moderate impact, should be addressed' },
  { value: 'SIGNIFICANT', label: 'Significant', color: 'warning', description: 'Notable impact, requires attention' },
  { value: 'MATERIAL', label: 'Material', color: 'error', description: 'Material impact, must be addressed' },
  { value: 'CRITICAL', label: 'Critical', color: 'error', description: 'Critical issue, immediate action required' },
];

export const FindingForm: React.FC<FindingFormProps> = ({
  open,
  onClose,
  onSuccess,
  procedureId,
  findingId,
  initialData,
}) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [formData, setFormData] = useState({
    title: initialData?.title || '',
    description: initialData?.description || '',
    severity: initialData?.severity || 'MODERATE',
    riskDescription: initialData?.riskDescription || '',
    impact: initialData?.impact || '',
    likelihood: initialData?.likelihood || '',
    recommendation: initialData?.recommendation || '',
    identifiedBy: initialData?.identifiedBy || '',
  });

  React.useEffect(() => {
    if (initialData) {
      setFormData({
        title: initialData.title || '',
        description: initialData.description || '',
        severity: initialData.severity || 'MODERATE',
        riskDescription: initialData.riskDescription || '',
        impact: initialData.impact || '',
        likelihood: initialData.likelihood || '',
        recommendation: initialData.recommendation || '',
        identifiedBy: initialData.identifiedBy || '',
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

    if (!formData.description.trim()) {
      setError('Description is required');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const payload = {
        ...formData,
        procedureId,
      };

      if (findingId) {
        await apiClient.put(`/findings/${findingId}`, payload);
      } else {
        await apiClient.post('/findings', payload);
      }

      onSuccess();
      handleClose();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save finding');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setFormData({
      title: '',
      description: '',
      severity: 'MODERATE',
      riskDescription: '',
      impact: '',
      likelihood: '',
      recommendation: '',
      identifiedBy: '',
    });
    setError(null);
    onClose();
  };

  const selectedSeverity = severities.find(s => s.value === formData.severity);

  return (
    <Dialog open={open} onClose={handleClose} maxWidth="md" fullWidth>
      <DialogTitle>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          <WarningIcon color="warning" />
          {findingId ? 'Edit Finding' : 'Create New Finding'}
        </Box>
      </DialogTitle>
      <DialogContent>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        <TextField
          fullWidth
          label="Finding Title"
          value={formData.title}
          onChange={(e) => handleChange('title', e.target.value)}
          required
          sx={{ mt: 2 }}
          placeholder="e.g., Inadequate Segregation of Duties in Cash Handling"
        />

        <TextField
          fullWidth
          label="Description"
          value={formData.description}
          onChange={(e) => handleChange('description', e.target.value)}
          multiline
          rows={4}
          required
          sx={{ mt: 2 }}
          placeholder="Provide a detailed description of what was found..."
          helperText="Describe the condition, criteria, cause, and effect"
        />

        <FormControl fullWidth required sx={{ mt: 2 }}>
          <InputLabel>Severity</InputLabel>
          <Select
            value={formData.severity}
            onChange={(e) => handleChange('severity', e.target.value)}
            label="Severity"
          >
            {severities.map((severity) => (
              <MenuItem key={severity.value} value={severity.value}>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, width: '100%' }}>
                  <Chip
                    label={severity.label}
                    color={severity.color as any}
                    size="small"
                  />
                  <Typography variant="caption" color="text.secondary">
                    {severity.description}
                  </Typography>
                </Box>
              </MenuItem>
            ))}
          </Select>
        </FormControl>

        {selectedSeverity && (
          <Alert severity={selectedSeverity.color as any} sx={{ mt: 1 }}>
            <Typography variant="caption">
              {selectedSeverity.description}
            </Typography>
          </Alert>
        )}

        <TextField
          fullWidth
          label="Risk Description"
          value={formData.riskDescription}
          onChange={(e) => handleChange('riskDescription', e.target.value)}
          multiline
          rows={2}
          sx={{ mt: 2 }}
          placeholder="Describe the risk associated with this finding..."
        />

        <TextField
          fullWidth
          label="Impact"
          value={formData.impact}
          onChange={(e) => handleChange('impact', e.target.value)}
          multiline
          rows={2}
          sx={{ mt: 2 }}
          placeholder="What is the potential impact if not addressed?"
          helperText="Financial, operational, compliance, or reputational impact"
        />

        <TextField
          fullWidth
          label="Likelihood"
          value={formData.likelihood}
          onChange={(e) => handleChange('likelihood', e.target.value)}
          sx={{ mt: 2 }}
          placeholder="e.g., High, Medium, Low"
          helperText="Assessment of how likely this risk is to occur"
        />

        <TextField
          fullWidth
          label="Recommendation"
          value={formData.recommendation}
          onChange={(e) => handleChange('recommendation', e.target.value)}
          multiline
          rows={3}
          sx={{ mt: 2 }}
          placeholder="What actions should be taken to address this finding?"
          helperText="Provide specific, actionable recommendations"
        />

        <TextField
          fullWidth
          label="Identified By"
          value={formData.identifiedBy}
          onChange={(e) => handleChange('identifiedBy', e.target.value)}
          sx={{ mt: 2 }}
          placeholder="Name of the auditor who identified this finding"
        />

        <Box sx={{ mt: 2, p: 2, bgcolor: 'warning.lighter', borderRadius: 1 }}>
          <Typography variant="caption" color="warning.dark">
            <strong>Note:</strong> All findings should be discussed with appropriate management 
            before finalization. Consider the context and obtain management's response.
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
          color="warning"
          disabled={loading || !formData.title.trim() || !formData.description.trim()}
          startIcon={loading ? <CircularProgress size={20} /> : <WarningIcon />}
        >
          {findingId ? 'Update' : 'Create'} Finding
        </Button>
      </DialogActions>
    </Dialog>
  );
};
