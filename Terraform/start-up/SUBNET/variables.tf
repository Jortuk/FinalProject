variable "availability_zone" {
  description = "Select Availability Zone."
}

variable "v4_cidr" {
  description = "This is the v4 Cider Block. This has the first 3 Blocks locked."
}

variable "pub_ip" {
  description = "Request a public ID for the given Subnet."
}

variable "vpc_id" {
  description = "This uses the VPC id aquired from the VPC Module to map this Subnet to the correct Network."
}

variable "name_tag" {
  description = "Name of the Subnet."
}

variable "network_tag" {
  description = "Name of the Network Being attached."
}