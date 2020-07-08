variable "v4_cidr" {
  description = "This is the base CIDR Block for this Instance. the first 2 Blacks are locked."
}

variable "hostname" {
  description = "True or False, would you like to have a host name?"
}

variable "name_tag" {
  description = "Name of the VPC."
}

variable "network_tag" {
  description = "Name of the Network Being attached."
}