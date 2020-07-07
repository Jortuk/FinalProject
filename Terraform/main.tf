# RUN terraform plan -lock=false -var 'username=${username}' -var 'password=${password}' -var 'pem_keyname=${pem_keyname}' -var 'pem_keypub=${pem_keypub}'

provider "aws" {
  # version                 = "~> 2.8"
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.pem_keyname
  public_key = var.pem_keypub
}

module "vpc" {
  source  = "./VPC"
  v4_cidr = "126.156.0.0/16"

  # @@@ TAGS @@@
  name_tag = "PetClinic"
}

module "igw" {
  source = "./IGW"
  vpc_id = module.vpc.vpc_id

  # @@@ TAGS @@@
  igw_name    = "PetClinic_igw"
  igw_network = "Network_Gate"
}

module "subnet" {
  source  = "./SUBNET"
  v4_cidr = "126.156.10.0/24"
  pub_ip  = true
  vpc_id  = module.vpc.vpc_id

  # @@@ TAGS @@@
  tag_name    = "Public_Subnet"
  tag_network = "Public"
}

module "public_routes" {
  source  = "./ROUTES"
  vpc_id  = module.vpc.vpc_id
  v4_cidr = "0.0.0.0/0"
  igw_id  = module.igw.igw_id

  # @@@ TAGS @@@
  tag_name    = "Public-Routes"
  tag_network = "Public"
}

module "public_routes_association" {
  source    = "./ROUTES/ASSOCIATION"
  table_id  = module.public_routes.route_id
  subnet_id = module.subnet.sub_id
}

module "sg" {
  source         = "./SG"
  sg_description = "This Security Group is created to allow various port access to an instance."
  vpc_id         = module.vpc.vpc_id
  port_desc      = {
    22 = "SSH-Port"
    80 = "HTTP-port"
    443 = "HTTPS-port"
    4200 = "Front-port"
    9966 = "Back-port"
    3306 = "SQL-port"
    }
  in_port        = [22, 80, 443, 4200, 9966, 3306]
  in_cidr        = "0.0.0.0/0"
  out_port       = 0
  out_protocol   = "-1"
  in_protocol    = "tcp"
  out_cidr       = "0.0.0.0/0"

  # @@@ TAGS @@@
  tag_name = "multi_port_access"
}

module "mysql_rds" {
  source         = "./RDS"
  instance_name  = "petclinic"
  instance_class = "t2.micro"
  vpc_sg_id      = [module.sg.sg_id]
  db_subnet_id   = module.subnet.sub_id
  username       = var.username
  password       = var.password

  # @@@ TAGS @@@
  tag_name = "My DB subnet group"
}

module "ec2_manager" {
  source         = "./EC2"
  instance_count = "1"
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t3a.medium"            # 2 x CPU + 4 x RAM
  pem_key        = var.pem_keyname
  subnet         = module.subnet.sub_id
  vpc_sg         = [module.sg.sg_id]
  pub_ip         = true

  # @@@ TAGS @@@
  tag_name = "Kube-Manager"
}

module "ec2_worker1" {
  source         = "./EC2"
  instance_count = 1
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.micro"              # 2 x CPU + 4 x RAM
  pem_key        = var.pem_keyname
  subnet         = module.subnet.sub_id
  vpc_sg         = [module.sg.sg_id]
  pub_ip         = true

  # @@@ TAGS @@@
  tag_name = "Kube-Worker-1"
}

module "ec2_worker2" {
  source         = "./EC2"
  instance_count = 1
  ami_code       = "ami-008320af74136c628" # Ubuntu 16.04
  type_code      = "t2.micro"              # 2 x CPU + 4 x RAM
  pem_key        = var.pem_keyname
  subnet         = module.subnet.sub_id
  vpc_sg         = [module.sg.sg_id]
  pub_ip         = true

  # @@@ TAGS @@@
  tag_name = "Kube-Worker-2"
}