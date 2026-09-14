# Work Solute Cooperative Federation — Full-Stack Python Build

This version keeps the Stitch HTML/CSS content and adds a Python FastAPI backend with SQLite for realistic federation data, authentication, dashboard metrics, society CRUD, financial summaries, welfare data, AI workforce forecasting, training data, and notifications.

## Requirements
- Python 3.10+

## Install
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## Run
```powershell
python run.py
```
Open `http://127.0.0.1:8000/`

## Demo login
- Email: `admin@sahayak.coop`
- Password: `admin123`

## Database
SQLite is created automatically at `data/federation.db` on first run. Seed values are district-level demonstration data for Coimbatore and nearby areas. The schema is intentionally simple so it can later be migrated to PostgreSQL.

## API
- `GET /api/health`
- `POST /api/auth/login`
- `POST /api/auth/logout`
- `GET /api/auth/me`
- `GET /api/dashboard`
- `GET /api/societies`
- `POST /api/societies`
- `PUT /api/societies/{id}`
- `DELETE /api/societies/{id}`
- `GET /api/financials`
- `GET /api/welfare`
- `GET /api/ai-forecast`
- `GET /api/training`
- `GET /api/notifications`
