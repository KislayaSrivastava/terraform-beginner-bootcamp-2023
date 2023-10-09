variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}

variable "bucket_name" {
   type = string
}

variable "foodtruck" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "movies" {
  type = object({
    public_path = string
    content_version = number
  })
}