variable "instance_count" {
  description = "The number of machines needed."
}

variable "ami_code" {
  description = "Operating System Image."
}

variable "type_code" {
  description = "Machine Spec code."
}

variable "pem_key" {
  description = "Pem Key paired with Instance."
}

variable "subnet" {
  description = "Subnet the EC2 is to reside within."
}

variable "vpc_sg" {
  description = "Allocated Security Group."
}

variable "pub_ip" {
  description = "Assign a public IP address to the EC2 Instance."
}

variable "user_data" {
  description = "Commands to run at the start of the instance."
}

variable "name_tag" {
  description = "Name of the Instance."
}

variable "network_tag" {
  description = "Name of the Network Being attached."
}