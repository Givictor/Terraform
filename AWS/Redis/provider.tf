provider "aws" {
region = var.region
version = "4.45.0"
}

terraform {
 backend "s3" {}
}
