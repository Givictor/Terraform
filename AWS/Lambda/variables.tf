variable "region"{
    default= "us-west-2"
}
variable "environment"{
    default= "<env>"
}

variable "tags"{
    type = map
    default = {
    "name" = "<lambda-name>"
    "CreateByTerraform" = true
    "ManagedBy" = "victorgibert750@gmail.com"

    }
}


variable "vpc_id" {
  default="<vpc-id>"
}

variable "sg_rules" {
  type = list(object({
    cidr_blocks = string
    from_port = number
    to_port = number
    type = string
    protocol = string
  }))
  default = [
    {
    cidr_blocks = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    type = "ingress"
    protocol = "tcp"
    }
  ]
}

variable "lambda" {
  type= map
  default={
    "handler" = "<lambda-handler-name>"
    "function_name" = "<lambda-function-name>"
    "runtime" = "python3.8"
    "strategy" = "Rolling"
    "min_health" = "75"
    "instance_warmup" = "60"
    "timeout" = "900"
    "secret_name"="<secret-name>"
    "s3_bucket" = "<s3-bucket>"
    "s3_key" = "asn-data-update.zip"
    "secret_arn" = "<secret-arn>
    "subnet_ids"= "<subnet-1>,<subnet-2>,<subnet-3>"
    "recipient"="victorgilbert750@gmail.com"
    "host"="email-smtp.us-west-2.amazonaws.com"
    "port"="587"
  }
}

variable "cloudwatch-log-group" {
  type= map
  default={
    "retention_in_days" = "14"
  }
}
