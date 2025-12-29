import React, { useState, useEffect } from 'react'
import {
  Badge,
  IconButton,
  Menu,
  MenuItem,
  ListItemIcon,
  ListItemText,
  Typography,
  Divider,
  Box,
  Button,
} from '@mui/material'
import {
  Notifications as NotificationsIcon,
  Info as InfoIcon,
  CheckCircle as SuccessIcon,
  Warning as WarningIcon,
  Error as ErrorIcon,
  Description as DocumentIcon,
  Assessment as AuditIcon,
  Email as MessageIcon,
  MarkEmailRead as MarkReadIcon,
} from '@mui/icons-material'
import { notificationService, type Notification } from '../services/notification.service'
import { useNavigate } from 'react-router-dom'

const NotificationBell: React.FC = () => {
  const navigate = useNavigate()
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [notifications, setNotifications] = useState<Notification[]>([])
  const [unreadCount, setUnreadCount] = useState(0)

  useEffect(() => {
    loadNotifications()
    
    // Subscribe to real-time notifications
    const unsubscribe = notificationService.subscribeToNotifications((notification) => {
      setNotifications(prev => [notification, ...prev])
      setUnreadCount(prev => prev + 1)
    })

    return () => unsubscribe()
  }, [])

  const loadNotifications = async () => {
    try {
      const data = await notificationService.getNotifications()
      setNotifications(data)
      const count = await notificationService.getUnreadCount()
      setUnreadCount(count)
    } catch (error) {
      console.error('Failed to load notifications:', error)
    }
  }

  const handleClick = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget)
  }

  const handleClose = () => {
    setAnchorEl(null)
  }

  const handleNotificationClick = async (notification: Notification) => {
    try {
      if (!notification.isRead) {
        await notificationService.markAsRead(notification.id)
        setUnreadCount(prev => Math.max(0, prev - 1))
        setNotifications(prev =>
          prev.map(n => n.id === notification.id ? { ...n, isRead: true } : n)
        )
      }

      if (notification.link) {
        navigate(notification.link)
      }
    } catch (error) {
      console.error('Failed to mark notification as read:', error)
    }
    handleClose()
  }

  const handleMarkAllRead = async () => {
    try {
      await notificationService.markAllAsRead()
      setUnreadCount(0)
      setNotifications(prev => prev.map(n => ({ ...n, isRead: true })))
    } catch (error) {
      console.error('Failed to mark all as read:', error)
    }
  }

  const getNotificationIcon = (type: string) => {
    switch (type) {
      case 'SUCCESS':
        return <SuccessIcon color="success" fontSize="small" />
      case 'WARNING':
        return <WarningIcon color="warning" fontSize="small" />
      case 'ERROR':
        return <ErrorIcon color="error" fontSize="small" />
      case 'DOCUMENT_REQUEST':
        return <DocumentIcon color="primary" fontSize="small" />
      case 'AUDIT_UPDATE':
        return <AuditIcon color="info" fontSize="small" />
      case 'MESSAGE':
        return <MessageIcon color="secondary" fontSize="small" />
      default:
        return <InfoIcon color="info" fontSize="small" />
    }
  }

  const formatTime = (date: string) => {
    const notifDate = new Date(date)
    const now = new Date()
    const diffMs = now.getTime() - notifDate.getTime()
    const diffMins = Math.floor(diffMs / 60000)
    const diffHours = Math.floor(diffMs / 3600000)
    const diffDays = Math.floor(diffMs / 86400000)

    if (diffMins < 1) return 'Just now'
    if (diffMins < 60) return `${diffMins}m ago`
    if (diffHours < 24) return `${diffHours}h ago`
    if (diffDays < 7) return `${diffDays}d ago`
    return notifDate.toLocaleDateString()
  }

  return (
    <>
      <IconButton color="inherit" onClick={handleClick}>
        <Badge badgeContent={unreadCount} color="error">
          <NotificationsIcon />
        </Badge>
      </IconButton>

      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleClose}
        PaperProps={{
          sx: { width: 360, maxHeight: 480 }
        }}
      >
        <Box sx={{ px: 2, py: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Typography variant="h6">Notifications</Typography>
          {unreadCount > 0 && (
            <Button size="small" onClick={handleMarkAllRead} startIcon={<MarkReadIcon />}>
              Mark all read
            </Button>
          )}
        </Box>
        <Divider />

        {notifications.length === 0 ? (
          <Box sx={{ p: 3, textAlign: 'center' }}>
            <Typography variant="body2" color="text.secondary">
              No notifications
            </Typography>
          </Box>
        ) : (
          notifications.slice(0, 10).map((notification) => (
            <MenuItem
              key={notification.id}
              onClick={() => handleNotificationClick(notification)}
              sx={{
                bgcolor: notification.isRead ? 'inherit' : 'action.hover',
                py: 1.5,
                px: 2,
              }}
            >
              <ListItemIcon>
                {getNotificationIcon(notification.type)}
              </ListItemIcon>
              <ListItemText
                primary={
                  <Typography variant="subtitle2" sx={{ fontWeight: notification.isRead ? 400 : 600 }}>
                    {notification.title}
                  </Typography>
                }
                secondary={
                  <>
                    <Typography variant="body2" color="text.secondary" noWrap>
                      {notification.message}
                    </Typography>
                    <Typography variant="caption" color="text.secondary">
                      {formatTime(notification.createdAt)}
                    </Typography>
                  </>
                }
              />
            </MenuItem>
          ))
        )}

        {notifications.length > 10 && (
          <>
            <Divider />
            <Box sx={{ p: 1, textAlign: 'center' }}>
              <Button size="small" onClick={() => { navigate('/notifications'); handleClose(); }}>
                View All
              </Button>
            </Box>
          </>
        )}
      </Menu>
    </>
  )
}

export default NotificationBell
