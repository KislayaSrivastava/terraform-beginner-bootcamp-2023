variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

variable "bucket_name" {
  description = "Name of the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Bucket name must be lowercase, between 3 and 63 characters, and may only contain lowercase letters, numbers, hyphens, and periods."
  }
}

#Commented for now
# variable "index_html_filepath" {
#   description = "Path to the index.html file"
#   type        = string

#   validation {
#     condition = fileexists(var.index_html_filepath)
#     error_message = "The provided index_html_filepath does not point to a valid file."
#   }
# }

# variable "error_html_filepath" {
#   description = "Path to the error.html file"
#   type        = string

#   validation {
#     #condition = fileexists(var.error_html_filepath)
#     error_message = "The provided error_html_filepath does not point to a valid file."
#   }
# }

variable "content_version" {
  description = "The content version (positive integer starting at 1)"
  type        = number
  default     = 1
  validation {
    condition     = var.content_version >= 1 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting at 1."
  }
}
