# ALB 정의

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
resource "aws_alb_target_group" "web" {
  name     = "web-target-group-${random_id.suffix.hex}" # 이름에 유니크 값 추가
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "random_id" "suffix" {
  byte_length = 4
}

# ALB 리스너
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web.arn
  }
}
