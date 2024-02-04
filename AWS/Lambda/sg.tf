resource "aws_security_group" "lambda_sg" {
  name        = "${var.environment}-${var.tags.name}"
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
  from_port       = lookup(element(var.sg_rules,count.index),"from_port","443")
  to_port         = lookup(element(var.sg_rules,count.index),"to_port","443")
  protocol        = lookup(element(var.sg_rules,count.index),"protocol","tcp")
  cidr_blocks     = split(",",lookup(element(var.sg_rules,count.index),"cidr_blocks","10.0.128.0/18,10.0.192.0/18"))
  security_group_id = aws_security_group.lambda_sg.id
