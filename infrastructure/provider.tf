terraform {
  required_version = ">= 0.13.5"
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}
