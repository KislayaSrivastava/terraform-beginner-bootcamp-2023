output "Ramdom_variable_user_id" {
    value = var.user_uuid
}

output "bucket_name"{
    value=aws_s3_bucket.website_bucket.bucket
}