// Minimal client-side scaffolding. Replace sampleData with API calls if needed.

const sampleData = {
  bills: [
    { title: 'Utilities', category: 'Utilities', due: '2026-01-02', amount: 100, status: 'scheduled' },
    { title: 'Rent', category: 'Housing', due: '2026-01-05', amount: 1200, status: 'scheduled' },
    { title: 'Subscriptions', category: 'Subs', due: '2026-01-21', amount: 40, status: 'scheduled' },
  ],
  income: [
    { title: 'Paycheck', date: '2026-01-01', amount: 2500, status: 'expected' },
  ],
};

const tabs = document.querySelectorAll('.tab');
const panels = document.querySelectorAll('.panel');

tabs.forEach((tab) => {
  tab.addEventListener('click', () => {
    const target = tab.dataset.tab;
    tabs.forEach((t) => t.classList.remove('active'));
    panels.forEach((p) => p.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById(target).classList.add('active');
  });
});

function formatMoney(n) {
  return `$${n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function renderDashboard() {
  const totalBills = sampleData.bills.reduce((s, b) => s + b.amount, 0);
  document.getElementById('dash-month-total').textContent = formatMoney(totalBills);
  document.getElementById('dash-month-count').textContent = `${sampleData.bills.length} bills`;
  const totalIncome = sampleData.income.reduce((s, i) => s + i.amount, 0);
  document.getElementById('dash-income').textContent = formatMoney(totalIncome);
  document.getElementById('dash-income-count').textContent = `${sampleData.income.length} entries`;
  document.getElementById('dash-next').textContent = formatMoney(totalBills);
  document.getElementById('dash-next-count').textContent = `${sampleData.bills.length} bills due`;

  const upcoming = document.getElementById('upcoming-list');
  upcoming.innerHTML = '';
  sampleData.bills.slice(0, 5).forEach((b) => {
    const li = document.createElement('li');
    li.innerHTML = `
      <div class="meta">
        <span class="label">${b.title}</span>
        <span class="sub">${b.due} · ${b.category}</span>
      </div>
      <div class="amount">${formatMoney(b.amount)}</div>
    `;
    upcoming.appendChild(li);
  });
  document.getElementById('upcoming-pill').textContent = `${sampleData.bills.length} due soon`;
}

function renderBills() {
  document.getElementById('bills-count').textContent = sampleData.bills.length;
  const list = document.getElementById('bills-list');
  list.innerHTML = '';
  sampleData.bills.forEach((b) => {
    const li = document.createElement('li');
    li.innerHTML = `
      <div class="meta">
        <span class="label">${b.title}</span>
        <span class="sub">${b.due} · ${b.category}</span>
      </div>
      <div class="amount">${formatMoney(b.amount)}</div>
    `;
    list.appendChild(li);
  });
}

function renderIncome() {
  document.getElementById('income-count').textContent = sampleData.income.length;
  const list = document.getElementById('income-list');
  list.innerHTML = '';
  sampleData.income.forEach((i) => {
    const li = document.createElement('li');
    li.innerHTML = `
      <div class="meta">
        <span class="label">${i.title}</span>
        <span class="sub">${i.date}</span>
      </div>
      <div class="amount badge-success">${formatMoney(i.amount)}</div>
    `;
    list.appendChild(li);
  });
}

function renderCalendar() {
  const grid = document.getElementById('calendar-grid');
  grid.innerHTML = '';
  // Show first 28 days as preview
  for (let d = 1; d <= 28; d++) {
    const hasBill = sampleData.bills.find((b) => b.due.endsWith(`-${String(d).padStart(2, '0')}`));
    const day = document.createElement('div');
    day.className = 'day';
    day.innerHTML = `
      <div class="date">${d}</div>
      ${hasBill ? `<div><span class="dot"></span>${hasBill.title}</div>` : '<div class="muted">No bills</div>'}
    `;
    grid.appendChild(day);
  }
}

function renderAll() {
  renderDashboard();
  renderBills();
  renderIncome();
  renderCalendar();
}

document.getElementById('settings-form').addEventListener('submit', (e) => {
  e.preventDefault();
  const base = document.getElementById('base-url').value.trim();
  const key = document.getElementById('api-key').value.trim();
  const mode = document.getElementById('sync-mode').value;
  alert(`Saved locally (not persisted):\nBase URL: ${base}\nMode: ${mode}\nAPI key length: ${key.length}`);
});

renderAll();
