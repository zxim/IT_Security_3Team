# ALB 생성
resource "aws_alb" "app" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_alb]
  subnets            = var.public_subnets

  tags = {
    Name = "app-load-balancer"
  }
}

# ALB 대상 그룹 (웹 서버 대상)
# ALB Target Group
resource "aws_lb_target_group" "web" {
  name     = "${var.environment}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment}-web-tg"
  }
}

# ALB 리스너 (웹 서버로 트래픽 전달)
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# 랜덤 ID 생성
resource "random_id" "suffix" {
  byte_length = 4
}

# CloudFront 배포 생성
resource "aws_cloudfront_distribution" "cdn" {
  # Origin 설정 (ALB와 연결)
  origin {
    domain_name = aws_alb.app.dns_name  # ALB의 DNS 이름
    origin_id   = "alb-origin"  # Origin 식별자
    custom_origin_config {
      http_port              = 80  # ALB 포트
      https_port             = 443
      origin_protocol_policy = "https-only"  # HTTPS만 사용
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]  # 지원할 SSL 프로토콜
    }
  }

  # 기본 캐시 동작 설정
  default_cache_behavior {
    target_origin_id       = "alb-origin"  # 연결할 Origin ID
    viewer_protocol_policy = "redirect-to-https"  # HTTP 요청을 HTTPS로 리다이렉트
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]  # 허용된 HTTP 메서드
    cached_methods         = ["GET", "HEAD"]  # 캐싱할 메서드
    forwarded_values {
      query_string = true  # 쿼리스트링 전달
      cookies {
        forward = "all"  # 모든 쿠키 전달
      }
    }
  }

  # HTTPS 설정 (viewer_certificate 블록)
  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn  # ACM 인증서 ARN
    ssl_support_method  = "sni-only"  # SNI 방식 사용
    minimum_protocol_version = "TLSv1.2_2021"  # 최소 프로토콜 버전
  }

  # CloudFront 로그 설정
  logging_config {
    include_cookies = false
    bucket          = var.s3_logging_bucket  # CloudFront 로그를 저장할 S3 버킷
    prefix          = "cloudfront-logs/"
  }

  # 배포 설정
  enabled         = true
  is_ipv6_enabled = true
  price_class     = var.cloudfront_price_class  # 사용할 CloudFront 요금 클래스
  default_root_object = "index.html"  # 기본 요청 경로

  # Geo 제한 설정
  restrictions {
    geo_restriction {
      restriction_type = "none"  # 특정 국가 제한 없이 전 세계 허용
    }
  }

  # 태그 추가
  tags = {
    Name = "${var.environment}-cloudfront"
  }
}
