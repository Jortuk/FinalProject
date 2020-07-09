variable "vpc_id" {
  description = "This uses the VPC id aquired from the VPC Module to map this Subnet to the correct Network."
}

variable "v4_cidr" {
  description = "This is the cidr block for the igw route."
}

variable "igw_id" {
  description = "This will attach the routes to the open internet."
}

variable "name_tag" {
  description = "Name of the Routes Table."
}

variable "network_tag" {
  description = "Name of the Network Being attached."
}