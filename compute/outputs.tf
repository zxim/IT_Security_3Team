# 웹 서버 인스턴스 ID 배열
output "web_instance_ids" {
  description = "List of Web Server Instance IDs"
  value = [aws_instance.web1.id, aws_instance.web2.id]
}

# 웹 서버 프라이빗 IP 배열
output "web_instance_private_ips" {
  description = "List of private IPs for web server instances"
  value       = [
    aws_instance.web1.private_ip,
    aws_instance.web2.private_ip
  ]
}

# 애플리케이션 서버 인스턴스 ID 배열
output "app_instance_ids" {
  description = "List of IDs for application server instances"
  value       = [
    aws_instance.app1.id,
    aws_instance.app2.id
  ]
}

# 애플리케이션 서버 프라이빗 IP 배열
output "app_instance_private_ips" {
  description = "List of private IPs for application server instances"
  value       = [
    aws_instance.app1.private_ip,
    aws_instance.app2.private_ip
  ]
}

# 배스천 호스트 출력
output "bastion_instance_id" {
  description = "ID of the Bastion Host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host instance"
  value       = aws_instance.bastion.public_ip
}
