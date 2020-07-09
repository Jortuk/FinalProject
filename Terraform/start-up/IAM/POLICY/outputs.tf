output "id" {
    value = "${aws_iam_policy.iam_policy.id}" 
}

output "arn" {
    value = "${aws_iam_policy.iam_policy.arn}" 
}

output "description" {
    value = "${aws_iam_policy.iam_policy.description}"
}

output "name" {
    value = "${aws_iam_policy.iam_policy.name}"
}

output "path" {
    value = "${aws_iam_policy.iam_policy.path}"
}

output "policy" {
    value = "${aws_iam_policy.iam_policy.policy}"
}



#id - The policy's ID.
#arn - The ARN assigned by AWS to this policy. ####
#description - The description of the policy.
#name - The name of the policy.
#path - The path of the policy in IAM.
#policy - The policy document.