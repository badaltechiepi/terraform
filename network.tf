resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = {
    Name     = local.vpc_name
  }
}
#subnet creation for the web,app,db
resource "aws_subnet" "subnetes" {
  count      = 4
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidrs[count.index]

  tags       = {
    Name     = var.subnet_names[count.index]
  }
}
#security group creation for the web
resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  #this is for ssh port
  ingress{
  description = "ssh port for the web"
  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.protocol
  cidr_blocks = [ local.anywhere ]
  }
  #this is for http port
  ingress{
  description = "HTTP port for the web"
  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.protocol
  cidr_blocks = [local.anywhere]
  }
  #this is for https port
  ingress{
  description = "HTTPS port for the web"
  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.protocol
  cidr_blocks = [local.anywhere]
  }
  #out bound rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.web_sg
  }

}
#internet gatway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "webigw"
  }
}
#route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicRoute"
  }
}
#route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "privateroute"
  }
}
#associated the public subnet for web
resource "aws_route_table_association" "web1_public_association" {
  subnet_id      = aws_subnet.subnetes[0].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "web2_public_association" {
  subnet_id      = aws_subnet.subnetes[1].id
  route_table_id = aws_route_table.public_rt.id
}
#associated the private subnet for DB
resource "aws_route_table_association" "db1_private_association" {
  subnet_id      = aws_subnet.subnetes[2].id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "db2_private_association" {
  subnet_id      = aws_subnet.subnetes[3].id
  route_table_id = aws_route_table.private_rt.id
}
