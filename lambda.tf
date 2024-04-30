resource "aws_lambda_function" "my_lambda" {
  function_name = "MyLambdaFunction"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "nodejs18.x"

  s3_bucket = aws_s3_bucket.lambda_code.bucket
  s3_key    = aws_s3_bucket_object.lambda_code.key
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
