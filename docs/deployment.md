# Deployment Flow

```text
Developer
    |
    v
Git Push
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    +-------------------------------+
    | Build Backend Image           |
    | Build Frontend Image          |
    | Trivy Security Scan           |
    +-------------------------------+
                |
                v
GitHub Container Registry (GHCR)
                |
                v
Git Repository (Helm Chart)
                |
                v
ArgoCD
                |
                v
Kubernetes Cluster
                |
    +-----------+-----------+
    |           |           |
Frontend     Backend    PostgreSQL
```

## Deployment Strategy

Current deployment uses:

- Helm
- ArgoCD
- Automated Sync
- Self Heal
- Prune
- Namespace Isolation