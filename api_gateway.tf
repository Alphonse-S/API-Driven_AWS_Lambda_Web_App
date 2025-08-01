# Create HTTP API Gateway to interact with the Lambda function
resource "aws_apigatewayv2_api" "message_api" {
  name          = var.api_name
  protocol_type = var.protocol_type

  cors_configuration {
  allow_origins = var.cors_allow_origins
  allow_methods = var.cors_allow_methods
  allow_headers = var.cors_allow_headers
}
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.message_api.id
  integration_type       = var.integration_type
  integration_uri        = aws_lambda_function.get_message.invoke_arn
  integration_method     = var.integration_method
  payload_format_version = var.payload_format_version
}


resource "aws_apigatewayv2_route" "get_message" {
  api_id    = aws_apigatewayv2_api.message_api.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}


resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.message_api.id
  name        = var.api_stage_name
  auto_deploy = var.enable_auto_deploy

  default_route_settings {
    detailed_metrics_enabled = var.enable_detailed_metrics
  }
}


# Create permision for API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = var.lambda_permission_statement_id
  action        = var.lambda_permission_action
  function_name = aws_lambda_function.get_message.function_name
  principal     = var.lambda_permission_principal
  source_arn    = "${aws_apigatewayv2_api.message_api.execution_arn}/*/*"
}



