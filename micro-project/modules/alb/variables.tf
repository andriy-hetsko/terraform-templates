variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "alb_sg_id" {}

variable "alb" {
  type = object({
    enabled = bool
    mode    = string
  })
}
variable "ecs_services" {
  type    = map(object({
    image             = string
    container_port    = number
    cpu               = number
    memory            = number
    desired_count     = number
    enable_exec       = bool
    healthcheck_path  = string
    path_patterns     = list(string)
    listener_priority = number
  }))
  default = {}
}

variable "ec2_services" {
  type = map(object({
    target_port       = number
    healthcheck_path  = string
    path_patterns     = list(string)
    listener_priority = number
  }))
  default = {}
}
