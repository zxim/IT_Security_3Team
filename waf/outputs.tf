output "waf_web_acl_id" {
  description = "The ID of the WAF Web ACL"
  value       = aws_wafv2_web_acl.example.id
}

output "waf_web_acl_name" {
  description = "The name of the WAF Web ACL"
  value       = aws_wafv2_web_acl.example.name
}

output "waf_acl_association_arn" {
  description = "The ARN of the WAF Web ACL Association"
  value       = aws_wafv2_web_acl_association.example.id
}

output "web_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = aws_wafv2_web_acl.example.arn
}

output "web_acl_id" {
  description = "The ID of the WAF Web ACL"
  value       = aws_wafv2_web_acl.example.id
}

output "web_acl_name" {
  description = "The name of the WAF Web ACL"
  value       = aws_wafv2_web_acl.example.name
}
