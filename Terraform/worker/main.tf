# RUN terraform plan -lock=false -var 'username=${username}' -var 'password=${password}' -var 'pem_keyname=${pem_keyname}' -var 'pem_keypub=${pem_keypub}'

provider "aws" {
  # version                 = "~> 2.8"
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@ Key Pair for machine Access @@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

resource "aws_key_pair" "key_pair" {
  key_name   = var.pem_keyname
  public_key = var.pem_keypub
}

