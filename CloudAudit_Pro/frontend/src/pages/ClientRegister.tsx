import React, { useState, useEffect } from 'react'
import {
  Container,
  Paper,
  TextField,
  Button,
  Typography,
  Box,
  Alert,
  CircularProgress,
  Card,
  CardContent,
} from '@mui/material'
import { useNavigate, useSearchParams } from 'react-router-dom'
import { invitationService } from '../services/invitation.service'
import { useAuth } from '../contexts/AuthContext'

function ClientRegister() {
  const [searchParams] = useSearchParams()
  const token = searchParams.get('token')
  const navigate = useNavigate()
  const { login } = useAuth()
  
  const [loading, setLoading] = useState(true)
  const [validating, setValidating] = useState(true)
  const [error, setError] = useState('')
  const [invitation, setInvitation] = useState<any>(null)
  
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    password: '',
    confirmPassword: '',
  })

  useEffect(() => {
    if (!token) {
      setError('Invalid invitation link. Please check your email for the correct link.')
      setValidating(false)
      setLoading(false)
      return
    }

    validateToken()
  }, [token])

  const validateToken = async () => {
    if (!token) return

    try {
      setValidating(true)
      const result = await invitationService.validateInvitation(token)
      
      if (result.valid && result.invitation) {
        setInvitation(result.invitation)
        // Pre-fill name if provided
        if (result.invitation.firstName) {
          setFormData(prev => ({ ...prev, firstName: result.invitation?.firstName || '' }))
        }
        if (result.invitation.lastName) {
          setFormData(prev => ({ ...prev, lastName: result.invitation?.lastName || '' }))
        }
      } else {
        setError(result.error || 'Invalid or expired invitation link')
      }
    } catch (err) {
      setError('Failed to validate invitation. Please try again or contact support.')
    } finally {
      setValidating(false)
      setLoading(false)
    }
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target
    setFormData(prev => ({ ...prev, [name]: value }))
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')

    // Validation
    if (!formData.firstName || !formData.lastName || !formData.password) {
      setError('Please fill in all required fields')
      return
    }

    if (formData.password.length < 8) {
      setError('Password must be at least 8 characters long')
      return
    }

    if (formData.password !== formData.confirmPassword) {
      setError('Passwords do not match')
      return
    }

    if (!token) {
      setError('Invalid invitation token')
      return
    }

    try {
      setLoading(true)
      
      // Accept invitation and create account
      const result = await invitationService.acceptInvitation(token, {
        firstName: formData.firstName,
        lastName: formData.lastName,
        password: formData.password,
      })

      // Auto-login after successful registration
      if (result.token) {
        localStorage.setItem('token', result.token)
        localStorage.setItem('user', JSON.stringify(result.user))
        
        // Navigate based on role
        if (result.user.role === 'CLIENT') {
          navigate('/client')
        } else {
          navigate('/')
        }
      } else {
        navigate('/login')
      }
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to complete registration. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  if (validating) {
    return (
      <Container maxWidth="sm" sx={{ mt: 8, display: 'flex', justifyContent: 'center' }}>
        <Box sx={{ textAlign: 'center' }}>
          <CircularProgress />
          <Typography variant="body1" sx={{ mt: 2 }}>
            Validating invitation...
          </Typography>
        </Box>
      </Container>
    )
  }

  if (!invitation || error) {
    return (
      <Container maxWidth="sm" sx={{ mt: 8 }}>
        <Paper elevation={3} sx={{ p: 4 }}>
          <Alert severity="error">
            {error || 'Invalid invitation link'}
          </Alert>
          <Box sx={{ mt: 3, textAlign: 'center' }}>
            <Button variant="contained" onClick={() => navigate('/login')}>
              Go to Login
            </Button>
          </Box>
        </Paper>
      </Container>
    )
  }

  return (
    <Container maxWidth="sm" sx={{ mt: 8 }}>
      <Paper elevation={3} sx={{ p: 4 }}>
        <Box sx={{ mb: 4 }}>
          <Typography variant="h4" align="center" gutterBottom>
            Complete Your Registration
          </Typography>
          <Typography variant="body1" align="center" color="text.secondary">
            You've been invited to join CloudAudit Pro
          </Typography>
        </Box>

        <Card variant="outlined" sx={{ mb: 3, bgcolor: 'info.light' }}>
          <CardContent>
            <Typography variant="body2" gutterBottom>
              <strong>Email:</strong> {invitation.email}
            </Typography>
            <Typography variant="body2" gutterBottom>
              <strong>Role:</strong> {invitation.role}
            </Typography>
            {invitation.companyId && (
              <Typography variant="body2">
                <strong>Company:</strong> {invitation.companyId}
              </Typography>
            )}
          </CardContent>
        </Card>

        {error && (
          <Alert severity="error" sx={{ mb: 3 }}>
            {error}
          </Alert>
        )}

        <form onSubmit={handleSubmit}>
          <TextField
            name="firstName"
            label="First Name"
            fullWidth
            required
            value={formData.firstName}
            onChange={handleInputChange}
            sx={{ mb: 2 }}
          />

          <TextField
            name="lastName"
            label="Last Name"
            fullWidth
            required
            value={formData.lastName}
            onChange={handleInputChange}
            sx={{ mb: 2 }}
          />

          <TextField
            name="password"
            label="Password"
            type="password"
            fullWidth
            required
            value={formData.password}
            onChange={handleInputChange}
            helperText="Minimum 8 characters"
            sx={{ mb: 2 }}
          />

          <TextField
            name="confirmPassword"
            label="Confirm Password"
            type="password"
            fullWidth
            required
            value={formData.confirmPassword}
            onChange={handleInputChange}
            sx={{ mb: 3 }}
          />

          <Button
            type="submit"
            variant="contained"
            fullWidth
            size="large"
            disabled={loading}
          >
            {loading ? 'Creating Account...' : 'Complete Registration'}
          </Button>
        </form>

        <Box sx={{ mt: 3, textAlign: 'center' }}>
          <Typography variant="body2" color="text.secondary">
            Already have an account?{' '}
            <Button variant="text" onClick={() => navigate('/login')}>
              Login
            </Button>
          </Typography>
        </Box>
      </Paper>
    </Container>
  )
}

export default ClientRegister
