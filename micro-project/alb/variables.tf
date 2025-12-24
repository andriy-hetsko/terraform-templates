variable "project_name" { type = string }
variable "environment"  { type = string }

variable "backend_bucket" { type = string }
variable "aws_region"     { type = string }

# variable "listener_port" {
#   type    = number
#   default = 80
# }

# variable "target_port" {
#   type    = number
#   default = 3000
# }

# variable "healthcheck_path" {
#   type    = string
#   default = "/health"
# }

variable "compute_type" {
  type    = string
}

# variable "services" {
#   description = "Services exposed via ALB"
#   type = map(object({
#     container_port   = number
#     healthcheck_path = string
#     path_pattern     = string
#     listener_priority  = optional(number)
#   }))
# }

variable "alb" {
  type = object({
    enabled = bool
    mode    = string
  })
}

# variable "mode" {
#   type = string
#   validation {
#     condition     = contains(["ecs", "ec2"], var.mode)
#     error_message = "alb.mode must be ecs or ec2"
#   }
# }

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
  type    = map(object({
    target_port       = number
    healthcheck_path  = string
    path_patterns     = list(string)
    listener_priority = number
  }))
  default = {}
}
