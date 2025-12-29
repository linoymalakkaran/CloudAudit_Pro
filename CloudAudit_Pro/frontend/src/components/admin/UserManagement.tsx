import React, { useState, useEffect } from 'react';
import { userManagementApi, TenantUser, UpdateUserDto, BulkUserActionDto } from '../../services/api';
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
  Menu,
  MenuItem,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  SelectChangeEvent,
  Alert,
  CircularProgress,
  Tooltip,
  TablePagination,
  Avatar,
  ListItemIcon,
  ListItemText,
  Divider,
  Badge
} from '@mui/material';
import {
  MoreVert as MoreVertIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  PersonAdd as PersonAddIcon,
  Email as EmailIcon,
  Block as BlockIcon,
  CheckCircle as CheckCircleIcon,
  Refresh as RefreshIcon,
  FilterList as FilterIcon,
  Search as SearchIcon,
  GetApp as GetAppIcon,
  VpnKey as VpnKeyIcon
} from '@mui/icons-material';
import { useNavigate, useLocation } from 'react-router-dom';

interface UserManagementProps {
  userRole: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
}

export const UserManagement: React.FC<UserManagementProps> = ({ userRole }) => {
  const [users, setUsers] = useState<TenantUser[]>([]);
  const [filteredUsers, setFilteredUsers] = useState<TenantUser[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('ALL');
  const [roleFilter, setRoleFilter] = useState<string>('ALL');
  const [selectedUsers, setSelectedUsers] = useState<string[]>([]);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [menuAnchor, setMenuAnchor] = useState<null | HTMLElement>(null);
  const [selectedUser, setSelectedUser] = useState<TenantUser | null>(null);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [bulkActionDialogOpen, setBulkActionDialogOpen] = useState(false);
  const [editForm, setEditForm] = useState({
    firstName: '',
    lastName: '',
    email: '',
    role: 'AUDITOR',
    jobTitle: '',
    department: '',
    phoneNumber: ''
  });

  const navigate = useNavigate();
  const location = useLocation();
  const isAdmin = userRole === 'ADMIN';
  const isManagerOrAdmin = ['ADMIN', 'MANAGER'].includes(userRole);

  useEffect(() => {
    fetchUsers();
  }, []);

  // Check if navigation state indicates we should refresh
  useEffect(() => {
    if (location.state && (location.state as any).refresh) {
      fetchUsers();
      // Clear the state to prevent repeated refreshes
      window.history.replaceState({}, document.title);
    }
  }, [location]);

  useEffect(() => {
    // Refresh users when window regains focus (e.g., navigating back from invite page)
    const handleFocus = () => {
      fetchUsers();
    };
    
    window.addEventListener('focus', handleFocus);
    return () => window.removeEventListener('focus', handleFocus);
  }, []);

  useEffect(() => {
    filterUsers();
  }, [users, searchTerm, statusFilter, roleFilter]);

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const data = await userManagementApi.getUsers();
      setUsers(data);
    } catch (error) {
      console.error('Failed to fetch users:', error);
    } finally {
      setLoading(false);
    }
  };

  const filterUsers = () => {
    let filtered = users.filter(user => !user.isDeleted);

    if (searchTerm) {
      filtered = filtered.filter(user => 
        user.firstName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.lastName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
        (user.jobTitle && user.jobTitle.toLowerCase().includes(searchTerm.toLowerCase())) ||
        (user.department && user.department.toLowerCase().includes(searchTerm.toLowerCase()))
      );
    }

    if (statusFilter !== 'ALL') {
      filtered = filtered.filter(user => user.status === statusFilter);
    }

    if (roleFilter !== 'ALL') {
      filtered = filtered.filter(user => user.role === roleFilter);
    }

    setFilteredUsers(filtered);
  };

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>, user: TenantUser) => {
    setMenuAnchor(event.currentTarget);
    setSelectedUser(user);
  };

  const handleMenuClose = () => {
    setMenuAnchor(null);
    setSelectedUser(null);
  };

  const handleEditUser = () => {
    if (selectedUser) {
      setEditForm({
        firstName: selectedUser.firstName,
        lastName: selectedUser.lastName,
        email: selectedUser.email,
        role: selectedUser.role,
        jobTitle: selectedUser.jobTitle || '',
        department: selectedUser.department || '',
        phoneNumber: selectedUser.phoneNumber || ''
      });
      setEditDialogOpen(true);
    }
    handleMenuClose();
  };

  const handleDeleteUser = () => {
    setDeleteDialogOpen(true);
    handleMenuClose();
  };

  const handleResetPassword = async () => {
    if (selectedUser) {
      try {
        await userManagementApi.resetPassword(selectedUser.id, { requirePasswordChange: true });
        fetchUsers(); // Refresh data
      } catch (error) {
        console.error('Failed to reset password:', error);
      }
    }
    handleMenuClose();
  };

  const handleToggleUserStatus = async () => {
    if (selectedUser) {
      try {
        const newStatus = selectedUser.status === 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';
        await userManagementApi.updateUser(selectedUser.id, { status: newStatus });
        fetchUsers(); // Refresh data
      } catch (error) {
        console.error('Failed to toggle user status:', error);
      }
    }
    handleMenuClose();
  };

  const handleSaveEdit = async () => {
    if (selectedUser) {
      try {
        await userManagementApi.updateUser(selectedUser.id, editForm as UpdateUserDto);
        setEditDialogOpen(false);
        fetchUsers(); // Refresh data
      } catch (error) {
        console.error('Failed to update user:', error);
      }
    }
  };

  const handleConfirmDelete = async () => {
    if (selectedUser) {
      try {
        await userManagementApi.deleteUser(selectedUser.id);
        setDeleteDialogOpen(false);
        fetchUsers(); // Refresh data
      } catch (error) {
        console.error('Failed to delete user:', error);
      }
    }
  };

  const handleBulkAction = async (action: BulkUserActionDto['action']) => {
    if (selectedUsers.length === 0) return;

    try {
      await userManagementApi.bulkAction({ action, userIds: selectedUsers });
      setSelectedUsers([]);
      setBulkActionDialogOpen(false);
      fetchUsers(); // Refresh data
    } catch (error) {
      console.error('Failed to perform bulk action:', error);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE': return 'success';
      case 'INACTIVE': return 'default';
      case 'INVITED': return 'info';
      case 'APPROVAL_PENDING': return 'warning';
      default: return 'default';
    }
  };

  const getRoleColor = (role: string) => {
    switch (role) {
      case 'ADMIN': return 'error';
      case 'MANAGER': return 'warning';
      case 'SENIOR_AUDITOR': return 'info';
      case 'AUDITOR': return 'primary';
      case 'INTERN': return 'default';
      default: return 'default';
    }
  };

  const formatDate = (dateString?: string) => {
    if (!dateString) return 'Never';
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const handleSelectUser = (userId: string) => {
    setSelectedUsers(prev => 
      prev.includes(userId) 
        ? prev.filter(id => id !== userId)
        : [...prev, userId]
    );
  };

  const handleSelectAll = () => {
    const currentPageUserIds = filteredUsers
      .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
      .map(user => user.id);
    
    if (currentPageUserIds.every(id => selectedUsers.includes(id))) {
      setSelectedUsers(prev => prev.filter(id => !currentPageUserIds.includes(id)));
    } else {
      setSelectedUsers(prev => [...new Set([...prev, ...currentPageUserIds])]);
    }
  };

  if (loading) {
    return (
      <Container maxWidth="lg" sx={{ mt: 4, mb: 4, textAlign: 'center' }}>
        <CircularProgress />
        <Typography sx={{ mt: 2 }}>Loading users...</Typography>
      </Container>
    );
  }

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      {/* Header */}
      <Box sx={{ mb: 4, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Box>
          <Typography variant="h4" component="h1" gutterBottom>
            User Management
          </Typography>
          <Typography variant="body1" color="text.secondary">
            Manage team members, roles, and permissions
          </Typography>
        </Box>
        {isManagerOrAdmin && (
          <Button
            variant="contained"
            startIcon={<PersonAddIcon />}
            onClick={() => navigate('/admin/users/invite')}
          >
            Invite User
          </Button>
        )}
      </Box>

      {/* Filters and Search */}
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <Grid container spacing={3} alignItems="center">
            <Grid item xs={12} md={4}>
              <TextField
                fullWidth
                placeholder="Search users..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                InputProps={{
                  startAdornment: <SearchIcon sx={{ mr: 1, color: 'action.active' }} />
                }}
              />
            </Grid>
            <Grid item xs={12} md={3}>
              <FormControl fullWidth>
                <InputLabel>Status</InputLabel>
                <Select
                  value={statusFilter}
                  onChange={(e: SelectChangeEvent) => setStatusFilter(e.target.value)}
                  label="Status"
                >
                  <MenuItem value="ALL">All Statuses</MenuItem>
                  <MenuItem value="ACTIVE">Active</MenuItem>
                  <MenuItem value="INACTIVE">Inactive</MenuItem>
                  <MenuItem value="INVITED">Invited</MenuItem>
                  <MenuItem value="APPROVAL_PENDING">Pending Approval</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={3}>
              <FormControl fullWidth>
                <InputLabel>Role</InputLabel>
                <Select
                  value={roleFilter}
                  onChange={(e: SelectChangeEvent) => setRoleFilter(e.target.value)}
                  label="Role"
                >
                  <MenuItem value="ALL">All Roles</MenuItem>
                  <MenuItem value="ADMIN">Admin</MenuItem>
                  <MenuItem value="MANAGER">Manager</MenuItem>
                  <MenuItem value="SENIOR_AUDITOR">Senior Auditor</MenuItem>
                  <MenuItem value="AUDITOR">Auditor</MenuItem>
                  <MenuItem value="INTERN">Intern</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={2}>
              <Box sx={{ display: 'flex', gap: 1 }}>
                <Tooltip title="Refresh">
                  <IconButton onClick={fetchUsers}>
                    <RefreshIcon />
                  </IconButton>
                </Tooltip>
                <Tooltip title="Export">
                  <IconButton>
                    <GetAppIcon />
                  </IconButton>
                </Tooltip>
              </Box>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Bulk Actions */}
      {selectedUsers.length > 0 && (
        <Alert severity="info" sx={{ mb: 2 }}>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <Typography>
              {selectedUsers.length} user{selectedUsers.length !== 1 ? 's' : ''} selected
            </Typography>
            <Box sx={{ display: 'flex', gap: 1 }}>
              <Button
                size="small"
                onClick={() => setBulkActionDialogOpen(true)}
                disabled={!isManagerOrAdmin}
              >
                Bulk Actions
              </Button>
              <Button
                size="small"
                onClick={() => setSelectedUsers([])}
              >
                Clear Selection
              </Button>
            </Box>
          </Box>
        </Alert>
      )}

      {/* Users Table */}
      <Card>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell padding="checkbox">
                  <input
                    type="checkbox"
                    onChange={handleSelectAll}
                    checked={
                      filteredUsers.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                        .every(user => selectedUsers.includes(user.id)) &&
                      filteredUsers.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage).length > 0
                    }
                    disabled={!isManagerOrAdmin}
                  />
                </TableCell>
                <TableCell>User</TableCell>
                <TableCell>Role</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Department</TableCell>
                <TableCell>Last Login</TableCell>
                <TableCell>Actions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {filteredUsers
                .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                .map((user) => (
                  <TableRow key={user.id} hover>
                    <TableCell padding="checkbox">
                      <input
                        type="checkbox"
                        checked={selectedUsers.includes(user.id)}
                        onChange={() => handleSelectUser(user.id)}
                        disabled={!isManagerOrAdmin}
                      />
                    </TableCell>
                    <TableCell>
                      <Box sx={{ display: 'flex', alignItems: 'center' }}>
                        <Avatar sx={{ mr: 2, width: 32, height: 32 }}>
                          {user.firstName.charAt(0)}{user.lastName.charAt(0)}
                        </Avatar>
                        <Box>
                          <Typography variant="body2" sx={{ fontWeight: 'medium' }}>
                            {user.firstName} {user.lastName}
                            {user.requirePasswordChange && (
                              <Badge badgeContent="!" color="warning" sx={{ ml: 1 }} />
                            )}
                          </Typography>
                          <Typography variant="caption" color="text.secondary">
                            {user.email}
                          </Typography>
                          {user.jobTitle && (
                            <Typography variant="caption" display="block" color="text.secondary">
                              {user.jobTitle}
                            </Typography>
                          )}
                        </Box>
                      </Box>
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={user.role.replace('_', ' ')}
                        color={getRoleColor(user.role) as any}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={user.status.replace('_', ' ')}
                        color={getStatusColor(user.status) as any}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2">
                        {user.department || '-'}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2">
                        {formatDate(user.lastLoginAt)}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      <Tooltip title="Actions">
                        <IconButton
                          onClick={(e) => handleMenuOpen(e, user)}
                          disabled={!isManagerOrAdmin}
                        >
                          <MoreVertIcon />
                        </IconButton>
                      </Tooltip>
                    </TableCell>
                  </TableRow>
                ))}
            </TableBody>
          </Table>
        </TableContainer>

        <TablePagination
          rowsPerPageOptions={[10, 25, 50]}
          component="div"
          count={filteredUsers.length}
          rowsPerPage={rowsPerPage}
          page={page}
          onPageChange={(_, newPage) => setPage(newPage)}
          onRowsPerPageChange={(e) => {
            setRowsPerPage(parseInt(e.target.value, 10));
            setPage(0);
          }}
        />
      </Card>

      {/* Actions Menu */}
      <Menu
        anchorEl={menuAnchor}
        open={Boolean(menuAnchor)}
        onClose={handleMenuClose}
      >
        <MenuItem onClick={handleEditUser}>
          <ListItemIcon>
            <EditIcon fontSize="small" />
          </ListItemIcon>
          <ListItemText>Edit User</ListItemText>
        </MenuItem>
        
        <MenuItem onClick={handleResetPassword}>
          <ListItemIcon>
            <VpnKeyIcon fontSize="small" />
          </ListItemIcon>
          <ListItemText>Reset Password</ListItemText>
        </MenuItem>

        <MenuItem onClick={handleToggleUserStatus}>
          <ListItemIcon>
            {selectedUser?.status === 'ACTIVE' ? 
              <BlockIcon fontSize="small" /> : 
              <CheckCircleIcon fontSize="small" />
            }
          </ListItemIcon>
          <ListItemText>
            {selectedUser?.status === 'ACTIVE' ? 'Deactivate' : 'Activate'} User
          </ListItemText>
        </MenuItem>

        <Divider />
        
        <MenuItem onClick={handleDeleteUser} sx={{ color: 'error.main' }}>
          <ListItemIcon>
            <DeleteIcon fontSize="small" color="error" />
          </ListItemIcon>
          <ListItemText>Delete User</ListItemText>
        </MenuItem>
      </Menu>

      {/* Edit User Dialog */}
      <Dialog open={editDialogOpen} onClose={() => setEditDialogOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Edit User</DialogTitle>
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={6}>
              <TextField
                fullWidth
                label="First Name"
                value={editForm.firstName}
                onChange={(e) => setEditForm(prev => ({ ...prev, firstName: e.target.value }))}
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                fullWidth
                label="Last Name"
                value={editForm.lastName}
                onChange={(e) => setEditForm(prev => ({ ...prev, lastName: e.target.value }))}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Email"
                value={editForm.email}
                onChange={(e) => setEditForm(prev => ({ ...prev, email: e.target.value }))}
              />
            </Grid>
            <Grid item xs={6}>
              <FormControl fullWidth>
                <InputLabel>Role</InputLabel>
                <Select
                  value={editForm.role}
                  onChange={(e: SelectChangeEvent) => setEditForm(prev => ({ ...prev, role: e.target.value as any }))}
                  label="Role"
                >
                  <MenuItem value="ADMIN">Admin</MenuItem>
                  <MenuItem value="MANAGER">Manager</MenuItem>
                  <MenuItem value="SENIOR_AUDITOR">Senior Auditor</MenuItem>
                  <MenuItem value="AUDITOR">Auditor</MenuItem>
                  <MenuItem value="INTERN">Intern</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={6}>
              <TextField
                fullWidth
                label="Job Title"
                value={editForm.jobTitle}
                onChange={(e) => setEditForm(prev => ({ ...prev, jobTitle: e.target.value }))}
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                fullWidth
                label="Department"
                value={editForm.department}
                onChange={(e) => setEditForm(prev => ({ ...prev, department: e.target.value }))}
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                fullWidth
                label="Phone Number"
                value={editForm.phoneNumber}
                onChange={(e) => setEditForm(prev => ({ ...prev, phoneNumber: e.target.value }))}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setEditDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleSaveEdit} variant="contained">Save</Button>
        </DialogActions>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={deleteDialogOpen} onClose={() => setDeleteDialogOpen(false)}>
        <DialogTitle>Delete User</DialogTitle>
        <DialogContent>
          <Typography>
            Are you sure you want to delete {selectedUser?.firstName} {selectedUser?.lastName}? 
            This action cannot be undone.
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDeleteDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleConfirmDelete} color="error" variant="contained">
            Delete
          </Button>
        </DialogActions>
      </Dialog>

      {/* Bulk Actions Dialog */}
      <Dialog open={bulkActionDialogOpen} onClose={() => setBulkActionDialogOpen(false)}>
        <DialogTitle>Bulk Actions</DialogTitle>
        <DialogContent>
          <Typography sx={{ mb: 2 }}>
            Select an action to perform on {selectedUsers.length} selected user{selectedUsers.length !== 1 ? 's' : ''}:
          </Typography>
          <Box sx={{ display: 'flex', flexDirection: 'column', gap: 1 }}>
            <Button
              fullWidth
              variant="outlined"
              startIcon={<CheckCircleIcon />}
              onClick={() => handleBulkAction('ACTIVATE')}
            >
              Activate Users
            </Button>
            <Button
              fullWidth
              variant="outlined"
              startIcon={<BlockIcon />}
              onClick={() => handleBulkAction('DEACTIVATE')}
            >
              Deactivate Users
            </Button>
            <Button
              fullWidth
              variant="outlined"
              startIcon={<VpnKeyIcon />}
              onClick={() => handleBulkAction('RESET_PASSWORD')}
            >
              Reset Passwords
            </Button>
            <Button
              fullWidth
              variant="outlined"
              color="error"
              startIcon={<DeleteIcon />}
              onClick={() => handleBulkAction('DELETE')}
            >
              Delete Users
            </Button>
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setBulkActionDialogOpen(false)}>Cancel</Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
};