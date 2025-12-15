variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "enable_ssm" {
  type    = bool
  default = true
}

variable "enable_ecr_pull" {
  type    = bool
  default = false
}

variable "enable_cloudwatch_logs" {
  type    = bool
  default = true
}

variable "enable_s3_read" {
  type    = bool
  default = false
}
