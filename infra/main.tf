provide "aws" {
  region = "us-east-2"
  profile = "sadia-office"
}
terraform {
  backend "s3" {
    bucket = "cinema-react-app-tf-state"
    key = "cinema-app.tfstate"
    region = "us-east-2"
    encrypt = true
  }  
}
locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  Environment = terraform.workspace
  Project = var.project
  ManagedBy = "terraform"
  Owner = "Sadia Hassan"
}