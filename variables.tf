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

## Define variables for DynamoDB table
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "dynamic-string-table"
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key_name" {
  description = "Hash key name for the DynamoDB table"
  type        = string
  default     = "id"
}

variable "environment_tag" {
  description = "Environment tag for the table"
  type        = string
  default     = "Dev"
}

variable "initial_item_id" {
  description = "ID value for the initial DynamoDB item"
  type        = string
  default     = "welcome-text"
}

variable "initial_message" {
  description = "Message string for the initial DynamoDB item"
  type        = string
  default     = "Hello from Terraform! 🚀"
}


## Define variables for Lambda function
variable "lambda_filename" {
  description = "Path to the Lambda deployment package"
  type        = string
  default     = "lambda-function/message.zip"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "getMessageFunction"
}

variable "lambda_handler" {
  description = "Lambda function entry point"
  type        = string
  default     = "message.lambda_handler"
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "lambda_timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
  default     = 10
}



# Define variables for API Gateway
variable "api_name" {
  description = "Name of the API Gateway resource"
  type        = string
  default     = "MessageAPI"
}

variable "protocol_type" {
  description = "Protocol type for API Gateway"
  type        = string
  default     = "HTTP"
}

variable "cors_allow_origins" {
  description = "Allowed origins for CORS configuration"
  type        = list(string)
  default     = ["*"]
}

variable "cors_allow_methods" {
  description = "Allowed HTTP methods for CORS"
  type        = list(string)
  default     = ["GET"]
}

variable "cors_allow_headers" {
  description = "Allowed headers for CORS"
  type        = list(string)
  default     = ["*"]
}

variable "integration_type" {
  description = "Integration type for API Gateway"
  type        = string
  default     = "AWS_PROXY"
}

variable "integration_method" {
  description = "HTTP method used for integration"
  type        = string
  default     = "POST"
}

variable "payload_format_version" {
  description = "Payload format version for Lambda integration"
  type        = string
  default     = "2.0"
}

variable "route_key" {
  description = "Route key defining method and resource path"
  type        = string
  default     = "GET /"
}


variable "api_stage_name" {
  description = "Name of the deployment stage"
  type        = string
  default     = "$default"
}

variable "enable_auto_deploy" {
  description = "Whether to enable automatic deployment for the stage"
  type        = bool
  default     = true
}

variable "enable_detailed_metrics" {
  description = "Enable detailed metrics for default route"
  type        = bool
  default     = true
}


variable "lambda_permission_statement_id" {
  description = "Statement ID for Lambda permission"
  type        = string
  default     = "AllowAPIGatewayInvoke"
}

variable "lambda_permission_action" {
  description = "Action allowed by Lambda permission"
  type        = string
  default     = "lambda:InvokeFunction"
}

variable "lambda_permission_principal" {
  description = "Principal allowed to invoke the Lambda function"
  type        = string
  default     = "apigateway.amazonaws.com"
}
