terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region     = "us-west-2"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-zee"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}