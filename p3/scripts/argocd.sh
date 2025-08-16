#!/bin/bash

set -e

sudo -v

echo "Creating ArgoCD/DEV namespaces..."
kubectl create namespace argocd || echo "Namespace 'argocd' already exists. Skipping..."
kubectl create namespace dev || echo "Namespace 'dev' already exists. Skipping..."

echo "Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD server to be ready..."
kubectl wait --for=condition=available --timeout=600s -n argocd deployment/argocd-server

echo "ArgoCD installed successfully."

echo
echo "Default username: admin"
echo -n "Password: "
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
echo

echo
echo "Starting port forwarding (press Ctrl+C to stop)..."
echo "Access the ArgoCD UI at: https://localhost:8080"
kubectl port-forward svc/argocd-server -n argocd 8080:443
