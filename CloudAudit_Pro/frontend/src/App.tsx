import React, { useState, useEffect } from 'react'
import { ThemeProvider, createTheme } from '@mui/material/styles'
import { CssBaseline } from '@mui/material'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import Login from './pages/Login'
import Register from './pages/Register'
import AdminPortal from './pages/admin/AdminPortal'
import ClientPortal from './pages/client/ClientPortal'
import AuditorPortal from './pages/auditor/AuditorPortal'
import Companies from './pages/admin/Companies'
import Users from './pages/admin/Users'
import AuditProcedures from './pages/auditor/AuditProcedures'
import Reports from './pages/Reports'
import Documents from './pages/Documents'
import GeneralLedger from './pages/GeneralLedger'
import FinancialStatements from './pages/FinancialStatements'
import AuditProceduresNew from './pages/AuditProcedures'
import ProcedureDetails from './pages/ProcedureDetails'
import TemplateLibrary from './pages/TemplateLibrary'
import MyWork from './pages/MyWork'
import KanbanBoard from './pages/KanbanBoard'
import CalendarView from './pages/CalendarView'
import CurrencyMaster from './pages/master/CurrencyMaster'
import BankMaster from './pages/master/BankMaster'
import FixedAssetSchedule from './pages/schedules/FixedAssetSchedule'
import LiabilitySchedule from './pages/schedules/LiabilitySchedule'
import EquitySchedule from './pages/schedules/EquitySchedule'
import ReviewPointManagement from './pages/review/ReviewPointManagement'
import ManagerReviewList from './pages/review/ManagerReviewList'
import AuditFinalization from './pages/audit/AuditFinalization'
import { AdminDashboard } from './components/admin/AdminDashboard'
import { UserManagement } from './components/admin/UserManagement'
import { InviteUser } from './components/admin/InviteUser'
import { PendingApprovals } from './components/admin/PendingApprovals'
import { AuthProvider, useAuth } from './contexts/AuthContext'

const theme = createTheme({
  palette: {
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
    background: {
      default: '#f5f5f5',
    },
  },
  typography: {
    h4: {
      fontWeight: 600,
    },
    h6: {
      fontWeight: 600,
    },
  },
})

function AppRoutes() {
  const { user, isAuthenticated } = useAuth()

  return (
    <Routes>
      {/* Regular Application Routes */}
      {!isAuthenticated ? (
        <>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="*" element={<Login />} />
        </>
      ) : (
        <Layout>
          <Route path="/" element={<Dashboard />} />
          
          {/* Admin Routes */}
          {(user?.role === 'ADMIN' || user?.role === 'MANAGER') && (
            <>
              <Route path="/admin" element={<AdminDashboard userRole={user.role} />} />
              <Route path="/admin/dashboard" element={<AdminDashboard userRole={user.role} />} />
              <Route path="/admin/users" element={<UserManagement userRole={user.role} />} />
              <Route path="/admin/users/invite" element={<InviteUser userRole={user.role} />} />
              <Route path="/admin/users/pending" element={<PendingApprovals userRole={user.role} />} />
              <Route path="/admin/companies" element={<Companies />} />
              <Route path="/admin/currency" element={<CurrencyMaster />} />
              <Route path="/admin/banks" element={<BankMaster />} />
              <Route path="/schedules/fixed-assets" element={<FixedAssetSchedule />} />
              <Route path="/schedules/liabilities" element={<LiabilitySchedule />} />
              <Route path="/schedules/equity" element={<EquitySchedule />} />
              <Route path="/review/points" element={<ReviewPointManagement />} />
              <Route path="/review/manager" element={<ManagerReviewList />} />
              <Route path="/audit/finalize" element={<AuditFinalization />} />
            </>
          )}
          
          {/* Auditor Routes */}
          {(user?.role === 'ADMIN' || user?.role === 'MANAGER' || user?.role === 'SENIOR_AUDITOR' || user?.role === 'AUDITOR') && (
            <>
              <Route path="/auditor" element={<AuditorPortal />} />
              <Route path="/procedures" element={<AuditProcedures />} />
              <Route path="/audit/procedures" element={<AuditProceduresNew />} />
              <Route path="/audit/procedures/:id" element={<ProcedureDetails />} />
              <Route path="/audit/kanban" element={<KanbanBoard />} />
              <Route path="/audit/calendar" element={<CalendarView />} />
              <Route path="/audit/templates" element={<TemplateLibrary />} />
              <Route path="/audit/my-work" element={<MyWork />} />
              <Route path="/documents" element={<Documents />} />
              <Route path="/ledger" element={<GeneralLedger />} />
              <Route path="/financial-statements" element={<FinancialStatements />} />
            </>
          )}
          
          {/* Client Routes */}
          <Route path="/client" element={<ClientPortal />} />
          
          {/* Common Routes */}
          <Route path="/reports" element={<Reports />} />
          
          <Route path="*" element={<Dashboard />} />
        </Layout>
      )}
    </Routes>
  )
}

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Router>
        <AuthProvider>
          <AppRoutes />
        </AuthProvider>
      </Router>
    </ThemeProvider>
  )
}

export default App