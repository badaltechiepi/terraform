locals{
   
    vpc_name   = "primary"
    ssh_port   = 22
    http_port  = 80
    https_port = 443
    other_port = 8080
    anywhere   = "0.0.0.0/0"
    protocol   = "tcp"
    web_sg     = "websg"
    db_sg      = "dbsg"
    pg_port    =  5432
}