(function(){
  const nav=[
    ['Overview','overview.html','grid_view'],
    ['Society Management','society-management.html','hub'],
    ['Financial Monitoring','financial-monitoring.html','account_balance'],
    ['Welfare Monitoring','welfare-monitoring.html','health_and_safety'],
    ['AI Demand Forecasting','ai-demand-forecasting.html','neurology'],
    ['Training & Certifications','training-certifications.html','verified']
  ];

  function text(el){return (el.textContent||'').replace(/\s+/g,' ').trim();}

  function currentPage(){
    const f=(location.pathname.split('/').pop()||'overview.html').toLowerCase();
    return f || 'overview.html';
  }

  function removeSourceShell(){
    document.querySelectorAll('aside.fixed').forEach(el=>el.remove());
    document.querySelectorAll('header.fixed').forEach(el=>el.remove());

    document.querySelectorAll('main nav').forEach(n=>{
      const t=text(n);
      if(/Home/i.test(t)&&(/Governance|Operations|Welfare|Finance|Society|Training|AI Demand/i.test(t))) n.remove();
    });

    // Remove only the explicitly unwanted source action.
    document.querySelectorAll('button,a').forEach(el=>{
      if(/\+\s*Add Cooperative Society/i.test(text(el))) el.remove();
    });
  }

  function buildSidebar(){
    if(document.querySelector('.sf-sidebar')) return;
    const current=currentPage();
    const side=document.createElement('aside');
    side.className='sf-sidebar';
    side.setAttribute('aria-label','Federation navigation');
    side.innerHTML=`
      <div class="sf-brand">
        <img src="../assets/sahayak-logo.svg" alt="Work Solute">
        <div class="sf-brand-text">Work Solute</div>
      </div>
      <nav class="sf-nav"></nav>
      <div class="sf-sidebar-footer">
        <button class="sf-toggle" type="button" aria-label="Open navigation" title="Open navigation">
          <span class="material-symbols-outlined">menu</span>
        </button>
      </div>`;

    const navEl=side.querySelector('.sf-nav');
    nav.forEach(([label,href,icon])=>{
      const a=document.createElement('a');
      a.href='/pages/'+href;
      a.className=current===href?'active':'';
      if(current===href) a.setAttribute('aria-current','page');
      a.innerHTML=`<span class="material-symbols-outlined">${icon}</span><span class="sf-nav-label">${label}</span>`;
      navEl.appendChild(a);
    });
    document.body.appendChild(side);
    const toggle=side.querySelector('.sf-toggle');
    toggle.addEventListener('click',()=>{
      document.body.classList.toggle('sf-sidebar-open');
      const open=document.body.classList.contains('sf-sidebar-open');
      toggle.setAttribute('aria-label',open?'Close navigation':'Open navigation');
      toggle.setAttribute('title',open?'Close navigation':'Open navigation');
      toggle.innerHTML=`<span class="material-symbols-outlined">${open?'close':'menu'}</span>`;
    });
  }

  function buildTopbar(){
    if(document.querySelector('.sf-topbar')) return;
    const wrap=document.querySelector('.pl-sidebar-width');
    if(!wrap) return;
    const bar=document.createElement('header');
    bar.className='sf-topbar';
    bar.innerHTML=`
      <div class="sf-topbar-left">
        <div class="sf-district-pill">
          <span class="material-symbols-outlined">account_tree</span>
          <div><strong>District Council: Coimbatore District</strong><br><span>10 Member Societies</span></div>
        </div>
      </div>
      <div class="sf-search">
        <span class="material-symbols-outlined">search</span>
        <input type="text" placeholder="Search societies, demands, reports..." aria-label="Global search">
        <kbd>⌘K</kbd>
      </div>
      <div class="sf-topbar-right">
        <button class="sf-tool" type="button" aria-label="Help"><span class="material-symbols-outlined">help_outline</span></button>
        <button class="sf-tool" type="button" aria-label="Notifications"><span class="material-symbols-outlined">notifications</span></button>
        <div class="sf-profile">
          <div class="sf-avatar">VS</div>
          <div><strong>V. Sureshkumar</strong><br><span>Administrative Officer</span></div>
          <span class="material-symbols-outlined">expand_more</span>
        </div>
      </div>`;
    wrap.insertBefore(bar,wrap.firstChild);
  }

  function harmonisePage(){
    document.body.classList.add('sf-shell-ready');
    document.querySelectorAll('main h1').forEach(e=>{e.style.fontSize='30px';e.style.lineHeight='1.12';e.style.fontWeight='800';});
    document.querySelectorAll('main h2').forEach(e=>{e.style.fontSize='21px';e.style.lineHeight='1.25';e.style.fontWeight='700';});
    document.querySelectorAll('main h3').forEach(e=>{e.style.fontSize='17px';e.style.lineHeight='1.3';e.style.fontWeight='700';});
  }

  function enhanceInteractivity(){
    document.addEventListener('click',e=>{
      const btn=e.target.closest('button');
      if(!btn) return;
      if(btn.matches('.sf-tool')){
        const label=btn.getAttribute('aria-label');
        btn.classList.add('ring-2');
        setTimeout(()=>btn.classList.remove('ring-2'),250);
        if(label==='Notifications') alert('2 federation notifications are available.');
        if(label==='Help') alert('Governance documentation and federation support are available from the administration desk.');
      }
    });
    const globalSearch=document.querySelector('.sf-search input');
    if(globalSearch){
      globalSearch.addEventListener('keydown',e=>{
        if(e.key==='Enter'){
          const q=globalSearch.value.trim();
          if(q) alert('Searching federation records for: '+q);
        }
      });
    }
  }

  function init(){
    removeSourceShell();
    buildSidebar();
    buildTopbar();
    harmonisePage();
    enhanceInteractivity();
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',init); else init();
})();

(function(){
  async function api(url, options){ const r=await fetch(url, {credentials:'include', ...(options||{})}); if(!r.ok) throw new Error((await r.json().catch(()=>({detail:r.statusText}))).detail||r.statusText); return r.json(); }
  function pageKey(){return (location.pathname.split('/').pop()||'overview.html').replace('.html','');}
  function addLogout(){
    const profile=document.querySelector('.sf-profile'); if(!profile || profile.querySelector('.sf-logout')) return;
    const b=document.createElement('button'); b.className='sf-logout'; b.type='button'; b.textContent='Sign out'; b.onclick=async()=>{try{await api('/api/auth/logout',{method:'POST'}); location.href='/login.html';}catch{} }; profile.appendChild(b);
  }
  async function hydrate(){
    try{ await api('/api/auth/me'); }catch{ location.href='/login.html'; return; }
    addLogout();
    const key=pageKey();
    try{
      if(key==='overview'){ const d=await api('/api/dashboard'); const nums=[d.societies,d.workers,d.activeWorkers,d.customers,d.bookings,d.completedBookings,d.cancelledBookings]; const els=[...document.querySelectorAll('.font-metric-display')]; nums.forEach((v,i)=>{if(els[i]) els[i].textContent=Number(v).toLocaleString('en-IN');}); const rev=els[7]; if(rev) rev.textContent='₹'+(d.revenue/100000).toFixed(2)+' Lakh'; const earn=els[8]; if(earn) earn.textContent='₹'+(d.workersEarnings/100000).toFixed(2)+' Lakh'; const rating=els[9]; if(rating) rating.textContent=d.averageRating.toFixed(2); }
      if(key==='ai-demand-forecasting'){
        const d=await api('/api/ai-forecast'); const cards=[...document.querySelectorAll('.font-metric-display')]; const vals=[d.summary.forecastBookings,d.summary.workerDemand,d.summary.activeRoster,-d.summary.shortage,d.summary.coordinated,d.summary.accuracy]; vals.forEach((v,i)=>{if(cards[i])cards[i].textContent=typeof v==='number'?v.toLocaleString('en-IN'):v});
      }
      if(key==='financial-monitoring'){
        const d=await api('/api/financials'); const amountNodes=[...document.querySelectorAll('.font-metric-display')]; if(amountNodes[0])amountNodes[0].textContent='₹'+(d.summary.monthlyAverage/100000).toFixed(2)+' Lakh'; if(amountNodes[1])amountNodes[1].textContent='₹'+(d.summary.reserve/100000).toFixed(2)+' Lakh';
      }
    }catch(err){ console.warn('API hydration:',err.message); }
  }
  const oldInit=window.__sfHydrateInit; if(!oldInit){window.__sfHydrateInit=true; if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',hydrate);else hydrate();}
})();
