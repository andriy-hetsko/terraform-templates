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

variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type = string
}
variable "allocated_storage" {
  type = number
}
variable "max_allocated_storage" {
  type    = number
  default = null
}
variable "engine_version" { type = string }

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}
