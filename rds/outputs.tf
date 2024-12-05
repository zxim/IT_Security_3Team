# RDS 출력값 정의
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "rds_sg" {
  description = "Security group ID for RDS"
  value       = var.security_group_rds
}
