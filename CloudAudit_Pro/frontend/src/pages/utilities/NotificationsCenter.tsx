import React, { useState, useEffect } from 'react';
import {
  Box,
  Badge,
  Button,
  Card,
  CardContent,
  Chip,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Divider,
  IconButton,
  List,
  ListItem,
  ListItemText,
  Tab,
  Tabs,
  Typography,
  Alert,
  CircularProgress,
  Checkbox,
  Menu,
  MenuItem,
} from '@mui/material';
import {
  Notifications as NotificationsIcon,
  Close as CloseIcon,
  DoneAll as MarkAllReadIcon,
  Delete as DeleteIcon,
  MoreVert as MoreVertIcon,
  CheckCircle as CheckIcon,
  Error as ErrorIcon,
  Warning as WarningIcon,
  Info as InfoIcon,
} from '@mui/icons-material';
import notificationsService, { Notification } from '../../services/notificationsService';

interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

function TabPanel(props: TabPanelProps) {
  const { children, value, index, ...other } = props;
  return (
    <div role="tabpanel" hidden={value !== index} {...other}>
      {value === index && <Box sx={{ py: 2 }}>{children}</Box>}
    </div>
  );
}

const NotificationsCenter: React.FC = () => {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const [loading, setLoading] = useState(false);
  const [tabValue, setTabValue] = useState(0);
  const [error, setError] = useState<string>('');
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [selectedNotification, setSelectedNotification] = useState<Notification | null>(null);

  useEffect(() => {
    loadNotifications();
    loadUnreadCount();
    
    // Poll for new notifications every 30 seconds
    const interval = setInterval(() => {
      loadUnreadCount();
    }, 30000);

    return () => clearInterval(interval);
  }, []);

  const loadNotifications = async () => {
    try {
      setLoading(true);
      const data = await notificationsService.getAll();
      setNotifications(data);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to load notifications');
    } finally {
      setLoading(false);
    }
  };

  const loadUnreadCount = async () => {
    try {
      const count = await notificationsService.getUnreadCount();
      setUnreadCount(count);
    } catch (err) {
      console.error('Failed to load unread count:', err);
    }
  };

  const handleMarkAsRead = async (id: string) => {
    try {
      await notificationsService.markAsRead(id);
      await loadNotifications();
      await loadUnreadCount();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to mark as read');
    }
  };

  const handleMarkAllAsRead = async () => {
    try {
      setLoading(true);
      await notificationsService.markAllAsRead();
      await loadNotifications();
      await loadUnreadCount();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to mark all as read');
    } finally {
      setLoading(false);
    }
  };

  const handleDismiss = async (id: string) => {
    try {
      await notificationsService.dismiss(id);
      await loadNotifications();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to dismiss notification');
    }
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this notification?')) {
      try {
        await notificationsService.delete(id);
        await loadNotifications();
        await loadUnreadCount();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to delete notification');
      }
    }
  };

  const handleBulkDismiss = async () => {
    if (selectedIds.size === 0) return;
    
    try {
      await notificationsService.bulkDismiss(Array.from(selectedIds));
      setSelectedIds(new Set());
      await loadNotifications();
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to dismiss notifications');
    }
  };

  const handleClearRead = async () => {
    if (window.confirm('Clear all read notifications?')) {
      try {
        await notificationsService.clearRead();
        await loadNotifications();
      } catch (err: any) {
        setError(err.response?.data?.message || 'Failed to clear read notifications');
      }
    }
  };

  const handleSelectNotification = (id: string) => {
    const newSelected = new Set(selectedIds);
    if (newSelected.has(id)) {
      newSelected.delete(id);
    } else {
      newSelected.add(id);
    }
    setSelectedIds(newSelected);
  };

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>, notification: Notification) => {
    setAnchorEl(event.currentTarget);
    setSelectedNotification(notification);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
    setSelectedNotification(null);
  };

  const getPriorityColor = (priority: string) => {
    const colors: any = {
      LOW: 'default',
      MEDIUM: 'info',
      HIGH: 'warning',
      URGENT: 'error',
    };
    return colors[priority] || 'default';
  };

  const getTypeIcon = (type: string) => {
    const icons: any = {
      SUCCESS: <CheckIcon color="success" />,
      ERROR: <ErrorIcon color="error" />,
      WARNING: <WarningIcon color="warning" />,
      INFO: <InfoIcon color="info" />,
    };
    return icons[type] || <InfoIcon />;
  };

  const filteredNotifications = notifications.filter((n) => {
    if (tabValue === 0) return true; // All
    if (tabValue === 1) return !n.readAt; // Unread
    if (tabValue === 2) return n.readAt; // Read
    return true;
  });

  return (
    <Box sx={{ p: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
          <Typography variant="h4">Notifications</Typography>
          <Badge badgeContent={unreadCount} color="error">
            <NotificationsIcon />
          </Badge>
        </Box>
        <Box sx={{ display: 'flex', gap: 1 }}>
          {selectedIds.size > 0 && (
            <Button variant="outlined" onClick={handleBulkDismiss}>
              Dismiss Selected ({selectedIds.size})
            </Button>
          )}
          <Button variant="outlined" startIcon={<DeleteIcon />} onClick={handleClearRead}>
            Clear Read
          </Button>
          <Button variant="contained" startIcon={<MarkAllReadIcon />} onClick={handleMarkAllAsRead}>
            Mark All Read
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" onClose={() => setError('')} sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Card>
        <Tabs value={tabValue} onChange={(_, v) => setTabValue(v)} sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tab label={`All (${notifications.length})`} />
          <Tab label={`Unread (${unreadCount})`} />
          <Tab label={`Read (${notifications.length - unreadCount})`} />
        </Tabs>

        <TabPanel value={tabValue} index={0}>
          {renderNotificationsList(filteredNotifications)}
        </TabPanel>
        <TabPanel value={tabValue} index={1}>
          {renderNotificationsList(filteredNotifications)}
        </TabPanel>
        <TabPanel value={tabValue} index={2}>
          {renderNotificationsList(filteredNotifications)}
        </TabPanel>
      </Card>

      {/* Context Menu */}
      <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleMenuClose}>
        {selectedNotification && !selectedNotification.readAt && (
          <MenuItem
            onClick={() => {
              handleMarkAsRead(selectedNotification.id);
              handleMenuClose();
            }}
          >
            Mark as Read
          </MenuItem>
        )}
        {selectedNotification && (
          <>
            <MenuItem
              onClick={() => {
                handleDismiss(selectedNotification.id);
                handleMenuClose();
              }}
            >
              Dismiss
            </MenuItem>
            <MenuItem
              onClick={() => {
                handleDelete(selectedNotification.id);
                handleMenuClose();
              }}
            >
              Delete
            </MenuItem>
          </>
        )}
      </Menu>
    </Box>
  );

  function renderNotificationsList(items: Notification[]) {
    if (loading) {
      return (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      );
    }

    if (items.length === 0) {
      return (
        <Box sx={{ p: 4, textAlign: 'center' }}>
          <NotificationsIcon sx={{ fontSize: 64, color: 'text.secondary', mb: 2 }} />
          <Typography variant="h6" color="text.secondary">
            No notifications
          </Typography>
        </Box>
      );
    }

    return (
      <List sx={{ p: 0 }}>
        {items.map((notification, index) => (
          <React.Fragment key={notification.id}>
            <ListItem
              sx={{
                bgcolor: notification.readAt ? 'background.paper' : 'action.hover',
                '&:hover': { bgcolor: 'action.selected' },
                cursor: 'pointer',
              }}
            >
              <Checkbox
                checked={selectedIds.has(notification.id)}
                onChange={() => handleSelectNotification(notification.id)}
                sx={{ mr: 1 }}
              />
              <Box sx={{ mr: 2 }}>{getTypeIcon(notification.notificationType)}</Box>
              <ListItemText
                primary={
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <Typography variant="subtitle1" fontWeight={notification.readAt ? 'normal' : 'bold'}>
                      {notification.title}
                    </Typography>
                    <Chip label={notification.priority} color={getPriorityColor(notification.priority) as any} size="small" />
                  </Box>
                }
                secondary={
                  <>
                    <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                      {notification.message}
                    </Typography>
                    <Typography variant="caption" color="text.secondary">
                      {new Date(notification.createdAt).toLocaleString()}
                    </Typography>
                  </>
                }
                onClick={() => !notification.readAt && handleMarkAsRead(notification.id)}
              />
              {notification.actionUrl && (
                <Button
                  variant="outlined"
                  size="small"
                  sx={{ mr: 1 }}
                  onClick={() => (window.location.href = notification.actionUrl!)}
                >
                  {notification.actionText || 'View'}
                </Button>
              )}
              <IconButton
                size="small"
                onClick={(e) => handleMenuOpen(e, notification)}
              >
                <MoreVertIcon />
              </IconButton>
            </ListItem>
            {index < items.length - 1 && <Divider />}
          </React.Fragment>
        ))}
      </List>
    );
  }
};

export default NotificationsCenter;
