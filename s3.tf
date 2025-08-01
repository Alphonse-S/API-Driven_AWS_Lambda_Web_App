# Create s3 bucket to host static website
resource "aws_s3_bucket" "static_site" {
  bucket = var.s3_bucket_name

  tags = var.s3_bucket_tags
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = var.s3_bucket_website_configuration.index_document_suffix
  }

  error_document {
    key = var.s3_bucket_website_configuration.error_document_key
  }

  routing_rule {
    condition {
      key_prefix_equals = var.s3_bucket_website_configuration.routing_rule.condition.key_prefix_equals
    }
    redirect {
      replace_key_prefix_with = var.s3_bucket_website_configuration.routing_rule.redirect.replace_key_prefix_with
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  content       = data.template_file.index_html.rendered
  content_type = "text/html"

}

data "template_file" "index_html" {
  template = file("${path.module}/website/index.template.html")

  vars = {
    api_url = aws_apigatewayv2_api.message_api.api_endpoint
  }
}
