##creating the subnets group
#resource "aws_db_subnet_group" "db_subnet" {
    #name = "dbsubnet"
    #subnet_ids = [aws_subnet.subnets[2].id, aws_subnet.subnets[3].id]
  #tags = {
    #Name = "My DB subnet group"
  #}
#}
##creating the RDS
#resource "aws_db_instance" "db" {
    #allocated_storage           = 20
    #engine                      = "postgres"
    #apply_immediately           = true
    #auto_minor_version_upgrade  =  false
    #backup_retention_period     = 0
    #db_subnet_group_name        = aws_db_subnet_group.db_subnet.name
    #instance_class              = "db.t3.micro"
    #multi_az                    = false
    #name                        = "instacook"
    #username                    = "postgres"
    #password                    = "postgres" 
    #vpc_security_group_ids      = [aws_security_group.dbsg.id]
    #skip_final_snapshot         = true         #to delete the DB
#
#
#}
