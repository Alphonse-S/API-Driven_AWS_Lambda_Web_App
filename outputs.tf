# S3 Website URL
output "s3_website_url" {
  value       = aws_s3_bucket_website_configuration.static_site.website_endpoint
  description = "The website endpoint for the S3 bucket"
}

# API Gateway Outputs
output "api_endpoint" {
  description = "Public API endpoint"
  value       = aws_apigatewayv2_api.message_api.api_endpoint
}