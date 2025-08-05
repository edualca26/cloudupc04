provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Environment = "Dev"
    Owner       = "GitHubActions"
  }
}