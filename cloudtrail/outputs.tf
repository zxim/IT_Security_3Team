# CloudTrail S3 Bucket ARN
output "cloudtrail_bucket_arn" {
  description = "The ARN of the CloudTrail S3 bucket"
  value       = aws_s3_bucket.cloudtrail_bucket.arn
}

# CloudWatch 로그 그룹 이름
output "cloudtrail_log_group_name" {
  description = "The name of the CloudWatch log group for CloudTrail"
  value       = aws_cloudwatch_log_group.cloudtrail_log_group.name
}

# CloudTrail ARN
output "cloudtrail_arn" {
  description = "The ARN of the CloudTrail"
  value       = aws_cloudtrail.main.arn
}
