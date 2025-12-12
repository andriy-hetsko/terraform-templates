variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "app_port" {
  type    = number
  default = 3000
}
