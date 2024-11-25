# S3 버킷 생성
resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket        = "${var.environment}-cloudtrail-logs"
  force_destroy = true
}

# S3 버킷 정책 생성
data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail_bucket.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}

# CloudWatch Log Group 생성
resource "aws_cloudwatch_log_group" "cloudtrail_log_group" {
  name              = "/aws/cloudtrail/${var.environment}"
  retention_in_days = 90
}

# CloudTrail 리소스 생성
resource "aws_cloudtrail" "main" {
  depends_on                   = [aws_s3_bucket_policy.cloudtrail_policy]
  name                         = "${var.environment}-cloudtrail"
  s3_bucket_name               = aws_s3_bucket.cloudtrail_bucket.id
  s3_key_prefix                = "prefix"
  include_global_service_events = true
  is_multi_region_trail        = true
  enable_logging               = true
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail_log_group.arn
  cloud_watch_logs_role_arn     = var.cloudtrail_cloudwatch_role_arn
}

# 필요한 데이터 소스 정의
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}
