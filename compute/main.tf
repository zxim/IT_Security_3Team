# Launch Template for Web Instances

resource "aws_launch_template" "web" {
  name = "web-launch-template"

  instance_type = var.web_instance_type
  image_id      = "ami-040c33c6a51fd5d96"
  key_name      = var.ssh_key_name

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.private_web_subnets[0]
    security_groups             = [var.security_group_web] # Security Group 추가
  }

  tags = {
    Name = "web-instance"
  }
}


# Auto Scaling Group for Web Instances
resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_web_subnets
  min_size            = 2
  max_size            = 10
  desired_capacity    = 2

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Scaling Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

# CloudWatch Metric Alarms for Auto Scaling
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Trigger scale-up when CPU utilization is above 80%."
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "LowCPUUtilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Trigger scale-down when CPU utilization is below 30%."
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}

# Bastion Host Instance
resource "aws_instance" "bastion" {
  ami           = "ami-040c33c6a51fd5d96"  # 우분투 프리티어 이미지
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name
  subnet_id     = var.public_subnets[0]
  vpc_security_group_ids = [var.security_group_bastion]

  tags = {
    Name = "bastion-instance"
  }
}

resource "aws_instance" "ids_instance" {
  ami             = "ami-040c33c6a51fd5d96"  # 예시 AMI ID
  instance_type   = "t3.micro"
  availability_zone = var.availability_zones[0]  # 1개 AZ만 사용
  subnet_id       = var.private_web_subnets[0]  # Subnet을 적절히 지정

  tags = {
    Name = "ids-instance"
  }
}
