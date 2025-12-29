import React, { useState, useEffect } from 'react'
import {
  Box,
  Paper,
  Typography,
  List,
  ListItem,
  ListItemText,
  ListItemAvatar,
  Avatar,
  TextField,
  Button,
  Divider,
  Badge,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Alert,
  CircularProgress,
  Chip,
} from '@mui/material'
import {
  Send as SendIcon,
  Refresh as RefreshIcon,
  Delete as DeleteIcon,
  MarkEmailRead as MarkReadIcon,
} from '@mui/icons-material'
import { messagingService, type MessageThread, type Message } from '../services/messaging.service'
import { useAuth } from '../contexts/AuthContext'

const Messages: React.FC = () => {
  const { user } = useAuth()
  const [threads, setThreads] = useState<MessageThread[]>([])
  const [selectedThread, setSelectedThread] = useState<MessageThread | null>(null)
  const [loading, setLoading] = useState(true)
  const [sending, setSending] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [newMessage, setNewMessage] = useState('')
  const [newThreadOpen, setNewThreadOpen] = useState(false)
  const [newThreadData, setNewThreadData] = useState({
    subject: '',
    message: '',
  })

  useEffect(() => {
    loadThreads()
    // Refresh every 30 seconds
    const interval = setInterval(loadThreads, 30000)
    return () => clearInterval(interval)
  }, [user])

  const loadThreads = async () => {
    if (!user?.companyId) return

    try {
      setLoading(true)
      const data = await messagingService.getThreads((user as any).companyId)
      setThreads(data)
      
      // Refresh selected thread if it exists
      if (selectedThread) {
        const updatedThread = data.find(t => t.id === selectedThread.id)
        if (updatedThread) {
          setSelectedThread(updatedThread)
        }
      }
    } catch (err) {
      console.error('Failed to load threads:', err)
      setError('Failed to load messages')
    } finally {
      setLoading(false)
    }
  }

  const handleSelectThread = async (thread: MessageThread) => {
    setSelectedThread(thread)
    
    // Mark thread as read
    try {
      await messagingService.markThreadAsRead(thread.id)
      // Refresh threads to update unread count
      loadThreads()
    } catch (err) {
      console.error('Failed to mark thread as read:', err)
    }
  }

  const handleSendMessage = async () => {
    if (!newMessage.trim() || !selectedThread || !user?.companyId) return

    try {
      setSending(true)
      await messagingService.sendMessage({
        subject: selectedThread.subject,
        message: newMessage,
        companyId: (user as any).companyId,
        threadId: selectedThread.id,
      })
      
      setNewMessage('')
      // Reload thread to show new message
      const updatedThread = await messagingService.getThread(selectedThread.id)
      setSelectedThread(updatedThread)
      loadThreads()
    } catch (err) {
      console.error('Failed to send message:', err)
      setError('Failed to send message')
    } finally {
      setSending(false)
    }
  }

  const handleNewThread = async () => {
    if (!newThreadData.subject.trim() || !newThreadData.message.trim() || !user?.companyId) {
      setError('Subject and message are required')
      return
    }

    try {
      setSending(true)
      await messagingService.sendMessage({
        subject: newThreadData.subject,
        message: newThreadData.message,
        companyId: (user as any).companyId,
      })
      
      setNewThreadOpen(false)
      setNewThreadData({ subject: '', message: '' })
      loadThreads()
    } catch (err) {
      console.error('Failed to create thread:', err)
      setError('Failed to send message')
    } finally {
      setSending(false)
    }
  }

  const formatTime = (date: string) => {
    const messageDate = new Date(date)
    const now = new Date()
    const diffMs = now.getTime() - messageDate.getTime()
    const diffMins = Math.floor(diffMs / 60000)
    const diffHours = Math.floor(diffMs / 3600000)
    const diffDays = Math.floor(diffMs / 86400000)

    if (diffMins < 1) return 'Just now'
    if (diffMins < 60) return `${diffMins}m ago`
    if (diffHours < 24) return `${diffHours}h ago`
    if (diffDays < 7) return `${diffDays}d ago`
    return messageDate.toLocaleDateString()
  }

  return (
    <Box sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Typography variant="h4">Messages</Typography>
        <Box>
          <IconButton onClick={loadThreads} disabled={loading}>
            <RefreshIcon />
          </IconButton>
          <Button
            variant="contained"
            startIcon={<SendIcon />}
            onClick={() => setNewThreadOpen(true)}
          >
            New Message
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      <Box sx={{ display: 'flex', gap: 2, flex: 1, overflow: 'hidden' }}>
        {/* Threads List */}
        <Paper sx={{ width: 350, display: 'flex', flexDirection: 'column' }}>
          <Box sx={{ p: 2, borderBottom: 1, borderColor: 'divider' }}>
            <Typography variant="h6">Conversations</Typography>
          </Box>
          
          {loading ? (
            <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
              <CircularProgress />
            </Box>
          ) : threads.length === 0 ? (
            <Box sx={{ p: 3, textAlign: 'center' }}>
              <Typography variant="body2" color="text.secondary">
                No messages yet. Start a conversation!
              </Typography>
            </Box>
          ) : (
            <List sx={{ flex: 1, overflow: 'auto' }}>
              {threads.map((thread) => (
                <React.Fragment key={thread.id}>
                  <ListItem
                    button
                    selected={selectedThread?.id === thread.id}
                    onClick={() => handleSelectThread(thread)}
                  >
                    <ListItemAvatar>
                      <Badge badgeContent={thread.unreadCount} color="primary">
                        <Avatar>
                          {thread.participants[0]?.firstName?.[0] || 'A'}
                        </Avatar>
                      </Badge>
                    </ListItemAvatar>
                    <ListItemText
                      primary={
                        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                          <Typography variant="subtitle2" noWrap sx={{ flex: 1 }}>
                            {thread.subject}
                          </Typography>
                          <Typography variant="caption" color="text.secondary">
                            {formatTime(thread.lastMessageAt)}
                          </Typography>
                        </Box>
                      }
                      secondary={
                        <Typography variant="body2" noWrap color="text.secondary">
                          {thread.messages[thread.messages.length - 1]?.message || ''}
                        </Typography>
                      }
                    />
                  </ListItem>
                  <Divider variant="inset" component="li" />
                </React.Fragment>
              ))}
            </List>
          )}
        </Paper>

        {/* Message Thread View */}
        <Paper sx={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
          {selectedThread ? (
            <>
              <Box sx={{ p: 2, borderBottom: 1, borderColor: 'divider' }}>
                <Typography variant="h6">{selectedThread.subject}</Typography>
                <Box sx={{ display: 'flex', gap: 1, mt: 1, flexWrap: 'wrap' }}>
                  {selectedThread.participants.map((participant) => (
                    <Chip
                      key={participant.id}
                      label={`${participant.firstName} ${participant.lastName} (${participant.role})`}
                      size="small"
                      variant="outlined"
                    />
                  ))}
                </Box>
              </Box>

              <Box sx={{ flex: 1, overflow: 'auto', p: 2 }}>
                {selectedThread.messages.map((message, index) => {
                  const isOwnMessage = message.sender.id === user?.id
                  return (
                    <Box
                      key={message.id}
                      sx={{
                        mb: 2,
                        display: 'flex',
                        flexDirection: isOwnMessage ? 'row-reverse' : 'row',
                        gap: 1,
                      }}
                    >
                      <Avatar sx={{ width: 32, height: 32 }}>
                        {message.sender.firstName[0]}
                      </Avatar>
                      <Paper
                        sx={{
                          p: 2,
                          maxWidth: '70%',
                          bgcolor: isOwnMessage ? 'primary.main' : 'grey.100',
                          color: isOwnMessage ? 'white' : 'text.primary',
                        }}
                      >
                        <Typography variant="caption" display="block" sx={{ mb: 0.5, opacity: 0.8 }}>
                          {message.sender.firstName} {message.sender.lastName}
                        </Typography>
                        <Typography variant="body2">{message.message}</Typography>
                        <Typography
                          variant="caption"
                          display="block"
                          sx={{ mt: 0.5, opacity: 0.7 }}
                        >
                          {formatTime(message.createdAt)}
                        </Typography>
                      </Paper>
                    </Box>
                  )
                })}
              </Box>

              <Box sx={{ p: 2, borderTop: 1, borderColor: 'divider', display: 'flex', gap: 1 }}>
                <TextField
                  fullWidth
                  multiline
                  maxRows={4}
                  placeholder="Type your message..."
                  value={newMessage}
                  onChange={(e) => setNewMessage(e.target.value)}
                  onKeyPress={(e) => {
                    if (e.key === 'Enter' && !e.shiftKey) {
                      e.preventDefault()
                      handleSendMessage()
                    }
                  }}
                />
                <Button
                  variant="contained"
                  endIcon={<SendIcon />}
                  onClick={handleSendMessage}
                  disabled={!newMessage.trim() || sending}
                >
                  Send
                </Button>
              </Box>
            </>
          ) : (
            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'center', flex: 1 }}>
              <Typography variant="body1" color="text.secondary">
                Select a conversation to view messages
              </Typography>
            </Box>
          )}
        </Paper>
      </Box>

      {/* New Thread Dialog */}
      <Dialog open={newThreadOpen} onClose={() => setNewThreadOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>New Message</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Subject"
            fullWidth
            value={newThreadData.subject}
            onChange={(e) => setNewThreadData({ ...newThreadData, subject: e.target.value })}
            sx={{ mb: 2 }}
          />
          <TextField
            margin="dense"
            label="Message"
            fullWidth
            multiline
            rows={4}
            value={newThreadData.message}
            onChange={(e) => setNewThreadData({ ...newThreadData, message: e.target.value })}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setNewThreadOpen(false)}>Cancel</Button>
          <Button
            onClick={handleNewThread}
            variant="contained"
            disabled={!newThreadData.subject.trim() || !newThreadData.message.trim() || sending}
          >
            {sending ? 'Sending...' : 'Send'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default Messages
