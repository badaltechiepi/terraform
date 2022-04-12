terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
