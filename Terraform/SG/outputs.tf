output "sg_id" {
  value = "${aws_security_group.sg.id}"
}

output "sg_arn" {
  value = "${aws_security_group.sg.arn}"
}

output "sg_vpc_id" {
  value = "${aws_security_group.sg.vpc_id}"
}

output "sg_owner" {
  value = "${aws_security_group.sg.owner_id}"
}

output "sg_name" {
  value = "${aws_security_group.sg.name}"
}

output "sg_description" {
  value = "${aws_security_group.sg.description}"
}

output "sg_ingress" {
  value = "${aws_security_group.sg.ingress}"
}

output "sg_egress" {
  value = "${aws_security_group.sg.egress}"
}