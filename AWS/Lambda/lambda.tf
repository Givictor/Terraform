resource "aws_lambda_function" "<lambda-function-name>" {
  function_name = var.lambda.function_name
  role          = aws_iam_role.<function-name>_lambda_role.arn
  handler       = var.lambda.handler
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  runtime = var.lambda.runtime
  timeout = var.lambda.timeout
  s3_bucket = var.lambda.s3_bucket
  s3_key = var.lambda.s3_key
  vpc_config {
    subnet_ids         = split(",",var.lambda.subnet_ids)
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  environment {
    variables = {
     REGION = var.region
     ENV = var.environment
     SECRET_NAME = var.lambda.secret_name
     SENDER = var.lambda.sender
     SENDER_NAME = var.lambda.sender_name
     RECIPIENT = var.lambda.recipient
     HOST = var.lambda.host
     PORT = var.lambda.port
     }
  }
}

resource "aws_lambda_permission" "<function-name>" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.<function-name>.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.lambda.s3_bucket1}"
}
