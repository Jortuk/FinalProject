resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = var.iam_pol_role
  policy_arn = var.iam_pol_arn
}