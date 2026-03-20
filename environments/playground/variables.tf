variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

variable "my_ip" {
  description = "Your home IP in CIDR notation — restricts SSH to your machine only. Find it at https://checkip.amazonaws.com"
  type        = string
  # Example: "1.2.3.4/32"
}

variable "key_pair_name" {
  description = "Name of an existing AWS key pair to use for SSH access. Create one in AWS Console → EC2 → Key Pairs."
  type        = string
}
