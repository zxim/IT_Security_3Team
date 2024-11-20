# ALB 관련 변수 정의
variable "public_subnets" {
  description = "퍼블릭 서브넷 ID 목록"
  type        = list(string)
}

variable "security_group_alb" {
  description = "ALB용 보안 그룹 ID"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


