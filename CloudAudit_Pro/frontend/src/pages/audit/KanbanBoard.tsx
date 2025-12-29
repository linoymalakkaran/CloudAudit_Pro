import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Chip,
  Avatar,
  IconButton,
  CircularProgress,
  Alert,
  Button,
} from '@mui/material';
import {
  Visibility as ViewIcon,
  ViewList as ListIcon,
  Add as AddIcon,
  CalendarToday as CalendarIcon,
} from '@mui/icons-material';
import { DragDropContext, Droppable, Draggable, DropResult } from '@hello-pangea/dnd';
import { useNavigate } from 'react-router-dom';
import apiClient from '../../services/api';

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

interface Column {
  id: string;
  title: string;
  status: string;
  color: string;
  procedures: Procedure[];
}

const statusColumns = [
  { id: 'not-started', title: 'Not Started', status: 'NOT_STARTED', color: '#e0e0e0' },
  { id: 'in-progress', title: 'In Progress', status: 'IN_PROGRESS', color: '#2196f3' },
  { id: 'review', title: 'Review Required', status: 'REVIEW_REQUIRED', color: '#ff9800' },
  { id: 'completed', title: 'Completed', status: 'COMPLETED', color: '#4caf50' },
];

const KanbanBoard: React.FC = () => {
  const navigate = useNavigate();
  const [columns, setColumns] = useState<Column[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    loadProcedures();
  }, []);

  const loadProcedures = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get('/procedures');
      const procedures: Procedure[] = response.data;

      // Organize procedures into columns
      const organizedColumns = statusColumns.map((col) => ({
        ...col,
        procedures: procedures.filter((p) => p.status === col.status),
      }));

      setColumns(organizedColumns);
      setError(null);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load procedures');
    } finally {
      setLoading(false);
    }
  };

  const onDragEnd = async (result: DropResult) => {
    const { source, destination, draggableId } = result;

    // Dropped outside a droppable area
    if (!destination) return;

    // Dropped in the same position
    if (source.droppableId === destination.droppableId && source.index === destination.index) {
      return;
    }

    // Find source and destination columns
    const sourceColumn = columns.find((col) => col.id === source.droppableId);
    const destColumn = columns.find((col) => col.id === destination.droppableId);

    if (!sourceColumn || !destColumn) return;

    // Get the procedure being moved
    const procedure = sourceColumn.procedures[source.index];

    // If moving to a different column, update status
    if (source.droppableId !== destination.droppableId) {
      try {
        // Optimistic update
        const newColumns = columns.map((col) => {
          if (col.id === source.droppableId) {
            return {
              ...col,
              procedures: col.procedures.filter((p) => p.id !== draggableId),
            };
          }
          if (col.id === destination.droppableId) {
            const newProcedure = { ...procedure, status: destColumn.status };
            const newProcedures = [...col.procedures];
            newProcedures.splice(destination.index, 0, newProcedure);
            return { ...col, procedures: newProcedures };
          }
          return col;
        });
        setColumns(newColumns);

        // API call to update status
        await apiClient.put(`/procedures/${procedure.id}`, {
          status: destColumn.status,
        });
      } catch (err: any) {
        setError('Failed to update procedure status');
        // Reload on error
        loadProcedures();
      }
    } else {
      // Reordering within the same column
      const newProcedures = Array.from(sourceColumn.procedures);
      const [removed] = newProcedures.splice(source.index, 1);
      newProcedures.splice(destination.index, 0, removed);

      const newColumns = columns.map((col) => {
        if (col.id === source.droppableId) {
          return { ...col, procedures: newProcedures };
        }
        return col;
      });
      setColumns(newColumns);
    }
  };

  const priorityColors: Record<string, 'default' | 'info' | 'warning' | 'error'> = {
    LOW: 'default',
    MEDIUM: 'info',
    HIGH: 'warning',
    CRITICAL: 'error',
  };

  const formatDate = (date?: string) => {
    if (!date) return '';
    return new Date(date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  };

  const isOverdue = (dueDate?: string) => {
    if (!dueDate) return false;
    return new Date(dueDate) < new Date();
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
        <Typography variant="h4">Kanban Board</Typography>
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
            startIcon={<CalendarIcon />}
            onClick={() => navigate('/audit/calendar')}
          >
            Calendar View
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

      <DragDropContext onDragEnd={onDragEnd}>
        <Box sx={{ display: 'flex', gap: 2, overflowX: 'auto', pb: 2 }}>
          {columns.map((column) => (
            <Box
              key={column.id}
              sx={{
                minWidth: 300,
                flex: 1,
                bgcolor: '#f5f5f5',
                borderRadius: 1,
                p: 2,
              }}
            >
              <Box
                sx={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                  mb: 2,
                }}
              >
                <Typography variant="h6" sx={{ fontWeight: 600 }}>
                  {column.title}
                </Typography>
                <Chip
                  label={column.procedures.length}
                  size="small"
                  sx={{ bgcolor: column.color, color: 'white' }}
                />
              </Box>

              <Droppable droppableId={column.id}>
                {(provided, snapshot) => (
                  <Box
                    ref={provided.innerRef}
                    {...provided.droppableProps}
                    sx={{
                      minHeight: 400,
                      bgcolor: snapshot.isDraggingOver ? '#e3f2fd' : 'transparent',
                      borderRadius: 1,
                      transition: 'background-color 0.2s',
                    }}
                  >
                    {column.procedures.map((procedure, index) => (
                      <Draggable key={procedure.id} draggableId={procedure.id} index={index}>
                        {(provided, snapshot) => (
                          <Card
                            ref={provided.innerRef}
                            {...provided.draggableProps}
                            {...provided.dragHandleProps}
                            sx={{
                              mb: 1.5,
                              cursor: 'grab',
                              boxShadow: snapshot.isDragging ? 4 : 1,
                              transform: snapshot.isDragging
                                ? provided.draggableProps.style?.transform
                                : 'none',
                              '&:hover': { boxShadow: 3 },
                            }}
                          >
                            <CardContent sx={{ p: 2, '&:last-child': { pb: 2 } }}>
                              <Box
                                sx={{
                                  display: 'flex',
                                  justifyContent: 'space-between',
                                  alignItems: 'start',
                                  mb: 1,
                                }}
                              >
                                <Typography
                                  variant="subtitle2"
                                  sx={{ fontWeight: 600, flex: 1, pr: 1 }}
                                >
                                  {procedure.name}
                                </Typography>
                                <IconButton
                                  size="small"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    navigate(`/audit/procedures/${procedure.id}`);
                                  }}
                                >
                                  <ViewIcon fontSize="small" />
                                </IconButton>
                              </Box>

                              <Typography
                                variant="caption"
                                color="textSecondary"
                                sx={{ display: 'block', mb: 1 }}
                              >
                                {procedure.company.name}
                              </Typography>

                              <Box sx={{ display: 'flex', gap: 0.5, flexWrap: 'wrap', mb: 1 }}>
                                <Chip
                                  label={procedure.priority}
                                  color={priorityColors[procedure.priority]}
                                  size="small"
                                />
                                {procedure._count.workpapers > 0 && (
                                  <Chip
                                    label={`${procedure._count.workpapers} WP`}
                                    size="small"
                                    variant="outlined"
                                  />
                                )}
                                {procedure._count.findings > 0 && (
                                  <Chip
                                    label={`${procedure._count.findings} F`}
                                    size="small"
                                    color="warning"
                                    variant="outlined"
                                  />
                                )}
                              </Box>

                              {procedure.dueDate && (
                                <Typography
                                  variant="caption"
                                  color={isOverdue(procedure.dueDate) ? 'error' : 'textSecondary'}
                                  sx={{ display: 'block', mb: 0.5 }}
                                >
                                  📅 {formatDate(procedure.dueDate)}
                                </Typography>
                              )}

                              {procedure.assignedTo && (
                                <Box sx={{ display: 'flex', alignItems: 'center', mt: 1 }}>
                                  <Avatar sx={{ width: 24, height: 24, fontSize: 12, mr: 1 }}>
                                    {procedure.assignedTo.firstName[0]}
                                    {procedure.assignedTo.lastName[0]}
                                  </Avatar>
                                  <Typography variant="caption">
                                    {procedure.assignedTo.firstName} {procedure.assignedTo.lastName}
                                  </Typography>
                                </Box>
                              )}
                            </CardContent>
                          </Card>
                        )}
                      </Draggable>
                    ))}
                    {provided.placeholder}
                  </Box>
                )}
              </Droppable>
            </Box>
          ))}
        </Box>
      </DragDropContext>
    </Box>
  );
};

export default KanbanBoard;
