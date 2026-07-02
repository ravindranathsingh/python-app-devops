#!/bin/bash
set -euo pipefail

# Update Apt Cache
echo "Updating Apt Cache..."
sudo apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1

# Add hosts to /etc/hosts
echo "Adding Hosts to /etc/hosts..."
sudo tee -a /etc/hosts > /dev/null <<EOF
192.168.56.10 master
192.168.56.11 worker
EOF

# Configure SSH authentication settings
echo "Configuring SSH authentication settings..."
sudo sed -i -E 's/^#?(PubkeyAuthentication)[[:space:]]+.*/\1 yes/' /etc/ssh/sshd_config
sudo sed -i -E 's/^#?(PasswordAuthentication)[[:space:]]+.*/\1 yes/' /etc/ssh/sshd_config
sudo sed -i -E 's/^#?(KbdInteractiveAuthentication)[[:space:]]+.*/\1 yes/' /etc/ssh/sshd_config

# Change password for vagrant user
echo "Changing password for vagrant user..."
echo "vagrant:vagrant" | sudo chpasswd

# Set timezone
echo "Setting timezone..."
sudo timedatectl set-timezone Asia/Kolkata

# Restart SSH service
echo "Restarting SSH service..."
sudo systemctl restart ssh

echo "Bootstrap script completed successfully!"