import React, { useState } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  FormControl,
  Grid,
  InputLabel,
  MenuItem,
  Select,
  Step,
  StepLabel,
  Stepper,
  TextField,
  Typography,
  Alert,
} from '@mui/material';
import { useNavigate } from 'react-router-dom';
import reportsService from '../../services/reports.service';
import { ReportType, ReportCategory, ExportFormat } from '../../types/report.types';

const ReportGenerator: React.FC = () => {
  const navigate = useNavigate();
  const [activeStep, setActiveStep] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const [formData, setFormData] = useState({
    name: '',
    description: '',
    reportType: ReportType.TRIAL_BALANCE,
    category: ReportCategory.FINANCIAL,
    companyId: '',
    periodId: '',
    format: ExportFormat.PDF,
    parameters: {},
    filters: {},
  });

  const steps = ['Select Report Type', 'Configure Parameters', 'Review & Generate'];

  const handleNext = () => {
    setActiveStep((prev) => prev + 1);
  };

  const handleBack = () => {
    setActiveStep((prev) => prev - 1);
  };

  const handleGenerate = async () => {
    setLoading(true);
    setError('');

    try {
      await reportsService.generateReport(formData.reportType, {
        companyId: formData.companyId,
        periodId: formData.periodId,
        parameters: formData.parameters,
        filters: formData.filters,
        format: formData.format,
      });

      navigate('/reports');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to generate report');
    } finally {
      setLoading(false);
    }
  };

  const renderStepContent = () => {
    switch (activeStep) {
      case 0:
        return (
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Report Type</InputLabel>
                <Select
                  value={formData.reportType}
                  onChange={(e) =>
                    setFormData({ ...formData, reportType: e.target.value as ReportType })
                  }
                  label="Report Type"
                >
                  {Object.values(ReportType).map((type) => (
                    <MenuItem key={type} value={type}>
                      {type.replace(/_/g, ' ')}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Category</InputLabel>
                <Select
                  value={formData.category}
                  onChange={(e) =>
                    setFormData({ ...formData, category: e.target.value as ReportCategory })
                  }
                  label="Category"
                >
                  {Object.values(ReportCategory).map((category) => (
                    <MenuItem key={category} value={category}>
                      {category.replace(/_/g, ' ')}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Report Name"
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
          </Grid>
        );

      case 1:
        return (
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Company ID"
                value={formData.companyId}
                onChange={(e) => setFormData({ ...formData, companyId: e.target.value })}
                required
                helperText="Enter the company ID for this report"
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Period ID (Optional)"
                value={formData.periodId}
                onChange={(e) => setFormData({ ...formData, periodId: e.target.value })}
                helperText="Leave blank for current period"
              />
            </Grid>
            <Grid item xs={12}>
              <FormControl fullWidth>
                <InputLabel>Export Format</InputLabel>
                <Select
                  value={formData.format}
                  onChange={(e) =>
                    setFormData({ ...formData, format: e.target.value as ExportFormat })
                  }
                  label="Export Format"
                >
                  {Object.values(ExportFormat).map((format) => (
                    <MenuItem key={format} value={format}>
                      {format}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
          </Grid>
        );

      case 2:
        return (
          <Box>
            <Typography variant="h6" gutterBottom>
              Review Report Configuration
            </Typography>
            <Grid container spacing={2} sx={{ mt: 2 }}>
              <Grid item xs={6}>
                <Typography color="textSecondary">Report Type:</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography>{formData.reportType.replace(/_/g, ' ')}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography color="textSecondary">Category:</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography>{formData.category}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography color="textSecondary">Name:</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography>{formData.name || 'Unnamed Report'}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography color="textSecondary">Company ID:</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography>{formData.companyId}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography color="textSecondary">Format:</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography>{formData.format}</Typography>
              </Grid>
            </Grid>
            {error && (
              <Alert severity="error" sx={{ mt: 2 }}>
                {error}
              </Alert>
            )}
          </Box>
        );

      default:
        return null;
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h4" gutterBottom>
        Generate Report
      </Typography>

      <Card sx={{ mt: 3 }}>
        <CardContent>
          <Stepper activeStep={activeStep} sx={{ mb: 4 }}>
            {steps.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>

          {renderStepContent()}

          <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 4 }}>
            <Button disabled={activeStep === 0} onClick={handleBack}>
              Back
            </Button>
            <Box>
              <Button onClick={() => navigate('/reports')} sx={{ mr: 1 }}>
                Cancel
              </Button>
              {activeStep === steps.length - 1 ? (
                <Button
                  variant="contained"
                  onClick={handleGenerate}
                  disabled={loading || !formData.companyId}
                >
                  {loading ? 'Generating...' : 'Generate Report'}
                </Button>
              ) : (
                <Button variant="contained" onClick={handleNext}>
                  Next
                </Button>
              )}
            </Box>
          </Box>
        </CardContent>
      </Card>
    </Box>
  );
};

export default ReportGenerator;
