---
title: Performance Monitoring
description: What to monitor, what good looks like, and how to troubleshoot slowness
---

# 📊 Performance Monitoring

Performance issues in audit systems usually show up as “the app feels slow” during peak fieldwork.

This page defines what to monitor and how to triage performance problems at a practical level.

## What to monitor (core signals)

### User experience

- Page load time for core workflows (procedures, workpapers, documents, reporting)
- Search responsiveness (global search, document search)
- File upload time and reliability

### Application health

- Error rate (4xx/5xx) and where errors cluster
- Latency percentiles (p50/p95/p99)
- Background job throughput (if used for reporting generation, imports, etc.)

### Data layer

- Query latency hotspots (slow queries)
- Locking/contention during peak activity
- Storage performance for document reads/writes

## Common hotspots in audit workflows

- Document-heavy engagements (many uploads, previews, downloads)
- Wide trial balances / large report generation
- Reviewer dashboards that aggregate many statuses
- Search over large datasets

## Troubleshooting checklist

When users report slowness:

1) Identify the workflow: procedures, workpapers, documents, or reporting.
2) Check if it’s isolated:
	- One engagement only
	- One user only
	- One geographic region/network
3) Look for correlated signals:
	- Spikes in latency
	- Spikes in error rate
	- Spikes in upload failures
4) Validate whether the issue is data-driven:
	- Large files
	- Large result sets
	- Long date ranges

## Scaling considerations (conceptual)

- Favor pagination and incremental loading for lists
- Ensure reporting generation is bounded and observable (progress + timeouts)
- Keep document operations resilient (retry where safe, avoid re-upload loops)

## Related docs

- [Documents module](/docs/modules/documents/overview)
- [Reporting module](/docs/modules/reporting/overview)
- [Security Overview](/docs/security/overview) (audit trail can affect performance if not designed carefully)
