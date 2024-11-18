output "alb_sg" {
  value = aws_security_group.alb.id
}

output "web_sg" {
  value = aws_security_group.web_sg.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "rds_sg" {
  value = aws_security_group.rds.id
}
