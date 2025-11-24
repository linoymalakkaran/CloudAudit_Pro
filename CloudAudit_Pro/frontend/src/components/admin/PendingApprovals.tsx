import React, { useState, useEffect } from 'react';
import { superAdminApi, ApprovalRequest, TenantUser } from '../../services/api';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  Button,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Alert,
  CircularProgress,
  Avatar,
  Divider,
  List,
  ListItem,
  ListItemAvatar,
  ListItemText,
  ListItemSecondaryAction,
  Tooltip,
  Badge,
  Tab,
  Tabs,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  SelectChangeEvent
} from '@mui/material';
import {
  CheckCircle as CheckCircleIcon,
  Cancel as CancelIcon,
  Visibility as VisibilityIcon,
  Email as EmailIcon,
  Person as PersonIcon,
  Business as BusinessIcon,
  Schedule as ScheduleIcon,
  Warning as WarningIcon,
  Refresh as RefreshIcon,
  FilterList as FilterIcon
} from '@mui/icons-material';

interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

function TabPanel(props: TabPanelProps) {
  const { children, value, index, ...other } = props;
  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`approval-tabpanel-${index}`}
      aria-labelledby={`approval-tab-${index}`}
      {...other}
    >
      {value === index && <Box sx={{ p: 0 }}>{children}</Box>}
    </div>
  );
}

interface PendingApprovalsProps {
  userRole: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
}

export const PendingApprovals: React.FC<PendingApprovalsProps> = ({ userRole }) => {
  const [tabValue, setTabValue] = useState(0);
  const [approvalRequests, setApprovalRequests] = useState<ApprovalRequest[]>([]);
  const [filteredRequests, setFilteredRequests] = useState<ApprovalRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedRequest, setSelectedRequest] = useState<ApprovalRequest | null>(null);
  const [detailsDialogOpen, setDetailsDialogOpen] = useState(false);
  const [approvalDialogOpen, setApprovalDialogOpen] = useState(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState(false);
  const [comments, setComments] = useState('');
  const [filterStatus, setFilterStatus] = useState<string>('PENDING');
  const [filterType, setFilterType] = useState<string>('ALL');

  const isAdmin = userRole === 'ADMIN';

  useEffect(() => {
    fetchApprovalRequests();
  }, []);

  useEffect(() => {
    filterRequests();
  }, [approvalRequests, filterStatus, filterType, tabValue]);

  const fetchApprovalRequests = async () => {
    try {
      setLoading(true);
      const data = await superAdminApi.getApprovalRequests();
      setApprovalRequests(data);
    } catch (error) {
      console.error('Failed to fetch approval requests:', error);
    } finally {
      setLoading(false);
    }
  };

  const filterRequests = () => {
    let filtered = approvalRequests;

    // Filter by tab (status)
    if (tabValue === 0) {
      filtered = filtered.filter(req => req.status === 'PENDING');
    } else if (tabValue === 1) {
      filtered = filtered.filter(req => req.status === 'APPROVED');
    } else if (tabValue === 2) {
      filtered = filtered.filter(req => req.status === 'REJECTED');
    }

    // Filter by type
    if (filterType !== 'ALL') {
      filtered = filtered.filter(req => req.type === filterType);
    }

    setFilteredRequests(filtered);
  };

  const handleTabChange = (event: React.SyntheticEvent, newValue: number) => {
    setTabValue(newValue);
  };

  const handleViewDetails = (request: ApprovalRequest) => {
    setSelectedRequest(request);
    setDetailsDialogOpen(true);
  };

  const handleApprove = (request: ApprovalRequest) => {
    setSelectedRequest(request);
    setComments('');
    setApprovalDialogOpen(true);
  };

  const handleReject = (request: ApprovalRequest) => {
    setSelectedRequest(request);
    setComments('');
    setRejectionDialogOpen(true);
  };

  const confirmApproval = async () => {
    if (!selectedRequest) return;

    try {
      await superAdminApi.approveRequest(selectedRequest.id, comments);
      setApprovalDialogOpen(false);
      fetchApprovalRequests();
    } catch (error) {
      console.error('Failed to approve request:', error);
    }
  };

  const confirmRejection = async () => {
    if (!selectedRequest) return;

    try {
      await superAdminApi.rejectRequest(selectedRequest.id, comments);
      setRejectionDialogOpen(false);
      fetchApprovalRequests();
    } catch (error) {
      console.error('Failed to reject request:', error);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING': return 'warning';
      case 'APPROVED': return 'success';
      case 'REJECTED': return 'error';
      default: return 'default';
    }
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'USER_INVITATION': return <EmailIcon />;
      case 'USER_APPROVAL': return <PersonIcon />;
      default: return <BusinessIcon />;
    }
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const pendingCount = approvalRequests.filter(req => req.status === 'PENDING').length;
  const approvedCount = approvalRequests.filter(req => req.status === 'APPROVED').length;
  const rejectedCount = approvalRequests.filter(req => req.status === 'REJECTED').length;

  if (loading) {
    return (
      <Container maxWidth="lg" sx={{ mt: 4, mb: 4, textAlign: 'center' }}>
        <CircularProgress />
        <Typography sx={{ mt: 2 }}>Loading approval requests...</Typography>
      </Container>
    );
  }

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      {/* Header */}
      <Box sx={{ mb: 4, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Box>
          <Typography variant="h4" component="h1" gutterBottom>
            Pending Approvals
          </Typography>
          <Typography variant="body1" color="text.secondary">
            Review and approve user invitations and requests
          </Typography>
        </Box>
        <Button
          variant="outlined"
          startIcon={<RefreshIcon />}
          onClick={fetchApprovalRequests}
        >
          Refresh
        </Button>
      </Box>

      {/* Summary Cards */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} sm={4}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <Badge badgeContent={pendingCount} color="warning">
                <ScheduleIcon sx={{ fontSize: 40, color: 'warning.main' }} />
              </Badge>
              <Typography variant="h4" color="warning.main" sx={{ mt: 1 }}>
                {pendingCount}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Pending Reviews
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={4}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <CheckCircleIcon sx={{ fontSize: 40, color: 'success.main' }} />
              <Typography variant="h4" color="success.main" sx={{ mt: 1 }}>
                {approvedCount}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Approved
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={4}>
          <Card>
            <CardContent sx={{ textAlign: 'center' }}>
              <CancelIcon sx={{ fontSize: 40, color: 'error.main' }} />
              <Typography variant="h4" color="error.main" sx={{ mt: 1 }}>
                {rejectedCount}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Rejected
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Filters */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Grid container spacing={2} alignItems="center">
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Request Type</InputLabel>
                <Select
                  value={filterType}
                  onChange={(e: SelectChangeEvent) => setFilterType(e.target.value)}
                  label="Request Type"
                >
                  <MenuItem value="ALL">All Types</MenuItem>
                  <MenuItem value="USER_INVITATION">User Invitations</MenuItem>
                  <MenuItem value="USER_APPROVAL">User Approvals</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <Typography variant="body2" color="text.secondary">
                Total requests: {filteredRequests.length}
              </Typography>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Tabs */}
      <Card>
        <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tabs value={tabValue} onChange={handleTabChange}>
            <Tab 
              label={
                <Badge badgeContent={pendingCount} color="warning">
                  Pending ({pendingCount})
                </Badge>
              } 
            />
            <Tab label={`Approved (${approvedCount})`} />
            <Tab label={`Rejected (${rejectedCount})`} />
          </Tabs>
        </Box>

        <TabPanel value={tabValue} index={0}>
          {/* Pending Requests */}
          {filteredRequests.length === 0 ? (
            <Box sx={{ p: 4, textAlign: 'center' }}>
              <CheckCircleIcon sx={{ fontSize: 60, color: 'success.main', mb: 2 }} />
              <Typography variant="h6" gutterBottom>
                No Pending Requests
              </Typography>
              <Typography variant="body2" color="text.secondary">
                All approval requests have been reviewed.
              </Typography>
            </Box>
          ) : (
            <List>
              {filteredRequests.map((request, index) => (
                <React.Fragment key={request.id}>
                  <ListItem alignItems="flex-start" sx={{ py: 2 }}>
                    <ListItemAvatar>
                      <Avatar sx={{ bgcolor: 'warning.main' }}>
                        {getTypeIcon(request.type)}
                      </Avatar>
                    </ListItemAvatar>
                    <ListItemText
                      primary={
                        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                          <Typography variant="subtitle1">
                            {request.requestData.firstName} {request.requestData.lastName}
                          </Typography>
                          <Chip 
                            label={request.type.replace('_', ' ')} 
                            size="small" 
                            color="primary" 
                          />
                          <Chip 
                            label={request.requestData.role.replace('_', ' ')} 
                            size="small" 
                            variant="outlined" 
                          />
                        </Box>
                      }
                      secondary={
                        <Box sx={{ mt: 1 }}>
                          <Typography variant="body2" color="text.secondary">
                            <strong>Email:</strong> {request.requestData.email}
                          </Typography>
                          {request.requestData.jobTitle && (
                            <Typography variant="body2" color="text.secondary">
                              <strong>Position:</strong> {request.requestData.jobTitle} - {request.requestData.department}
                            </Typography>
                          )}
                          <Typography variant="body2" color="text.secondary">
                            <strong>Submitted:</strong> {formatDate(request.submittedAt)} by {request.submittedBy}
                          </Typography>
                          {request.tenantUser && (
                            <Typography variant="body2" color="text.secondary">
                              <strong>Tenant ID:</strong> {request.tenantUser.tenantId}
                            </Typography>
                          )}
                        </Box>
                      }
                    />
                    <ListItemSecondaryAction>
                      <Box sx={{ display: 'flex', gap: 1 }}>
                        <Tooltip title="View Details">
                          <IconButton onClick={() => handleViewDetails(request)}>
                            <VisibilityIcon />
                          </IconButton>
                        </Tooltip>
                        {isAdmin && (
                          <>
                            <Button
                              variant="contained"
                              color="success"
                              size="small"
                              onClick={() => handleApprove(request)}
                            >
                              Approve
                            </Button>
                            <Button
                              variant="outlined"
                              color="error"
                              size="small"
                              onClick={() => handleReject(request)}
                            >
                              Reject
                            </Button>
                          </>
                        )}
                      </Box>
                    </ListItemSecondaryAction>
                  </ListItem>
                  {index < filteredRequests.length - 1 && <Divider />}
                </React.Fragment>
              ))}
            </List>
          )}
        </TabPanel>

        <TabPanel value={tabValue} index={1}>
          {/* Approved Requests */}
          {filteredRequests.length === 0 ? (
            <Box sx={{ p: 4, textAlign: 'center' }}>
              <Typography variant="h6" gutterBottom>
                No Approved Requests
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Approved requests will appear here.
              </Typography>
            </Box>
          ) : (
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>User</TableCell>
                    <TableCell>Type</TableCell>
                    <TableCell>Role</TableCell>
                    <TableCell>Approved By</TableCell>
                    <TableCell>Date</TableCell>
                    <TableCell>Actions</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {filteredRequests.map((request) => (
                    <TableRow key={request.id}>
                      <TableCell>
                        <Box>
                          <Typography variant="body2" sx={{ fontWeight: 'medium' }}>
                            {request.requestData.firstName} {request.requestData.lastName}
                          </Typography>
                          <Typography variant="caption" color="text.secondary">
                            {request.requestData.email}
                          </Typography>
                        </Box>
                      </TableCell>
                      <TableCell>
                        <Chip 
                          label={request.type.replace('_', ' ')} 
                          size="small" 
                          color="primary" 
                        />
                      </TableCell>
                      <TableCell>
                        <Chip 
                          label={request.requestData.role.replace('_', ' ')} 
                          size="small" 
                          variant="outlined" 
                        />
                      </TableCell>
                      <TableCell>
                        <Typography variant="body2">
                          {request.reviewedBy || 'System'}
                        </Typography>
                      </TableCell>
                      <TableCell>
                        <Typography variant="body2">
                          {formatDate(request.reviewedAt || request.submittedAt)}
                        </Typography>
                      </TableCell>
                      <TableCell>
                        <IconButton onClick={() => handleViewDetails(request)}>
                          <VisibilityIcon />
                        </IconButton>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          )}
        </TabPanel>

        <TabPanel value={tabValue} index={2}>
          {/* Rejected Requests */}
          {filteredRequests.length === 0 ? (
            <Box sx={{ p: 4, textAlign: 'center' }}>
              <Typography variant="h6" gutterBottom>
                No Rejected Requests
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Rejected requests will appear here.
              </Typography>
            </Box>
          ) : (
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>User</TableCell>
                    <TableCell>Type</TableCell>
                    <TableCell>Role</TableCell>
                    <TableCell>Rejected By</TableCell>
                    <TableCell>Date</TableCell>
                    <TableCell>Actions</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {filteredRequests.map((request) => (
                    <TableRow key={request.id}>
                      <TableCell>
                        <Box>
                          <Typography variant="body2" sx={{ fontWeight: 'medium' }}>
                            {request.requestData.firstName} {request.requestData.lastName}
                          </Typography>
                          <Typography variant="caption" color="text.secondary">
                            {request.requestData.email}
                          </Typography>
                        </Box>
                      </TableCell>
                      <TableCell>
                        <Chip 
                          label={request.type.replace('_', ' ')} 
                          size="small" 
                          color="primary" 
                        />
                      </TableCell>
                      <TableCell>
                        <Chip 
                          label={request.requestData.role.replace('_', ' ')} 
                          size="small" 
                          variant="outlined" 
                        />
                      </TableCell>
                      <TableCell>
                        <Typography variant="body2">
                          {request.reviewedBy || 'System'}
                        </Typography>
                      </TableCell>
                      <TableCell>
                        <Typography variant="body2">
                          {formatDate(request.reviewedAt || request.submittedAt)}
                        </Typography>
                      </TableCell>
                      <TableCell>
                        <IconButton onClick={() => handleViewDetails(request)}>
                          <VisibilityIcon />
                        </IconButton>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          )}
        </TabPanel>
      </Card>

      {/* Details Dialog */}
      <Dialog open={detailsDialogOpen} onClose={() => setDetailsDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>Request Details</DialogTitle>
        <DialogContent>
          {selectedRequest && (
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <Typography variant="h6" gutterBottom>
                  User Information
                </Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Name</Typography>
                <Typography>{selectedRequest.requestData.firstName} {selectedRequest.requestData.lastName}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Email</Typography>
                <Typography>{selectedRequest.requestData.email}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Role</Typography>
                <Typography>{selectedRequest.requestData.role.replace('_', ' ')}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Job Title</Typography>
                <Typography>{selectedRequest.requestData.jobTitle || 'Not specified'}</Typography>
              </Grid>
              <Grid item xs={12}>
                <Divider sx={{ my: 2 }} />
                <Typography variant="h6" gutterBottom>
                  Request Information
                </Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Type</Typography>
                <Chip label={selectedRequest.type.replace('_', ' ')} size="small" color="primary" />
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Status</Typography>
                <Chip 
                  label={selectedRequest.status} 
                  size="small" 
                  color={getStatusColor(selectedRequest.status) as any} 
                />
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Submitted By</Typography>
                <Typography>{selectedRequest.submittedBy}</Typography>
              </Grid>
              <Grid item xs={6}>
                <Typography variant="body2" color="text.secondary">Submitted At</Typography>
                <Typography>{formatDate(selectedRequest.submittedAt)}</Typography>
              </Grid>
              {selectedRequest.reviewedBy && (
                <>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">Reviewed By</Typography>
                    <Typography>{selectedRequest.reviewedBy}</Typography>
                  </Grid>
                  <Grid item xs={6}>
                    <Typography variant="body2" color="text.secondary">Reviewed At</Typography>
                    <Typography>{formatDate(selectedRequest.reviewedAt!)}</Typography>
                  </Grid>
                </>
              )}
              {selectedRequest.reviewComments && (
                <Grid item xs={12}>
                  <Typography variant="body2" color="text.secondary">Review Comments</Typography>
                  <Typography>{selectedRequest.reviewComments}</Typography>
                </Grid>
              )}
            </Grid>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDetailsDialogOpen(false)}>Close</Button>
        </DialogActions>
      </Dialog>

      {/* Approval Dialog */}
      <Dialog open={approvalDialogOpen} onClose={() => setApprovalDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Approve Request</DialogTitle>
        <DialogContent>
          <Typography gutterBottom>
            Are you sure you want to approve this request?
          </Typography>
          <TextField
            fullWidth
            multiline
            rows={3}
            label="Comments (Optional)"
            value={comments}
            onChange={(e) => setComments(e.target.value)}
            sx={{ mt: 2 }}
            placeholder="Add any comments about this approval..."
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setApprovalDialogOpen(false)}>Cancel</Button>
          <Button onClick={confirmApproval} variant="contained" color="success">
            Approve
          </Button>
        </DialogActions>
      </Dialog>

      {/* Rejection Dialog */}
      <Dialog open={rejectionDialogOpen} onClose={() => setRejectionDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Reject Request</DialogTitle>
        <DialogContent>
          <Alert severity="warning" sx={{ mb: 2 }}>
            This action will reject the user request. Please provide a reason.
          </Alert>
          <TextField
            fullWidth
            multiline
            rows={3}
            label="Rejection Reason"
            value={comments}
            onChange={(e) => setComments(e.target.value)}
            required
            placeholder="Please provide a reason for rejection..."
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setRejectionDialogOpen(false)}>Cancel</Button>
          <Button 
            onClick={confirmRejection} 
            variant="contained" 
            color="error"
            disabled={!comments.trim()}
          >
            Reject
          </Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
};