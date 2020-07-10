output "arn" {
  value = "${aws_vpc.VPC.arn}"
}

output "id" {
  value = "${aws_vpc.VPC.id}"
}

output "v4" {
  value = "${aws_vpc.VPC.cidr_block}"
}

output "tenancy" {
  value = "${aws_vpc.VPC.instance_tenancy}"
}

output "dns_supp" {
  value = "${aws_vpc.VPC.enable_dns_support}"
}

output "dns_host" {
  value = "${aws_vpc.VPC.enable_dns_hostnames}"
}

output "class" {
  value = "${aws_vpc.VPC.enable_classiclink}"
}

output "mroute_id" {
  value = "${aws_vpc.VPC.main_route_table_id}"
}

output "acl_id" {
  value = "${aws_vpc.VPC.default_network_acl_id}"
}

output "sg_id" {
  value = "${aws_vpc.VPC.default_security_group_id}"
}

output "route_id" {
  value = "${aws_vpc.VPC.default_route_table_id}"
}

output "v6_id" {
  value = "${aws_vpc.VPC.ipv6_association_id}"
}

output "v6" {
  value = "${aws_vpc.VPC.ipv6_cidr_block}"
}

output "owner" {
  value = "${aws_vpc.VPC.owner_id}"
}