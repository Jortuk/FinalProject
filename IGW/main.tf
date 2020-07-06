resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name    = var.igw_name
    Network = var.igw_network
  }
}