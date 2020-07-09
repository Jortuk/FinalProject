# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@ Prerequesits ~ START @@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Create a t2.micro Developer Server to host the Repo...
# * git clone https://github.com/Jortuk/FinalProject

# Move into Terraform Directory via the 'terraform' branch to install dependancies...
# * cd FinalProject/
# * git branch terraform
# * cd Terraform/

# Now within this directory you able to run scripts, creating a Keygen and installing dependancies
# for Terraform and awscli (aws IAM crodentuals will be requested)...
# * sh scrips/setup.sh
#   ~ enter AWS Login Keys

# Witht he dependancies installed and AWS crodentuals accessable by Terraform. The Resources related
# to the 'Pet Clinic' app can be run (Database 'Username' and 'Password' will be requested)...
# * cd start-up && terraform init
# * terraform apply
#   ~ enter username
#   ~ enter password

# After the Resources are finished constructing, the Manager node is now able to be accessed using the
# ssh Key produced within the setup script...
# * ssh -i "~/.ssh/AWS-Remote" ubuntu@ec2-0-0-0-0.eu-west-1.compute.amazonaws.com

# Sign in using the AWS Keys (this is the last time they will be needed durring this build)...
# * aws configure

# Build Worker Nodes
# * cd FinalProject/Terraform/worker
# * terraform init
# * terraform apply

# Using the IP address of the worker node include it in the area marker {add ip}...
# * sudo vim .bashrc
#   ~ export USERNAME="admin"
#   ~ export PASSWORD="group2password"
#   ~ export URL="petclinicdb.cncg09p34dh0.eu-west-1.rds.amazonaws.com"
#   ~ export worker={add ip}
#   ~ export ANSIBLE_HOST_KEY_CHECKING=False

# Aquire Secret Key for Jenkins...
# * sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Allow jenkins to run without the need of a password by entering the following command and pasting the
# following in the file...
# * sudo visudo
#   ~ jenkins ALL=(ALL) NOPASSWD: ALL

# Final step before entering Jenkins, The worker node will need to sit in the folloing directory and be
# called 'worker'...
# * sudo su jenkins
# * sudo vim /etc/hosts
#   ~ Name the worker node 'worker'

# Access Jenkins on the new server using its public IP followed by :8080 and paste in the Secret Key...

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Prerequesits ~ END @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

provider "aws" {
  # version                 = "~> 2.8"
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@ Key Pair for machine Access @@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

resource "aws_key_pair" "key_pair" {
  key_name   = "AWS-Remote"
  public_key = file("/home/ubuntu/.ssh/AWS-Remote.pub")
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@ Create Virtual Priv Network @@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "vpc" {
  source  = "./VPC"
  v4_cidr = "126.156.0.0/16"
  hostname = true

  # @@@ TAGS @@@
  name_tag = "PetClinic-Private-Cloud"
  network_tag = "PetClinic"
}

module "igw" {
  source = "./IGW"
  vpc_id = module.vpc.id

  # @@@ TAGS @@@
  name_tag    = "PetClinic_Network_Gate"
  network_tag = "PetClinic"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "subnet" {
  source  = "./SUBNET"
  availability_zone = data.aws_availability_zones.available.names[0]
  v4_cidr = "126.156.10.0/24"
  pub_ip  = true
  vpc_id  = module.vpc.id

  # @@@ TAGS @@@
  name_tag    = "PetClinic_Subnet"
  network_tag = "PetClinic"
}

module "subnet_needed" {
  source  = "./SUBNET"
  availability_zone = data.aws_availability_zones.available.names[1]
  v4_cidr = "126.156.20.0/24"
  pub_ip  = true
  vpc_id  = module.vpc.id

  # @@@ TAGS @@@
  name_tag    = "Closed_PetClinic_Subnet"
  network_tag = "PetClinic"
}

module "public_routes" {
  source  = "./ROUTES"
  vpc_id  = module.vpc.id
  v4_cidr = "0.0.0.0/0"
  igw_id  = module.igw.id

  # @@@ TAGS @@@
  name_tag    = "PetClinic-Routes"
  network_tag = "PetClinic"
}

module "public_routes_association" {
  source    = "./ROUTES/ASSOCIATION"
  table_id  = module.public_routes.id
  subnet_id = module.subnet.id
}

# iam user

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@ Create Security Group @@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "sg" {
  source         = "./SG"
  sg_description = "This Security Group is created to allow various port access to an instance."
  vpc_id         = module.vpc.id
  port_desc      = {
    22 = "SSH-Port"
    80 = "HTTP-port"
    8080 = "Jenkins-port"
    }
  in_port        = [22, 80, 8080]
  in_cidr        = "0.0.0.0/0"
  out_port       = 0
  out_protocol   = "-1"
  in_protocol    = "tcp"
  out_cidr       = "0.0.0.0/0"

  # @@@ TAGS @@@
  name_tag = "multi_port_access"
  network_tag = "PetClinic"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Create IAM role @@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "iam" {
  source = "./IAM"
  iam_name = "AWSResourcePolicies"
  iam_desc = "aws_iam_role provision"
}

module "iam_policy" {
  source = "./IAM/POLICY"
  name = "AWSResourcePolicy"
  desc = "Policy used in conjunction with IAM Role"
  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "iam_policy_1" {
    source = "./IAM/POLICY_ATTACH"
    iam_pol_role = module.iam.name
    iam_pol_arn = module.iam_policy.arn
  }

module "iam_policy_2" {
    source = "./IAM/POLICY_ATTACH"
    iam_pol_role = module.iam.name
    iam_pol_arn = module.iam_policy.arn
  }

module "iam_policy_3" {
    source = "./IAM/POLICY_ATTACH"
    iam_pol_role = module.iam.name
    iam_pol_arn = module.iam_policy.arn
  }

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Create SQL Database @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "mysql_rds" {
  source         = "./RDS"
  instance_name  = "petclinicdbtesting"
  instance_class = "db.t2.micro"
  vpc_sg_id      = [module.sg.id]
  db_subnet_id1  = module.subnet.id
  db_subnet_id2  = module.subnet_needed.id
  username       = var.username
  password       = var.password
  skip_snapshot  = true
  snapshot_name  = false

  # @@@ TAGS @@@
  name_tag = "petclinicdb"
  network_tag = "PetClinic"
}

# rna ~ output this from above

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Create EC2 Instance @@@@@@@
# @@@@@@@       Manager       @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "ec2_manager" {
  source         = "./EC2"
  instance_count = "1"
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.medium"            # 2 x CPU + 4 x RAM
  pem_key        = "AWS-Remote"
  subnet         = module.subnet.id
  vpc_sg         = [module.sg.id]
  pub_ip         = true
  user_data      = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt install awscli -y
    sudo apt install default-jre -y
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update  -y
    sudo apt install jenkins  -y
    sudo systemctl start jenkins
    sudo apt install figlet
    EOF

  # @@@ TAGS @@@
  name_tag = "Swarm-Manager"
  network_tag = "PetClinic"
}