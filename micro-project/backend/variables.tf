variable "backend_bucket_name" {
  type        = string
  description = "Name of S3 bucket for Terraform state"
}

variable "aws_region" {
  type        = string
  description = "AWS region for S3 bucket"
}
