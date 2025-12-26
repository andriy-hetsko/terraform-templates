variable "project_name" { 
    type = string 
    }
variable "environment"  {
     type = string 
     }

variable "backend_bucket" {
     type = string 
     }
variable "aws_region"     {
     type = string 
     }

variable "instance_type" {
  default = "t3.micro"
}

variable "associate_public_ip" {
  default = false
}

variable "compute_type" {
  type        = string
}
# variable "target_port" {
#   type        = number 
# }
# variable "ec2_services" {
#   type    = map(object({
#     target_port       = number
#     healthcheck_path  = string
#     path_patterns     = list(string)
#     listener_priority = number
#   }))
#   default = {}
# }
# variable "ec2_services" {
#   type = map(object({
#     instance_type      = optional(string)
#     associate_public_ip = optional(bool)

#     root_volume = object({
#       size       = number
#       type       = optional(string)
#       iops       = optional(number)
#       throughput = optional(number)
#     })

#     data_volume = optional(object({
#       enabled    = bool
#       device     = string
#       size       = number
#       type       = string
#       iops       = optional(number)
#       throughput = optional(number)
#     }))

#     user_data_file = string

#     target_port       = number
#     healthcheck_path  = string
#     path_patterns     = list(string)
#     listener_priority = number
#   }))
#   default = {}
# }
variable "ec2_services" {
  type = map(object({
    instance = object({
      instance_type = string

      root_volume = object({
        size       = number
        type       = string
        iops       = optional(number)
        throughput = optional(number)
      })

      data_volume = optional(object({
        enabled    = bool
        device     = optional(string)
        size       = optional(number)
        type       = optional(string)
        iops       = optional(number)
        throughput = optional(number)
      }))

      user_data_file = string
    })

    alb = object({
      target_port       = number
      healthcheck_path  = string
      path_patterns     = list(string)
      listener_priority = number
    })
  }))
}


# variable "alb" {
#   type = object({
#     enabled = bool
#     mode    = string
#   })
# }
variable "alb" {
  type = object({
    enabled = bool
    mode    = string # ecs | ec2
  })

  validation {
    condition     = contains(["ecs", "ec2"], var.alb.mode)
    error_message = "alb.mode must be ecs or ec2"
  }
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "compute" {
  type = object({
    ecs = object({
      enabled = bool
    })
    ec2 = object({
      enabled        = bool
      instance_type  = optional(string)
      key_name       = optional(string)
    })
  })
}
