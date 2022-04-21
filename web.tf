resource "aws_instance" "web1" {
  ami                         = "ami-0892d3c7ee96c0bf7"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  availability_zone           = "us-west-2"
  vpc_security_group_ids      = [aws_security_group.websg.id]
  subnet_id                   = aws_subnet.subnetes[0].id
  key_name                    = "rancher"
  tags = {
    Name = "web1"
  }
}