resource "aws_subnet" "subnet" {
  availability_zone       = var.availability_zone
  cidr_block              = var.v4_cidr
  map_public_ip_on_launch = var.pub_ip
  vpc_id                  = var.vpc_id

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}