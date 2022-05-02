resource "aws_instance" "web1" {
  ami                         = "ami-0fb653ca2d3203ac1" #Depend upon the aws configure setup in the terminal
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.websg.id]
  subnet_id                   = aws_subnet.subnets[0].id
  key_name                    = "terraform"
   tags = {
    Name = "web1"
  }
  connection {
     type = "ssh"
     user = "ubuntu"
     host = self.public_ip
     port = 22
     private_key = file("/home/ubuntu/terraform.pem")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y" 
    ]
  }
}