output "bucket_name" {
    description = "Bucket Name for our static website"
    value = module.terrahouse_aws.bucket_name
}

output "S3_website_endpoint" {
    description = "Static Website Endpoint Url"
    value=module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "Cloudfront Distribution URL"
  value=module.terrahouse_aws.cloudfront_url
}