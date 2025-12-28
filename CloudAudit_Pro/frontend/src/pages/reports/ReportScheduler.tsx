import React, { useEffect, useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Chip,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Grid,
  Switch,
  FormControlLabel,
  CircularProgress,
  Tabs,
  Tab,
} from '@mui/material';
import {
  Add,
  Edit,
  Delete,
  PlayArrow,
  Pause,
  History,
  CalendarMonth,
} from '@mui/icons-material';
import reportingService from '../../services/reporting.service';

interface ReportSchedule {
  id: string;
  reportId?: string;
  reportTemplateId?: string;
  companyId: string;
  periodId?: string;
  frequency: string;
  scheduleTime: string;
  timezone: string;
  isActive: boolean;
  lastRunAt?: string;
  nextRunAt?: string;
  parameters?: any;
  filters?: any;
  recipients: string[];
  emailSubject?: string;
  emailBody?: string;
  createdAt: string;
  updatedAt: string;
}

const ReportScheduler: React.FC = () => {
  const [schedules, setSchedules] = useState<ReportSchedule[]>([]);
  const [loading, setLoading] = useState(false);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [selectedSchedule, setSelectedSchedule] = useState<ReportSchedule | null>(null);
  const [tabValue, setTabValue] = useState(0);
  const [upcomingSchedules, setUpcomingSchedules] = useState<any[]>([]);
  const [scheduleHistory, setScheduleHistory] = useState<any[]>([]);
  const [formData, setFormData] = useState({
    reportTemplateId: '',
    companyId: '',
    periodId: '',
    frequency: 'MONTHLY',
    scheduleTime: '09:00',
    timezone: 'UTC',
    isActive: true,
    recipients: '',
    emailSubject: '',
    emailBody: '',
  });

  useEffect(() => {
    loadSchedules();
    loadUpcoming();
  }, []);

  const loadSchedules = async () => {
    setLoading(true);
    try {
      const data = await reportingService.getSchedules();
      setSchedules(data);
    } catch (error) {
      console.error('Failed to load schedules:', error);
    } finally {
      setLoading(false);
    }
  };

  const loadUpcoming = async () => {
    try {
      const data = await reportingService.getUpcomingSchedules(7);
      setUpcomingSchedules(data);
    } catch (error) {
      console.error('Failed to load upcoming schedules:', error);
    }
  };

  const loadHistory = async (scheduleId: string) => {
    try {
      const data = await reportingService.getScheduleHistory(scheduleId);
      setScheduleHistory(data);
    } catch (error) {
      console.error('Failed to load schedule history:', error);
    }
  };

  const handleCreate = () => {
    setSelectedSchedule(null);
    setFormData({
      reportTemplateId: '',
      companyId: '',
      periodId: '',
      frequency: 'MONTHLY',
      scheduleTime: '09:00',
      timezone: 'UTC',
      isActive: true,
      recipients: '',
      emailSubject: '',
      emailBody: '',
    });
    setDialogOpen(true);
  };

  const handleEdit = (schedule: ReportSchedule) => {
    setSelectedSchedule(schedule);
    setFormData({
      reportTemplateId: schedule.reportTemplateId || '',
      companyId: schedule.companyId,
      periodId: schedule.periodId || '',
      frequency: schedule.frequency,
      scheduleTime: schedule.scheduleTime,
      timezone: schedule.timezone,
      isActive: schedule.isActive,
      recipients: schedule.recipients.join(', '),
      emailSubject: schedule.emailSubject || '',
      emailBody: schedule.emailBody || '',
    });
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      const payload = {
        ...formData,
        recipients: formData.recipients.split(',').map((r) => r.trim()),
      };

      if (selectedSchedule) {
        await reportingService.updateSchedule(selectedSchedule.id, payload);
      } else {
        await reportingService.createSchedule(payload);
      }

      setDialogOpen(false);
      loadSchedules();
      loadUpcoming();
    } catch (error) {
      console.error('Failed to save schedule:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (!window.confirm('Are you sure you want to delete this schedule?')) return;

    try {
      await reportingService.deleteSchedule(id);
      loadSchedules();
      loadUpcoming();
    } catch (error) {
      console.error('Failed to delete schedule:', error);
    }
  };

  const handleToggleActive = async (id: string) => {
    try {
      await reportingService.toggleScheduleActive(id);
      loadSchedules();
      loadUpcoming();
    } catch (error) {
      console.error('Failed to toggle schedule:', error);
    }
  };

  const handleRunNow = async (id: string) => {
    try {
      await reportingService.runScheduleNow(id);
      alert('Schedule executed successfully');
      loadSchedules();
    } catch (error) {
      console.error('Failed to run schedule:', error);
    }
  };

  const getFrequencyColor = (frequency: string) => {
    switch (frequency) {
      case 'DAILY':
        return 'primary';
      case 'WEEKLY':
        return 'secondary';
      case 'MONTHLY':
        return 'success';
      case 'QUARTERLY':
        return 'warning';
      case 'ANNUALLY':
        return 'info';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ p: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Report Scheduler</Typography>
        <Button variant="contained" startIcon={<Add />} onClick={handleCreate}>
          Create Schedule
        </Button>
      </Box>

      {/* Tabs */}
      <Tabs value={tabValue} onChange={(e, v) => setTabValue(v)} sx={{ mb: 3 }}>
        <Tab label="All Schedules" />
        <Tab label="Upcoming" />
      </Tabs>

      {/* All Schedules Tab */}
      {tabValue === 0 && (
        <Card>
          <CardContent>
            {loading ? (
              <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
                <CircularProgress />
              </Box>
            ) : schedules.length === 0 ? (
              <Typography textAlign="center" color="textSecondary">
                No schedules found
              </Typography>
            ) : (
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell>Template</TableCell>
                      <TableCell>Frequency</TableCell>
                      <TableCell>Schedule Time</TableCell>
                      <TableCell>Status</TableCell>
                      <TableCell>Last Run</TableCell>
                      <TableCell>Next Run</TableCell>
                      <TableCell>Recipients</TableCell>
                      <TableCell align="right">Actions</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {schedules.map((schedule) => (
                      <TableRow key={schedule.id}>
                        <TableCell>{schedule.reportTemplateId || schedule.reportId}</TableCell>
                        <TableCell>
                          <Chip
                            label={schedule.frequency}
                            size="small"
                            color={getFrequencyColor(schedule.frequency)}
                          />
                        </TableCell>
                        <TableCell>
                          {schedule.scheduleTime} ({schedule.timezone})
                        </TableCell>
                        <TableCell>
                          <Chip
                            label={schedule.isActive ? 'Active' : 'Paused'}
                            size="small"
                            color={schedule.isActive ? 'success' : 'default'}
                          />
                        </TableCell>
                        <TableCell>
                          {schedule.lastRunAt
                            ? new Date(schedule.lastRunAt).toLocaleString()
                            : 'Never'}
                        </TableCell>
                        <TableCell>
                          {schedule.nextRunAt
                            ? new Date(schedule.nextRunAt).toLocaleString()
                            : 'N/A'}
                        </TableCell>
                        <TableCell>{schedule.recipients.length} recipient(s)</TableCell>
                        <TableCell align="right">
                          <IconButton size="small" onClick={() => handleRunNow(schedule.id)}>
                            <PlayArrow fontSize="small" />
                          </IconButton>
                          <IconButton size="small" onClick={() => handleEdit(schedule)}>
                            <Edit fontSize="small" />
                          </IconButton>
                          <IconButton
                            size="small"
                            onClick={() => handleToggleActive(schedule.id)}
                          >
                            {schedule.isActive ? <Pause fontSize="small" /> : <PlayArrow fontSize="small" />}
                          </IconButton>
                          <IconButton
                            size="small"
                            onClick={() => {
                              loadHistory(schedule.id);
                              // Could open a history dialog here
                            }}
                          >
                            <History fontSize="small" />
                          </IconButton>
                          <IconButton size="small" onClick={() => handleDelete(schedule.id)}>
                            <Delete fontSize="small" />
                          </IconButton>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            )}
          </CardContent>
        </Card>
      )}

      {/* Upcoming Tab */}
      {tabValue === 1 && (
        <Card>
          <CardContent>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              <CalendarMonth sx={{ mr: 1 }} />
              <Typography variant="h6">Next 7 Days</Typography>
            </Box>
            {upcomingSchedules.length === 0 ? (
              <Typography color="textSecondary">No upcoming schedules</Typography>
            ) : (
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell>Schedule</TableCell>
                      <TableCell>Frequency</TableCell>
                      <TableCell>Next Run</TableCell>
                      <TableCell>Recipients</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {upcomingSchedules.map((schedule) => (
                      <TableRow key={schedule.id}>
                        <TableCell>{schedule.reportTemplateId || schedule.reportId}</TableCell>
                        <TableCell>
                          <Chip
                            label={schedule.frequency}
                            size="small"
                            color={getFrequencyColor(schedule.frequency)}
                          />
                        </TableCell>
                        <TableCell>
                          {new Date(schedule.nextRunAt).toLocaleString()}
                        </TableCell>
                        <TableCell>{schedule.recipients?.length || 0} recipient(s)</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            )}
          </CardContent>
        </Card>
      )}

      {/* Create/Edit Dialog */}
      <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>
          {selectedSchedule ? 'Edit Schedule' : 'Create Schedule'}
        </DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Report Template ID"
                value={formData.reportTemplateId}
                onChange={(e) => setFormData({ ...formData, reportTemplateId: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Company ID"
                value={formData.companyId}
                onChange={(e) => setFormData({ ...formData, companyId: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Period ID"
                value={formData.periodId}
                onChange={(e) => setFormData({ ...formData, periodId: e.target.value })}
              />
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth>
                <InputLabel>Frequency</InputLabel>
                <Select
                  value={formData.frequency}
                  onChange={(e) => setFormData({ ...formData, frequency: e.target.value })}
                  label="Frequency"
                >
                  <MenuItem value="DAILY">Daily</MenuItem>
                  <MenuItem value="WEEKLY">Weekly</MenuItem>
                  <MenuItem value="MONTHLY">Monthly</MenuItem>
                  <MenuItem value="QUARTERLY">Quarterly</MenuItem>
                  <MenuItem value="ANNUALLY">Annually</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={4}>
              <TextField
                fullWidth
                label="Schedule Time"
                type="time"
                value={formData.scheduleTime}
                onChange={(e) => setFormData({ ...formData, scheduleTime: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12} md={4}>
              <FormControl fullWidth>
                <InputLabel>Timezone</InputLabel>
                <Select
                  value={formData.timezone}
                  onChange={(e) => setFormData({ ...formData, timezone: e.target.value })}
                  label="Timezone"
                >
                  <MenuItem value="UTC">UTC</MenuItem>
                  <MenuItem value="America/New_York">Eastern</MenuItem>
                  <MenuItem value="America/Chicago">Central</MenuItem>
                  <MenuItem value="America/Denver">Mountain</MenuItem>
                  <MenuItem value="America/Los_Angeles">Pacific</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Recipients (comma-separated emails)"
                value={formData.recipients}
                onChange={(e) => setFormData({ ...formData, recipients: e.target.value })}
                helperText="Enter email addresses separated by commas"
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Email Subject"
                value={formData.emailSubject}
                onChange={(e) => setFormData({ ...formData, emailSubject: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Email Body"
                multiline
                rows={4}
                value={formData.emailBody}
                onChange={(e) => setFormData({ ...formData, emailBody: e.target.value })}
              />
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Switch
                    checked={formData.isActive}
                    onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                  />
                }
                label="Active"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDialogOpen(false)}>Cancel</Button>
          <Button variant="contained" onClick={handleSave}>
            Save
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default ReportScheduler;
