# Create IAM Role for Lambda API Gateway
resource "aws_iam_role" "lambda_apigateway_role" {

  name = "lambda-apigateway-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

}


# Create IAM Policy for Lambda API Gateway

resource "aws_iam_policy" "lambda_apigateway_policy" {
  name        = "lambda-apigateway-policy"
  description = "IAM Policy for Lambda to interact with Dynamodb abd CloudWatch Logs"

  policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Stmt1428341300017"
        Effect = "Allow"
        Action = [
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
        ]
        Resource = "*"
      },
      {
        Sid    = ""
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach IAM Policy to the IAM Role 

resource "aws_iam_role_policy_attachment" "lambda_apigateway_role_attachment" {

  role       = aws_iam_role.lambda_apigateway_role.name
  policy_arn = aws_iam_policy.lambda_apigateway_policy.arn

}