terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.47"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws-region
}

# Random string to create unique identifier
resource "random_string" "random" {
  length  = 8
  lower   = true
  upper   = false
  number  = false
  special = false
}

