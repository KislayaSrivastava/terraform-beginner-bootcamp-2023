terraform {
  cloud {
    organization = "KS-Food-Vendor-Organization"
    workspaces {
      name = "terra-house-FoodCart"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
    
}