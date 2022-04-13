variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type    = string
}
variable "subnet_cidrs" {
  default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
  description = "This is the CIDR range of the subnets"
}
variable "subnet_names" {
  default = ["web1","web2","db1","db2"]
  description = "avalibility zone"
}