resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [var.db_subnet_id1, var.db_subnet_id2]

  tags = {
    Name = var.name_tag
    Network = var.network_tag
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier             = var.instance_name
  allocated_storage      = var.storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.instance_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = var.vpc_sg_id
  final_snapshot_identifier = var.snapshot_name
  skip_final_snapshot = var.skip_snapshot
}