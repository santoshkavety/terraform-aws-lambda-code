resource "aws_s3_bucket" "lambda_code" {
  bucket = "my-lambda-code-bucket"
}

resource "aws_s3_bucket_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code.bucket
  key    = "lambda_function.zip"
  source = "lambda_function.zip"
}