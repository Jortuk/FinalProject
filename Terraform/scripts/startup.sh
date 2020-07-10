#!/bin/bash

# get a key to apply to new machine
sh Terraform/scripts/keygen.sh

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

echo "Enter the following command to begin Terraform build"

echo ""

echo '~      cd Terraform/start-up/ && terraform init && terraform apply'

echo ""