# 웹 서버 보안 그룹 출력
output "web_sg" {
  description = "Security group ID for web servers"
  value       = aws_security_group.web.id
}

# 배스천 호스트 보안 그룹 출력
output "bastion_sg" {
  description = "Security group ID for the bastion host"
  value       = aws_security_group.bastion.id
}

# NAT 인스턴스 보안 그룹 출력
output "nat_sg" {
  description = "Security group ID for the NAT instance"
  value       = aws_security_group.nat.id
}

# IDS/IPS 보안 그룹 출력
output "ids_sg" {
  description = "Security group ID for IDS/IPS instances"
  value       = aws_security_group.ids.id
}

# ALB 보안 그룹 출력
output "alb_sg" {
  description = "Security group ID for the Application Load Balancer"
  value       = aws_security_group.alb.id
}

# RDS 보안 그룹 출력
output "rds_sg" {
  description = "Security group ID for the RDS instance"
  value       = aws_security_group.rds.id
}
