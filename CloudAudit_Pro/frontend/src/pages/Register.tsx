import React, { useState } from 'react'
import {
  Container,
  Paper,
  TextField,
  Button,
  Typography,
  Box,
  Alert,
  Grid,
  Link as MuiLink,
  Card,
  CardContent,
  Stepper,
  Step,
  StepLabel
} from '@mui/material'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'

function Register() {
  const { register } = useAuth()
  const navigate = useNavigate()
  const [activeStep, setActiveStep] = useState(0)
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    // Personal Info
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    confirmPassword: '',
    jobTitle: '',
    department: '',
    // Company/Tenant Info
    companyName: '',
    tenantSubdomain: '',
  })

  const steps = ['Personal Information', 'Company Setup', 'Review & Submit']

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target
    setFormData(prev => ({
      ...prev,
      [name]: value
    }))
  }

  const handleNext = () => {
    if (activeStep === 0) {
      // Validate personal info
      if (!formData.firstName || !formData.lastName || !formData.email || !formData.password) {
        setError('Please fill in all required fields')
        return
      }
      if (formData.password !== formData.confirmPassword) {
        setError('Passwords do not match')
        return
      }
      if (formData.password.length < 8) {
        setError('Password must be at least 8 characters long')
        return
      }
    }
    
    if (activeStep === 1) {
      // Validate company info
      if (!formData.companyName) {
        setError('Company name is required')
        return
      }
    }
    
    setError('')
    setActiveStep(prev => prev + 1)
  }

  const handleBack = () => {
    setActiveStep(prev => prev - 1)
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      await register({
        firstName: formData.firstName,
        lastName: formData.lastName,
        email: formData.email,
        password: formData.password,
        jobTitle: formData.jobTitle,
        department: formData.department,
        companyName: formData.companyName,
        tenantSubdomain: formData.tenantSubdomain || undefined,
      })
      navigate('/')
    } catch (err: any) {
      setError(err.message || 'Registration failed')
    } finally {
      setLoading(false)
    }
  }

  const renderPersonalInfo = () => (
    <Grid container spacing={2}>
      <Grid item xs={12} sm={6}>
        <TextField
          name="firstName"
          label="First Name"
          fullWidth
          required
          value={formData.firstName}
          onChange={handleInputChange}
        />
      </Grid>
      <Grid item xs={12} sm={6}>
        <TextField
          name="lastName"
          label="Last Name"
          fullWidth
          required
          value={formData.lastName}
          onChange={handleInputChange}
        />
      </Grid>
      <Grid item xs={12}>
        <TextField
          name="email"
          label="Email Address"
          type="email"
          fullWidth
          required
          value={formData.email}
          onChange={handleInputChange}
        />
      </Grid>
      <Grid item xs={12} sm={6}>
        <TextField
          name="password"
          label="Password"
          type="password"
          fullWidth
          required
          value={formData.password}
          onChange={handleInputChange}
          helperText="Minimum 8 characters"
        />
      </Grid>
      <Grid item xs={12} sm={6}>
        <TextField
          name="confirmPassword"
          label="Confirm Password"
          type="password"
          fullWidth
          required
          value={formData.confirmPassword}
          onChange={handleInputChange}
        />
      </Grid>
      <Grid item xs={12} sm={6}>
        <TextField
          name="jobTitle"
          label="Job Title"
          fullWidth
          value={formData.jobTitle}
          onChange={handleInputChange}
          placeholder="e.g., Managing Partner, Finance Director"
        />
      </Grid>
      <Grid item xs={12} sm={6}>
        <TextField
          name="department"
          label="Department"
          fullWidth
          value={formData.department}
          onChange={handleInputChange}
          placeholder="e.g., Audit, Finance, Management"
        />
      </Grid>
    </Grid>
  )

  const renderCompanyInfo = () => (
    <Grid container spacing={2}>
      <Grid item xs={12}>
        <TextField
          name="companyName"
          label="Company/Organization Name"
          fullWidth
          required
          value={formData.companyName}
          onChange={handleInputChange}
          placeholder="e.g., ABC Audit Firm, XYZ Accounting"
        />
      </Grid>
      <Grid item xs={12}>
        <TextField
          name="tenantSubdomain"
          label="Subdomain (Optional)"
          fullWidth
          value={formData.tenantSubdomain}
          onChange={handleInputChange}
          placeholder="e.g., abc-audit (will create abc-audit.cloudaudit.com)"
          helperText="Leave blank to auto-generate from company name"
        />
      </Grid>
    </Grid>
  )

  const renderReview = () => (
    <Grid container spacing={2}>
      <Grid item xs={12}>
        <Typography variant="h6" gutterBottom>Review Your Information</Typography>
      </Grid>
      <Grid item xs={12} md={6}>
        <Card variant="outlined">
          <CardContent>
            <Typography variant="subtitle2" gutterBottom>Personal Information</Typography>
            <Typography variant="body2">Name: {formData.firstName} {formData.lastName}</Typography>
            <Typography variant="body2">Email: {formData.email}</Typography>
            {formData.jobTitle && <Typography variant="body2">Title: {formData.jobTitle}</Typography>}
            {formData.department && <Typography variant="body2">Department: {formData.department}</Typography>}
          </CardContent>
        </Card>
      </Grid>
      <Grid item xs={12} md={6}>
        <Card variant="outlined">
          <CardContent>
            <Typography variant="subtitle2" gutterBottom>Company Information</Typography>
            <Typography variant="body2">Company: {formData.companyName}</Typography>
            {formData.tenantSubdomain && (
              <Typography variant="body2">Subdomain: {formData.tenantSubdomain}</Typography>
            )}
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  )

  return (
    <Container maxWidth="md" sx={{ mt: 8 }}>
      <Paper elevation={3} sx={{ p: 4 }}>
        <Box sx={{ mb: 4 }}>
          <Typography variant="h4" align="center" gutterBottom>
            Register for CloudAudit Pro
          </Typography>
          <Typography variant="body1" align="center" color="text.secondary">
            Set up your audit management platform
          </Typography>
        </Box>

        <Stepper activeStep={activeStep} sx={{ mb: 4 }}>
          {steps.map((label) => (
            <Step key={label}>
              <StepLabel>{label}</StepLabel>
            </Step>
          ))}
        </Stepper>

        {error && (
          <Alert severity="error" sx={{ mb: 3 }}>
            {error}
          </Alert>
        )}

        <form onSubmit={activeStep === 2 ? handleSubmit : (e) => e.preventDefault()}>
          {activeStep === 0 && renderPersonalInfo()}
          {activeStep === 1 && renderCompanyInfo()}
          {activeStep === 2 && renderReview()}

          <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 4 }}>
            <Button
              onClick={handleBack}
              disabled={activeStep === 0}
            >
              Back
            </Button>
            
            <Box>
              {activeStep < 2 ? (
                <Button
                  variant="contained"
                  onClick={handleNext}
                >
                  Next
                </Button>
              ) : (
                <Button
                  type="submit"
                  variant="contained"
                  disabled={loading}
                >
                  {loading ? 'Creating Account...' : 'Create Account'}
                </Button>
              )}
            </Box>
          </Box>
        </form>

        <Box sx={{ mt: 3, textAlign: 'center' }}>
          <Typography variant="body2">
            Already have an account?{' '}
            <MuiLink component={Link} to="/login">
              Sign in here
            </MuiLink>
          </Typography>
        </Box>
      </Paper>
    </Container>
  )
}

export default Register