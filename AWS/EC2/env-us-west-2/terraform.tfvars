tags = {
name = "<instance-name>"
CreatedByTerraform = true
ManagedBy  = "devops@securin.io"
Scheduler = "off=true|off_time=default|on=true|on_time=default"
}

environment = "<env>"
region="us-west-2"


launch_template= {
    instance_type="<instance_type>"
    key_name= "<key-name>"
    termination_protection = false
    ami = "<ami-id>"
}

default_sgs= "<security-group-id>"

subnet_ids="<subnet-1>,<subnet-2>,<subnet-3>"

vpc_id="<vpc-id>"

az="us-west-2a,us-west-2b,-west-2a,us-west-2c"

sg_rules = [

{
    cidr_blocks = "<cidr>"
    from_port = 22
    to_port = 22
    type = "ingress"
    protocol = "tcp"
}
]


instance_root_volume={
      volume_type="gp2"
      volume_size="64"
      delete_on_termination=true
      encrypted=true
      kms_key_id= "<kms-ebs-key>"

 }
 block_volume={
      size = 50
      type= "gp2"
      encrypted = true
      kms_key_id = "<kms-ebs-key>"
}
