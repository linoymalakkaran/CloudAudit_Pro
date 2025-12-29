import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  Grid,
  InputLabel,
  MenuItem,
  Select,
  TextField,
  Typography,
  Paper,
  Divider,
  Alert,
} from '@mui/material';
import {
  CheckCircle as CheckCircleIcon,
  Publish as PublishIcon,
  Assessment as AssessmentIcon,
  Edit as EditIcon,
} from '@mui/icons-material';
import auditFinalizationService, {
  AuditFinalization,
  FinalizationStatus,
  OpinionType,
  AuditSummary,
  CreateAuditFinalizationDto,
  UpdateAuditFinalizationDto,
} from '../../services/auditFinalizationService';

const AuditFinalizationPage: React.FC = () => {
  const [finalization, setFinalization] = useState<AuditFinalization | null>(null);
  const [summary, setSummary] = useState<AuditSummary | null>(null);
  const [loading, setLoading] = useState(false);
  const [openDialog, setOpenDialog] = useState(false);
  const [formData, setFormData] = useState<Partial<CreateAuditFinalizationDto>>({});

  // Assume these come from context/props
  const companyId = localStorage.getItem('selectedCompanyId') || '';
  const periodId = localStorage.getItem('selectedPeriodId') || '';

  useEffect(() => {
    if (companyId && periodId) {
      loadFinalization();
      loadSummary();
    }
  }, [companyId, periodId]);

  const loadFinalization = async () => {
    setLoading(true);
    try {
      const data = await auditFinalizationService.getByCompanyAndPeriod(companyId, periodId);
      setFinalization(data);
    } catch (error) {
      console.error('Finalization not found, will create new:', error);
      setFinalization(null);
    } finally {
      setLoading(false);
    }
  };

  const loadSummary = async () => {
    try {
      const data = await auditFinalizationService.getAuditSummary(companyId, periodId);
      setSummary(data);
    } catch (error) {
      console.error('Failed to load audit summary:', error);
    }
  };

  const handleOpenDialog = () => {
    if (finalization) {
      setFormData({
        title: finalization.title,
        status: finalization.status,
        opinionType: finalization.opinionType,
        opinionText: finalization.opinionText,
        executiveSummary: finalization.executiveSummary,
        keyFindings: finalization.keyFindings,
        recommendations: finalization.recommendations,
        materialityThreshold: finalization.materialityThreshold,
        auditStartDate: finalization.auditStartDate,
        auditEndDate: finalization.auditEndDate,
        notes: finalization.notes,
      });
    } else {
      setFormData({
        companyId,
        periodId,
        title: `Audit Finalization - ${periodId}`,
        status: FinalizationStatus.DRAFT,
        requiresPartnerApproval: true,
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setFormData({});
  };

  const handleSave = async () => {
    try {
      if (finalization) {
        await auditFinalizationService.updateAuditFinalization(
          finalization.id,
          formData as UpdateAuditFinalizationDto
        );
      } else {
        await auditFinalizationService.createAuditFinalization(
          formData as CreateAuditFinalizationDto
        );
      }
      handleCloseDialog();
      loadFinalization();
    } catch (error) {
      console.error('Failed to save audit finalization:', error);
    }
  };

  const handleFinalize = async () => {
    if (!finalization) return;

    if (
      window.confirm(
        'Are you sure you want to finalize this audit? This action cannot be undone.'
      )
    ) {
      try {
        await auditFinalizationService.finalizeAudit(finalization.id);
        loadFinalization();
      } catch (error: any) {
        alert(error.response?.data?.message || 'Failed to finalize audit');
      }
    }
  };

  const handleIssueReport = async () => {
    if (!finalization) return;

    if (window.confirm('Are you sure you want to issue the audit report?')) {
      try {
        await auditFinalizationService.issueReport(finalization.id);
        loadFinalization();
      } catch (error) {
        console.error('Failed to issue report:', error);
      }
    }
  };

  const getStatusColor = (status: FinalizationStatus) => {
    switch (status) {
      case FinalizationStatus.DRAFT:
        return 'default';
      case FinalizationStatus.IN_PROGRESS:
        return 'warning';
      case FinalizationStatus.REVIEW:
        return 'info';
      case FinalizationStatus.APPROVED:
        return 'success';
      case FinalizationStatus.FINALIZED:
        return 'success';
      case FinalizationStatus.ISSUED:
        return 'success';
      default:
        return 'default';
    }
  };

  const getOpinionColor = (opinion: OpinionType) => {
    switch (opinion) {
      case OpinionType.UNQUALIFIED:
        return 'success';
      case OpinionType.QUALIFIED:
        return 'warning';
      case OpinionType.ADVERSE:
        return 'error';
      case OpinionType.DISCLAIMER:
        return 'error';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h4" gutterBottom>
        Audit Finalization
      </Typography>

      {!finalization && (
        <Alert severity="info" sx={{ mb: 3 }}>
          No finalization record exists for this audit. Click "Create/Edit Finalization" to begin.
        </Alert>
      )}

      {finalization && (
        <Paper sx={{ p: 3, mb: 3 }}>
          <Grid container spacing={2}>
            <Grid item xs={12} sm={6}>
              <Typography variant="h6" gutterBottom>
                {finalization.title}
              </Typography>
              <Chip
                label={finalization.status}
                color={getStatusColor(finalization.status)}
                sx={{ mr: 1 }}
              />
              {finalization.opinionType && (
                <Chip
                  label={finalization.opinionType}
                  color={getOpinionColor(finalization.opinionType)}
                />
              )}
            </Grid>
            <Grid item xs={12} sm={6} sx={{ textAlign: 'right' }}>
              <Button
                variant="outlined"
                startIcon={<EditIcon />}
                onClick={handleOpenDialog}
                sx={{ mr: 1 }}
              >
                Edit
              </Button>
              {!finalization.isFinalized && (
                <Button
                  variant="contained"
                  startIcon={<CheckCircleIcon />}
                  onClick={handleFinalize}
                  color="success"
                  sx={{ mr: 1 }}
                >
                  Finalize Audit
                </Button>
              )}
              {finalization.isFinalized && finalization.status !== FinalizationStatus.ISSUED && (
                <Button
                  variant="contained"
                  startIcon={<PublishIcon />}
                  onClick={handleIssueReport}
                  color="primary"
                >
                  Issue Report
                </Button>
              )}
            </Grid>
          </Grid>
        </Paper>
      )}

      {!finalization && (
        <Box sx={{ textAlign: 'center', mb: 3 }}>
          <Button variant="contained" startIcon={<AssessmentIcon />} onClick={handleOpenDialog}>
            Create Finalization
          </Button>
        </Box>
      )}

      {/* Audit Summary */}
      {summary && (
        <Grid container spacing={3}>
          <Grid item xs={12} md={4}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom color="primary">
                  Procedures Summary
                </Typography>
                <Divider sx={{ my: 2 }} />
                <Grid container spacing={1}>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Total:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold">
                      {summary.procedures.total}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Completed:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="success.main">
                      {summary.procedures.completed}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      In Progress:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="warning.main">
                      {summary.procedures.inProgress}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Not Started:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="error.main">
                      {summary.procedures.notStarted}
                    </Typography>
                  </Grid>
                </Grid>
              </CardContent>
            </Card>
          </Grid>

          <Grid item xs={12} md={4}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom color="error">
                  Findings Summary
                </Typography>
                <Divider sx={{ my: 2 }} />
                <Grid container spacing={1}>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Total:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold">
                      {summary.findings.total}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Open:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="error.main">
                      {summary.findings.open}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Closed:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="success.main">
                      {summary.findings.closed}
                    </Typography>
                  </Grid>
                  <Grid item xs={12}>
                    <Divider sx={{ my: 1 }} />
                  </Grid>
                  <Grid item xs={6}>
                    <Chip label="Critical" size="small" color="error" />
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2">{summary.findings.bySeverity.critical}</Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Chip label="High" size="small" color="warning" />
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2">{summary.findings.bySeverity.high}</Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Chip label="Medium" size="small" color="info" />
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2">{summary.findings.bySeverity.medium}</Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Chip label="Low" size="small" />
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2">{summary.findings.bySeverity.low}</Typography>
                  </Grid>
                </Grid>
              </CardContent>
            </Card>
          </Grid>

          <Grid item xs={12} md={4}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom color="info.main">
                  Review Points Summary
                </Typography>
                <Divider sx={{ my: 2 }} />
                <Grid container spacing={1}>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Total:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold">
                      {summary.reviewPoints.total}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Outstanding:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="error.main">
                      {summary.reviewPoints.outstanding}
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">
                      Cleared:
                    </Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" fontWeight="bold" color="success.main">
                      {summary.reviewPoints.cleared}
                    </Typography>
                  </Grid>
                </Grid>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      )}

      {/* Create/Edit Dialog */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle>
          {finalization ? 'Edit Audit Finalization' : 'Create Audit Finalization'}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Title"
                value={formData.title || ''}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                required
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Status</InputLabel>
                <Select
                  value={formData.status || FinalizationStatus.DRAFT}
                  onChange={(e) =>
                    setFormData({ ...formData, status: e.target.value as FinalizationStatus })
                  }
                  label="Status"
                >
                  {Object.values(FinalizationStatus).map((status) => (
                    <MenuItem key={status} value={status}>
                      {status}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} sm={6}>
              <FormControl fullWidth>
                <InputLabel>Opinion Type</InputLabel>
                <Select
                  value={formData.opinionType || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, opinionType: e.target.value as OpinionType })
                  }
                  label="Opinion Type"
                >
                  <MenuItem value="">None</MenuItem>
                  {Object.values(OpinionType).map((opinion) => (
                    <MenuItem key={opinion} value={opinion}>
                      {opinion}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Opinion Text"
                value={formData.opinionText || ''}
                onChange={(e) => setFormData({ ...formData, opinionText: e.target.value })}
                multiline
                rows={4}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Executive Summary"
                value={formData.executiveSummary || ''}
                onChange={(e) => setFormData({ ...formData, executiveSummary: e.target.value })}
                multiline
                rows={4}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Key Findings"
                value={formData.keyFindings || ''}
                onChange={(e) => setFormData({ ...formData, keyFindings: e.target.value })}
                multiline
                rows={4}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Recommendations"
                value={formData.recommendations || ''}
                onChange={(e) => setFormData({ ...formData, recommendations: e.target.value })}
                multiline
                rows={4}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Materiality Threshold"
                type="number"
                value={formData.materialityThreshold || ''}
                onChange={(e) =>
                  setFormData({ ...formData, materialityThreshold: Number(e.target.value) })
                }
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Audit Start Date"
                type="date"
                value={formData.auditStartDate || ''}
                onChange={(e) => setFormData({ ...formData, auditStartDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Audit End Date"
                type="date"
                value={formData.auditEndDate || ''}
                onChange={(e) => setFormData({ ...formData, auditEndDate: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Notes"
                value={formData.notes || ''}
                onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
                multiline
                rows={3}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog}>Cancel</Button>
          <Button onClick={handleSave} variant="contained">
            Save
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default AuditFinalizationPage;
