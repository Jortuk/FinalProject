variable "v4_cidr" {
  description = "This is the v4 Cider Block. This has the first 3 Blocks locked."
}

variable "pub_ip" {
  description = "Request a public ID for the given Subnet."
}

variable "vpc_id" {
  description = "This uses the VPC id aquired from the VPC Module to map this Subnet to the correct Network."
}

variable "tag_name" {
  description = "This is the name of this Subnet"
}

variable "tag_network" {
  description = "This is Network for this Subnet"
}