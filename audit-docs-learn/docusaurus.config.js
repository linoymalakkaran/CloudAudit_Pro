// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer').themes.github;
const darkCodeTheme = require('prism-react-renderer').themes.dracula;

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'CloudAudit Pro Learning Hub',
  tagline: 'Master Modern Audit Management - A Complete Guide for Everyone',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://your-docusaurus-test-site.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  baseUrl: '/',

  // GitHub pages deployment config.
  organizationName: 'cloudaudit', // Usually your GitHub org/user name.
  projectName: 'learning-hub', // Usually your repo name.

  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang.
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Remove this to remove the "edit this page" links.
          editUrl: undefined,
        },
        blog: {
          showReadingTime: true,
          // Remove this to remove the "edit this page" links.
          editUrl: undefined,
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'CloudAudit Pro',
        logo: {
          alt: 'CloudAudit Pro Logo',
          src: 'img/logo.svg',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'Learning Hub',
          },
          {
            to: '/docs/reference/glossary',
            label: 'Glossary',
            position: 'left'
          },
          {
            to: '/docs/examples/overview',
            label: 'Examples',
            position: 'left'
          },
          {
            href: 'https://github.com/cloudaudit/pro',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Documentation',
            items: [
              {
                label: 'Getting Started',
                to: '/docs/intro',
              },
              {
                label: 'Audit Basics',
                to: '/docs/basics/what-is-auditing',
              },
              {
                label: 'User Roles',
                to: '/docs/actors/overview',
              },
            ],
          },
          {
            title: 'Learn',
            items: [
              {
                label: 'Business Processes',
                to: '/docs/processes/audit-lifecycle',
              },
              {
                label: 'Modules',
                to: '/docs/modules/company/overview',
              },
              {
                label: 'Examples',
                to: '/docs/examples/overview',
              },
            ],
          },
          {
            title: 'Reference',
            items: [
              {
                label: 'Glossary',
                to: '/docs/reference/glossary',
              },
              {
                label: 'Quick Guides',
                to: '/docs/reference/quick-guides/overview',
              },
              {
                label: 'FAQ',
                to: '/docs/reference/faq',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/cloudaudit/pro',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} CloudAudit Pro. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        additionalLanguages: ['typescript', 'javascript', 'json', 'bash'],
      },
      algolia: {
        // Public API key: safe to commit
        appId: 'YOUR_APP_ID',
        apiKey: 'YOUR_SEARCH_API_KEY',
        indexName: 'cloudaudit_pro',
        // Optional: see doc section below
        contextualSearch: true,
      },
      docs: {
        sidebar: {
          hideable: true,
          autoCollapseCategories: true,
        },
      },
      colorMode: {
        defaultMode: 'light',
        disableSwitch: false,
        respectPrefersColorScheme: true,
      },
    }),

  markdown: {
    mermaid: true,
  },
  themes: ['@docusaurus/theme-mermaid'],
};

module.exports = config;
