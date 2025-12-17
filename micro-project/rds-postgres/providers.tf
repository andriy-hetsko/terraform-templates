provider "aws" {
  region = var.aws_region
}
# # variable "project_name" {
# #   type = string
# # }

# # variable "environment" {
# #   type = string
# # }

# variable "aws_region" {
#   type = string
# }

# # variable "backend_bucket" {
# #   type = string
# # }

# variable "vpc_id" {
#   type = string
# }

# variable "private_subnet_ids" {
#   type = list(string)
# }

# variable "rds_security_group_id" {
#   type = string
# }

# variable "db_password" {
#   type      = string
#   sensitive = true
# }