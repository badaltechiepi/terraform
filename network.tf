resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "primary"
  }
}
resource "aws_subnet" "subnetes" {
  count = 6
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidrs[count.index]

  tags = {
    Name = var.subnet_names[count.index]
  }
}