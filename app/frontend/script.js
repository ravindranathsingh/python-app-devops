const API_URL = "/api";

document.addEventListener('DOMContentLoaded', () => {
    checkHealth();
    fetchLogs();

    document.getElementById('deploymentForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        const service = document.getElementById('serviceName').value;
        const env = document.getElementById('environment').value;

        try {
            const response = await fetch(`${API_URL}/deployments`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ service: service, environment: env })
            });
            if (response.ok) {
                document.getElementById('deploymentForm').reset();
                fetchLogs(); 
            }
        } catch (error) {
            console.error('Failed to submit configuration payload:', error);
        }
    });
});

async function checkHealth() {
    const badge = document.getElementById('connectionStatus');
    try {
        const response = await fetch(`${API_URL}/health`);
        const data = await response.json();
        if (data.status === "healthy") {
            badge.textContent = "CONNECTED TO BACKEND API & POSTGRESQL";
            badge.className = "badge online";
        } else {
            badge.textContent = "BACKEND UNHEALTHY: DATABASE ERROR";
            badge.className = "badge offline";
        }
    } catch {
        badge.textContent = "DISCONNECTED FROM BACKEND SERVICES";
        badge.className = "badge offline";
    }
}

async function fetchLogs() {
    const list = document.getElementById('logList');
    try {
        const response = await fetch(`${API_URL}/deployments`);
        const logs = await response.json();
        
        list.innerHTML = '';
        
        if (!logs || logs.length === 0) {
            list.innerHTML = '<li class="empty">No entries found.</li>';
            return;
        }
        
        logs.forEach(log => {
            const li = document.createElement('li');
            li.innerHTML = `[${log.timestamp}] Deployment success: <strong>${log.service}</strong> target -> <strong>${log.environment}</strong>`;
            list.appendChild(li);
        });
    } catch {
        list.innerHTML = '<li class="error">Error contacting DB storage services.</li>';
    }
}
