# Fetch the current AWS account ID dynamically
# data "aws_caller_identity" "current" {}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "LambdaFunctionOverHttps.py"
  output_path = "function.zip"
}


# resource "aws_lambda_permission" "apigw_lambda" {
#   statement_id             = "AllowExecutionFromAPIGateway"
#   action                   = "lambda:InvokeFunction" 
#   function_name            = aws_lambda_function.lambda_https.function_name
#   principal                = "apigateway.amazonaws.com"
#   source_arn              = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.dynamodb_operations_api.id}/*/${aws_api_gateway_method.post_method.http_method}${aws_api_gateway_resource.dynamodb_manager_resource.path}"
# }


# Create AWS Lambda Function
resource "aws_lambda_function" "lambda_https" {
  function_name    = "LambdaFunctionOverHttps"
  filename         = "function.zip"  # Path to the zipped function code
  source_code_hash = data.archive_file.lambda.output_base64sha256  # Ensure function updates when zip changes
  role             = aws_iam_role.lambda_apigateway_role.arn
  handler          = "LambdaFunctionOverHttps.lambda_handler"
  runtime          = "python3.12"
  timeout          = 10  # Timeout in seconds
  memory_size      = 128 # Memory allocation in MB

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

# # Create permission to allow API Gateway to invoke the Lambda function
# resource "aws_lambda_permission" "allow_apigateway_invoke" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda_https.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*/POST/DynamoDBManager"
# }

# Output the Lambda Function ARN
output "lambda_function_arn" {
  value = aws_lambda_function.lambda_https.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda_https.invoke_arn
}