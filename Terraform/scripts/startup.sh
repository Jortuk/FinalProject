#!/bin/bash

# get a key to apply to new machine
sh Terraform/scripts/keygen.sh

echo ""

# install requirments for Terraform
sh Terraform/scripts/terra.sh

echo ""

# Install Amazon CLI
sudo apt install awscli

echo ""

echo "Log into AWS using your IAM Keys..."

echo ""

# AWS Configure ~ Create credentials file
aws configure

echo ""

echo "Enter the following command to befin Terraform build"

echo ""

echo '~      cd start-up/ && terraform init'

echo ""

echo '~      terraform apply -lock=false -var 'username="admin"' -var 'password="group2password"' -auto-approve'

echo ""