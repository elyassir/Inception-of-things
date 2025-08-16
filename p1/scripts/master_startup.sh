#!/bin/bash

set -e

apt-get update && apt-get install curl net-tools -y
echo "[+] Installing k3s"

# Fully configure k3s to expose services externally
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" sh -

# Wait for k3s to be ready
echo "[+] Waiting for k3s to initialize..."

while [ ! -f "/var/lib/rancher/k3s/server/node-token" ]; do
    echo "Waiting for K3s token to be generated..."
    sleep 5
done

chown -R vagrant:vagrant /etc/rancher/k3s/k3s.yaml

# Save the token for worker nodes
TOKEN_PATH="/vagrant/node-token"
cp /var/lib/rancher/k3s/server/node-token $TOKEN_PATH
chmod 644 $TOKEN_PATH
echo "[+] Saved node token to $TOKEN_PATH"

# Just like the subject example
echo "alias k='kubectl'" >> /home/vagrant/.bashrc
