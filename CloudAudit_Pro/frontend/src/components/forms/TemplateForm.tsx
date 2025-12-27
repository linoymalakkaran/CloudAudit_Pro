import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  TextField,
  FormControlLabel,
  Switch,
  Alert,
  CircularProgress,
} from '@mui/material';
import apiClient from '../../services/api';

interface TemplateFormProps {
  template?: any;
  onSuccess: () => void;
  onCancel: () => void;
}

const TemplateForm: React.FC<TemplateFormProps> = ({ template, onSuccess, onCancel }) => {
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    category: '',
    procedureText: '',
    isMandatory: false,
    estimatedHours: '',
    requiredSkills: '',
    isActive: true,
  });

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (template) {
      setFormData({
        name: template.name || '',
        description: template.description || '',
        category: template.category || '',
        procedureText: template.procedureText || '',
        isMandatory: template.isMandatory || false,
        estimatedHours: template.estimatedHours?.toString() || '',
        requiredSkills: template.requiredSkills ? JSON.stringify(template.requiredSkills, null, 2) : '',
        isActive: template.isActive !== false,
      });
    }
  }, [template]);

  const handleChange = (field: string, value: any) => {
    setFormData({ ...formData, [field]: value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const payload: any = {
        name: formData.name,
        description: formData.description || null,
        category: formData.category || null,
        procedureText: formData.procedureText,
        isMandatory: formData.isMandatory,
        estimatedHours: formData.estimatedHours ? parseFloat(formData.estimatedHours) : null,
        requiredSkills: formData.requiredSkills ? JSON.parse(formData.requiredSkills) : null,
        isActive: formData.isActive,
      };

      if (template) {
        await apiClient.put(`/procedure-templates/${template.id}`, payload);
      } else {
        await apiClient.post('/procedure-templates', payload);
      }

      onSuccess();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save template');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit} mt={2}>
      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <TextField
        fullWidth
        required
        label="Template Name"
        value={formData.name}
        onChange={(e) => handleChange('name', e.target.value)}
        margin="normal"
      />

      <TextField
        fullWidth
        label="Description"
        value={formData.description}
        onChange={(e) => handleChange('description', e.target.value)}
        margin="normal"
        multiline
        rows={2}
      />

      <TextField
        fullWidth
        label="Category"
        value={formData.category}
        onChange={(e) => handleChange('category', e.target.value)}
        margin="normal"
        helperText="e.g., Substantive Testing, Compliance, Internal Controls"
      />

      <TextField
        fullWidth
        required
        label="Procedure Text"
        value={formData.procedureText}
        onChange={(e) => handleChange('procedureText', e.target.value)}
        margin="normal"
        multiline
        rows={6}
        helperText="The detailed procedure steps"
      />

      <TextField
        fullWidth
        label="Estimated Hours"
        type="number"
        value={formData.estimatedHours}
        onChange={(e) => handleChange('estimatedHours', e.target.value)}
        margin="normal"
        inputProps={{ min: 0, step: 0.5 }}
      />

      <TextField
        fullWidth
        label="Required Skills (JSON)"
        value={formData.requiredSkills}
        onChange={(e) => handleChange('requiredSkills', e.target.value)}
        margin="normal"
        multiline
        rows={3}
        helperText='Optional JSON object, e.g., {"skills": ["Accounting", "Auditing"]}'
      />

      <FormControlLabel
        control={
          <Switch
            checked={formData.isMandatory}
            onChange={(e) => handleChange('isMandatory', e.target.checked)}
          />
        }
        label="Mandatory Procedure"
      />

      <FormControlLabel
        control={
          <Switch checked={formData.isActive} onChange={(e) => handleChange('isActive', e.target.checked)} />
        }
        label="Active"
      />

      <Box mt={3} display="flex" gap={2}>
        <Button type="submit" variant="contained" color="primary" disabled={loading}>
          {loading ? <CircularProgress size={24} /> : template ? 'Update Template' : 'Create Template'}
        </Button>
        <Button variant="outlined" onClick={onCancel} disabled={loading}>
          Cancel
        </Button>
      </Box>
    </Box>
  );
};

export default TemplateForm;
