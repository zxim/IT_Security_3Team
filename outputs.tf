# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Public Subnets
output "public_subnet_az1_id" {
  description = "The ID of the public subnet in AZ1"
  value       = module.vpc.public_subnet_az1_id
}

output "public_subnet_az2_id" {
  description = "The ID of the public subnet in AZ2"
  value       = module.vpc.public_subnet_az2_id
}

# Private Web Subnets
output "private_web_subnet_az1_id" {
  description = "The ID of the private web subnet in AZ1"
  value       = module.vpc.private_web_subnet_az1_id
}

output "private_web_subnet_az2_id" {
  description = "The ID of the private web subnet in AZ2"
  value       = module.vpc.private_web_subnet_az2_id
}

# RDS Subnets
output "private_rds_subnet_az1_id" {
  description = "The ID of the private RDS subnet in AZ1"
  value       = module.vpc.private_rds_subnet_az1_id
}

output "private_rds_subnet_az2_id" {
  description = "The ID of the private RDS subnet in AZ2"
  value       = module.vpc.private_rds_subnet_az2_id
}

# ALB Outputs
output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

# Compute Outputs
output "web_instance_ids" {
  description = "List of IDs for the web server instances"
  value       = module.compute.web_instance_ids
}

output "web_instance_private_ips" {
  description = "List of private IPs for the web server instances"
  value       = module.compute.web_instance_private_ips
}

# RDS Outputs
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_security_group_id" {
  description = "The security group ID for the RDS instance"
  value       = module.security.rds_sg
}

# CloudFront Outputs
output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront Distribution"
  value       = module.cloudfront.distribution_id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront Distribution"
  value       = module.cloudfront.domain_name
}

# WAF Outputs (Updated)
output "waf_acl_arn" {
  description = "The ARN of the WAF ACL"
  value       = module.security.waf_acl_arn # security 모듈에서 가져오기
}

output "waf_alb_association" {
  description = "The ID of the WAF association with ALB"
  value       = module.security.waf_alb_association # security 모듈에서 가져오기
}
output "cloudtrail_bucket_arn" {
  description = "CloudTrail S3 Bucket ARN"
  value       = module.cloudtrail.cloudtrail_bucket_arn
}

output "cloudtrail_log_group_name" {
  description = "CloudTrail Log Group Name"
  value       = module.cloudtrail.cloudtrail_log_group_name
}
