provide "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "cinema-app.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  comman_tags = {
    Environment = terraform.workspace
    Project = var.project
    ManagedBy = "Terraform"
    Owner " Sadia Hassan"
  }
}