resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layers/<lambda-layer>.zip"
  layer_name = "${var.tags.name}-layers"

  compatible_runtimes = ["python2.7","python3.6","python3.7","python3.8"]
}
