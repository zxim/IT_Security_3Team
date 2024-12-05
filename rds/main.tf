# RDS DB Subnet Group 생성
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = [
    var.private_rds_az1,  # AZ1의 RDS 서브넷
    var.private_rds_az2   # AZ2의 RDS 서브넷
  ]
  tags = {
    Name = "rds-subnet-group"
  }
}


# RDS Instance
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  storage_encrypted      = true  # 스토리지 암호화 활성화
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "mydatabase"
  username               = var.db_username    # 변수에서 가져옴
  password               = var.db_password    # 변수에서 가져옴
  publicly_accessible    = false
  multi_az               = true  # 멀티 AZ 활성화
  vpc_security_group_ids = [var.security_group_rds]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  performance_insights_enabled = false

  tags = {
    Name = "rds-instance"
  }
}