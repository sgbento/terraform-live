# ── Identity ──────────────────────────────────────────────────────────────────

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

# ── Module versions ───────────────────────────────────────────────────────────
# Pin each module to a specific git tag.
# To upgrade, change the tag here and run terraform init -upgrade.

variable "modules_version" {
  description = "Git tag of the terraform-modules repo to use for all modules"
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
