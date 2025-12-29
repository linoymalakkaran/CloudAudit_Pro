import React, { useState, useEffect } from 'react';
import { userManagementApi, UserStats as ApiUserStats } from '../../services/api';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  Button,
  Tab,
  Tabs,
  Badge,
  Alert,
  Divider,
  IconButton,
  Menu,
  MenuItem,
  Tooltip
} from '@mui/material';
import {
  People as PeopleIcon,
  PersonAdd as PersonAddIcon,
  Pending as PendingIcon,
  Assignment as AssignmentIcon,
  Settings as SettingsIcon,
  MoreVert as MoreVertIcon,
  Analytics as AnalyticsIcon,
  Security as SecurityIcon
} from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

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
      id={`admin-tabpanel-${index}`}
      aria-labelledby={`admin-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Box sx={{ p: 3 }}>
          {children}
        </Box>
      )}
    </div>
  );
}

interface AdminDashboardProps {
  userRole: 'ADMIN' | 'MANAGER' | 'SENIOR_AUDITOR' | 'AUDITOR' | 'INTERN';
}

export const AdminDashboard: React.FC<AdminDashboardProps> = ({ userRole }) => {
  const [tabValue, setTabValue] = useState(0);
  const [userStats, setUserStats] = useState<ApiUserStats | null>(null);
  const [pendingCount, setPendingCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [menuAnchor, setMenuAnchor] = useState<null | HTMLElement>(null);
  const navigate = useNavigate();

  const isAdmin = userRole === 'ADMIN';
  const isManagerOrAdmin = ['ADMIN', 'MANAGER'].includes(userRole);

  useEffect(() => {
    fetchUserStats();
    fetchPendingCount();
  }, []);

  const fetchUserStats = async () => {
    try {
      const stats = await userManagementApi.getUserStats();
      setUserStats(stats);
    } catch (error) {
      console.error('Failed to fetch user stats:', error);
      // Set default stats on error
      setUserStats({
        total: 0,
        active: 0,
        inactive: 0,
        pending: 0,
        roleDistribution: {},
        recentActivity: { newInvitationsThisWeek: 0 }
      });
    } finally {
      setLoading(false);
    }
  };

  const fetchPendingCount = async () => {
    try {
      const stats = await userManagementApi.getUserStats();
      setPendingCount(stats.pending);
    } catch (error) {
      console.error('Failed to fetch pending count:', error);
      setPendingCount(0);
    }
  };

  const handleTabChange = (event: React.SyntheticEvent, newValue: number) => {
    setTabValue(newValue);
  };

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
    setMenuAnchor(event.currentTarget);
  };

  const handleMenuClose = () => {
    setMenuAnchor(null);
  };

  const navigateToUserManagement = () => {
    navigate('/admin/users');
  };

  const navigateToInviteUser = () => {
    navigate('/admin/users/invite');
  };

  const navigateToPendingApprovals = () => {
    navigate('/admin/users/pending');
  };

  const StatCard: React.FC<{
    title: string;
    value: number | string;
    icon: React.ReactNode;
    color?: 'primary' | 'secondary' | 'success' | 'warning' | 'error';
    onClick?: () => void;
  }> = ({ title, value, icon, color = 'primary', onClick }) => (
    <Card 
      sx={{ 
        cursor: onClick ? 'pointer' : 'default',
        '&:hover': onClick ? { transform: 'translateY(-2px)', boxShadow: 3 } : {},
        transition: 'all 0.2s ease-in-out'
      }}
      onClick={onClick}
    >
      <CardContent>
        <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <Box>
            <Typography variant="h4" color={`${color}.main`}>
              {value}
            </Typography>
            <Typography variant="body2" color="text.secondary">
              {title}
            </Typography>
          </Box>
          <Box sx={{ color: `${color}.main` }}>
            {icon}
          </Box>
        </Box>
      </CardContent>
    </Card>
  );

  if (loading) {
    return (
      <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
        <Typography>Loading dashboard...</Typography>
      </Container>
    );
  }

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      {/* Header */}
      <Box sx={{ mb: 4, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Box>
          <Typography variant="h4" component="h1" gutterBottom>
            {isAdmin ? 'Admin Dashboard' : 'Team Management'}
          </Typography>
          <Typography variant="body1" color="text.secondary">
            {isAdmin 
              ? 'Manage users, roles, and system settings' 
              : 'Manage your team members and assignments'
            }
          </Typography>
        </Box>
        <Box>
          <Tooltip title="Quick Actions">
            <IconButton onClick={handleMenuOpen}>
              <MoreVertIcon />
            </IconButton>
          </Tooltip>
          <Menu
            anchorEl={menuAnchor}
            open={Boolean(menuAnchor)}
            onClose={handleMenuClose}
          >
            {isManagerOrAdmin && (
              <MenuItem onClick={() => { handleMenuClose(); navigateToInviteUser(); }}>
                <PersonAddIcon sx={{ mr: 1 }} />
                Invite User
              </MenuItem>
            )}
            {isAdmin && (
              <MenuItem onClick={() => { handleMenuClose(); navigateToPendingApprovals(); }}>
                <PendingIcon sx={{ mr: 1 }} />
                Pending Approvals
              </MenuItem>
            )}
          </Menu>
        </Box>
      </Box>

      {/* Stats Overview */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Total Users"
            value={userStats?.total || 0}
            icon={<PeopleIcon sx={{ fontSize: 40 }} />}
            color="primary"
            onClick={navigateToUserManagement}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Active Users"
            value={userStats?.active || 0}
            icon={<SecurityIcon sx={{ fontSize: 40 }} />}
            color="success"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Pending Approval"
            value={userStats?.pending || 0}
            icon={<PendingIcon sx={{ fontSize: 40 }} />}
            color="warning"
            onClick={isAdmin ? navigateToPendingApprovals : undefined}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="New This Week"
            value={userStats?.recentActivity?.newInvitationsThisWeek || 0}
            icon={<PersonAddIcon sx={{ fontSize: 40 }} />}
            color="secondary"
          />
        </Grid>
      </Grid>

      {/* Quick Actions */}
      {isManagerOrAdmin && (
        <Box sx={{ mb: 4 }}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Quick Actions
              </Typography>
              <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                <Button
                  variant="contained"
                  startIcon={<PersonAddIcon />}
                  onClick={navigateToInviteUser}
                >
                  Invite User
                </Button>
                <Button
                  variant="outlined"
                  startIcon={<PeopleIcon />}
                  onClick={navigateToUserManagement}
                >
                  Manage Users
                </Button>
                {isAdmin && (
                  <Button
                    variant="outlined"
                    startIcon={<PendingIcon />}
                    onClick={navigateToPendingApprovals}
                    color="warning"
                  >
                    Review Approvals ({pendingCount})
                  </Button>
                )}
              </Box>
            </CardContent>
          </Card>
        </Box>
      )}

      {/* Detailed Tabs */}
      <Card>
        <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tabs value={tabValue} onChange={handleTabChange}>
            <Tab label="Overview" />
            {isManagerOrAdmin && <Tab label="Team Analytics" />}
            {isAdmin && <Tab label="System Settings" />}
          </Tabs>
        </Box>

        <TabPanel value={tabValue} index={0}>
          {/* Role Distribution */}
          <Typography variant="h6" gutterBottom>
            Team Composition
          </Typography>
          <Grid container spacing={2} sx={{ mb: 3 }}>
            {userStats && userStats.roleDistribution && Object.entries(userStats.roleDistribution).map(([role, count]) => (
              <Grid item xs={12} sm={6} md={4} key={role}>
                <Box sx={{ p: 2, border: 1, borderColor: 'divider', borderRadius: 1 }}>
                  <Typography variant="h4" color="primary.main">
                    {count}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {role.replace('_', ' ').toLowerCase().replace(/\b\w/g, l => l.toUpperCase())}
                  </Typography>
                </Box>
              </Grid>
            ))}
          </Grid>

          <Divider sx={{ my: 3 }} />

          {/* Recent Activity */}
          <Typography variant="h6" gutterBottom>
            Recent Activity
          </Typography>
          <Alert severity="info" sx={{ mb: 2 }}>
            {userStats?.recentActivity?.newInvitationsThisWeek || 0} new user{(userStats?.recentActivity?.newInvitationsThisWeek || 0) !== 1 ? 's' : ''} invited this week
          </Alert>
        </TabPanel>

        {isManagerOrAdmin && (
          <TabPanel value={tabValue} index={1}>
            <Typography variant="h6" gutterBottom>
              Team Analytics
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Detailed analytics and performance metrics will be displayed here.
            </Typography>
            {/* Add charts and analytics components here */}
          </TabPanel>
        )}

        {isAdmin && (
          <TabPanel value={tabValue} index={2}>
            <Typography variant="h6" gutterBottom>
              System Settings
            </Typography>
            <Typography variant="body2" color="text.secondary">
              System configuration and administrative settings will be displayed here.
            </Typography>
            {/* Add system settings components here */}
          </TabPanel>
        )}
      </Card>
    </Container>
  );
};