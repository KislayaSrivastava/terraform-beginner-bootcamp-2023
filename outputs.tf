output "bucket_name" {
    description = "Bucket Name for our static website"
    value = module.terrahouse_aws.bucket_name
}