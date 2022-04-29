output "vpcid" {
  value = aws_vpc.vpc
}
output "subnets" {
    value = aws_subnet.subnets
  
}
output "dbname" {
  value = aws_db_instance.db.name
}