terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region     = "us-east-2"
}
#remote place to store the state and lock perpose in aws
# terraform {
#   backend "s3" {
#     bucket = "qts3tfstatestechiepi"
#     key    = "activity2.tfstate"
#     region = "us-east-2"
#     dynamodb_table = "qttflocking"
#   }
# }
terraform {
  backend "local" {
    path = "/terraform.tfstate"
  }
}