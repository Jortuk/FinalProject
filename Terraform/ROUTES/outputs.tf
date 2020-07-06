output "route_id" {
  value = "${aws_route_table.routes.id}"
}

output "route_owner" {
  value = "${aws_route_table.routes.owner_id}"
}