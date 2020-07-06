variable "sg_description" {
  description = "This will describe the purpose of the Security Group."
}

variable "vpc_id" {
  description = "This uses the VPC id aquired from the VPC Module to map this Security Group to the correct Network."
}

variable "port_desc" {
  description = "This uses the VPC id aquired from the VPC Module to map this Security Group to the correct Network."
}

variable "in_port" {
  description = "Incoming ports."
}

variable "in_protocol" {
  description = "Port ProtocL, tcp default."
}

variable "in_cidr" {
  description = "CIDR block available for incoming ports."
}

variable "out_port" {
  description = "outgoing ports."
}

variable "out_protocol" {
  description = "outgoing protocol."
}

variable "out_cidr" {
  description = "CIDR block available for outgoing ports."
}

variable "tag_name" {
  description = "This the Name of this Security Group."
}