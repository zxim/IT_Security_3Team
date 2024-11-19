# RDS 출력값 정의

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}
