import React from 'react'
import { 
  Grid, 
  Card, 
  CardContent, 
  Typography, 
  Box,
  Button,
  Chip
} from '@mui/material'
import { 
  Business as BusinessIcon,
  People as PeopleIcon,
  Assessment as ReportIcon,
  Add as AddIcon
} from '@mui/icons-material'
import { Link } from 'react-router-dom'
import { useAuth } from '../../contexts/AuthContext'

function AdminPortal() {
  const { user } = useAuth()

  const adminCards = [
    {
      title: 'Company Management',
      description: 'Manage audit client companies, their details, and audit periods',
      icon: <BusinessIcon sx={{ fontSize: 40, color: 'primary.main' }} />,
      link: '/admin/companies',
      count: '5 Active Companies'
    },
    {
      title: 'User Management',
      description: 'Manage team members, their roles, and access permissions',
      icon: <PeopleIcon sx={{ fontSize: 40, color: 'success.main' }} />,
      link: '/admin/users',
      count: '12 Team Members'
    },
    {
      title: 'Audit Procedures',
      description: 'Create and manage audit procedure templates and workflows',
      icon: <ReportIcon sx={{ fontSize: 40, color: 'warning.main' }} />,
      link: '/procedures',
      count: '25 Active Procedures'
    }
  ]

  return (
    <Box>
      <Box sx={{ mb: 4 }}>
        <Typography variant="h4" gutterBottom>
          Admin Portal
        </Typography>
        <Typography variant="body1" color="text.secondary">
          Welcome, {user?.firstName}! Manage your audit firm from here.
        </Typography>
        <Chip 
          label={`${user?.role} Access`} 
          color="primary" 
          sx={{ mt: 1 }}
        />
      </Box>

      <Grid container spacing={3}>
        {adminCards.map((card) => (
          <Grid item xs={12} md={4} key={card.title}>
            <Card 
              sx={{ 
                height: '100%', 
                display: 'flex', 
                flexDirection: 'column',
                transition: 'transform 0.2s',
                '&:hover': {
                  transform: 'translateY(-4px)',
                  boxShadow: 3
                }
              }}
            >
              <CardContent sx={{ flexGrow: 1, textAlign: 'center', p: 3 }}>
                <Box sx={{ mb: 2 }}>
                  {card.icon}
                </Box>
                <Typography variant="h6" gutterBottom>
                  {card.title}
                </Typography>
                <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                  {card.description}
                </Typography>
                <Chip 
                  label={card.count} 
                  size="small" 
                  variant="outlined" 
                  sx={{ mb: 2 }}
                />
                <Box>
                  <Button
                    component={Link}
                    to={card.link}
                    variant="contained"
                    startIcon={<AddIcon />}
                    fullWidth
                  >
                    Manage
                  </Button>
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Box sx={{ mt: 4 }}>
        <Grid container spacing={3}>
          <Grid item xs={12} md={8}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom>
                  Recent Activity
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  • John Doe completed Bank Confirmation procedure for Acme Corp
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  • New user Sarah Wilson added to the team
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  • Quarterly report generated for Tech Solutions Ltd
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  • Audit procedure template updated for Cash Flow Analysis
                </Typography>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} md={4}>
            <Card>
              <CardContent>
                <Typography variant="h6" gutterBottom>
                  Quick Actions
                </Typography>
                <Button
                  component={Link}
                  to="/admin/companies"
                  variant="outlined"
                  fullWidth
                  sx={{ mb: 1 }}
                >
                  Add New Company
                </Button>
                <Button
                  component={Link}
                  to="/admin/users"
                  variant="outlined"
                  fullWidth
                  sx={{ mb: 1 }}
                >
                  Invite User
                </Button>
                <Button
                  component={Link}
                  to="/procedures"
                  variant="outlined"
                  fullWidth
                >
                  Create Procedure
                </Button>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      </Box>
    </Box>
  )
}

export default AdminPortal