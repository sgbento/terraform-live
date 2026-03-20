# ── Module version ────────────────────────────────────────────────────────────
modules_version = "v1.0.0"

# ── AWS ───────────────────────────────────────────────────────────────────────
aws_region = "eu-west-1"

# ── Networking ────────────────────────────────────────────────────────────────
# Staging uses a separate CIDR range from dev to avoid overlap if VPCs are ever peered
vpc_cidr = "10.1.0.0/16"
azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

public_subnet_cidrs  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/22", "10.1.14.0/22", "10.1.18.0/22"]
data_subnet_cidrs    = ["10.1.30.0/24", "10.1.31.0/24", "10.1.32.0/24"]
