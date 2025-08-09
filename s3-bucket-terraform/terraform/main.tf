provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = true  # Esto borra el bucket aunque tenga objetos

  rule {
    id     = "mover-a-glacier-y-borrar"
    status = "Enabled"

    transition {
      days          = 1
      storage_class = "GLACIER"
    }

    expiration {
      days = 2
    }
  }

  tags = {
    Environment = "Dev"
    Owner       = "GitHubActions"
  }
}