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
resource "aws_security_group" "allow_tls" {
  name        = "websg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress{
  description = "ssh port for the web"
  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.protocol
  cidr_blocks = [ local.anywhere ]
  }
  ingress{
  description = "HTTP port for the web"
  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.protocol
  cidr_blocks = [local.anywhere]
  }
  ingress{
  description = "HTTPS port for the web"
  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.protocol
  cidr_blocks = [local.anywhere]
  }
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

