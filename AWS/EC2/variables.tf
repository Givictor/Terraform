
variable "region"{
    default= "us-west-2"
}
variable "environment"{
    default= "<ennv>"
}


variable "vpc_id" {
  default="<vpc-id>"
}

variable "subnet_ids"{
  default = "<subnet-1>,<subnet-2>,<subnet-3>"
}
variable "ami"{
  type=map
  default={
    "filter_key" = "name"
    "owner" = "amazon"
    "ami-regex" = "ubuntu-bionic-18.04-amd64-server-20191002-*"
  }
}

variable "dns_hostnames" {
  default= true
}

variable "tags"{
    type = map
    default = {
    "name" = "<Instance Name>"
    "CreatedByTerraform" = "true"
    "ManagedBy" = "victorgilbert750@gmail.com"
    "Scheduler" = "off=true|off_time=default|on=true|on_time=default" #For Auto Scheduling
    }
}

variable "az"{
   default = "us-west-2a,us-west-2b,-west-2a,us-west-2c"
}

variable "instance" {
 type= map
 default = {
    count = 1
    instance_type="<instance_type>"
    key_name= "<key-name>"
    private= true
    block_devices= false
    ami_id= "<ami-id>"
    termination_protection = true

 }

}


variable "source_dest_check" {
  default=true
}

variable "instance_root_volume" {
 type= map
 default = {
      volume_type="gp2"
      volume_size="8"
      delete_on_termination=true
      encrypted=true
      kms_key_id = "test"

 }

}


variable "block_volume" {
  type= map
  default = {
      size = 50
      type= "gp2"
      encrypted = true
      kms_key_id = "test"
  }
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
    cidr_blocks = "<cidr_block>"
    from_port = 22
    to_port = 22
    type = "ingress"
    protocol = "tcp"
    }
  ]
}

variable "default_sgs"{
  default= "<security-group-id>"
}
