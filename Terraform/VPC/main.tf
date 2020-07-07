resource "aws_vpc" "VPC" {
  cidr_block = var.v4_cidr

  tags = {
    Name = var.name_tag
  }
}