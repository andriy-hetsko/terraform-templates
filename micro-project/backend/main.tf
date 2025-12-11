provider "aws" {
  region = var.aws_region
}

# ---------------------------
# S3 bucket for Terraform state
# ---------------------------
resource "aws_s3_bucket" "tf_state" {
  bucket = var.backend_bucket_name

  tags = {
    ManagedBy = "terraform"
    Purpose   = "tfstate"
  }
}

# ENABLE VERSIONING
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ENABLE ENCRYPTION (new syntax for AWS provider v5)
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.tf_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
