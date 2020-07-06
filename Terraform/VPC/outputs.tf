output "vpc_arn" {
  value = "${aws_vpc.VPC.arn}"
}

output "vpc_id" {
  value = "${aws_vpc.VPC.id}"
}

output "vpc_v4" {
  value = "${aws_vpc.VPC.cidr_block}"
}

output "vpc_tenancy" {
  value = "${aws_vpc.VPC.instance_tenancy}"
}

output "vpc_dns_supp" {
  value = "${aws_vpc.VPC.enable_dns_support}"
}

output "vpc_dns_host" {
  value = "${aws_vpc.VPC.enable_dns_hostnames}"
}

output "vpc_class" {
  value = "${aws_vpc.VPC.enable_classiclink}"
}

output "vpc_mroute_id" {
  value = "${aws_vpc.VPC.main_route_table_id}"
}

output "vpc_acl_id" {
  value = "${aws_vpc.VPC.default_network_acl_id}"
}

output "vpc_sg" {
  value = "${aws_vpc.VPC.default_security_group_id}"
}

output "vpc_droute_id" {
  value = "${aws_vpc.VPC.default_route_table_id}"
}

output "vpc_v6_id" {
  value = "${aws_vpc.VPC.ipv6_association_id}"
}

output "vpc_v6" {
  value = "${aws_vpc.VPC.ipv6_cidr_block}"
}

output "vpc_owner" {
  value = "${aws_vpc.VPC.owner_id}"
}