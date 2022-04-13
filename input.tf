variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type    = string
}
variable "subnet_cidr" {
  type    = list(string)
  default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
}
variable "subnet_avzone" {
  type    = list(string)
  default = ["web1","web2","db1","db2"]
}