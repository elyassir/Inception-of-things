#!/bin/bash

set -e
apt-get update && apt-get install curl net-tools -y

MASTER_IP="192.168.56.110"
TOKEN_PATH="/vagrant/node-token"

# Read token from shared file
if [[ ! -f "$TOKEN_PATH" ]]; then
    echo "Error: Token file not found at $TOKEN_PATH"
    exit 1
fi

K3S_TOKEN=$(cat $TOKEN_PATH)
K3S_URL="https://${MASTER_IP}:6443"

# Install agent
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --flannel-iface eth1" K3S_TOKEN=$K3S_TOKEN sh -s - --server $K3S_URL
echo "[+] k3s worker node started successfully"