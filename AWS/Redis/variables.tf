variable "region"{
    default= "us-east-1"
}
variable "environment"{
    default= "<env>"
}

variable "default_sgs"{
  default= "<security-group-id>"
}

variable "vpc_id" {
  default="<vpc-id>"
}

variable "subnet_ids"{
  default = "<subnet-1>,<subnet-2>,<subnet-3>"
}

variable "cluster_mode"{
default=false  
}


variable "tags"{
    type = map
    default = {
    "name" = "redis"
    "createdby" = "victorgilbert750@gmail.com"
    }
}

variable "az"{
   default = "us-east-1a,us-east-1b,us-east-1c"
}

variable "redis-standalone" {
 type= map
 default = {
    node_type="<node-type>"
    port=6379
    parameter_group_name= "default.redis6.x"
 }

}

variable "redis-cluster-config" {
 type= map
 default = {
    node_type="<node-type>"
    port=6379
    parameter_group_name= "default.redis6.x.cluster.on"
    automatic_failover_enabled=true
    replica=1
    shard=2 
    transit_encryption_enabled=true
    at_rest_encryption_enabled=true
    kms_key_id="<kms-redis-key>"
    apply_immediately=true
    snapshot_retention_limit="7"
    multi_az_enabled=true
 }
}


variable "sg_rules_sgid"{
    type = list(object({
    sg_id = string
    from_port = number
    to_port = number
    type = string
    protocol = string
  }))
  default = [
    {
    sg_id = "sg-0000"
    from_port = 443
    to_port = 443
    type = "ingress"
    protocol = "tcp"
    }
  ]
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



variable "test_sg_rules" {
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


variable "self_sg_rules" {
  type = list(object({
    self = bool
    from_port = number
    to_port = number
    type = string
    protocol = string
  }))
  default = [
    {
    self = true
    cidr_blocks = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    type = "ingress"
    protocol = "tcp"
    }
  ]
}



variable "src_sg_rules" {
  type = list(object({
    source_security_group_id = string
    from_port = number
    to_port = number
    type = string
    protocol = string
  }))
  default = [
    {
    source_security_group_id = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    type = "ingress"
    protocol = "tcp"
    }
  ]
}

variable "alb_sg_rules" {
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

