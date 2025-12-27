import React, { useState, useEffect } from 'react';
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
} from '@mui/material';
import apiClient from '../../services/api';

interface TenantUser {
  id: string;
  user: {
    firstName: string;
    lastName: string;
    email: string;
  };
}

interface AssignmentDialogProps {
  open: boolean;
  onClose: () => void;
  onSuccess: () => void;
  procedureId: string;
  currentAssignee?: {
    id: string;
    user: {
      firstName: string;
      lastName: string;
    };
  };
}

export const AssignmentDialog: React.FC<AssignmentDialogProps> = ({
  open,
  onClose,
  onSuccess,
  procedureId,
  currentAssignee,
}) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [users, setUsers] = useState<TenantUser[]>([]);
  const [assignedToId, setAssignedToId] = useState('');
  const [dueDate, setDueDate] = useState('');
  const [notes, setNotes] = useState('');

  useEffect(() => {
    if (open) {
      loadUsers();
      if (currentAssignee) {
        setAssignedToId(currentAssignee.id);
      }
    }
  }, [open, currentAssignee]);

  const loadUsers = async () => {
    try {
      const response = await apiClient.get('/tenant-users');
      setUsers(response.data);
    } catch (err: any) {
      setError('Failed to load users');
    }
  };

  const handleSubmit = async () => {
    if (!assignedToId) {
      setError('Please select a user to assign');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      await apiClient.post(`/audit-procedures/${procedureId}/assign`, {
        assignedToId,
        dueDate: dueDate ? new Date(dueDate).toISOString() : undefined,
        notes,
      });

      onSuccess();
      handleClose();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to assign procedure');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setAssignedToId('');
    setDueDate('');
    setNotes('');
    setError(null);
    onClose();
  };

  return (
    <Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
      <DialogTitle>Assign Procedure</DialogTitle>
      <DialogContent>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        {currentAssignee && (
          <Alert severity="info" sx={{ mb: 2 }}>
            Currently assigned to: {currentAssignee.user.firstName} {currentAssignee.user.lastName}
          </Alert>
        )}

        <FormControl fullWidth sx={{ mt: 2 }} required>
          <InputLabel>Assign To</InputLabel>
          <Select
            value={assignedToId}
            onChange={(e) => setAssignedToId(e.target.value)}
            label="Assign To"
          >
            {users.map((user) => (
              <MenuItem key={user.id} value={user.id}>
                {user.user.firstName} {user.user.lastName} ({user.user.email})
              </MenuItem>
            ))}
          </Select>
        </FormControl>

        <TextField
          fullWidth
          type="date"
          label="Due Date"
          value={dueDate}
          onChange={(e) => setDueDate(e.target.value)}
          InputLabelProps={{ shrink: true }}
          sx={{ mt: 2 }}
        />

        <TextField
          fullWidth
          label="Assignment Notes"
          value={notes}
          onChange={(e) => setNotes(e.target.value)}
          multiline
          rows={3}
          placeholder="Add any instructions or notes for the assignee..."
          sx={{ mt: 2 }}
        />

        <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: 'block' }}>
          The assignee will be notified of this assignment.
        </Typography>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleClose} disabled={loading}>
          Cancel
        </Button>
        <Button
          onClick={handleSubmit}
          variant="contained"
          disabled={loading || !assignedToId}
          startIcon={loading ? <CircularProgress size={20} /> : null}
        >
          Assign
        </Button>
      </DialogActions>
    </Dialog>
  );
};
