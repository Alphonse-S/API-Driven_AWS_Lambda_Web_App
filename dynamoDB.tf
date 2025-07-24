# Create a DynamoDB table with a dynamic string attribute
resource "aws_dynamodb_table" "dynamic_string_table" {
  name         = "dynamic-string-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table_item" "initial_message" {
  table_name = aws_dynamodb_table.dynamic_string_table.name
  hash_key   = "id"

  item = jsonencode({
    id = { S = "welcome-text" }
    message = { S = "Hello from Terraform! 🚀" }
  })
}
