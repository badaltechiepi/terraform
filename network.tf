resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "primary"
  }
}
resource "aws_subnet" "web1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = "web1"
  }
}
resource "aws_subnet" "web2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "web1"
  }
}
resource "aws_subnet" "db1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.2.0/24"

  tags = {
    Name = "db1"
  }
}
resource "aws_subnet" "db2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "db2"
  }
}