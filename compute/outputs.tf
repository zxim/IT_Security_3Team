# 웹 서버 인스턴스 ID 배열
output "web_instance_ids" {
  description = "List of IDs for web server instances"
  value       = [
    aws_instance.web1.id,
    aws_instance.web2.id
  ]
}

# 웹 서버 프라이빗 IP 배열
output "web_instance_private_ips" {
  description = "List of private IPs for web server instances"
  value       = [
    aws_instance.web1.private_ip,
    aws_instance.web2.private_ip
  ]
}

# 기존 출력 값 유지
output "web_server_1_id" {
  description = "ID of the primary web server instance"
  value       = aws_instance.web1.id
}

output "web_server_1_private_ip" {
  description = "Private IP of the primary web server instance"
  value       = aws_instance.web1.private_ip
}

output "web_server_2_id" {
  description = "ID of the backup web server instance"
  value       = aws_instance.web2.id
}

output "web_server_2_private_ip" {
  description = "Private IP of the backup web server instance"
  value       = aws_instance.web2.private_ip
}

# 기존 IDS/IPS, NAT, Bastion 출력 유지
output "ids_instance_id" {
  description = "ID of the IDS/IPS instance"
  value       = aws_instance.ids_instance.id
}

output "ids_instance_private_ip" {
  description = "Private IP of the IDS/IPS instance"
  value       = aws_instance.ids_instance.private_ip
}

output "nat_instance_id" {
  description = "ID of the NAT instance"
  value       = aws_instance.nat_instance.id
}

output "nat_instance_public_ip" {
  description = "Public IP of the NAT instance"
  value       = aws_instance.nat_instance.public_ip
}

output "bastion_instance_id" {
  description = "ID of the Bastion Host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host instance"
  value       = aws_instance.bastion.public_ip
}
