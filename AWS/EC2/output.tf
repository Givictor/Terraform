output "instance_id" {
    value= aws_instance.instance.*.id
}

output "sg_id" {
    value = aws_security_group.instance_sg.id
}
