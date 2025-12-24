variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "alb_sg_id" {}
variable "listener_port" {}
variable "target_type" {}

variable "services" {
  type = map(object({
    healthcheck_path = string
    path_pattern     = string
    container_port   = number
    listener_priority  = number
  }))
}
