output "id" {
  value = "${aws_security_group.sg.id}"
}

output "arn" {
  value = "${aws_security_group.sg.arn}"
}

output "vpc_id" {
  value = "${aws_security_group.sg.vpc_id}"
}

output "owner" {
  value = "${aws_security_group.sg.owner_id}"
}

output "name" {
  value = "${aws_security_group.sg.name}"
}

output "description" {
  value = "${aws_security_group.sg.description}"
}

output "ingress" {
  value = "${aws_security_group.sg.ingress}"
}

output "egress" {
  value = "${aws_security_group.sg.egress}"
}