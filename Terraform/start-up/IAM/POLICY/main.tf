resource "aws_iam_policy" "iam_policy" {
  name        = var.name
  description = var.desc

  policy = var.policy
}