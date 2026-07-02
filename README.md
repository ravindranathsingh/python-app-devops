# DevOps Deployment Portal (`devops-app-platform`)

A production-grade, three-tier cloud-native application designed to log, track, and monitor software deployment events across multi-stage infrastructure. This platform is split into a completely decoupled frontend dashboard, a stateless Python REST API backend, and a transactional database storage layer.

---

## Architecture Overview

The system enforces a strict separation of concerns to support independent scaling, zero-downtime rolling updates, and immutable container delivery strategies.

### Component Breakdown
1. **Frontend (Presentation Layer)**: A clean, performance-optimized single-page dashboard built with raw semantic HTML5, utility CSS, and native JavaScript. It uses the asynchronous Fetch API to push data without layout re-renders.
2. **Backend (Application Logic)**: A stateless Flask REST API engine that exposes secure routing endpoints. It communicates configuration metrics cleanly via environment injection following **Twelve-Factor App** principles.
3. **Database (Data Persistence)**: A transactional PostgreSQL instance running relational schema migration handling to store logs permanently with strict temporal indexing.

---

## Repository Layout

```text
devops-app-platform/
├── frontend/                  # Presentation Assets (Nginx Target)
│   ├── index.html             # Application markup frame
│   ├── style.css              # Structural layout theme (Dark mode optimized)
│   └── script.js              # Fetch client & reactive DOM lifecycle logic
│
└── backend/                   # Stateless API Source Core
    ├── app.py                 # Application router & DB connection handler
    └── requirements.txt       # Frozen upstream Python dependency definitions
```

---

## API Specifications

The backend service listens on port `5000` by default and exposes the following production endpoints:

| Endpoint | Method | Payload (JSON) | Description |
| :--- | :---: | :--- | :--- |
| `/api/health` | `GET` | *None* | **Health Check Probe**. Validates runtime status and active live connectivity to the DB storage subsystem. Returns `200 OK` or `500 Error`. |
| `/api/deployments` | `GET` | *None* | **Fetch Operations**. Retrieves all historical system logs ordered chronologically by newest insertion timestamp. |
| `/api/deployments` | `POST` | `{"service": "string", "environment": "string"}` | **Write Operations**. Accepts structural configurations, runs schema processing, and commits a new metadata entry to the DB. |

---

## Environment Configuration

The backend layer relies on environment values for secure database handshakes. Never hardcode credentials within source code files.

| Environment Variable | Default Value | Purpose |
| :--- | :--- | :--- |
| `DB_HOST` | `localhost` | Network IP address or internal service host name for the DB node. |
| `DB_NAME` | `devops_db` | Target PostgreSQL active database logical instance name. |
| `DB_USER` | `postgres` | Access role username for infrastructure execution hooks. |
| `DB_PASS` | `securepassword` | Strong password value protecting database records. |

---

## Local Engineering Run Guide

### Step 1: Initialize Database Layer
Ensure you have a local PostgreSQL engine running and execute a script query to create the container targets:
```sql
CREATE DATABASE devops_db;
```

### Step 2: Spin Up Backend Engine
Navigate to your backend service workspace, isolate dependencies inside a virtual environment, and boot the runtime layer:
```bash
cd backend/
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Inject operational configuration parameters and launch 
export DB_HOST="localhost"
export DB_PASS="your_local_password"
python3 app.py
```

### Step 3: Run the Presentation UI
Because the frontend communicates via decoupled API hooks, you can execute it through a local HTTP loop server or drop it straight into your standard browser window:
```bash
cd ../frontend/
# Start a simple native python listener tool
python3 -m http.server 8000
```
Open your client browser layout tracking portal to access the application dashboard: **`http://localhost:8000`**

---

## DevOps & Production Readiness Checklist

Before tagging this repository structure as stable for a target Production launch, ensure the following milestones are configured in your pipeline:

* [ ] **CORS Settings Integration**: Fine-tune cross-origin access policies inside `backend/app.py` from open wildcard formats (`*`) to target strict domain names.
* [ ] **Production Web Server Deployment**: Do not run the embedded Flask runtime utility in production. Switch implementation strategies to use stable ASGI/WSGI wrappers like **Gunicorn** or **uWSGI**.
* [ ] **Reverse Proxy Configurations**: Deploy an Nginx server or Cloud Layer Load Balancer in front of your microservices to securely terminate SSL/TLS encryption.
* [ ] **Continuous Integration (CI)**: Write testing workflows that run code analysis tests (`flake8`, `black`, `hadolint`) on every commit build hook.