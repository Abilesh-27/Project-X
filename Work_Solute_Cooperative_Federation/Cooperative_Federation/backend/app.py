from fastapi import FastAPI, Depends, HTTPException, Request
from fastapi.responses import FileResponse, RedirectResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.sessions import SessionMiddleware
from pydantic import BaseModel, Field
import sqlite3, os, secrets
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / 'data' / 'federation.db'

app = FastAPI(title='Work Solute Cooperative Federation API', version='1.0.0')
app.add_middleware(SessionMiddleware, secret_key=os.getenv('SESSION_SECRET', 'dev-only-change-me'))
app.add_middleware(CORSMiddleware, allow_origins=['*'], allow_credentials=True, allow_methods=['*'], allow_headers=['*'])

class Login(BaseModel):
    email: str
    password: str

class SocietyIn(BaseModel):
    name: str = Field(min_length=3, max_length=120)
    district: str = Field(min_length=2, max_length=80)
    registration_no: str = Field(min_length=3, max_length=40)
    workers: int = Field(ge=0, le=20000)
    customers: int = Field(ge=0, le=200000)
    status: str = Field(pattern='^(ACTIVE|INACTIVE|PENDING)$')


def db():
    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    DB.parent.mkdir(parents=True, exist_ok=True)
    con = db()
    cur = con.cursor()
    cur.executescript('''
    CREATE TABLE IF NOT EXISTS societies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      district TEXT NOT NULL,
      registration_no TEXT NOT NULL UNIQUE,
      status TEXT NOT NULL DEFAULT 'ACTIVE',
      workers INTEGER NOT NULL DEFAULT 0,
      customers INTEGER NOT NULL DEFAULT 0,
      monthly_revenue REAL NOT NULL DEFAULT 0,
      welfare_coverage REAL NOT NULL DEFAULT 0,
      rating REAL NOT NULL DEFAULT 4.5,
      monthly_bookings INTEGER NOT NULL DEFAULT 0
    );
    CREATE TABLE IF NOT EXISTS financials (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      period TEXT UNIQUE NOT NULL,
      gmv REAL NOT NULL,
      worker_earnings REAL NOT NULL,
      federation_reserve REAL NOT NULL,
      welfare_disbursement REAL NOT NULL
    );
    CREATE TABLE IF NOT EXISTS notifications (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      body TEXT NOT NULL,
      level TEXT NOT NULL DEFAULT 'info',
      created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    ''')
    if cur.execute('SELECT COUNT(*) FROM societies').fetchone()[0] == 0:
        rows = [
            ('Coimbatore Urban Workers Co-op','Coimbatore North','TN-CBE-001','ACTIVE',168,1480,315000,91.6,4.6,520),
            ('Kovai Rural Workers Co-op','Coimbatore South','TN-CBE-002','ACTIVE',154,1320,276000,90.5,4.5,470),
            ('Sulur Workers Co-op','Sulur','TN-CBE-003','ACTIVE',132,1180,238000,86.7,4.6,410),
            ('Pollachi Workers Co-op','Pollachi','TN-CBE-004','ACTIVE',146,1240,251000,78.4,4.4,445),
            ('Mettupalayam Workers Co-op','Mettupalayam','TN-CBE-005','ACTIVE',121,980,198000,76.7,4.5,360),
            ('Annur Workers Co-op','Annur','TN-CBE-006','ACTIVE',96,820,171000,74.2,4.3,300),
            ('Kinathukadavu Workers Co-op','Kinathukadavu','TN-CBE-007','ACTIVE',108,910,189000,82.3,4.4,328),
            ('Perur Workers Co-op','Perur','TN-CBE-008','ACTIVE',118,1040,214000,84.6,4.5,342),
            ('Madukkarai Workers Co-op','Madukkarai','TN-CBE-009','ACTIVE',101,875,182000,80.1,4.4,315),
            ('Karamadai Workers Co-op','Karamadai','TN-CBE-010','ACTIVE',92,790,164000,77.8,4.3,286),
            ('Gandhipuram Skilled Services Co-op','Coimbatore Central','TN-CBE-011','ACTIVE',138,1210,247000,88.9,4.6,398),
            ('Singanallur Service Workers Co-op','Coimbatore East','TN-CBE-012','ACTIVE',142,1270,261000,89.8,4.5,416),
            ('Saravanampatti Workers Co-op','Coimbatore North East','TN-CBE-013','ACTIVE',126,1130,229000,87.1,4.6,372),
            ('Kuniyamuthur Workers Co-op','Coimbatore South West','TN-CBE-014','ACTIVE',115,1010,205000,81.5,4.4,348),
            ('Vadavalli Workers Co-op','Coimbatore West','TN-CBE-015','ACTIVE',99,870,177000,79.4,4.3,295),
        ]
        cur.executemany('''INSERT INTO societies(name,district,registration_no,status,workers,customers,monthly_revenue,welfare_coverage,rating,monthly_bookings)
          VALUES(?,?,?,?,?,?,?,?,?,?)''', rows)
        cur.executemany('INSERT INTO financials(period,gmv,worker_earnings,federation_reserve,welfare_disbursement) VALUES(?,?,?,?,?)', [
          ('Apr 2026', 3250000, 2600000, 560000, 188000),
          ('May 2026', 3470000, 2780000, 575000, 201000),
          ('Jun 2026', 3680000, 2940000, 590000, 215000),
          ('Jul 2026', 3810000, 3050000, 608000, 226000),
          ('Aug 2026', 3970000, 3180000, 625000, 238000),
          ('Sep 2026 YTD', 2140000, 1710000, 428000, 126000),
        ])
        cur.executemany('INSERT INTO notifications(title,body,level) VALUES(?,?,?)', [
          ('Compliance review completed','14 societies cleared the latest monthly compliance checklist.','success'),
          ('Forecast run ready','Next-day workforce forecast is ready for federation review.','info'),
          ('Welfare claim pending','3 welfare claims are awaiting society-level verification.','warning'),
        ])
    con.commit(); con.close()

init_db()


def current_user(request: Request):
    user = request.session.get('user')
    if not user:
        raise HTTPException(status_code=401, detail='Authentication required')
    return user

@app.get('/api/health')
def health():
    return {'ok': True, 'service': 'work-solute-federation-python'}

@app.post('/api/auth/login')
def login(payload: Login, request: Request):
    if payload.email.strip().lower() != 'admin@sahayak.coop' or payload.password != 'admin123':
        raise HTTPException(status_code=401, detail='Incorrect credentials')
    request.session['user'] = {'name':'V. Sureshkumar','role':'Administrative Officer','email':payload.email.lower()}
    return {'user': request.session['user']}

@app.post('/api/auth/logout')
def logout(request: Request):
    request.session.clear()
    return {'ok': True}

@app.get('/api/auth/me')
def me(user=Depends(current_user)):
    return {'user': user}

@app.get('/api/dashboard')
def dashboard(user=Depends(current_user)):
    con = db(); r = con.execute('''SELECT COUNT(*) societies,SUM(workers) workers,SUM(customers) customers,
      SUM(monthly_revenue) revenue,SUM(monthly_bookings) bookings,AVG(rating) rating,AVG(welfare_coverage) welfare FROM societies''').fetchone()
    active = con.execute("SELECT SUM(workers) FROM societies WHERE status='ACTIVE'").fetchone()[0] or 0
    completed = round((r['bookings'] or 0) * .945); cancelled = round((r['bookings'] or 0) * .033)
    con.close()
    return {'societies':10,'workers':r['workers'] or 0,'activeWorkers':round(active*.84),'customers':r['customers'] or 0,
            'bookings':r['bookings'] or 0,'completedBookings':completed,'cancelledBookings':cancelled,
            'revenue':round(r['revenue'] or 0),'workersEarnings':round((r['revenue'] or 0)*.79),
            'averageRating':round(r['rating'] or 4.5,2),'welfareCoverage':round(r['welfare'] or 0,1)}

@app.get('/api/societies')
def societies(q: str='', status: str='', page: int=1, limit: int=10, user=Depends(current_user)):
    page=max(page,1); limit=min(max(limit,1),50)
    con=db(); params=[]; where=[]
    if q:
        where.append('(name LIKE ? OR district LIKE ? OR registration_no LIKE ?)'); params += [f'%{q}%',f'%{q}%',f'%{q}%']
    if status:
        where.append('status=?'); params.append(status)
    clause=' WHERE '+ ' AND '.join(where) if where else ''
    total=con.execute('SELECT COUNT(*) FROM societies'+clause,params).fetchone()[0]
    rows=con.execute('SELECT * FROM societies'+clause+' ORDER BY name LIMIT ? OFFSET ?',params+[limit,(page-1)*limit]).fetchall()
    con.close(); return {'data':[dict(x) for x in rows],'total':total,'page':page,'limit':limit,'pages':max(1,(total+limit-1)//limit)}

@app.post('/api/societies',status_code=201)
def create_society(payload: SocietyIn, user=Depends(current_user)):
    con=db()
    try:
        con.execute('INSERT INTO societies(name,district,registration_no,status,workers,customers,monthly_revenue,welfare_coverage,rating,monthly_bookings) VALUES(?,?,?,?,?,?,?,?,?,?)',
          (payload.name,payload.district,payload.registration_no,payload.status,payload.workers,payload.customers,0,0,4.5,0))
        con.commit(); row=con.execute('SELECT * FROM societies WHERE registration_no=?',(payload.registration_no,)).fetchone(); con.close(); return dict(row)
    except sqlite3.IntegrityError:
        con.close(); raise HTTPException(status_code=409, detail='Registration number already exists')

@app.put('/api/societies/{sid}')
def update_society(sid:int,payload:SocietyIn,user=Depends(current_user)):
    con=db(); cur=con.execute('UPDATE societies SET name=?,district=?,registration_no=?,status=?,workers=?,customers=? WHERE id=?',
      (payload.name,payload.district,payload.registration_no,payload.status,payload.workers,payload.customers,sid))
    if cur.rowcount==0: con.close(); raise HTTPException(status_code=404, detail='Society not found')
    con.commit(); row=con.execute('SELECT * FROM societies WHERE id=?',(sid,)).fetchone(); con.close(); return dict(row)

@app.delete('/api/societies/{sid}')
def delete_society(sid:int,user=Depends(current_user)):
    con=db(); cur=con.execute('DELETE FROM societies WHERE id=?',(sid,)); con.commit(); con.close()
    if cur.rowcount==0: raise HTTPException(status_code=404, detail='Society not found')
    return {'ok':True}

@app.get('/api/financials')
def financials(user=Depends(current_user)):
    con=db(); rows=con.execute('SELECT * FROM financials ORDER BY id DESC').fetchall(); con.close()
    total=sum(x['gmv'] for x in rows)
    return {'data':[dict(x) for x in rows], 'summary':{'totalGMV':total,'monthlyAverage':round(total/max(len(rows),1)),'workerShare':0.79,'reserve':rows[0]['federation_reserve'] if rows else 0}}

@app.get('/api/welfare')
def welfare(user=Depends(current_user)):
    con=db(); rows=con.execute('SELECT name,district,registration_no,workers,welfare_coverage,rating FROM societies ORDER BY welfare_coverage DESC').fetchall(); con.close()
    return {'data':[dict(x) for x in rows]}

@app.get('/api/ai-forecast')
def ai_forecast(user=Depends(current_user)):
    con=db(); rows=con.execute('SELECT name,district,workers,monthly_bookings FROM societies ORDER BY name').fetchall(); con.close()
    data=[]
    for i,r in enumerate(rows):
        demand=round((r['monthly_bookings']/30)*1.05 + (i%4)*2)
        available=round(r['workers']*.84)
        gap=available-round(demand*.95)
        status='Surplus' if gap>3 else 'Balanced' if gap>=-2 else 'Shortage'
        data.append({'society':r['name'],'district':r['district'],'current_active':available,'predicted_demand':demand,'required':max(round(demand*.95),0),'available':available,'gap':gap,'status':status})
    shortages=sum(1 for x in data if x['gap']<0); surplus=sum(1 for x in data if x['gap']>0)
    return {'data':data,'summary':{'forecastBookings':round(sum(x['predicted_demand'] for x in data)*1.4),'workerDemand':round(sum(x['required'] for x in data)),'activeRoster':round(sum(x['available'] for x in data)),'shortage':-sum(x['gap'] for x in data if x['gap']<0),'coordinated':shortages,'surplusSocieties':surplus,'accuracy':94.2}}

@app.get('/api/training')
def training(user=Depends(current_user)):
    return {'data':[
      {'name':'Digital Service Excellence','category':'Service Delivery','enrolled':312,'certified':268,'completion':85.9,'next_batch':'Sep 18, 2026'},
      {'name':'Workplace Safety','category':'Safety','enrolled':428,'certified':391,'completion':91.4,'next_batch':'Sep 22, 2026'},
      {'name':'Cooperative Governance','category':'Governance','enrolled':186,'certified':162,'completion':87.1,'next_batch':'Oct 03, 2026'},
      {'name':'Customer Service & Digital Tools','category':'Skills','enrolled':254,'certified':219,'completion':86.2,'next_batch':'Oct 11, 2026'}
    ]}

@app.get('/api/notifications')
def notifications(user=Depends(current_user)):
    con=db(); rows=con.execute('SELECT * FROM notifications ORDER BY id DESC LIMIT 10').fetchall(); con.close(); return {'data':[dict(x) for x in rows]}

@app.get('/')
def root():
    return FileResponse(ROOT/'login.html')

@app.get('/{path:path}')
def static_pages(path:str):
    if path.startswith('api/'):
        raise HTTPException(status_code=404)
    candidates=[ROOT/path, ROOT/'pages'/path]
    for c in candidates:
        if c.is_file(): return FileResponse(c)
    return FileResponse(ROOT/'pages'/'overview.html')
