# ALB Outputs
output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_alb.app.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_alb.app.dns_name
}
output "alb_zone_id" {
  description = "The Hosted Zone ID of the ALB"
  value       = aws_alb.app.zone_id
}