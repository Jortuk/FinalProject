resource "aws_route_table" "routes" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.v4_cidr
    gateway_id = var.igw_id
  }

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}