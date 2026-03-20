# terraform-live

Live environment configurations for AWS EKS infrastructure.
Each environment calls modules from the `terraform-modules` repo, pinned to a git tag.

---

## Repo relationship

```
terraform-modules  (library — reusable modules, versioned with git tags)
        │
        │  source = "git::https://github.com/your-github-username/terraform-modules.git//modules/vpc?ref=v1.0.0"
        │
terraform-live     (live — environment-specific values only, no module logic)
```

**Rule:** no resource logic lives here. Only variable values and module calls.

---

## Environments

| Environment | CIDR | State key |
|---|---|---|
| `dev` | 10.0.0.0/16 | `dev/networking/terraform.tfstate` |
| `staging` | 10.1.0.0/16 | `staging/networking/terraform.tfstate` |
| `prod` | 10.2.0.0/16 | `prod/networking/terraform.tfstate` |

Each environment has its own non-overlapping VPC CIDR so they can be safely peered in future.

---

## Usage

```bash
# Deploy dev networking
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Upgrading a module version

1. In `terraform.tfvars`, change `modules_version = "v1.1.0"`
2. Run `terraform init -upgrade` to pull the new module source
3. Run `terraform plan` to review changes
4. Apply after review

---

## Structure

```
environments/
├── dev/
│   ├── main.tf           # Module calls
│   ├── variables.tf      # Variable declarations
│   ├── outputs.tf        # Outputs (vpc_id, subnet_ids, etc.)
│   ├── providers.tf      # AWS provider + Terraform backend
│   └── terraform.tfvars  # Actual values for this environment
├── staging/
│   └── terraform.tfvars
└── prod/
    └── terraform.tfvars
```
