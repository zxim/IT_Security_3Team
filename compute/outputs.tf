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

output "ids_instance_ids" {
  description = "ID of the IDS/IPS instance"
  value       = aws_instance.ids_instance.id  # 1개 인스턴스의 ID만 출력
}

output "ids_instance_private_ips" {
  description = "Private IP of the IDS/IPS instance"
  value       = aws_instance.ids_instance.private_ip  # 1개 인스턴스의 Private IP 출력
}

