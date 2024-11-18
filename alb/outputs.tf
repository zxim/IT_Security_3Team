# ALB 출력값 정의

output "alb_dns_name" {
  value = aws_alb.app.dns_name
}
