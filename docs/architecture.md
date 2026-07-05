# Architecture

## High-Level Architecture

```text
                +----------------------+
                |      GitHub Repo     |
                +----------+-----------+
                           |
                           |
                    GitHub Actions
                           |
                           v
                 Build Docker Images
                           |
                           v
             GitHub Container Registry
                           |
                           |
                  ArgoCD (GitOps)
                           |
                           v
                  Kubernetes Cluster
                           |
        +------------------+------------------+
        |                  |                  |
        v                  v                  v
   Frontend           Backend           PostgreSQL
    (React)           (Flask)           (PVC)
```

## Components

### Frontend

- React application
- Served through Kubernetes Service
- Exposed using Ingress

### Backend

- Flask REST API
- Connects to PostgreSQL
- Uses Kubernetes Secrets for database credentials

### Database

- PostgreSQL Deployment
- Persistent Volume Claim
- ClusterIP Service

### Deployment

- Helm manages Kubernetes resources.
- ArgoCD continuously synchronizes the cluster state.