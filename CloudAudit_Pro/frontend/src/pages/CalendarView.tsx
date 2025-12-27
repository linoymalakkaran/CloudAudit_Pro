import React, { useState, useEffect } from 'react';
import {
  Box,
  Typography,
  Card,
  CircularProgress,
  Alert,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Chip,
  Avatar,
  Stack,
} from '@mui/material';
import {
  ViewList as ListIcon,
  ViewKanban as KanbanIcon,
  Add as AddIcon,
} from '@mui/icons-material';
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import '@fullcalendar/core';
import '@fullcalendar/daygrid';
import { useNavigate } from 'react-router-dom';
import apiClient from '../services/api';

interface Procedure {
  id: string;
  name: string;
  description?: string;
  status: string;
  priority: string;
  dueDate?: string;
  company: { name: string };
  assignedTo?: { firstName: string; lastName: string };
  _count: { workpapers: number; findings: number };
}

interface CalendarEvent {
  id: string;
  title: string;
  start: string;
  backgroundColor: string;
  borderColor: string;
  extendedProps: Procedure;
}

const CalendarView: React.FC = () => {
  const navigate = useNavigate();
  const [procedures, setProcedures] = useState<Procedure[]>([]);
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedProcedure, setSelectedProcedure] = useState<Procedure | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);

  useEffect(() => {
    loadProcedures();
  }, []);

  const loadProcedures = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get('/api/procedures');
      const proceduresData = response.data;
      setProcedures(proceduresData);

      // Convert procedures to calendar events
      const calendarEvents: CalendarEvent[] = proceduresData
        .filter((p: Procedure) => p.dueDate)
        .map((p: Procedure) => ({
          id: p.id,
          title: p.name,
          start: p.dueDate!,
          backgroundColor: getEventColor(p.status, p.priority).bg,
          borderColor: getEventColor(p.status, p.priority).border,
          extendedProps: p,
        }));

      setEvents(calendarEvents);
    } catch (err) {
      setError('Failed to load procedures');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const getEventColor = (status: string, priority: string) => {
    // Priority takes precedence for overdue items
    if (priority === 'HIGH') {
      return { bg: '#d32f2f', border: '#b71c1c' };
    }
    if (priority === 'MEDIUM') {
      return { bg: '#f57c00', border: '#e65100' };
    }

    // Otherwise color by status
    switch (status) {
      case 'NOT_STARTED':
        return { bg: '#757575', border: '#616161' };
      case 'IN_PROGRESS':
        return { bg: '#1976d2', border: '#1565c0' };
      case 'REVIEW_REQUIRED':
        return { bg: '#ed6c02', border: '#e65100' };
      case 'COMPLETED':
        return { bg: '#2e7d32', border: '#1b5e20' };
      default:
        return { bg: '#9e9e9e', border: '#757575' };
    }
  };

  const handleEventClick = (info: any) => {
    const procedure = info.event.extendedProps as Procedure;
    setSelectedProcedure(procedure);
    setDialogOpen(true);
  };

  const handleCloseDialog = () => {
    setDialogOpen(false);
    setSelectedProcedure(null);
  };

  const handleViewProcedure = () => {
    if (selectedProcedure) {
      navigate(`/audit/procedures/${selectedProcedure.id}`);
    }
  };

  const getStatusLabel = (status: string) => {
    switch (status) {
      case 'NOT_STARTED':
        return 'Not Started';
      case 'IN_PROGRESS':
        return 'In Progress';
      case 'REVIEW_REQUIRED':
        return 'Review Required';
      case 'COMPLETED':
        return 'Completed';
      default:
        return status;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'NOT_STARTED':
        return 'default';
      case 'IN_PROGRESS':
        return 'primary';
      case 'REVIEW_REQUIRED':
        return 'warning';
      case 'COMPLETED':
        return 'success';
      default:
        return 'default';
    }
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'HIGH':
        return 'error';
      case 'MEDIUM':
        return 'warning';
      case 'LOW':
        return 'info';
      default:
        return 'default';
    }
  };

  if (loading) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Calendar View</Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button
            variant="outlined"
            startIcon={<ListIcon />}
            onClick={() => navigate('/audit/procedures')}
          >
            List View
          </Button>
          <Button
            variant="outlined"
            startIcon={<KanbanIcon />}
            onClick={() => navigate('/audit/kanban')}
          >
            Kanban View
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => navigate('/audit/procedures')}
          >
            New Procedure
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      <Card sx={{ p: 2 }}>
        <FullCalendar
          plugins={[dayGridPlugin, interactionPlugin]}
          initialView="dayGridMonth"
          events={events}
          eventClick={handleEventClick}
          height="auto"
          headerToolbar={{
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek',
          }}
          eventTimeFormat={{
            hour: 'numeric',
            minute: '2-digit',
            meridiem: 'short',
          }}
        />
      </Card>

      {/* Procedure Detail Dialog */}
      <Dialog
        open={dialogOpen}
        onClose={handleCloseDialog}
        maxWidth="sm"
        fullWidth
      >
        {selectedProcedure && (
          <>
            <DialogTitle>
              <Typography variant="h6">{selectedProcedure.name}</Typography>
            </DialogTitle>
            <DialogContent>
              <Stack spacing={2}>
                {selectedProcedure.description && (
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Description
                    </Typography>
                    <Typography variant="body2">{selectedProcedure.description}</Typography>
                  </Box>
                )}

                <Box>
                  <Typography variant="subtitle2" color="text.secondary">
                    Company
                  </Typography>
                  <Typography variant="body2">{selectedProcedure.company.name}</Typography>
                </Box>

                <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Status
                    </Typography>
                    <Chip
                      label={getStatusLabel(selectedProcedure.status)}
                      color={getStatusColor(selectedProcedure.status) as any}
                      size="small"
                      sx={{ mt: 0.5 }}
                    />
                  </Box>

                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Priority
                    </Typography>
                    <Chip
                      label={selectedProcedure.priority}
                      color={getPriorityColor(selectedProcedure.priority) as any}
                      size="small"
                      sx={{ mt: 0.5 }}
                    />
                  </Box>
                </Box>

                {selectedProcedure.dueDate && (
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Due Date
                    </Typography>
                    <Typography variant="body2">
                      {new Date(selectedProcedure.dueDate).toLocaleDateString()}
                    </Typography>
                  </Box>
                )}

                {selectedProcedure.assignedTo && (
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Assigned To
                    </Typography>
                    <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mt: 0.5 }}>
                      <Avatar sx={{ width: 32, height: 32 }}>
                        {selectedProcedure.assignedTo.firstName[0]}
                        {selectedProcedure.assignedTo.lastName[0]}
                      </Avatar>
                      <Typography variant="body2">
                        {selectedProcedure.assignedTo.firstName} {selectedProcedure.assignedTo.lastName}
                      </Typography>
                    </Box>
                  </Box>
                )}

                <Box sx={{ display: 'flex', gap: 2 }}>
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Workpapers
                    </Typography>
                    <Typography variant="body2">{selectedProcedure._count.workpapers}</Typography>
                  </Box>
                  <Box>
                    <Typography variant="subtitle2" color="text.secondary">
                      Findings
                    </Typography>
                    <Typography variant="body2">{selectedProcedure._count.findings}</Typography>
                  </Box>
                </Box>
              </Stack>
            </DialogContent>
            <DialogActions>
              <Button onClick={handleCloseDialog}>Close</Button>
              <Button onClick={handleViewProcedure} variant="contained">
                View Details
              </Button>
            </DialogActions>
          </>
        )}
      </Dialog>
    </Box>
  );
};

export default CalendarView;
