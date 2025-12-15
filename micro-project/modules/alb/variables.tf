variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

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

variable "target_type" {
  type        = string
  description = "Target type for TG: ip (ECS/Fargate= ip) or instance (EC2= instance)"
}

variable "tags" {
  type    = map(string)
  default = {}
}