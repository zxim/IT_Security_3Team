# SSH 키 이름
ssh_key_name_bastion = "public"
ssh_key_name_web     = "public-webserver"
ssh_key_name_app     = "private-appserver"

# 데이터베이스 설정
db_username = "admin"
db_password = "maria1234"

# CloudFront 설정
cloudfront_price_class = "PriceClass_100"

# ACM 인증서 ARN
acm_certificate_arn = "arn:aws:acm:<region>:<account-id>:certificate/<certificate-id>" # 실제 ACM ARN 입력

# S3 로그 버킷

s3_logging_bucket = "your-s3-logging-bucket-name" # S3 로그 버킷 이름 입력

# 실제 사용할 Route 53 도메인 이름
route53_domain_name = "mymain.click"

# 환경 이름
environment = "dev"

sns_topic_arn = "<SNS Topic ARN>"

alb_arn = "<Your ALB ARN>"  # 실제 ALB ARN 값을 입력