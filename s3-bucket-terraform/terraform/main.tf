provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = true  # Esto borra el bucket aunque tenga objetos

  rule {
    id     = "mover-a-glacier-y-borrar"
    status = "Enabled"

    filter {
      tag {
        key   = "usuario"
        value = "juan"
      }
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  tags = {
    Environment = "Dev"
    Owner       = "GitHubActions"
  }
}