# SSH 키 이름
ssh_key_name_bastion = "public"
ssh_key_name_web = "public-webserver"
ssh_key_name_app = "private-appserver"

# 데이터베이스 설정
db_username = "admin"
db_password = "maria1234"

# CloudFront 설정
cloudfront_price_class = "PriceClass_100"

# ACM 인증서 ARN
acm_certificate_arn = "arn:aws:acm:<region>:<account-id>:certificate/<certificate-id>"  # 실제 ACM ARN 입력

# S3 로그 버킷
s3_logging_bucket = "your-s3-logging-bucket-name"  # S3 로그 버킷 이름 입력


# 환경 이름
environment = "dev"
