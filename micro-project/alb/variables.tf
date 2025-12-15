variable "project_name" { type = string }
variable "environment"  { type = string }

variable "backend_bucket" { type = string }
variable "aws_region"     { type = string }

variable "listener_port" {
  type    = number
  default = 80
}

variable "target_port" {
  type    = number
  default = 3000
}

variable "healthcheck_path" {
  type    = string
  default = "/health"
}

variable "compute_type" {
  type    = string
}