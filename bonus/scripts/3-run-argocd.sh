#!/bin/bash

kubectl create namespace dev || true

kubectl apply -f ../confs/argocd-application.yaml

read -p "Press enter to continue..."

kubectl port-forward service/playground-service 8888:8888 -n dev &

read -p "Press enter to stop port forwarding..."

# Stop the port forwarding
kill %1

kubectl port-forward service/playground-service 8888:8888 -n dev &

read -p "Press enter to stop port forwarding..."

# Stop the port forwarding
kill %1
