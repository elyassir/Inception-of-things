#!/bin/bash

mkdir -p ../dev

cd ../dev

cat <<EOF > playground-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: playground
spec:
  replicas: 1
  selector:
    matchLabels:
      app: playground
  template:
    metadata:
      labels:
        app: playground
    spec:
      containers:
      - name: playground
        image: wil42/playground:v1
        ports:
          - containerPort: 8888
EOF

cat <<EOF > playground-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: playground-service
spec:
  selector:
    app: playground
  ports:
    - protocol: TCP
      port: 8888
      targetPort: 8888
  type: ClusterIP
EOF


read -p "Enter Git repo URL: " REPO_URL
read -p "Enter Git username: " GIT_USER
read -p "Enter Git password or token: " GIT_PASS
echo

# Initialize repo
git init --initial-branch=main

# Remove remote if exists
git remote add origin "$REPO_URL"

# Set Git credential helper to store credentials temporarily
git config credential.helper store

# Save credentials temporarily
echo "url=$REPO_URL
username=$GIT_USER
password=$GIT_PASS" | git credential approve

# Commit and push
git add .
git commit -m "Add playground deployment and service"
git push --set-upstream origin main --force

while true; do
  read -p "Enter 'y' to continue: " REPLY
  if [ "$REPLY" == "y" ]; then
    break
  fi
done

# Update the image version
sed -i 's|wil42/playground:v1|wil42/playground:v2|g' playground-deployment.yaml

git add .
git commit -m "Update playground image to version 2"
git push origin main --force