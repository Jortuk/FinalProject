output "igw_id" {
  value = "${aws_internet_gateway.my_igw.id}"
}

output "igw_arn" {
  value = "${aws_internet_gateway.my_igw.arn}"
}

output "igw_owner" {
  value = "${aws_internet_gateway.my_igw.owner_id}"
}