import React, { useState } from 'react';
import { userManagementApi, InviteUserDto } from '../../services/api';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  TextField,
  Button,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  SelectChangeEvent,
  Alert,
  Stepper,
  Step,
  StepLabel,
  Paper,
  Chip,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  CircularProgress,
  Autocomplete,
  Switch,
  FormControlLabel,
  Divider
} from '@mui/material';
import {
  PersonAdd as PersonAddIcon,
  Email as EmailIcon,
  Delete as DeleteIcon,
  Preview as PreviewIcon,
  Send as SendIcon,
  CheckCircle as CheckCircleIcon,
  Cancel as CancelIcon
} from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

interface InviteUserForm {
  firstName: string;
  lastName: string;
  email: string;
  role: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
  jobTitle: string;
  department: string;
  phoneNumber: string;
  sendInviteEmail: boolean;
  requirePasswordChange: boolean;
  customMessage: string;
}

interface BatchInvite {
  users: InviteUserForm[];
  currentStep: number;
}

interface InviteUserProps {
  userRole: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
}

const steps = ['User Details', 'Review & Confirm', 'Send Invitations'];

const roleHierarchy = {
  ADMIN: ['MANAGER', 'SENIOR_AUDITOR', 'AUDITOR', 'INTERN'],
  MANAGER: ['SENIOR_AUDITOR', 'AUDITOR', 'INTERN'],
  SENIOR_AUDITOR: ['AUDITOR', 'INTERN'],
  AUDITOR: ['INTERN'],
  INTERN: []
};

const departments = [
  'Internal Audit',
  'External Audit',
  'Financial Audit',
  'Operational Audit',
  'IT Audit',
  'Compliance',
  'Risk Management',
  'Quality Assurance',
  'Administration',
  'Other'
];

export const InviteUser: React.FC<InviteUserProps> = ({ userRole }) => {
  const [activeStep, setActiveStep] = useState(0);
  const [loading, setLoading] = useState(false);
  const [isBatchMode, setIsBatchMode] = useState(false);
  const [previewDialogOpen, setPreviewDialogOpen] = useState(false);
  const [successDialogOpen, setSuccessDialogOpen] = useState(false);
  const [invitedUsers, setInvitedUsers] = useState<string[]>([]);
  
  const [singleUser, setSingleUser] = useState<InviteUserForm>({
    firstName: '',
    lastName: '',
    email: '',
    role: 'AUDITOR',
    jobTitle: '',
    department: '',
    phoneNumber: '',
    sendInviteEmail: true,
    requirePasswordChange: true,
    customMessage: ''
  });

  const [batchInvite, setBatchInvite] = useState<BatchInvite>({
    users: [],
    currentStep: 0
  });

  const navigate = useNavigate();
  const isAdmin = userRole === 'ADMIN';
  const isManagerOrAdmin = ['ADMIN', 'MANAGER'].includes(userRole);

  const availableRoles = isAdmin 
    ? roleHierarchy.ADMIN 
    : roleHierarchy[userRole] || [];

  const validateEmail = (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  };

  const validateForm = (user: InviteUserForm): string[] => {
    const errors: string[] = [];
    
    if (!user.firstName.trim()) errors.push('First name is required');
    if (!user.lastName.trim()) errors.push('Last name is required');
    if (!user.email.trim()) errors.push('Email is required');
    else if (!validateEmail(user.email)) errors.push('Valid email is required');
    if (!user.role) errors.push('Role is required');
    
    return errors;
  };

  const handleSingleUserChange = (field: keyof InviteUserForm, value: any) => {
    setSingleUser(prev => ({ ...prev, [field]: value }));
  };

  const addUserToBatch = () => {
    const errors = validateForm(singleUser);
    if (errors.length > 0) {
      alert(errors.join(', '));
      return;
    }

    setBatchInvite(prev => ({
      ...prev,
      users: [...prev.users, { ...singleUser }]
    }));

    // Reset form
    setSingleUser({
      firstName: '',
      lastName: '',
      email: '',
      role: 'AUDITOR',
      jobTitle: '',
      department: '',
      phoneNumber: '',
      sendInviteEmail: true,
      requirePasswordChange: true,
      customMessage: ''
    });
  };

  const removeUserFromBatch = (index: number) => {
    setBatchInvite(prev => ({
      ...prev,
      users: prev.users.filter((_, i) => i !== index)
    }));
  };

  const handleNext = () => {
    if (!isBatchMode) {
      const errors = validateForm(singleUser);
      if (errors.length > 0) {
        alert(errors.join(', '));
        return;
      }
    } else if (batchInvite.users.length === 0) {
      alert('Please add at least one user to the batch');
      return;
    }

    setActiveStep(prev => prev + 1);
  };

  const handleBack = () => {
    setActiveStep(prev => prev - 1);
  };

  const handleSubmit = async () => {
    setLoading(true);
    try {
      const usersToInvite = isBatchMode ? batchInvite.users : [singleUser];
      
      if (isBatchMode && usersToInvite.length > 1) {
        await userManagementApi.inviteMultipleUsers(usersToInvite as InviteUserDto[]);
      } else {
        for (const user of usersToInvite) {
          await userManagementApi.inviteUser(user as InviteUserDto);
        }
      }

      setInvitedUsers(usersToInvite.map(u => `${u.firstName} ${u.lastName}`));
      setSuccessDialogOpen(true);
      setActiveStep(0);
      
      // Reset forms
      setSingleUser({
        firstName: '',
        lastName: '',
        email: '',
        role: 'AUDITOR',
        jobTitle: '',
        department: '',
        phoneNumber: '',
        sendInviteEmail: true,
        requirePasswordChange: true,
        customMessage: ''
      });
      setBatchInvite({ users: [], currentStep: 0 });
      
    } catch (error) {
      console.error('Failed to send invitations:', error);
    } finally {
      setLoading(false);
    }
  };

  const renderUserForm = (user: InviteUserForm, onChange: (field: keyof InviteUserForm, value: any) => void) => (
    <Grid container spacing={3}>
      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="First Name"
          value={user.firstName}
          onChange={(e) => onChange('firstName', e.target.value)}
          required
        />
      </Grid>
      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="Last Name"
          value={user.lastName}
          onChange={(e) => onChange('lastName', e.target.value)}
          required
        />
      </Grid>
      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="Email Address"
          type="email"
          value={user.email}
          onChange={(e) => onChange('email', e.target.value)}
          required
        />
      </Grid>
      <Grid item xs={12} md={6}>
        <FormControl fullWidth required>
          <InputLabel>Role</InputLabel>
          <Select
            value={user.role}
            onChange={(e: SelectChangeEvent) => onChange('role', e.target.value)}
            label="Role"
          >
            {availableRoles.map(role => (
              <MenuItem key={role} value={role}>
                {role.replace('_', ' ').toLowerCase().replace(/\b\w/g, l => l.toUpperCase())}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </Grid>
      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="Job Title"
          value={user.jobTitle}
          onChange={(e) => onChange('jobTitle', e.target.value)}
        />
      </Grid>
      <Grid item xs={12} md={6}>
        <Autocomplete
          fullWidth
          options={departments}
          value={user.department}
          onChange={(_, newValue) => onChange('department', newValue || '')}
          renderInput={(params) => (
            <TextField {...params} label="Department" />
          )}
        />
      </Grid>
      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="Phone Number"
          value={user.phoneNumber}
          onChange={(e) => onChange('phoneNumber', e.target.value)}
          placeholder="+1-234-567-8900"
        />
      </Grid>
      <Grid item xs={12}>
        <TextField
          fullWidth
          multiline
          rows={3}
          label="Custom Welcome Message (Optional)"
          value={user.customMessage}
          onChange={(e) => onChange('customMessage', e.target.value)}
          placeholder="Add a personal welcome message for the new user..."
        />
      </Grid>
      <Grid item xs={12}>
        <Box sx={{ display: 'flex', flexDirection: 'column', gap: 1 }}>
          <FormControlLabel
            control={
              <Switch
                checked={user.sendInviteEmail}
                onChange={(e) => onChange('sendInviteEmail', e.target.checked)}
              />
            }
            label="Send invitation email immediately"
          />
          <FormControlLabel
            control={
              <Switch
                checked={user.requirePasswordChange}
                onChange={(e) => onChange('requirePasswordChange', e.target.checked)}
              />
            }
            label="Require password change on first login"
          />
        </Box>
      </Grid>
    </Grid>
  );

  const renderStepContent = (step: number) => {
    switch (step) {
      case 0:
        return (
          <Box>
            {/* Mode Toggle */}
            <Card sx={{ mb: 3 }}>
              <CardContent>
                <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
                  <Typography variant="h6">Invitation Mode</Typography>
                  <FormControlLabel
                    control={
                      <Switch
                        checked={isBatchMode}
                        onChange={(e) => setIsBatchMode(e.target.checked)}
                      />
                    }
                    label="Batch Mode"
                  />
                </Box>
                <Typography variant="body2" color="text.secondary">
                  {isBatchMode 
                    ? 'Invite multiple users at once. Add users to the batch and send all invitations together.'
                    : 'Invite a single user. Fill out the form below and send the invitation.'
                  }
                </Typography>
              </CardContent>
            </Card>

            {/* User Form */}
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom>
                  {isBatchMode ? 'Add User to Batch' : 'User Information'}
                </Typography>
                {renderUserForm(singleUser, handleSingleUserChange)}
                
                {isBatchMode && (
                  <Box sx={{ mt: 3 }}>
                    <Button
                      variant="outlined"
                      startIcon={<PersonAddIcon />}
                      onClick={addUserToBatch}
                      fullWidth
                    >
                      Add to Batch
                    </Button>
                  </Box>
                )}
              </CardContent>
            </Card>

            {/* Batch List */}
            {isBatchMode && batchInvite.users.length > 0 && (
              <Card sx={{ mt: 3 }}>
                <CardContent>
                  <Typography variant="h6" gutterBottom>
                    Users in Batch ({batchInvite.users.length})
                  </Typography>
                  <List>
                    {batchInvite.users.map((user, index) => (
                      <ListItem key={index} divider>
                        <ListItemText
                          primary={`${user.firstName} ${user.lastName}`}
                          secondary={
                            <Box>
                              <Typography variant="body2" color="text.secondary">
                                {user.email} • {user.role.replace('_', ' ')}
                              </Typography>
                              {user.jobTitle && (
                                <Typography variant="caption" color="text.secondary">
                                  {user.jobTitle} - {user.department}
                                </Typography>
                              )}
                            </Box>
                          }
                        />
                        <ListItemSecondaryAction>
                          <IconButton
                            onClick={() => removeUserFromBatch(index)}
                            color="error"
                          >
                            <DeleteIcon />
                          </IconButton>
                        </ListItemSecondaryAction>
                      </ListItem>
                    ))}
                  </List>
                </CardContent>
              </Card>
            )}
          </Box>
        );

      case 1:
        const usersToReview = isBatchMode ? batchInvite.users : [singleUser];
        return (
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Review Invitations
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
                Please review the invitation details before sending.
              </Typography>
              
              {usersToReview.map((user, index) => (
                <Paper key={index} sx={{ p: 2, mb: 2 }}>
                  <Grid container spacing={2}>
                    <Grid item xs={12} md={6}>
                      <Typography variant="subtitle2">Name</Typography>
                      <Typography>{user.firstName} {user.lastName}</Typography>
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <Typography variant="subtitle2">Email</Typography>
                      <Typography>{user.email}</Typography>
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <Typography variant="subtitle2">Role</Typography>
                      <Chip 
                        label={user.role.replace('_', ' ')} 
                        size="small" 
                        color="primary" 
                      />
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <Typography variant="subtitle2">Department</Typography>
                      <Typography>{user.department || 'Not specified'}</Typography>
                    </Grid>
                    {user.jobTitle && (
                      <Grid item xs={12} md={6}>
                        <Typography variant="subtitle2">Job Title</Typography>
                        <Typography>{user.jobTitle}</Typography>
                      </Grid>
                    )}
                    {user.phoneNumber && (
                      <Grid item xs={12} md={6}>
                        <Typography variant="subtitle2">Phone</Typography>
                        <Typography>{user.phoneNumber}</Typography>
                      </Grid>
                    )}
                    <Grid item xs={12}>
                      <Typography variant="subtitle2">Settings</Typography>
                      <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap' }}>
                        {user.sendInviteEmail && (
                          <Chip label="Send Email" size="small" color="success" />
                        )}
                        {user.requirePasswordChange && (
                          <Chip label="Require Password Change" size="small" color="warning" />
                        )}
                      </Box>
                    </Grid>
                    {user.customMessage && (
                      <Grid item xs={12}>
                        <Typography variant="subtitle2">Custom Message</Typography>
                        <Paper sx={{ p: 1, bgcolor: 'grey.50' }}>
                          <Typography variant="body2">{user.customMessage}</Typography>
                        </Paper>
                      </Grid>
                    )}
                  </Grid>
                </Paper>
              ))}

              <Box sx={{ mt: 3 }}>
                <Button
                  variant="outlined"
                  startIcon={<PreviewIcon />}
                  onClick={() => setPreviewDialogOpen(true)}
                >
                  Preview Email
                </Button>
              </Box>
            </CardContent>
          </Card>
        );

      case 2:
        return (
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <CheckCircleIcon sx={{ fontSize: 60, color: 'success.main', mb: 2 }} />
              <Typography variant="h5" gutterBottom>
                Invitations Sent Successfully!
              </Typography>
              <Typography variant="body1" color="text.secondary" sx={{ mb: 3 }}>
                {isBatchMode ? batchInvite.users.length : 1} invitation{isBatchMode && batchInvite.users.length !== 1 ? 's' : ''} sent successfully.
                Users will receive an email with instructions to set up their account.
              </Typography>
              
              <Box sx={{ display: 'flex', justifyContent: 'center', gap: 2 }}>
                <Button
                  variant="contained"
                  onClick={() => navigate('/admin/users')}
                >
                  View Users
                </Button>
                <Button
                  variant="outlined"
                  onClick={() => {
                    setActiveStep(0);
                    setIsBatchMode(false);
                  }}
                >
                  Invite More Users
                </Button>
              </Box>
            </CardContent>
          </Card>
        );

      default:
        return null;
    }
  };

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      {/* Header */}
      <Box sx={{ mb: 4 }}>
        <Typography variant="h4" component="h1" gutterBottom>
          Invite Users
        </Typography>
        <Typography variant="body1" color="text.secondary">
          Add new team members to your organization
        </Typography>
      </Box>

      {/* Progress Stepper */}
      <Card sx={{ mb: 4 }}>
        <CardContent>
          <Stepper activeStep={activeStep} alternativeLabel>
            {steps.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>
        </CardContent>
      </Card>

      {/* Step Content */}
      {renderStepContent(activeStep)}

      {/* Navigation Buttons */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 4 }}>
        <Button
          onClick={() => navigate('/admin/users')}
          variant="outlined"
          startIcon={<CancelIcon />}
        >
          Cancel
        </Button>

        <Box sx={{ display: 'flex', gap: 2 }}>
          {activeStep > 0 && (
            <Button onClick={handleBack}>
              Back
            </Button>
          )}
          
          {activeStep < steps.length - 1 ? (
            <Button
              variant="contained"
              onClick={handleNext}
              disabled={loading}
            >
              {activeStep === 1 ? 'Send Invitations' : 'Next'}
            </Button>
          ) : activeStep === 1 ? (
            <Button
              variant="contained"
              onClick={handleSubmit}
              disabled={loading}
              startIcon={loading ? <CircularProgress size={20} /> : <SendIcon />}
            >
              {loading ? 'Sending...' : 'Send Invitations'}
            </Button>
          ) : null}
        </Box>
      </Box>

      {/* Email Preview Dialog */}
      <Dialog open={previewDialogOpen} onClose={() => setPreviewDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>Email Preview</DialogTitle>
        <DialogContent>
          <Paper sx={{ p: 3, bgcolor: 'grey.50' }}>
            <Typography variant="h6" gutterBottom>
              Welcome to CloudAudit Pro!
            </Typography>
            <Typography paragraph>
              Hi {singleUser.firstName},
            </Typography>
            <Typography paragraph>
              You've been invited to join CloudAudit Pro as a {singleUser.role.replace('_', ' ').toLowerCase()}.
              Please click the link below to set up your account and get started.
            </Typography>
            {singleUser.customMessage && (
              <Box sx={{ p: 2, bgcolor: 'primary.light', borderRadius: 1, mb: 2 }}>
                <Typography variant="body2" sx={{ fontStyle: 'italic' }}>
                  "{singleUser.customMessage}"
                </Typography>
              </Box>
            )}
            <Typography paragraph>
              Click here to accept your invitation: <strong>[INVITATION LINK]</strong>
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Best regards,<br />
              The CloudAudit Pro Team
            </Typography>
          </Paper>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setPreviewDialogOpen(false)}>Close</Button>
        </DialogActions>
      </Dialog>

      {/* Success Dialog */}
      <Dialog open={successDialogOpen} onClose={() => setSuccessDialogOpen(false)}>
        <DialogTitle>Invitations Sent!</DialogTitle>
        <DialogContent>
          <Typography gutterBottom>
            The following users have been successfully invited:
          </Typography>
          <List>
            {invitedUsers.map((user, index) => (
              <ListItem key={index}>
                <ListItemText primary={user} />
                <CheckCircleIcon color="success" />
              </ListItem>
            ))}
          </List>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setSuccessDialogOpen(false)}>Close</Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
};