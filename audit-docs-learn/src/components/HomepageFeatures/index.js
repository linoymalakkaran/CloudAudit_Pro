import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: '📚 Learn from Scratch',
    description: (
      <>
        No prior knowledge of auditing or accounting required. Start with the basics 
        and progressively build your understanding with simple, clear explanations.
      </>
    ),
  },
  {
    title: '👥 Follow Real People',
    description: (
      <>
        Meet Sarah the Senior Auditor, Mike the Manager, and other personas. 
        Follow their day-to-day workflows and see how they use CloudAudit Pro.
      </>
    ),
  },
  {
    title: '🔄 See Complete Processes',
    description: (
      <>
        Follow data from initial import through to final reports. Understand 
        every step of the audit journey with real-world examples and sample data.
      </>
    ),
  },
  {
    title: '💼 Real-World Examples',
    description: (
      <>
        Learn with complete scenarios: ABC Manufacturing's year-end audit, 
        XYZ Retail's interim review, and more. Sample data included.
      </>
    ),
  },
  {
    title: '🎯 Visual Learning',
    description: (
      <>
        Understand complex concepts with diagrams, flowcharts, and visual aids. 
        Every process is illustrated for easy comprehension.
      </>
    ),
  },
  {
    title: '📖 Complete Reference',
    description: (
      <>
        100+ term glossary, quick reference guides, FAQs, and data dictionary. 
        Everything you need in one place.
      </>
    ),
  },
];

function Feature({title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className={styles.featureCard}>
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className={styles.learningPaths}>
          <h2>🚀 Choose Your Learning Path</h2>
          <div className={styles.pathsContainer}>
            <div className={styles.pathCard}>
              <h3>🌟 Complete Beginner</h3>
              <p>New to auditing? Start here!</p>
              <ol>
                <li>Understanding the Basics</li>
                <li>Meet the Team</li>
                <li>The Audit Journey</li>
                <li>Try Real Examples</li>
              </ol>
              <a href="/docs/basics/what-is-auditing" className="button button--primary">
                Start Here
              </a>
            </div>
            
            <div className={styles.pathCard}>
              <h3>👔 Audit Professional</h3>
              <p>Experienced auditor learning the system</p>
              <ol>
                <li>User Roles & Permissions</li>
                <li>Business Processes</li>
                <li>Procedures & Workpapers</li>
                <li>Reporting & Analytics</li>
              </ol>
              <a href="/docs/actors/overview" className="button button--primary">
                Jump In
              </a>
            </div>
            
            <div className={styles.pathCard}>
              <h3>💻 Technical User</h3>
              <p>Developer or IT professional</p>
              <ol>
                <li>System Overview</li>
                <li>Architecture & Data Flow</li>
                <li>Module Documentation</li>
                <li>Integration Guide</li>
              </ol>
              <a href="/docs/basics/system-overview" className="button button--primary">
                Dive Deep
              </a>
            </div>
          </div>
        </div>

        <div className={styles.featuresSection}>
          <h2>✨ What Makes This Different</h2>
          <div className="row">
            {FeatureList.map((props, idx) => (
              <Feature key={idx} {...props} />
            ))}
          </div>
        </div>

        <div className={styles.statsSection}>
          <h2>📊 What's Inside</h2>
          <div className={styles.statsGrid}>
            <div className={styles.statCard}>
              <div className={styles.statNumber}>12+</div>
              <div className={styles.statLabel}>System Modules</div>
            </div>
            <div className={styles.statCard}>
              <div className={styles.statNumber}>7</div>
              <div className={styles.statLabel}>User Roles</div>
            </div>
            <div className={styles.statCard}>
              <div className={styles.statNumber}>50+</div>
              <div className={styles.statLabel}>Step-by-Step Guides</div>
            </div>
            <div className={styles.statCard}>
              <div className={styles.statNumber}>100+</div>
              <div className={styles.statLabel}>Diagrams & Examples</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
