import React, { useState } from 'react';
import {
  Box,
  TextField,
  Button,
  CircularProgress,
  Alert,
} from '@mui/material';
import { Send as SendIcon } from '@mui/icons-material';

interface CommentFormProps {
  onSubmit: (comment: string) => Promise<void>;
}

const CommentForm: React.FC<CommentFormProps> = ({ onSubmit }) => {
  const [comment, setComment] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!comment.trim()) {
      setError('Comment cannot be empty');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      await onSubmit(comment.trim());
      setComment('');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to add comment');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit} sx={{ mt: 2 }}>
      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}
      
      <TextField
        fullWidth
        multiline
        rows={3}
        label="Add a comment"
        value={comment}
        onChange={(e) => setComment(e.target.value)}
        disabled={loading}
        placeholder="Share your thoughts, ask questions, or provide feedback..."
      />
      
      <Box sx={{ mt: 2, display: 'flex', justifyContent: 'flex-end' }}>
        <Button
          type="submit"
          variant="contained"
          color="primary"
          startIcon={loading ? <CircularProgress size={20} /> : <SendIcon />}
          disabled={loading || !comment.trim()}
        >
          {loading ? 'Posting...' : 'Post Comment'}
        </Button>
      </Box>
    </Box>
  );
};

export default CommentForm;
