# ── Module version ────────────────────────────────────────────────────────────
modules_version = "v1.0.0"

# ── AWS ───────────────────────────────────────────────────────────────────────
aws_region = "eu-west-1"

# ── Networking ────────────────────────────────────────────────────────────────
# Prod uses its own CIDR range — non-overlapping across all envs
vpc_cidr = "10.2.0.0/16"
azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

public_subnet_cidrs  = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24"]
private_subnet_cidrs = ["10.2.10.0/22", "10.2.14.0/22", "10.2.18.0/22"]
data_subnet_cidrs    = ["10.2.30.0/24", "10.2.31.0/24", "10.2.32.0/24"]
