# ── Module version ────────────────────────────────────────────────────────────
modules_version = "v1.1.0"

# ── AWS ───────────────────────────────────────────────────────────────────────
aws_region = "eu-west-1"

# ── Networking ────────────────────────────────────────────────────────────────
vpc_cidr = "10.0.0.0/16"
azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/22", "10.0.14.0/22", "10.0.18.0/22"]
data_subnet_cidrs    = ["10.0.30.0/24", "10.0.31.0/24", "10.0.32.0/24"]

# ── EKS ───────────────────────────────────────────────────────────────────────
kubernetes_version = "1.31"

# Restrict to your home IP for security: ["x.x.x.x/32"]
public_access_cidrs = ["0.0.0.0/0"]

# ── Node Group ────────────────────────────────────────────────────────────────
node_instance_type  = "t3.medium"
node_capacity_type  = "SPOT"      # ~70% cheaper than ON_DEMAND — switch to ON_DEMAND for prod
node_desired_size   = 1
node_min_size       = 1
node_max_size       = 3
