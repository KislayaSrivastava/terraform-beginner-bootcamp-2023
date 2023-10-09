output "bucket_name" {
    description = "Bucket Name for our static website"
    value = module.terrahome_foodtruck_hosting.bucket_name
}

output "S3_website_endpoint_FoodTruck" {
    description = "Static Website Endpoint Url"
    value=module.terrahome_foodtruck_hosting.website_endpoint
}

output "cloudfront_url_FoodTruck" {
  description = "Cloudfront Distribution URL"
  value=module.terrahome_foodtruck_hosting.cloudfront_url
}

output "S3_website_endpoint_Movies" {
    description = "Static Website Endpoint Url"
    value=module.terrahome_movies_hosting.website_endpoint
}

output "cloudfront_url_Movies" {
  description = "Cloudfront Distribution URL"
  value=module.terrahome_movies_hosting.cloudfront_url
}