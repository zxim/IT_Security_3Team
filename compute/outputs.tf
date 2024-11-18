# VPC 관련 출력값 정의

output "web_instance_ids" {
  value = aws_instance.web[*].id
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "web_instance_public_ips" {
  value = aws_instance.web[*].public_ip
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
