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
import CountryMaster from './pages/master/CountryMaster'
import FixedAssetSchedule from './pages/schedules/FixedAssetSchedule'
import LiabilitySchedule from './pages/schedules/LiabilitySchedule'
import EquitySchedule from './pages/schedules/EquitySchedule'
import ReviewPointManagement from './pages/review/ReviewPointManagement'
import ManagerReviewList from './pages/review/ManagerReviewList'
import AuditFinalization from './pages/audit/AuditFinalization'
import SamplingPlan from './pages/SamplingPlan'
import SubstantiveTesting from './pages/SubstantiveTesting'
import InternalControls from './pages/InternalControls'
import { AdminDashboard } from './components/admin/AdminDashboard'
import { UserManagement } from './components/admin/UserManagement'
import { InviteUser } from './components/admin/InviteUser'
import { PendingApprovals } from './components/admin/PendingApprovals'
import { AuthProvider, useAuth } from './contexts/AuthContext'

// Phase 6: Reporting & Analytics Pages
import ReportsDashboard from './pages/reports/ReportsDashboard'
import ReportGenerator from './pages/reports/ReportGenerator'
import ReportViewer from './pages/reports/ReportViewer'
import ReportTemplates from './pages/reports/ReportTemplates'
import ReportScheduler from './pages/reports/ReportScheduler'
import DashboardViewer from './pages/reports/DashboardViewer'
import DashboardBuilder from './pages/reports/DashboardBuilder'
import AnalyticsOverview from './pages/reports/AnalyticsOverview'

// Phase 7: System Utilities Pages
import SystemSettings from './pages/SystemSettings'
import NotificationsCenter from './pages/NotificationsCenter'
import UserPreferences from './pages/UserPreferences'
import DataImportExport from './pages/DataImportExport'
import IntegrationsManager from './pages/IntegrationsManager'

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

  if (!isAuthenticated) {
    return (
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="*" element={<Login />} />
      </Routes>
    )
  }

  return (
    <Layout>
      <Routes>
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
            <Route path="/admin/countries" element={<CountryMaster />} />
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
            
            {/* Phase 4: Advanced Testing Routes */}
            <Route path="/testing/sampling" element={<SamplingPlan />} />
            <Route path="/testing/substantive" element={<SubstantiveTesting />} />
            <Route path="/testing/controls" element={<InternalControls />} />
          </>
        )}
        
        {/* Client Routes */}
        <Route path="/client" element={<ClientPortal />} />
        
        {/* Common Routes */}
        <Route path="/reports" element={<Reports />} />
        
        {/* Phase 6: Reporting & Analytics Routes */}
        <Route path="/reports/dashboard" element={<ReportsDashboard />} />
        <Route path="/reports/generate" element={<ReportGenerator />} />
        <Route path="/reports/:id" element={<ReportViewer />} />
        <Route path="/report-templates" element={<ReportTemplates />} />
        <Route path="/report-schedules" element={<ReportScheduler />} />
        <Route path="/dashboards" element={<DashboardViewer />} />
        <Route path="/dashboards/builder" element={<DashboardBuilder />} />
        <Route path="/analytics" element={<AnalyticsOverview />} />
        
        {/* Phase 7: System Utilities Routes */}
        <Route path="/settings/system" element={<SystemSettings />} />
        <Route path="/notifications" element={<NotificationsCenter />} />
        <Route path="/settings/preferences" element={<UserPreferences />} />
        <Route path="/data/import-export" element={<DataImportExport />} />
        <Route path="/settings/integrations" element={<IntegrationsManager />} />
        
        <Route path="*" element={<Dashboard />} />
      </Routes>
    </Layout>
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