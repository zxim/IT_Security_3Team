# 도메인 이름
variable "route53_domain_name" {
  description = "Domain name for Route 53"
  type        = string
}

# ALB DNS 이름
variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

# ALB Hosted Zone ID
variable "alb_zone_id" {
  description = "The Hosted Zone ID of the ALB"
  type        = string
}
