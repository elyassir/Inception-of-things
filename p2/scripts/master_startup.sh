#!/bin/bash

set -e

apt-get update && apt-get install curl -y

echo "[+] Installing k3s"
curl -sfL https://get.k3s.io | sh -

chown -R vagrant:vagrant /etc/rancher/k3s/k3s.yaml

echo "[+] Waiting for k3s to initialize..."
while ! kubectl get nodes &>/dev/null; do
    sleep 1
done

echo "[+] Applying Kubernetes manifests..."

echo "[+] Deploying application deployments"
kubectl apply -f /vagrant/confs/deployments

echo "[+] Deploying services"
kubectl apply -f /vagrant/confs/services

echo "[+] Deploying ingress"
kubectl apply -f /vagrant/confs/ingress

