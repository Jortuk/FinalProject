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

# cidr_block - (Required) The CIDR block of the route.
# ipv6_cidr_block - (Optional) The Ipv6 CIDR block of the route.

# One of the following target arguments must be supplied:

# egress_only_gateway_id - (Optional) Identifier of a VPC Egress Only Internet Gateway.
# gateway_id - (Optional) Identifier of a VPC internet gateway or a virtual private gateway.
# instance_id - (Optional) Identifier of an EC2 instance.
# nat_gateway_id - (Optional) Identifier of a VPC NAT gateway.
# network_interface_id - (Optional) Identifier of an EC2 network interface.
# transit_gateway_id - (Optional) Identifier of an EC2 Transit Gateway.
# vpc_peering_connection_id - (Optional) Identifier of a VPC peering connection.