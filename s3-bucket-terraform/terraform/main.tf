provider "aws" {
  region = var.region
}

# Crear el bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = true  # Esto borra el bucket aunque tenga objetos

  tags = {
    Environment = "Dev"
    Owner       = "GitHubActions"
  }
}



# Configurar lifecycle del bucket

resource "aws_s3_bucket_lifecycle_configuration" "my_bucket_lifecycle" {
  bucket = aws_s3_bucket.my_bucket.id

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
}