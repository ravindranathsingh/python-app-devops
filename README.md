## Project Architecture

This repository demonstrates an end-to-end DevOps platform built using both traditional CI/CD and modern GitOps practices.

Current application:

- Frontend (HTML, CSS, JavaScript)
- Flask Backend API
- PostgreSQL Database

The application will progressively evolve into a production-style deployment using:

- Git & GitFlow
- Docker
- GitHub Actions
- Jenkins
- SonarQube
- Trivy
- GitHub Container Registry (GHCR)
- Kubernetes
- Helm
- ArgoCD
- Terraform
- Ansible
- NGINX Ingress
- Prometheus
- Grafana
- Loki

Infrastructure:

- Master VM (192.168.56.10)
- Worker VM (192.168.56.11)

## Repository Structure

The repository is organized to separate application code from infrastructure and deployment automation.

- `app/` – Frontend and Backend source code
- `scripts/` – VM bootstrap and Kubernetes setup scripts
- `docker/` – Docker-related files (if shared)
- `jenkins/` – Jenkins shared library and pipeline resources
- `github/` – GitHub Actions workflows
- `kubernetes/` – Kubernetes manifests
- `helm/` – Helm charts
- `terraform/` – Infrastructure as Code
- `ansible/` – Configuration management
- `monitoring/` – Prometheus, Grafana, Loki configurations
- `docs/` – Architecture diagrams and documentation

## Git Branching Strategy

This project follows a simplified GitFlow model.

- `main` – Production-ready code
- `develop` – Active development branch
- `feature/<feature-name>` – New features
- `release/<version>` – Release preparation
- `hotfix/<issue>` – Production fixes

All development starts from a feature branch and is merged into `develop`. Releases are promoted from `develop` to `main`.

## Backend Containerization

The Flask backend is packaged as a Docker container using a production-oriented Dockerfile.

Features:

- Python 3.12 slim base image
- Layered dependency installation
- Non-root application user
- Environment variable configuration
- Optimized image size