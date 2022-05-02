output "vpcid" {
  value = aws_vpc.vpc
}
output "subnets" {
    value = aws_subnet.subnets
  
}
output "dbname" {
  value = aws_db_instance.db.name
}
output "publicip" {
  value = aws_instance.web1.public_ip
  depends_on = [
    aws_instance.web1
  ]
}
output "dbsubnets" {
  
  value = aws_db_subnet_group.db_subnet
}