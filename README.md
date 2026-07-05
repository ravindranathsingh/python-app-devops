# Python App DevOps

A production-ready full-stack DevOps project demonstrating modern cloud-native application deployment using Docker, Kubernetes, Helm, GitHub Actions, and ArgoCD with GitOps.

---

## Project Overview

This project deploys a full-stack Python application consisting of:

- React Frontend
- Flask Backend
- PostgreSQL Database

The application is containerized with Docker, deployed to Kubernetes using Helm, and continuously delivered using ArgoCD following GitOps principles.

---

## Technology Stack

| Component | Technology |
|-----------|------------|
| Frontend | React |
| Backend | Flask |
| Database | PostgreSQL |
| Container Runtime | Docker |
| Container Registry | GitHub Container Registry (GHCR) |
| Orchestration | Kubernetes (kubeadm) |
| Package Manager | Helm |
| CI | GitHub Actions |
| CD | ArgoCD |
| GitOps | Enabled |

---

## Repository Structure

```text
.
├── app/
│   ├── backend/
│   └── frontend/
├── helm/
├── argocd/
├── ansible/
├── docs/
├── scripts/
├── k8s/
├── .github/
├── LICENSE
└── README.md
```

---

## Architecture

See:

- docs/architecture.md

---

## Deployment Diagram

See:

- docs/deployment.md

---

## CI/CD Workflow

1. Developer pushes code to GitHub.
2. GitHub Actions builds backend and frontend Docker images.
3. Images are pushed to GitHub Container Registry (GHCR).
4. Security scans are performed using Trivy.
5. Helm chart updates are committed (future enhancement: automated image updates).
6. ArgoCD detects Git changes.
7. ArgoCD synchronizes the Kubernetes cluster.
8. Application is deployed automatically.

---

## Features

- Dockerized frontend and backend
- PostgreSQL with persistent storage
- Kubernetes Deployments
- Services
- Ingress
- Helm chart
- GitHub Actions CI
- ArgoCD GitOps
- Trivy image scanning
- GitHub Container Registry
- Namespace isolation
- ImagePullSecrets

---

## Prerequisites

- Ubuntu Linux
- Docker
- Kubernetes (kubeadm)
- kubectl
- Helm
- Git
- GitHub account
- ArgoCD

---

## Deployment

Install the Helm chart:

```bash
helm install python-app ./helm -n python-app --create-namespace
```

Upgrade the release:

```bash
helm upgrade python-app ./helm -n python-app
```

---

## Documentation

Additional documentation is available in the `docs/` directory.

---

## License

This project is licensed under the MIT License.