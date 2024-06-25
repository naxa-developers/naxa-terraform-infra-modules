output "vpc_id" {
  value = aws_vpc.primary.id

  description = "VPC ID of the primary VPC created by the VPC module"
}

output "public_subnets" {
  value = [for subnet in aws_subnet.public : subnet.id]

  description = "List of public subnet IDs"
}

output "private_subnets" {
  value = [for subnet in aws_subnet.private : subnet.id]

  description = "List of public subnet IDs"
}

output "ipv4_prefix_list_id" {
  value = aws_ec2_managed_prefix_list.admin-v4.id

  description = "ID of the prefix list with IPv4 addresses; Use this for security group SSH allow-lists"
}

output "ipv6_prefix_list_id" {
  value = aws_ec2_managed_prefix_list.admin-v6.id

  description = "ID of the prefix list with IPv6 addresses; Use this for security group SSH allow-lists"
}

output "default_security_group_id" {
  value = aws_default_security_group.default.id

  description = "Default Security Group ID for the VPC"
}
