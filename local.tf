locals{
   
    vpc_name  = "primary"
    ssh_port  = 22
    http_port = 80
    https_port = 443
    anywhere = "0.0.0.0/0"
    protocol = "tcp"
    web_sg    = "websg"
}