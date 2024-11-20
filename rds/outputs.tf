# RDS 출력값 정의
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}
