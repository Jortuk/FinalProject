output "id" {
  value = "${aws_internet_gateway.my_igw.id}"
}

output "arn" {
  value = "${aws_internet_gateway.my_igw.arn}"
}

output "owner" {
  value = "${aws_internet_gateway.my_igw.owner_id}"
}