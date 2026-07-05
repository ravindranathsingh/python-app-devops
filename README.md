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

## Ansible

Ansible is used as the configuration management tool to provision and configure the Kubernetes cluster.

Control Node:
- Master VM (192.168.56.10)

Managed Nodes:
- Master VM
- Worker VM

## Container Network Interface (CNI)

Flannel is used as the Kubernetes CNI to provide networking between Pods across cluster nodes.

## Database

PostgreSQL is deployed as a Kubernetes Deployment with a PersistentVolumeClaim for persistent storage.

## Kubernetes Namespace

All application resources are deployed into a dedicated namespace named `devops-app` for logical isolation.

## PostgreSQL Secret

Database credentials are stored in a Kubernetes Secret and injected into the PostgreSQL container as environment variables.

## Persistent Storage

A PersistentVolumeClaim is used to persist PostgreSQL data across Pod restarts and recreations.

## PostgreSQL Deployment

PostgreSQL runs as a single-replica Deployment and stores its data on a PersistentVolumeClaim.

kubectl get pods -n python-app

kubectl get pvc -n python-app

## Backend Deployment

The Flask backend is deployed as a Kubernetes Deployment and connects to PostgreSQL through the internal Kubernetes Service.

## Backend Service

The Flask backend is exposed internally using a ClusterIP Service. Other applications inside the cluster communicate with it using the DNS name `backend`.

## Frontend Deployment

The frontend is deployed as a Kubernetes Deployment running NGINX to serve the static web application. It communicates with the backend through the Kubernetes Ingress.

## Frontend Service

The frontend is exposed internally using a ClusterIP Service. External users access it through the NGINX Ingress Controller.

## NGINX Ingress Controller

NGINX Ingress Controller provides a single external entry point into the Kubernetes cluster. It routes incoming HTTP requests to the appropriate Kubernetes Services and performs load balancing across application Pods.

## Application Ingress

The Ingress resource routes external HTTP traffic:
- `/` → frontend service
- `/api` → backend service

## Helm Packaging

The manually created Kubernetes manifests are converted into reusable Helm charts.

### Objectives

- Replace static Kubernetes YAML manifests with Helm templates.
- Separate configuration from templates using `values.yaml`.
- Make deployments reusable across development, staging, and production environments.
- Follow the Helm chart structure recommended by the official Helm documentation.

### Helm Chart Structure

The project uses the standard Helm chart layout recommended by Helm.

The chart separates:

- Chart metadata
- Default configuration values
- Kubernetes resource templates
- Helper templates

This separation allows the same chart to be reused across multiple environments by changing only configuration values.

### Helm Chart Initialization

The Helm chart was initialized using the standard `helm create` command to generate the recommended chart structure.

Unused example templates were removed, and the remaining files were customized specifically for this application to create a clean, production-ready Helm chart.

### Chart Metadata

The Helm chart metadata is defined in `Chart.yaml`.

This file identifies the chart and provides version information required for packaging and deployment.

### Helm Chart Metadata

The chart metadata was customized to describe the application instead of using Helm's default example values.

Chart version and application version are managed independently to support controlled application and chart releases.

### Helm Migration

The existing Kubernetes manifests serve as the source of truth for the Helm chart.

Before templating, all manifests are reviewed to identify reusable configuration, ensuring the Helm chart preserves the existing deployment behavior.

### Helm Template Organization

The Helm templates follow the same directory structure as the original Kubernetes manifests. This one-to-one mapping simplifies the migration from raw manifests to Helm templates while preserving readability.

### Helm Chart Validation

Before deployment, the Helm chart is validated locally to ensure the templates render correctly and the chart structure follows Helm standards.

### Helm Validation

The Helm chart was validated using `helm lint` and `helm template`.

The initial installation is performed in a separate namespace to verify the chart before migrating existing resources to Helm management.

### Helm Template Helpers

Reusable template helpers are used to eliminate duplication and keep metadata consistent across all Kubernetes resources.

### Environment Configuration

The Helm chart supports multiple environments through separate values files.

Environment-specific configuration is supplied during deployment without modifying the chart templates.

### Continuous Integration

GitHub Actions performs automated validation on every change before artifacts are built and deployed through the rest of the DevOps pipeline.