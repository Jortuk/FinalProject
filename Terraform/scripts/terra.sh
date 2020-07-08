#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Aquire the terraform tools.
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip

# Install unzip
sudo apt install unzip

# Unzip Terraform Tools
unzip terraform_*_linux_*.zip

# Move file to executable location
sudo mv terraform /usr/local/bin

# Remove the zip file
rm terraform_*_linux_*.zip

echo ""

terraform --version