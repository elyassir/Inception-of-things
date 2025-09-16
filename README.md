# Inception-of-things 🚀

A comprehensive DevOps project implementing Kubernetes clusters, CI/CD pipelines, and GitOps practices using K3s with Vagrant, ArgoCD, and GitLab.

## 📋 Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Part 1: K3s Cluster Setup](#part-1-k3s-cluster-setup)
- [Part 2: K3s with Ingress Controller](#part-2-k3s-with-ingress-controller)
- [Part 3: K3d + ArgoCD](#part-3-k3d--argocd)
- [Bonus: GitLab + ArgoCD Integration](#bonus-gitlab--argocd-integration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🎯 Overview
This project demonstrates modern DevOps practices by implementing:
- **K3s Kubernetes clusters** with master-worker node architecture
- **Ingress routing** for multiple applications
- **GitOps workflows** using ArgoCD
- **CI/CD pipelines** with GitLab integration
- **Infrastructure as Code** using Vagrant and shell scripts

## 📁 Project Structure
```
Inception-of-things/
├── p1/                     # Part 1: Basic K3s cluster
│   ├── scripts/
│   │   ├── master_startup.sh
│   │   └── worker_startup.sh
│   └── Vagrantfile
├── p2/                     # Part 2: K3s with Ingress
│   ├── confs/
│   │   ├── deployments/
│   │   │   └── apps_deployments.yaml
│   │   ├── ingress/
│   │   │   └── ingress_service.yaml
│   │   └── services/
│   │       └── apps_services.yaml
│   ├── scripts/
│   │   └── master_startup.sh
│   └── Vagrantfile
├── p3/                     # Part 3: K3d + ArgoCD
│   ├── confs/
│   │   └── application.yaml
│   └── scripts/
│       ├── apply.sh
│       ├── argocd.sh
│       └── install-k3d-docker-kubectl.sh
├── bonus/                  # Bonus: GitLab + ArgoCD
│   ├── confs/
│   │   ├── argocd-application.yaml
│   │   └── gitlab-deployment.yaml
│   └── scripts/
│       ├── 1-setup-gitlab.sh
│       ├── 2-set-repo.sh
│       └── 3-run-argocd.sh
└── README.md
```

## 🏗️ Part 1: K3s Cluster Setup
Creates a basic K3s cluster with one server and one agent node.

### Deployment
```bash
cd p1
vagrant up
```

### Verification
```bash
vagrant ssh <server>
kubectl get nodes -o wide
kubectl get pods -A
```

## 🌐 Part 2: K3s with Ingress Controller
Extends Part 1 with NGINX Ingress Controller and multiple applications.

### Deployment
```bash
cd p2
vagrant up
```

### Access Applications
Add to your `/etc/hosts`:
```
192.168.56.110 app1.com app2.com app3.com
```
Access via:
- http://app1.com
- http://app2.com
- http://app3.com

## 🔄 Part 3: K3d + ArgoCD
Implements GitOps using K3d and ArgoCD for continuous deployment.

### Deployment
```bash
cd p3/scripts
bash apply.sh
bash argocd.sh
```

## 🎁 Bonus: GitLab + ArgoCD Integration
Complete CI/CD pipeline with local GitLab instance and ArgoCD.

### Setup
```bash
cd bonus
bash scripts/1-setup-gitlab.sh
bash scripts/3-run-argocd.sh
```

### Monitor deployments
```bash
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```

### Cleanup
```bash
# For Vagrant parts (p1, p2)
vagrant destroy -f

# For K3d parts (p3, bonus)
# Add cleanup scripts as needed
```

## 📚 Additional Resources
- [K3s Documentation](https://docs.k3s.io/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [GitLab Documentation](https://docs.gitlab.com/)

## 🏷️ Tags
`kubernetes` `k3s` `k3d` `argocd` `gitlab` `gitops` `devops` `ci-cd` `vagrant` `docker` `ingress`
