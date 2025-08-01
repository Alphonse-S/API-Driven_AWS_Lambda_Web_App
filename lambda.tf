data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda-function/message.py"
  output_path = "${path.module}/lambda-function/message.zip"
}



## Define lambda function configuration
resource "aws_lambda_function" "get_message" {
  filename         = var.lambda_filename
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }

  depends_on = [aws_iam_policy_attachment.lambda_basic_execution]
}