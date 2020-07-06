resource "aws_instance" "ec2_instance" {
  count                       = var.instance_count
  ami                         = var.ami_code
  instance_type               = var.type_code
  key_name                    = var.pem_key
  subnet_id                   = var.subnet
  vpc_security_group_ids      = var.vpc_sg
  associate_public_ip_address = var.pub_ip

  tags = {
    Name = var.tag_name
  }
}