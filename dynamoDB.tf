# Create a DynamoDB table with a dynamic string attribute
resource "aws_dynamodb_table" "dynamic_string_table" {
  name         = var.dynamodb_table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key_name

  attribute {
    name = var.hash_key_name
    type = "S"
  }

  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_dynamodb_table_item" "initial_message" {
  table_name = aws_dynamodb_table.dynamic_string_table.name
  hash_key   = var.hash_key_name

  item = jsonencode({
    id      = { S = var.initial_item_id }
    message = { S = var.initial_message }
  })
}
