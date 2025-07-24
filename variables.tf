variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}


## Define variables for s3 bucket
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "static-site-swagger-3000" 
}

variable "s3_bucket_tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {
    Name = "StaticWebsiteBucket" 
  }
}

variable "block_public_acls" {
  description = "Block public ACLs for the S3 bucket"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Block public policy for the S3 bucket"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the S3 bucket"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets for the S3 bucket"
  type        = bool
  default     = false
}

## Define an Object Variable for the s3 bucket website configuration
variable "s3_bucket_website_configuration" {
  description = "Website configuration for the S3 bucket"
  type = object({
    index_document_suffix = string
    error_document_key    = string
    routing_rule          = object({
      condition = object({
        key_prefix_equals = string
      })
      redirect = object({
        replace_key_prefix_with = string
      })
    })
  })
  default = {
    index_document_suffix = "index.html"
    error_document_key    = "error.html"
    routing_rule = {
      condition = {
        key_prefix_equals = "docs/"
      }
      redirect = {
        replace_key_prefix_with = "documents/"
      }
    }
  }
}