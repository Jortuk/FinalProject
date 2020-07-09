resource "aws_vpc" "VPC" {
  cidr_block = var.v4_cidr
  enable_dns_hostnames = var.hostname

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}