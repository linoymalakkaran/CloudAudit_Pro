/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  // Main tutorial sidebar
  tutorialSidebar: [
    {
      type: 'doc',
      id: 'intro',
      label: '👋 Welcome',
    },
    {
      type: 'category',
      label: '📚 Understanding the Basics',
      collapsed: false,
      items: [
        'basics/what-is-auditing',
        'basics/audit-terminology',
        'basics/system-overview',
        'basics/why-cloudaudit-pro',
      ],
    },
    {
      type: 'category',
      label: '👥 Meet the Team - User Roles',
      collapsed: true,
      items: [
        'actors/overview',
        'actors/super-admin',
        'actors/admin',
        'actors/manager',
        'actors/senior-auditor',
        'actors/auditor',
        'actors/intern',
        'actors/client',
      ],
    },
    {
      type: 'category',
      label: '🔄 The Audit Journey - Business Processes',
      collapsed: true,
      items: [
        'processes/audit-lifecycle',
        'processes/01-setup',
        'processes/02-planning',
        'processes/03-trial-balance',
        'processes/04-execution',
        'processes/05-review',
        'processes/06-reporting',
        'processes/07-completion',
      ],
    },
    {
      type: 'category',
      label: '🧩 System Modules - Features Deep Dive',
      collapsed: true,
      items: [
        {
          type: 'category',
          label: '🏢 Company Management',
          items: [
            'modules/company/overview',
            'modules/company/setup',
            'modules/company/configuration',
            'modules/company/lifecycle',
          ],
        },
        {
          type: 'category',
          label: '📅 Period Management',
          items: [
            'modules/periods/overview',
            'modules/periods/creating-periods',
            'modules/periods/period-lifecycle',
          ],
        },
        {
          type: 'category',
          label: '📊 Chart of Accounts',
          items: [
            'modules/accounts/overview',
            'modules/accounts/account-types',
            'modules/accounts/account-structure',
            'modules/accounts/setup-guide',
          ],
        },
        {
          type: 'category',
          label: '⚖️ Trial Balance',
          items: [
            'modules/trial-balance/overview',
            'modules/trial-balance/understanding-tb',
            'modules/trial-balance/importing-data',
            'modules/trial-balance/working-with-tb',
          ],
        },
        {
          type: 'category',
          label: '✅ Audit Procedures',
          items: [
            'modules/procedures/overview',
            'modules/procedures/understanding-procedures',
            'modules/procedures/creating-procedures',
            'modules/procedures/workflow',
            'modules/procedures/templates',
          ],
        },
        {
          type: 'category',
          label: '📝 Workpapers & Findings',
          items: [
            'modules/workpapers/overview',
            'modules/workpapers/creating-workpapers',
            'modules/workpapers/findings',
            'modules/workpapers/evidence',
          ],
        },
        {
          type: 'category',
          label: '📖 Journal Entries',
          items: [
            'modules/journals/overview',
            'modules/journals/understanding-adjustments',
            'modules/journals/creating-entries',
            'modules/journals/approval-workflow',
          ],
        },
        {
          type: 'category',
          label: '📄 Financial Statements',
          items: [
            'modules/statements/overview',
            'modules/statements/balance-sheet',
            'modules/statements/income-statement',
            'modules/statements/cash-flow',
            'modules/statements/generation',
          ],
        },
        {
          type: 'category',
          label: '📁 Document Management',
          items: [
            'modules/documents/overview',
            'modules/documents/uploading',
            'modules/documents/organizing',
            'modules/documents/linking',
          ],
        },
        {
          type: 'category',
          label: '📈 Reporting & Analytics',
          items: [
            'modules/reporting/overview',
            'modules/reporting/dashboards',
            'modules/reporting/reports',
            'modules/reporting/analytics',
          ],
        },
        {
          type: 'category',
          label: '🌐 Client Portal',
          items: [
            'modules/client-portal/overview',
            'modules/client-portal/onboarding',
            'modules/client-portal/communication',
            'modules/client-portal/document-submission',
          ],
        },
        {
          type: 'category',
          label: '🔔 Notifications',
          items: [
            'modules/notifications/overview',
            'modules/notifications/types',
            'modules/notifications/preferences',
          ],
        },
      ],
    },
    {
      type: 'category',
      label: '🔄 Data Flow & Transformations',
      collapsed: true,
      items: [
        'data-flow/overview',
        'data-flow/tb-to-fs',
        'data-flow/procedure-to-report',
        'data-flow/document-flow',
        'data-flow/complete-lifecycle',
      ],
    },
    {
      type: 'category',
      label: '💼 Real-World Examples',
      collapsed: true,
      items: [
        'examples/overview',
        {
          type: 'category',
          label: 'Sample Companies',
          items: [
            'examples/companies/abc-manufacturing',
            'examples/companies/xyz-retail',
            'examples/companies/tech-startup',
          ],
        },
        {
          type: 'category',
          label: 'Complete Scenarios',
          items: [
            'examples/scenarios/year-end-audit',
            'examples/scenarios/interim-review',
            'examples/scenarios/first-time-setup',
            'examples/scenarios/multi-location',
          ],
        },
        {
          type: 'category',
          label: 'Sample Data',
          items: [
            'examples/data/trial-balance-samples',
            'examples/data/chart-of-accounts',
            'examples/data/procedures',
          ],
        },
      ],
    },
    {
      type: 'category',
      label: '📖 Reference Materials',
      collapsed: true,
      items: [
        'reference/glossary',
        {
          type: 'category',
          label: 'Quick Guides',
          items: [
            'reference/quick-guides/overview',
            'reference/quick-guides/keyboard-shortcuts',
            'reference/quick-guides/common-tasks',
            'reference/quick-guides/status-guide',
          ],
        },
        'reference/faq',
        'reference/data-dictionary',
      ],
    },
  ],
};

module.exports = sidebars;
