variable "alb_arn" {
  description = "The ARN of the Application Load Balancer (ALB)"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ALB"
  type        = string
}
