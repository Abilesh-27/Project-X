# Perur Workers Cooperative Society — Labour Service Platform

This implementation uses the Google Stitch export as the primary UI source and adds a connected demo application layer around it.

## Entry points
- `index.html` — role selection
- `login.html` — demo role login
- `executive_overview_dashboard/index.html` — Stitch admin overview
- `dispatch.html` — service allocation and dispatch control
- `customer.html` — household/institutional customer portal
- `worker.html` — worker portal
- `booking-create.html` — service request / institutional booking form
- `invoice.html` — invoices, payments and earnings split
- `notifications.html` — notification centre

## Data
Demo operational state is stored in browser `localStorage` under `perur-coop-demo-v1`. Replace this layer with your backend/API, authentication provider, database, payment gateway and real GPS/map services for production deployment.

## Business rules represented
- Operating district: Coimbatore district
- Fixed platform/service fee (not percentage based)
- Household and institutional workflows
- Previous-day institutional booking guidance
- Worker allocation using skill, availability, workload and service area
- Onsite-only location/journey tracking
- Service timeline: Assigned → Journey Started → Arrived → Service Started → Service Completed
- XGBoost is the designated demand forecasting algorithm
- Monthly vs all-time financial reporting labels
