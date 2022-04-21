resource "aws_instance" "web1" {
  ami                         = "ami-0fb653ca2d3203ac1" #Depend upon the aws configure setup in the terminal
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.websg.id]
  subnet_id                   = aws_subnet.subnetes[0].id
  key_name                    = "rancher"
}