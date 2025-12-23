variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "service_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "target_group_arn" {
  type = string
}
