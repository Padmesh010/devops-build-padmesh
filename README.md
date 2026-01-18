# DevOps Project 3 – E-Commerce Application CI/CD with Monitoring

## Project Description

This project implements a complete end-to-end DevOps workflow for a React-based E-Commerce application.
The goal of this project is to automate build, image creation, deployment, and monitoring using industry-standard DevOps tools.

The application is containerized using Docker, automated using Jenkins pipelines, deployed on AWS EC2, and monitored using Prometheus and Grafana.

---

## Application Overview

* Frontend: React E-Commerce application
* Served using Nginx
* Runs inside a Docker container on port 80
* Accessible using EC2 public IP

---

## Source Code Management

GitHub is used as the central source code repository.

Two branches are maintained:

* **dev** – Development pipeline
* **master** – Production pipeline

Branch-based execution is used to control DEV and PROD image creation.

---

## CI/CD Pipeline (Jenkins)

Jenkins is installed on an AWS EC2 instance and configured with required plugins.

The pipeline is defined using a Jenkinsfile stored in the repository.

Pipeline flow:

1. Checkout source code from GitHub
2. Detect active Git branch
3. Build Docker image
4. Login to Docker Hub using Jenkins credentials
5. Push Docker image to Docker Hub

Docker images:

* dev branch → `padmeshka/devops-build-dev:latest`
* master branch → `padmeshka/devops-build-prod:latest`

Jenkins credentials used:

* GitHub SSH key
* Docker Hub username and password

---

## Docker Configuration

* Dockerfile uses `nginx:alpine`
* React build files are copied to Nginx web root
* Port 80 is exposed
* Docker Compose is used for local deployment
* Shell scripts are created for build and deployment automation

Files used:

* Dockerfile
* docker-compose.yml
* build.sh
* deploy.sh

---

## Deployment

Deployment is done on an AWS EC2 Ubuntu instance.

Deployment steps:

* Pull image from Docker Hub
* Stop and remove existing container
* Run new container using latest image
* Map container port 80 to host port 80

Application is verified using EC2 public IP in the browser.

---

## Monitoring Setup

### Node Exporter

* Installed and running on EC2
* Exposes system metrics on port 9100

### Prometheus

* Installed and running on EC2
* Scrapes metrics from:

  * Node Exporter
  * Prometheus itself
* Targets verified as UP in Prometheus UI

### Grafana

* Installed and running on EC2
* Prometheus added as data source
* Node Exporter Full dashboard imported (Dashboard ID: 1860)

Metrics monitored:

* CPU usage
* Memory usage
* Disk usage
* Network traffic
* System uptime

---

## Security and Access

* SSH key-based authentication for GitHub
* Jenkins uses credential manager for secrets
* Docker Hub credentials secured in Jenkins
* No hard-coded secrets in source code

---

## Final Outcome

* Automated CI/CD pipeline for DEV and PROD
* Docker images built and pushed automatically
* Application deployed successfully on AWS EC2
* Live monitoring using Prometheus and Grafana
* Industry-standard DevOps workflow implemented

---
