#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the hostname of the VM
VM_HOSTNAME=$(hostname)

# Print the hostname
echo "The hostname of this VM is: $VM_HOSTNAME"

# Navigate to /root directory
cd /root

# Download the mde_installer.sh script
curl -O https://raw.githubusercontent.com/microsoft/mdatp-xplat/refs/heads/master/linux/installation/mde_installer.sh

# Make the installer executable
chmod u+x mde_installer.sh

# Run the installer with the hostname used as the tag
sudo ./mde_installer.sh --install --channel prod --onboard onboarding.py --tag "GROUP $VM_HOSTNAME" --min_req -y

# Enable real-time protection
sudo mdatp config real-time-protection --value enabled

# Enable behavior monitoring
sudo mdatp config behavior_monitoring --value enabled

# Check the health of Microsoft Defender
sudo mdatp health
