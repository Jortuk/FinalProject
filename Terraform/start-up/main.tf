# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@ Prerequesits ~ START @@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Having created a t2.micro and pulled down the git repository.
# run the following command to activate a shell script, installing Terraform and create a keygen.
# RUN 'cd FinalProject/ && git checkout terraform && cd Terraform/ && sh scripts/initialize.sh'

# With Terraform Installed, run the command bellow to start the build process of all AWS Resources needed.
# RUN 'cd start-up/ && terraform apply -var 'pem_keyname=${pem_keyname}' -var 'pem_keypub=${pem_keypub}'

# The Manager node will download and install terraform and git for us. pulling the repo down, starting the worker node build and aquiring the IP address for both.
# This process will take a moment to complete.

# Run the following command to enter Jenkins and guide setup in tutorial and begin build and launch the application.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Prerequesits ~ END @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# RUN terraform plan -lock=false -var 'pem_keyname=${pem_keyname}' -var 'pem_keypub=${pem_keypub}'

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

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@ Create Virtual Priv Network @@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "vpc" {
  source  = "./VPC"
  v4_cidr = "126.156.0.0/16"

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

module "subnet" {
  source  = "./SUBNET"
  v4_cidr = "126.156.10.0/24"
  pub_ip  = true
  vpc_id  = module.vpc.id

  # @@@ TAGS @@@
  name_tag    = "PetClinic_Subnet"
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
# @@@@@@@ Create SQL Database @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

module "mysql_rds" {
  source         = "./RDS"
  instance_name  = "petclinic"
  instance_class = "t2.micro"
  vpc_sg_id      = [module.sg.id]
  db_subnet_id   = module.subnet.id
  username       = var.username
  password       = var.password

  # @@@ TAGS @@@
  name_tag = "My DB subnet group"
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
  pem_key        = module.key_pair.name
  subnet         = module.subnet.id
  vpc_sg         = [module.sg.id]
  pub_ip         = true
  user_data      = << EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt instal awscli
  sudo apt install default-jre
  wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
  sudo apt update
  sudo apt install jenkins
  sudo systemctl start jenkins
	EOF

  # @@@ TAGS @@@
  name_tag = "Swarm-Manager"
  network_tag = "PetClinic"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@ Create EC2 Instance @@@@@@@
# @@@@@@@       Workers       @@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

data {
  get security groups
  get subnet 
}

module "ec2_worker1" {
  source         = "./EC2"
  instance_count = 1
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.small"              # 2 x CPU + 4 x RAM
  pem_key        = module.key_pair.name
  subnet         = module.subnet.id
  vpc_sg         = [module.sg.id]
  pub_ip         = true
  user_data      = << EOF
  #! /bin/bash
	EOF

  # @@@ TAGS @@@
  name_tag = "Swarm-Worker-1"
  network_tag = "PetClinic"
}

module "ec2_worker2" {
  source         = "./EC2"
  instance_count = 1
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.small"              # 2 x CPU + 4 x RAM
  pem_key        = module.key_pair.name
  subnet         = module.subnet.id
  vpc_sg         = [module.sg.id]
  pub_ip         = true
  user_data      = << EOF
  #! /bin/bash
	EOF

  # @@@ TAGS @@@
  name_tag = "Swarm-Worker-2"
  network_tag = "PetClinic"
}