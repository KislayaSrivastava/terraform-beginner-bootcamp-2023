terraform {
  cloud {
    organization = "KS-Food-Vendor-Organization"
    workspaces {
      name = "terra-house-FoodCart"
    }
  }
}

module "terrahouse_aws" {
  source ="./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}