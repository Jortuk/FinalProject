provider "aws" {
  # version                 = "~> 2.8"
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@ Key Pair for machine Access @@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

resource "aws_key_pair" "key_pair" {
  name    = "petClinic"
  key     = file("/home/ubuntu/.ssh/petClinic.pub")
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Create EC2 Instance @@@@@@@
# @@@@@@@       Workers       @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["PetClinic_Subnet"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["multi_port_access"]
  }
}

module "ec2_worker1" {
  source         = "./EC2"
  instance_count = 1
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.small"              # 2 x CPU + 4 x RAM
  pem_key        = "petClinic"
  subnet         = data.aws_subnet.subnet.id # Task ~ get the Subnet group with Name Tag "PetClinic_Subnet"
  vpc_sg         = [data.aws_security_group.sg.id] # Task ~ get the Security group with Name Tag "multi_port_access"
  pub_ip         = true
  user_data      = <<-EOF
  #! /bin/bash
	EOF

  # @@@ TAGS @@@
  name_tag = "Swarm-Worker-1"
  network_tag = "PetClinic"
}