output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs — used for ALB"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs — used for EKS managed node groups"
  value       = module.subnets.private_subnet_ids
}

output "data_subnet_ids" {
  description = "Data subnet IDs — used for RDS, ElastiCache"
  value       = module.subnets.data_subnet_ids
}

output "nat_public_ips" {
  description = "Elastic IPs of NAT Gateways — whitelist these for outbound traffic"
  value       = module.nat_gateway.nat_public_ips
}
