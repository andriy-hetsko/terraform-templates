variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "rds_sg_id" {
  type = string
}

variable "identifier" {
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

variable "instance_class" {
  type = string
}
variable "allocated_storage" {
  type = number
}
variable "max_allocated_storage" {
  type    = number
  default = null
}

variable "engine_version" {
  type = string
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "backup_retention_period" {
  type    = number
  default = 7
}
