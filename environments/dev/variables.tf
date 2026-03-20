# ── AWS ───────────────────────────────────────────────────────────────────────

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

# ── Module versions ───────────────────────────────────────────────────────────

variable "modules_version" {
  description = "Git tag of the terraform-modules repo to use"
  type        = string
  default     = "v1.0.0"
}

# ── Networking ────────────────────────────────────────────────────────────────

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones to deploy into"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets — EKS nodes (one per AZ)"
  type        = list(string)
  default     = ["10.0.10.0/22", "10.0.14.0/22", "10.0.18.0/22"]
}

variable "data_subnet_cidrs" {
  description = "CIDR blocks for data subnets — RDS, ElastiCache (one per AZ)"
  type        = list(string)
  default     = ["10.0.30.0/24", "10.0.31.0/24", "10.0.32.0/24"]
}

# ── EKS ───────────────────────────────────────────────────────────────────────

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to reach the EKS public API endpoint (your home IP)"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Restrict to your IP: ["x.x.x.x/32"]
}

# ── Node Group ────────────────────────────────────────────────────────────────

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_capacity_type" {
  description = "SPOT for cost saving (~70% cheaper), ON_DEMAND for stability"
  type        = string
  default     = "SPOT"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}
