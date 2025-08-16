#!/bin/bash

# Create namespace if it doesn't exist
kubectl create namespace "gitlab" || true

# Apply the GitLab manifest
kubectl apply -f ../confs/gitlab-deployment.yaml -n gitlab

# Wait for the GitLab webservice pod to be ready
echo "Waiting for GitLab pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=gitlab -n "gitlab" --timeout=500s

sleep 60

# kubectl get pods -n kube-system -l k8s-app=kube-dns -o json
# Detect the running GitLab pod dynamically
POD_NAME=$(kubectl get pods -n gitlab -l app=gitlab -o jsonpath='{.items[0].metadata.name}')

# Get the initial root password
ROOT_PASSWORD=$(kubectl exec -n gitlab "$POD_NAME" -- cat /etc/gitlab/initial_root_password)

# Get Service IP and NodePort (optional dynamic lookup)
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')

echo ""
echo "✅ GitLab installation completed successfully!"
echo "Access GitLab at: http://$NODE_IP:30080/ you may need to wait a few minutes for the service to be fully up."
echo "Admin Credentials:"
echo "   • Username: root"
echo "   • Password: $ROOT_PASSWORD"
