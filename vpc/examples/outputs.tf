output "VPC" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "IPv4_prefix_list" {
  value = module.vpc.ipv4_prefix_list_id
}

output "IPv6_prefix_list" {
  value = module.vpc.ipv6_prefix_list_id
}
