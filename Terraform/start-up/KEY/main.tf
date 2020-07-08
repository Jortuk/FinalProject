resource "aws_key_pair" "key_pair" {
  key_name   = var.name
  public_key = var.key
}