# RDS 정의

# RDS DB Subnet Group 생성
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "rds-subnet-group"
  }
}



# RDS Instance
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "mydatabase"
  username               = "admin"
  password               = "maria1234"
  publicly_accessible    = false
  vpc_security_group_ids = [var.security_group_rds]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "rds-instance"
  }
}
