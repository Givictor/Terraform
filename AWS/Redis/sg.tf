resource "aws_security_group" "redis_sg" {
  name        = "${var.environment}-${var.tags.name}-sg"
  description = "${var.environment}-${var.tags.name}-Security Groups"
  #vpc_id      = data.terraform_remote_state.csw_infra.outputs.vpc_id
  vpc_id      = var.vpc_id
  tags = {
     Name = "${var.environment}-${var.tags.name}-sg"
     Environment = var.environment
     }
}



resource "aws_security_group_rule" "sg_rule" {
  count = length(var.sg_rules)  
  type            = lookup(element(var.sg_rules,count.index),"type","ingress")
  from_port       = lookup(element(var.sg_rules,count.index),"from_port","443")
  to_port         = lookup(element(var.sg_rules,count.index),"to_port","443")
  protocol        = lookup(element(var.sg_rules,count.index),"protocol","tcp")
  cidr_blocks     = split(",",lookup(element(var.sg_rules,count.index),"cidr_blocks","10.0.128.0/18,10.0.192.0/18"))
  security_group_id = aws_security_group.redis_sg.id
}


resource "aws_security_group_rule" "src_sg_rule" {
 count = length(var.src_sg_rules)
 from_port       = lookup(element(var.src_sg_rules,count.index),"from_port","443")
 to_port         = lookup(element(var.src_sg_rules,count.index),"to_port","443")
 protocol        = lookup(element(var.src_sg_rules,count.index),"protocol","tcp")
 security_group_id        = aws_security_group.redis_sg.id
 source_security_group_id = lookup(element(var.src_sg_rules,count.index),"source_security_group_id","tcp")
 type                     = lookup(element(var.src_sg_rules,count.index),"type","ingress")
    }





resource "aws_security_group" "test_redis_sg" {
  count = var.shared-svc-test==true ? 1:0
  name        = "test-${var.environment}-${var.tags.name}-sg"
  description = "test-${var.environment}-${var.tags.name}-Security Groups"
  vpc_id      = var.vpc_id
  tags = {
     Name = "test-${var.environment}-${var.tags.name}-sg"
     Environment = var.environment
     }
}



resource "aws_security_group_rule" "test_sg_rule" {
  count = var.shared-svc-test==true ? length(var.test_sg_rules):0
  type            = lookup(element(var.test_sg_rules,count.index),"type","ingress")
  from_port       = lookup(element(var.test_sg_rules,count.index),"from_port","443")
  to_port         = lookup(element(var.test_sg_rules,count.index),"to_port","443")
  protocol        = lookup(element(var.test_sg_rules,count.index),"protocol","tcp")
  cidr_blocks     = split(",",lookup(element(var.test_sg_rules,count.index),"cidr_blocks","10.0.128.0/18,10.0.192.0/18"))
  security_group_id = aws_security_group.test_redis_sg.0.id
}


