locals {
  name         = "myapp-dev"
  cluster_name = "myapp-dev"

  # Git source base — all modules pinned to the same tag for consistency
  modules_base = "git::https://github.com/sgbento/terraform-modules.git//modules"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Project     = "myapp"
  }
}

# ─── VPC ──────────────────────────────────────────────────────────────────────

module "vpc" {
  source = "${local.modules_base}/vpc?ref=${var.modules_version}"

  name         = local.name
  cidr_block   = var.vpc_cidr
  cluster_name = local.cluster_name
  tags         = local.tags
}

# ─── Subnets ──────────────────────────────────────────────────────────────────

module "subnets" {
  source = "${local.modules_base}/subnets?ref=${var.modules_version}"

  name                  = local.name
  vpc_id                = module.vpc.vpc_id
  cluster_name          = local.cluster_name
  azs                   = var.azs
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  data_subnet_cidrs     = var.data_subnet_cidrs
  public_route_table_id = module.vpc.public_route_table_id
  tags                  = local.tags
}

# ─── NAT Gateway ──────────────────────────────────────────────────────────────
# single_nat_gateway = true saves ~$66/month for personal/dev use

module "nat_gateway" {
  source = "${local.modules_base}/nat-gateway?ref=${var.modules_version}"

  name                    = local.name
  public_subnet_ids       = module.subnets.public_subnet_ids
  private_route_table_ids = module.subnets.private_route_table_ids
  data_route_table_ids    = module.subnets.data_route_table_ids
  internet_gateway_id     = module.vpc.internet_gateway_id
  single_nat_gateway      = true
  tags                    = local.tags
}

# ─── EKS Cluster ──────────────────────────────────────────────────────────────

module "eks" {
  source = "${local.modules_base}/eks?ref=${var.modules_version}"

  cluster_name        = local.cluster_name
  kubernetes_version  = var.kubernetes_version
  private_subnet_ids  = module.subnets.private_subnet_ids
  public_access_cidrs = var.public_access_cidrs
  tags                = local.tags
}

# ─── Node Group ───────────────────────────────────────────────────────────────

module "node_group" {
  source = "${local.modules_base}/node-group?ref=${var.modules_version}"

  cluster_name       = module.eks.cluster_name
  node_group_name    = "${local.name}-nodes"
  private_subnet_ids = module.subnets.private_subnet_ids
  instance_type      = var.node_instance_type
  capacity_type      = var.node_capacity_type
  desired_size       = var.node_desired_size
  min_size           = var.node_min_size
  max_size           = var.node_max_size
  tags               = local.tags
}
