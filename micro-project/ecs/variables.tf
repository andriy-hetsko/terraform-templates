variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "services" {
  type = map(object({
    image           = string
    container_port  = number
    cpu             = number
    memory          = number
    desired_count   = number
  }))
}
variable "aws_region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "aws_region" {
  type = string
}
