output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs — used for ALB"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs — used for EKS nodes"
  value       = module.subnets.private_subnet_ids
}

output "data_subnet_ids" {
  description = "Data subnet IDs — used for RDS, ElastiCache"
  value       = module.subnets.data_subnet_ids
}

output "nat_public_ips" {
  description = "Elastic IPs of NAT Gateways"
  value       = module.nat_gateway.nat_public_ips
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint — use with kubectl"
  value       = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN — used for IRSA (IAM roles for pods)"
  value       = module.eks.oidc_provider_arn
}
