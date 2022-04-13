resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "primary"
  }
}
resource "aws_subnet" "web1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr[0]

  tags = {
    Name = var.subnet_avzone[0]
  }
}
resource "aws_subnet" "web2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr[1]

  tags = {
    Name = var.subnet_avzone[1]
  }
}
resource "aws_subnet" "db1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr[2]

  tags = {
    Name = var.subnet_avzone[2]
  }
}
resource "aws_subnet" "db2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr[3]

  tags = {
    Name = var.subnet_avzone[3]
  }
}