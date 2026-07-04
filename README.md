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

