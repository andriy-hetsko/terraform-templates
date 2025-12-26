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
variable "ec2_services" {
  type    = map(object({
    target_port       = number
    healthcheck_path  = string
    path_patterns     = list(string)
    listener_priority = number
  }))
  default = {}
}
variable "alb" {
  type = object({
    enabled = bool
    mode    = string
  })
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
