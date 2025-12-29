import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Typography,
  Grid,
  TextField,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Switch,
  FormControlLabel,
  Divider,
  Alert,
  CircularProgress,
  Accordion,
  AccordionSummary,
  AccordionDetails,
} from '@mui/material';
import {
  ExpandMore as ExpandMoreIcon,
  Save as SaveIcon,
  Refresh as ResetIcon,
  Upload as UploadIcon,
  Download as DownloadIcon,
} from '@mui/icons-material';
import userPreferencesService, { UserPreference } from '../../services/userPreferencesService';

interface PreferenceCategory {
  name: string;
  label: string;
  preferences: UserPreference[];
}

const UserPreferences: React.FC = () => {
  const [preferences, setPreferences] = useState<UserPreference[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string>('');
  const [success, setSuccess] = useState<string>('');
  const [formData, setFormData] = useState<Record<string, any>>({});
  const [expandedPanel, setExpandedPanel] = useState<string>('');

  const categories: string[] = [
    'THEME',
    'LANGUAGE',
    'TIMEZONE',
    'DATE_FORMAT',
    'NOTIFICATIONS',
    'DISPLAY',
    'ACCESSIBILITY',
  ];

  useEffect(() => {
    loadPreferences();
  }, []);

  const loadPreferences = async () => {
    try {
      setLoading(true);
      const data = await userPreferencesService.getAll();
      setPreferences(data);
      
      // Initialize form data from preferences
      const formValues: Record<string, any> = {};
      data.forEach((pref) => {
        formValues[pref.preferenceKey] = parsePreferenceValue(pref);
      });
      setFormData(formValues);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load preferences');
    } finally {
      setLoading(false);
    }
  };

  const parsePreferenceValue = (pref: UserPreference): any => {
    switch (pref.dataType) {
      case 'BOOLEAN':
        return pref.preferenceValue === 'true';
      case 'NUMBER':
        return parseFloat(pref.preferenceValue);
      case 'JSON':
        return JSON.parse(pref.preferenceValue);
      default:
        return pref.preferenceValue;
    }
  };

  const handleChange = (key: string, value: any) => {
    setFormData({ ...formData, [key]: value });
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      setError('');
      
      const updates = preferences.map((pref) => ({
        preferenceKey: pref.preferenceKey,
        preferenceValue: String(formData[pref.preferenceKey] || ''),
        category: pref.category,
        dataType: pref.dataType,
      }));

      await userPreferencesService.bulkUpdate(updates);
      setSuccess('Preferences saved successfully');
      await loadPreferences();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to save preferences');
    } finally {
      setLoading(false);
    }
  };

  const handleReset = async () => {
    if (window.confirm('Reset all preferences to default values?')) {
      try {
        setLoading(true);
        await userPreferencesService.resetToDefaults();
        setSuccess('Preferences reset to defaults');
        await loadPreferences();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to reset preferences');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleExport = async () => {
    try {
      const blob = await userPreferencesService.exportPreferences();
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `preferences_${new Date().toISOString().split('T')[0]}.json`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
      setSuccess('Preferences exported successfully');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to export preferences');
    }
  };

  const handleImport = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;

    try {
      setLoading(true);
      await userPreferencesService.importPreferences(file);
      setSuccess('Preferences imported successfully');
      await loadPreferences();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to import preferences');
    } finally {
      setLoading(false);
      event.target.value = '';
    }
  };

  const groupedPreferences: PreferenceCategory[] = categories.map((cat) => ({
    name: cat,
    label: cat.replace('_', ' '),
    preferences: preferences.filter((p) => p.category === cat),
  }));

  const renderPreferenceField = (pref: UserPreference) => {
    const value = formData[pref.preferenceKey] ?? '';

    switch (pref.dataType) {
      case 'BOOLEAN':
        return (
          <FormControlLabel
            control={
              <Switch
                checked={value === true}
                onChange={(e) => handleChange(pref.preferenceKey, e.target.checked)}
              />
            }
            label={pref.preferenceKey.replace(/\./g, ' ').replace(/_/g, ' ')}
          />
        );

      case 'NUMBER':
        return (
          <TextField
            fullWidth
            type="number"
            label={pref.preferenceKey}
            value={value}
            onChange={(e) => handleChange(pref.preferenceKey, parseFloat(e.target.value))}
            size="small"
          />
        );

      case 'SELECT':
        const options = pref.preferenceValue.split(',');
        return (
          <FormControl fullWidth size="small">
            <InputLabel>{pref.preferenceKey}</InputLabel>
            <Select
              value={value}
              label={pref.preferenceKey}
              onChange={(e) => handleChange(pref.preferenceKey, e.target.value)}
            >
              {options.map((opt) => (
                <MenuItem key={opt} value={opt}>
                  {opt}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        );

      default:
        return (
          <TextField
            fullWidth
            label={pref.preferenceKey}
            value={value}
            onChange={(e) => handleChange(pref.preferenceKey, e.target.value)}
            size="small"
          />
        );
    }
  };

  if (loading && preferences.length === 0) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">User Preferences</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button variant="outlined" startIcon={<ResetIcon />} onClick={handleReset}>
            Reset to Defaults
          </Button>
          <Button variant="outlined" startIcon={<DownloadIcon />} onClick={handleExport}>
            Export
          </Button>
          <Button variant="outlined" component="label" startIcon={<UploadIcon />}>
            Import
            <input type="file" accept=".json" hidden onChange={handleImport} />
          </Button>
          <Button variant="contained" startIcon={<SaveIcon />} onClick={handleSave} disabled={loading}>
            Save Preferences
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {success && (
        <Alert severity="success" onClose={() => setSuccess('')} sx={{ mb: 2 }}>
          {success}
        </Alert>
      )}

      <Box>
        {groupedPreferences.map((category) => (
          <Accordion
            key={category.name}
            expanded={expandedPanel === category.name}
            onChange={(_, isExpanded) => setExpandedPanel(isExpanded ? category.name : '')}
            sx={{ mb: 1 }}
          >
            <AccordionSummary expandIcon={<ExpandMoreIcon />}>
              <Typography variant="h6">{category.label}</Typography>
              <Typography variant="caption" sx={{ ml: 2, mt: 0.5 }} color="text.secondary">
                {category.preferences.length} settings
              </Typography>
            </AccordionSummary>
            <AccordionDetails>
              <Grid container spacing={3}>
                {category.preferences.map((pref) => (
                  <Grid item xs={12} sm={6} key={pref.id}>
                    {renderPreferenceField(pref)}
                  </Grid>
                ))}
              </Grid>
            </AccordionDetails>
          </Accordion>
        ))}
      </Box>
    </Box>
  );
};

export default UserPreferences;
