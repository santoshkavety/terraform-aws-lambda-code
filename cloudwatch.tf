
resource "aws_iam_policy_attachment" "lambda_logs" {
name = "lambda_logs"
roles = [aws_iam_role.lambda_exec.name]
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
name = "every-5-minutes"
schedule_expression = "cron(*/5 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
rule = aws_cloudwatch_event_rule.every_five_minutes.name
target_id = "TriggerLambda"
arn = aws_lambda_function.my_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
statement_id = "AllowExecutionFromCloudWatch"
action = "lambda:InvokeFunction"
function_name = aws_lambda_function.my_lambda.function_name
principal = "events.amazonaws.com"
source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
}