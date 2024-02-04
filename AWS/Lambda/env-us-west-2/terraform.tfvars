tags = {
name = "<function-name>"
CreatedByTerraform=true
ManagedBy  = "victorgilbert750@gmail.com"
}

environment = "<env>"
region = "us-west-2"

vpc_id="<vpc-id>"

lambda={
    "handler" = "<handler-name>"
    "function_name" = "<function-name>"
    "runtime" = "python3.8"
    "strategy" = "Rolling"
    "min_health" = "75"
    "instance_warmup" = "60"
    "timeout" = "900"
    "secret_name"="ASN"
    "s3_bucket" = "bucket-name"
    "subnet_ids"= "<subnet-1>,<subnet-2>,<subnet-3>"
    "recipient"="victorgilbert750@gmail.com"
    "host"="email-smtp.us-west-2.amazonaws.com"
    "port"="587"
}
sg_rules = [
{
    cidr_blocks = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
    type = "egress"
    protocol = "tcp"
    self = false
}
]
