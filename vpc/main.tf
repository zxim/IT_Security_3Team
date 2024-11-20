# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# 기존 인터넷 게이트웨이 확인
data "aws_internet_gateway" "existing" {
  filter {
    name   = "attachment.vpc-id"
    values = [aws_vpc.main.id]
  }
}

# 인터넷 게이트웨이 (조건적으로 생성)
resource "aws_internet_gateway" "main" {
  count = data.aws_internet_gateway.existing.id != "" ? 0 : 1

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [vpc_id]
  }
}

# 퍼블릭 서브넷 (AZ1)
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_az1
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "${var.environment}-public-subnet-az1"
  }
}

# 퍼블릭 서브넷 (AZ2)
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_az2
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "${var.environment}-public-subnet-az2"
  }
}

# 프라이빗 서브넷 (웹 서버 및 IDS용 AZ1)
resource "aws_subnet" "private_web_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_web_subnet_cidr_az1
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "${var.environment}-private-web-subnet-az1"
  }
}

# 프라이빗 서브넷 (웹 서버 및 IDS용 AZ2)
resource "aws_subnet" "private_web_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_web_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "${var.environment}-private-web-subnet-az2"
  }
}

# 프라이빗 서브넷 (RDS용 AZ1)
resource "aws_subnet" "private_rds_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_rds_subnet_cidr_az1
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "${var.environment}-private-rds-subnet-az1"
  }
}

# 프라이빗 서브넷 (RDS용 AZ2)
resource "aws_subnet" "private_rds_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_rds_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "${var.environment}-private-rds-subnet-az2"
  }
}

# 퍼블릭 라우팅 테이블
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

# 퍼블릭 라우팅 테이블과 IGW 연결
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = data.aws_internet_gateway.existing.id != "" ? data.aws_internet_gateway.existing.id : aws_internet_gateway.main[0].id
}

# 퍼블릭 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# 프라이빗 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

# 프라이빗 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "private_web_az1" {
  subnet_id      = aws_subnet.private_web_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_web_az2" {
  subnet_id      = aws_subnet.private_web_az2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_az1" {
  subnet_id      = aws_subnet.private_rds_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_az2" {
  subnet_id      = aws_subnet.private_rds_az2.id
  route_table_id = aws_route_table.private.id
}
