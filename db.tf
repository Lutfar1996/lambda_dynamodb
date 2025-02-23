# Create DynamoDB Table
resource "aws_dynamodb_table" "lambda_apigateway_table" {
  name           = "lambda-apigateway"
  billing_mode   = "PAY_PER_REQUEST"  # This is the default billing mode (On-demand)
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"  # String type for the partition key
  }

  # Default settings for Table settings are automatically applied
}
