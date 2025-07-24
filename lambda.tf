data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda-function/message.py"
  output_path = "${path.module}/lambda-function/message.zip"
}




resource "aws_lambda_function" "get_message" {
  filename         = "lambda-function/message.zip"
  function_name    = "getMessageFunction"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "message.py.lambda_handler"
  runtime          = "python3.9"
  timeout          = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.dynamic_string_table.name
    }
  }

  depends_on = [aws_iam_policy_attachment.lambda_basic_execution]
}