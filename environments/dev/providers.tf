terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state — uncomment once your S3 bucket + DynamoDB table exist
  # backend "s3" {
  #   bucket         = "myapp-terraform-state"
  #   key            = "dev/networking/terraform.tfstate"
  #   region         = "eu-west-1"
  #   dynamodb_table = "myapp-terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy   = "terraform"
      Environment = "dev"
      Repo        = "terraform-live"
    }
  }
}
