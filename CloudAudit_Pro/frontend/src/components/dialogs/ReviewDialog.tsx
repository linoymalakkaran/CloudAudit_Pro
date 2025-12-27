import React, { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  TextField,
  CircularProgress,
  Alert,
  Typography,
  Box,
  Chip,
} from '@mui/material';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import CancelIcon from '@mui/icons-material/Cancel';
import EditIcon from '@mui/icons-material/Edit';
import apiClient from '../../services/api';

interface ReviewDialogProps {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
  procedureId: string;
  procedureTitle: string;
}

export const ReviewDialog: React.FC<ReviewDialogProps> = ({
  open,
  onClose,
  onSuccess,
  procedureId,
  procedureTitle,
}) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [reviewStatus, setReviewStatus] = useState<'APPROVED' | 'REJECTED' | 'REQUIRES_CHANGES'>('APPROVED');
  const [reviewComments, setReviewComments] = useState('');

  const handleSubmit = async () => {
    if (reviewStatus !== 'APPROVED' && !reviewComments.trim()) {
      setError('Please provide comments for rejection or requested changes');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      await apiClient.post(`/audit-procedures/${procedureId}/review`, {
        reviewStatus,
        reviewComments,
      });

      onSuccess();
      handleClose();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to submit review');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setReviewStatus('APPROVED');
    setReviewComments('');
    setError(null);
    onClose();
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'APPROVED':
        return <CheckCircleIcon />;
      case 'REJECTED':
        return <CancelIcon />;
      case 'REQUIRES_CHANGES':
        return <EditIcon />;
      default:
        return null;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'APPROVED':
        return 'success';
      case 'REJECTED':
        return 'error';
      case 'REQUIRES_CHANGES':
        return 'warning';
      default:
        return 'default';
    }
  };

  return (
    <Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
      <DialogTitle>Review Procedure</DialogTitle>
      <DialogContent>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        <Alert severity="info" sx={{ mb: 3 }}>
          <Typography variant="subtitle2" gutterBottom>
            Reviewing: {procedureTitle}
          </Typography>
          <Typography variant="caption">
            Please carefully review the procedure, workpapers, and findings before making a decision.
          </Typography>
        </Alert>

        <FormControl fullWidth required>
          <InputLabel>Review Decision</InputLabel>
          <Select
            value={reviewStatus}
            onChange={(e) => setReviewStatus(e.target.value as any)}
            label="Review Decision"
          >
            <MenuItem value="APPROVED">
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                <Chip
                  icon={<CheckCircleIcon />}
                  label="Approve"
                  color="success"
                  size="small"
                />
                <Typography variant="body2" sx={{ ml: 1 }}>
                  - Procedure meets all requirements
                </Typography>
              </Box>
            </MenuItem>
            <MenuItem value="REQUIRES_CHANGES">
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                <Chip
                  icon={<EditIcon />}
                  label="Requires Changes"
                  color="warning"
                  size="small"
                />
                <Typography variant="body2" sx={{ ml: 1 }}>
                  - Minor revisions needed
                </Typography>
              </Box>
            </MenuItem>
            <MenuItem value="REJECTED">
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                <Chip
                  icon={<CancelIcon />}
                  label="Reject"
                  color="error"
                  size="small"
                />
                <Typography variant="body2" sx={{ ml: 1 }}>
                  - Significant issues found
                </Typography>
              </Box>
            </MenuItem>
          </Select>
        </FormControl>

        <TextField
          fullWidth
          label="Review Comments"
          value={reviewComments}
          onChange={(e) => setReviewComments(e.target.value)}
          multiline
          rows={5}
          required={reviewStatus !== 'APPROVED'}
          placeholder={
            reviewStatus === 'APPROVED'
              ? 'Optional: Add any comments or recommendations...'
              : 'Required: Explain what needs to be addressed...'
          }
          sx={{ mt: 3 }}
          helperText={
            reviewStatus !== 'APPROVED'
              ? 'Please provide detailed feedback on what needs to be changed'
              : 'Comments are optional for approved procedures'
          }
        />

        <Box sx={{ mt: 2, p: 2, bgcolor: 'grey.50', borderRadius: 1 }}>
          <Typography variant="caption" color="text.secondary">
            <strong>Note:</strong> The procedure status will be updated based on your decision. 
            The assignee will be notified of your review.
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
          color={getStatusColor(reviewStatus) as any}
          disabled={loading}
          startIcon={loading ? <CircularProgress size={20} /> : getStatusIcon(reviewStatus)}
        >
          Submit Review
        </Button>
      </DialogActions>
    </Dialog>
  );
};
