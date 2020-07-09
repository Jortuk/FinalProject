resource "aws_instance" "ec2_instance" {
  count                       = var.instance_count
  ami                         = var.ami_code
  instance_type               = var.type_code
  key_name                    = var.pem_key
  subnet_id                   = var.subnet
  vpc_security_group_ids      = var.vpc_sg
  associate_public_ip_address = var.pub_ip
  user_data                   = var.user_data

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}