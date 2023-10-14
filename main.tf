terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
}
  cloud {
    organization = "KS-Food-Vendor-Organization"
    workspaces {
      name = "terra-house-FoodCart"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahome_foodtruck_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.foodtruck.public_path
  content_version = var.foodtruck.content_version
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
  domain_name = module.terrahome_foodtruck_hosting.cloudfront_url
  town="cooker-cove"
  content_version=var.foodtruck.content_version
}

module "terrahome_movies_hosting" {
source = "./modules/terrahome_aws"
user_uuid = var.teacherseat_user_uuid
bucket_name = var.bucket_name
public_path = var.movies.public_path
content_version = var.movies.content_version
}

resource "terratowns_home" "Movies-to-Rent" {
  name = "Best Action Movies"
  description =<<DESCRIPTION
Hollywood has consistently delivered some of the most exhilarating and pulse-pounding action movies in cinematic history. From heart-pounding car chases to explosive fight sequences, these films have set the bar high for adrenaline-pumping entertainment. Classics like "Die Hard" and "Terminator 2: Judgment Day" have forever etched their place in action movie history with iconic characters like John McClane and the T-800. More recent additions, such as "Mad Max: Fury Road" and "John Wick," have redefined the genre with breathtaking stunts and relentless action. Superhero blockbusters like "The Dark Knight" and "Avengers: Endgame" have also left audiences in awe with their epic battles and complex characters. Hollywood's dedication to pushing the boundaries of action filmmaking continues to captivate audiences worldwide, ensuring that the legacy of incredible action movies lives on for generations to come.
DESCRIPTION
  domain_name = module.terrahome_movies_hosting.cloudfront_url
  town="video-valley"
  content_version = var.movies.content_version
}