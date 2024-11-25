output "route53_zone_id" {
  description = "The ID of the Route 53 Hosted Zone"
  value       = aws_route53_zone.main.zone_id
}

output "route53_record_name" {
  description = "The name of the Route 53 A record"
  value       = aws_route53_record.www.name
}
