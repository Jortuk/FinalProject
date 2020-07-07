resource "aws_security_group" "sg" {
  name        = var.tag_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.in_port
    content {
      description = var.port_desc[port.value]
      from_port   = port.value
      to_port     = port.value
      protocol    = var.in_protocol
      cidr_blocks = [var.in_cidr]
    }
  }

  egress {
    from_port   = var.out_port
    to_port     = var.out_port
    protocol    = var.out_protocol
    cidr_blocks = [var.out_cidr]
  }

  tags = {
    Name = var.tag_name
  }
}

# name - (Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name
# name_prefix - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name.
# description - (Optional, Forces new resource) The security group description. Defaults to "Managed by Terraform". Cannot be "". NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags.
# ingress - (Optional) Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode.
# egress - (Optional, VPC only) Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode.
# revoke_rules_on_delete - (Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false
# vpc_id - (Optional, Forces new resource) The VPC ID.
# tags - (Optional) A map of tags to assign to the resource.

# The ingress block supports:

# cidr_blocks - (Optional) List of CIDR blocks.
# ipv6_cidr_blocks - (Optional) List of IPv6 CIDR blocks.
# prefix_list_ids - (Optional) List of prefix list IDs.
# from_port - (Required) The start port (or ICMP type number if protocol is "icmp" or "icmpv6")
# protocol - (Required) The protocol. If you select a protocol of "-1" (semantically equivalent to "all", which is not a valid value here), you must specify a "from_port" and "to_port" equal to 0. If not icmp, icmpv6, tcp, udp, or "-1" use the protocol number
# security_groups - (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
# self - (Optional) If true, the security group itself will be added as a source to this ingress rule.
# to_port - (Required) The end range port (or ICMP code if protocol is "icmp").
# description - (Optional) Description of this ingress rule.

# The egress block supports:

# cidr_blocks - (Optional) List of CIDR blocks.
# ipv6_cidr_blocks - (Optional) List of IPv6 CIDR blocks.
# prefix_list_ids - (Optional) List of prefix list IDs (for allowing access to VPC endpoints)
# from_port - (Required) The start port (or ICMP type number if protocol is "icmp")
# protocol - (Required) The protocol. If you select a protocol of "-1" (semantically equivalent to "all", which is not a valid value here), you must specify a "from_port" and "to_port" equal to 0. If not icmp, tcp, udp, or "-1" use the protocol number
# security_groups - (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
# self - (Optional) If true, the security group itself will be added as a source to this egress rule.
# to_port - (Required) The end range port (or ICMP code if protocol is "icmp").
# description - (Optional) Description of this egress rule.