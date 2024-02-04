resource "aws_security_group" "instance_sg" {
  name        = "${var.environment}-${var.tags.name}-instance"
  description = "${var.environment}-${var.tags.name}-Security Groups"
  vpc_id      = var.vpc_id
  tags = {
     Name = "${var.environment}-${var.tags.name}-sg"
     CreatedByTerraform = var.tags.CreatedByTerraform
     Environment = var.environment
     ManagedBy  = var.tags.ManagedBy
     }
}

resource "aws_security_group_rule" "sg_rule" {
  count = length(var.sg_rules)  
  type            = lookup(element(var.sg_rules,count.index),"type","ingress")
  from_port       = lookup(element(var.sg_rules,count.index),"from_port","8834")
  to_port         = lookup(element(var.sg_rules,count.index),"to_port","8834")
  protocol        = lookup(element(var.sg_rules,count.index),"protocol","tcp")
  cidr_blocks     = split(",",lookup(element(var.sg_rules,count.index),"cidr_blocks","10.0.128.0/18,10.0.192.0/18"))
  security_group_id = aws_security_group.instance_sg.id
}

resource "aws_instance" "instance" {
  count = var.instance.count
  ami           = var.instance.ami_id
  instance_type = var.instance.instance_type
  key_name = var.instance.key_name
  subnet_id = element(split(",",var.subnet_ids),count.index)
  disable_api_termination = var.instance.termination_protection
  associate_public_ip_address = false
  source_dest_check = var.source_dest_check
  security_groups = [aws_security_group.instance_sg.id,var.default_sgs]
  ebs_optimized = true
  iam_instance_profile = aws_iam_instance_profile.aws_scanner_profile.name
  
  root_block_device {
      volume_type=var.instance_root_volume.volume_type
      volume_size=var.instance_root_volume.volume_size
      delete_on_termination=var.instance_root_volume.delete_on_termination
      encrypted=var.instance_root_volume.encrypted
      kms_key_id = var.instance_root_volume.kms_key_id
  }
  volume_tags ={
     Name = "${var.environment}-${var.tags.name}-volume"
     CreatedByTerraform = var.tags.CreatedByTerraform
     Environment = var.environment
     ManagedBy  = var.tags.ManagedBy
     }
  tags = {
     Name = "${var.environment}-${var.tags.name}-instance"
     CreatedByTerraform = var.tags.CreatedByTerraform
     Environment = var.environment
     ManagedBy  = var.tags.ManagedBy
     }
}

resource "aws_ebs_volume" "instance_volume" {
  count = var.instance.count
  availability_zone = element(split(",",var.az),count.index)
  size = var.block_volume.size
  type = var.block_volume.type
  encrypted =var.block_volume.encrypted
  kms_key_id = var.block_volume.kms_key_id

  tags = {
     Name = "${var.environment}-${var.tags.name}-block-volume"
     CreatedByTerraform = var.tags.CreatedByTerraform
     Environment = var.environment
     ManagedBy  = var.tags.ManagedBy
     AutomatedEBSSnapshot = true
     }
}



resource "aws_volume_attachment" "ebs_att" {
  count = var.instance.count
  device_name = "/dev/sdh"
  volume_id   = lookup(element(aws_ebs_volume.instance_volume,count.index),"id","test")
  instance_id = lookup(element(aws_instance.instance,count.index),"id","test")
}
