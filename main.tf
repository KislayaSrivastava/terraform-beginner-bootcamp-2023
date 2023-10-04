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
  index_html_filepath = "${path.root}${var.index_html_filepath}"
  error_html_filepath = "${path.root}${var.error_html_filepath}"
  content_version = var.content_version
  assets_path = "${path.root}${var.assets_path}"
}