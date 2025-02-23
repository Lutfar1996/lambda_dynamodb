
# Create the REST API
resource "aws_api_gateway_rest_api" "dynamodb_operations_api" {
  name        = "DynamoDBOperations"
  description = "API for DynamoDB operations"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


# Create the resource DynamoDBManager
resource "aws_api_gateway_resource" "dynamodb_manager_resource" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations_api.id
  parent_id   = aws_api_gateway_rest_api.dynamodb_operations_api.root_resource_id
  path_part   = "DynamoDBManager"
}

# Create the POST method for the resource
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.dynamodb_operations_api.id
  resource_id   = aws_api_gateway_resource.dynamodb_manager_resource.id
  http_method   = "POST"
  authorization = "NONE"  # You can modify this based on your security requirements (e.g., AWS_IAM, Cognito)
}


# Integrate the method with the Lambda function
resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id              = aws_api_gateway_rest_api.dynamodb_operations_api.id
  resource_id              = aws_api_gateway_resource.dynamodb_manager_resource.id
  http_method              = aws_api_gateway_method.post_method.http_method
  integration_http_method  = "POST"
  type                     = "AWS_PROXY"
  uri                      =  aws_lambda_function.lambda_https.invoke_arn
}


resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda_apigateway_role.name
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id             = "AllowExecutionFromAPIGateway"
  action                   = "lambda:InvokeFunction" 
  function_name            = aws_lambda_function.lambda_https.function_name
  principal                = "apigateway.amazonaws.com"
  source_arn               = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.dynamodb_operations_api.id}/*/${aws_api_gateway_method.post_method.http_method}${aws_api_gateway_resource.dynamodb_manager_resource.path}"
}



# Create the API Gateway Deployment
resource "aws_api_gateway_deployment" "dynamodb_operations_deployment" {
  depends_on = [
    aws_api_gateway_integration.post_integration,  # Ensure integration is created before deployment
  ]
  
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations_api.id
  stage_name  = "prod"  # Set the stage name (can be dev, prod, etc.)
}


# Output the API Gateway URL
output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.dynamodb_operations_api.id}.execute-api.${var.region}.amazonaws.com/prod/DynamoDBManager"
}












# arn:aws:lambda:us-east-1:390402542649:function:LambdaFunctionOverHttps