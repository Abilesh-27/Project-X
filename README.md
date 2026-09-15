# Sahayak (Work Solute) — Cooperative Home Services Platform

**Sahayak** is a cooperative-owned digital marketplace connecting verified Labour Cooperative Society workers — electricians, plumbers, cleaners, carpenters, caregivers, drivers, gardeners, and technicians — with households and institutions, while ensuring fair wages, worker welfare, and transparent, cooperative-governed service delivery.

This repository is a monorepo containing all four applications that make up the platform.

---

## Repository Structure

```
Project-X/
├── work_solute_customer_app/          # Customer mobile app (Flutter)
├── Work_Solute_Worker_App/            # Worker mobile app (Flutter)
├── Work_Solute_Cooperative_Society/   # Society admin dashboard (Web)
└── Work_Solute_Cooperative_Federation/ # Federation admin dashboard (Web + API)
```

| Component | Platform | Status |
|---|---|---|
| Customer App | Flutter (Android/iOS/Web/Windows/macOS/Linux) | Active development |
| Worker App | Flutter (Android) | Active development, Phase 5 |
| Cooperative Society Dashboard | Static HTML/CSS/JS (Stitch-generated) | UI prototype |
| Cooperative Federation Dashboard | FastAPI + SQLite backend, HTML/CSS/JS frontend | Functional backend + UI |

---

## 1. Customer App — `work_solute_customer_app/`

The primary consumer-facing app. Households and institutions create service requests, get matched with verified cooperative workers, track jobs in real time, pay, and rate service.

**Stack:** Flutter 3.x / Dart, Material 3, `google_fonts`, `intl` for localization.

**Structure:**
```
lib/
├── core/
│   ├── theme/          # SahayakColors, typography, theme.dart
│   └── localization/   # app_strings.dart — en, hi, ta, ml
├── data/
│   ├── models/          # language, service, user, booking, worker, address, invoice, coordinator
│   └── repositories/    # app_repository.dart
└── ui/
    ├── features/
    │   ├── onboarding/
    │   ├── marketplace/       # Home & service discovery
    │   ├── booking_wizard/    # Request creation flow
    │   ├── booking_status/    # Worker matching, tracking
    │   ├── bookings_list/     # My Bookings
    │   └── profile/
    └── shared_widgets/
```

**Key implemented business rules:**
- Doorstep 4-digit job-start OTP verification
- 1-hour free cancellation policy
- Multi-domain/multi-trade request matching
- Transparent cooperative pricing (visit/diagnostic fee separated from labor and material cost)
- Institution accounts: sequential site naming (Office 1, Office 2…), per-domain coordinator contacts, consolidated invoicing
- Full multilingual support: English, Hindi, Tamil, Malayalam
- 3-tab navigation: Home, Bookings, Profile (deliberately no unrelated tabs/features)

**Run:**
```bash
cd work_solute_customer_app
flutter pub get
flutter run
```

---

## 2. Worker App — `Work_Solute_Worker_App/`

The field-worker-facing app (active project at `stitch_worker/`). Workers receive job requests, accept/decline, navigate to the customer, verify arrival via OTP, log diagnosis and materials, and collect payment.

**Stack:** Flutter / Dart, Material 3, full localization (en/hi/ta/ml), extensive automated test suite (unit, widget, responsive, multi-locale, scrolling).

**Structure:**
```
stitch_worker/
├── lib/
│   ├── app/
│   ├── core/
│   ├── features/
│   └── l10n/
└── test/
```

**Notable screens:** Home Dashboard, Institution Dashboard, Earnings Dashboard, Schedule, Report Delay, Cancel Job, Reschedule, Customer Unavailable, Notifications, Settings, Support, SOS, Courses, Schemes.

See `PLAN.md` for the full build specification and `HANDOFF.md` for current phase status and test results.

**Run:**
```bash
cd Work_Solute_Worker_App/stitch_worker
flutter pub get
flutter gen-l10n
flutter run
```

---

## 3. Cooperative Society Dashboard — `Work_Solute_Cooperative_Society/`

Web dashboard for local Cooperative Society administrators: worker management, booking/service management, institutional booking flow, worker welfare & social security, payments/earnings & federation settlement, reports & analytics, and platform fee configuration.

**Stack:** Static HTML/CSS/JS (Stitch-exported UI). Currently a UI prototype — no backend service implemented yet in this repo.

**Pages** (`admin/`): executive overview dashboard, worker management directory, booking & service management, institutional booking flow, worker welfare & social security, payment/earnings & federation settlement, reports & analytics, settings — dual platform fee rules, civic union labour governance.

**Run:** open any page's `index.html` directly, or serve the folder with a static file server:
```bash
cd "Work_Solute_Cooperative_Society/Co-operative Society"
python -m http.server 8080
```

---

## 4. Cooperative Federation Dashboard — `Work_Solute_Cooperative_Federation/`

Top-level governance dashboard: society management (CRUD), financial monitoring, welfare monitoring, training & certifications, and AI-driven demand forecasting review.

**Stack:** FastAPI + SQLite backend (Python), static HTML/CSS/JS frontend, session-based auth.

**API endpoints:**
```
GET  /api/health
POST /api/auth/login
POST /api/auth/logout
GET  /api/auth/me
GET  /api/dashboard
GET  /api/societies        POST /api/societies
PUT  /api/societies/{id}   DELETE /api/societies/{id}
GET  /api/financials
GET  /api/welfare
GET  /api/ai-forecast
GET  /api/training
GET  /api/notifications
```

**Run:**
```bash
cd Work_Solute_Cooperative_Federation/Cooperative_Federation
python -m venv .venv
source .venv/bin/activate        # or .\.venv\Scripts\Activate.ps1 on Windows
pip install -r requirements.txt
python run.py
```
Open `http://127.0.0.1:8000/`

**Demo login:** `admin@sahayak.coop` / `admin123`
SQLite database auto-creates at `data/federation.db` with seed data for Coimbatore-area societies on first run.

---

## Platform-Wide Principles

- **Cooperative ownership over gig-economy extraction** — workers are cooperative members, not independent gig contractors
- **Fair-work distribution** — worker ranking optimizes for skill/distance/rating first; fairness only breaks near-ties, never overrides a genuinely better match
- **Human-in-the-loop AI** — demand forecasting recommends workforce reallocation; a Federation/Society admin always approves, never fully automated
- **Tiered, transparent platform fees** — 10% for households (full service amount), 18% for institutions (visit/diagnostic charge only — labor and material cost pass through fee-free)
- **Multilingual by default** — English, Hindi, Tamil, Malayalam across customer and worker apps

## Tech Stack Summary

| Layer | Technology |
|---|---|
| Customer & Worker Apps | Flutter / Dart |
| Society & Federation Dashboards | HTML/CSS/JS, FastAPI (Federation) |
| Federation Database | SQLite (dev) → PostgreSQL (planned production path) |
| Localization | 4 languages: en, hi, ta, ml |

## Contributing

This is an active, in-development cooperative platform project. See each component's own `PLAN.md`/`HANDOFF.md` (where present) for current phase status before starting new work.

## License

_Add your chosen license here._
