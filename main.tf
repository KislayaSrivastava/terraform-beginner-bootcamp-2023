terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
}
  # cloud {
  #   organization = "KS-Food-Vendor-Organization"
  #   workspaces {
  #     name = "terra-house-FoodCart"
  #   }
  # }
}

module "terrahouse_aws" {
  source ="./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = "${path.root}${var.index_html_filepath}"
  error_html_filepath = "${path.root}${var.error_html_filepath}"
  content_version = var.content_version
  assets_path = "${path.root}${var.assets_path}"
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

resource "terratowns_home" "food-truck" {
  name = "My Food Truck 'let's eat' is here to stay forver"
  description =<<DESCRIPTION
Welcome to 'Let's Eat'! 🌟
We're thrilled to introduce our mouthwatering world of flavors on wheels to Bangalore. At Let's Eat, we're not just serving food; we're crafting unforgettable culinary experiences, one plate at a time.
Our Menu: Explore a delectable lineup of Lucknawi delights, from classic favorites to innovative creations. Our ingredients are fresh, our recipes are handcrafted, and our passion for food is unparalleled.
Our Chefs: Meet the talented culinary artists behind the magic - Kislaya & Shruti. With years of experience and a commitment to excellence, they're here to tantalize your taste buds.
Our Truck: Our vibrant and welcoming food truck is not just a place to eat; it's a gathering spot for friends and foodies alike. We take pride in our spotlessly clean kitchen on wheels, ensuring your meals are prepared with love and care.
Join the Let's eat Family: We're more than just a food truck; we're a community. Follow us on social media for the latest updates, special promotions, and behind-the-scenes glimpses of our food truck adventures.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town="missingo"
  content_version=1
}