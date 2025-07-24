# S3 Website URL
output "s3_website_url" {
  value       = aws_s3_bucket_website_configuration.static_site.website_endpoint
  description = "The website endpoint for the S3 bucket"
}
