resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = {
    Name     = local.vpc_name
  }
}
#subnet creation for the web,app,db
resource "aws_subnet" "subnets" {
  count      = length(var.subnet_names) #length function to take the count
  vpc_id     = aws_vpc.vpc.id
 # cidr_block = var.subnet_cidrs[count.index] 
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index )
  tags       = {
    Name     = var.subnet_names[count.index]
  }
  #explicity dependency
 # depends_on = [
  #  aws_vpc.vpc
  #]
}
#security group creation for the web
resource "aws_security_group" "websg" {
  name        = "websg"
  description = "allow trafic to access the application"
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
#security group for the DB
resource "aws_security_group" "dbsg" {
  name        = "dbsg"
  description = "only internal communication"
  vpc_id      = aws_vpc.vpc.id
  #this is for ssh port
  ingress{
  description = "open postgress only in the VPC"
  from_port   = local.pg_port
  to_port     = local.pg_port
  protocol    = local.protocol
  cidr_blocks = [ var.vpc_cidr ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.db_sg
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
  subnet_id      = aws_subnet.subnets[0].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "web2_public_association" {
  subnet_id      = aws_subnet.subnets[1].id
  route_table_id = aws_route_table.public_rt.id
}
#associated the private subnet for DB
resource "aws_route_table_association" "db1_private_association" {
  subnet_id      = aws_subnet.subnets[2].id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "db2_private_association" {
  subnet_id      = aws_subnet.subnets[3].id
  route_table_id = aws_route_table.private_rt.id
}
