locals {
  name         = "myapp-dev"
  cluster_name = "myapp-dev"

  # Git source base — all modules are pinned to the same tag for consistency.
  # To use a different version per module, replace with individual variables.
  # Replace "your-github-username" with your actual GitHub username
  modules_base = "git::https://github.com/your-github-username/terraform-modules.git//modules"

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

# ─── NAT Gateways ─────────────────────────────────────────────────────────────

module "nat_gateway" {
  source = "${local.modules_base}/nat-gateway?ref=${var.modules_version}"

  name                    = local.name
  public_subnet_ids       = module.subnets.public_subnet_ids
  private_route_table_ids = module.subnets.private_route_table_ids
  data_route_table_ids    = module.subnets.data_route_table_ids
  internet_gateway_id     = module.vpc.internet_gateway_id
  tags                    = local.tags
}
