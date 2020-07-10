resource "aws_iam_role" "iam_role" {
  name = var.iam_name
  description = var.iam_desc

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
      Name = var.iam_name
  }
}