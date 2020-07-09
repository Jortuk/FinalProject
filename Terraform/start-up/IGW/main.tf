resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}