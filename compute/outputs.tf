# 웹 인스턴스 출력값
output "web_asg_name" {
  description = "Name of the Auto Scaling Group for web servers"
  value       = aws_autoscaling_group.web_asg.name
}

# 배스천 호스트 출력값
output "bastion_instance_id" {
  description = "ID of the Bastion Host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host instance"
  value       = aws_instance.bastion.public_ip
}

# IDS/IPS 인스턴스 출력값
output "ids_instance_ids" {
  description = "List of IDs for IDS/IPS instances across AZs"
  value       = aws_instance.ids_instance[*].id
}

output "ids_instance_private_ips" {
  description = "List of private IPs for IDS/IPS instances across AZs"
  value       = aws_instance.ids_instance[*].private_ip
}

