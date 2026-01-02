---
title: Security Overview
description: Practical security model, access controls, and audit trail expectations
---

# 🔐 Security Overview

This page summarizes the security concepts that matter day-to-day: who can see what, how actions are tracked, and how evidence is protected.

It is intentionally implementation-agnostic (exact settings may vary by deployment), but it sets consistent expectations.

## Security goals for audit work

- Confidentiality: only authorized users can access client data
- Integrity: evidence and conclusions are protected from tampering
- Traceability: key actions are recorded with actor + time + context
- Availability: authorized users can work without disruption

## Authentication (who you are)

Typical expectations:

- Users sign in with a unique identity (no shared accounts)
- Strong password policy and/or SSO (when available)
- Multi-factor authentication for privileged roles

## Authorization (what you can do)

Access should be role-based and scoped:

- By engagement/company (a user should not see other clients by default)
- By module and permission (view/create/edit/approve)
- By document sensitivity (restricted evidence)

Role context:

- Privileged setup and access controls are typically owned by Admin/Super Admin roles.

## Audit trail (what happened)

For an audit platform, the audit trail is part of the product’s credibility.

At minimum, record:

- Authentication events (login/logout, failures)
- Evidence/document actions (upload, replace, delete, download)
- Workflow actions (status changes, sign-offs, returns)
- Key record edits (procedures, workpapers, reporting outputs)

Each event should capture:

- Who did it (user)
- When (timestamp)
- What changed (before/after where feasible)
- Where (engagement/company, record id)

## Document protection

Good defaults:

- Restrict who can download/export sensitive documents
- Require justification or elevated role for deletion
- Prefer “supersede/replace” with history over hard overwrite
- Ensure evidence is linked to the relevant [Procedures](/docs/modules/procedures/overview) and [Workpapers](/docs/modules/workpapers/overview)

## Operational practices

- Use least privilege (grant only what’s needed)
- Review access when team members roll on/off engagements
- Treat “Returned with notes” workflows as controlled changes (see [Status Guide](/docs/reference/quick-guides/status-guide))

## Related documentation

- [Meet the Team - User Roles](/docs/actors/overview)
- [Status Guide](/docs/reference/quick-guides/status-guide)
- [Documents module](/docs/modules/documents/overview)
