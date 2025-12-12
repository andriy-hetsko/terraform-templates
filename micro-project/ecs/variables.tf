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

variable "container_image" {
     type = string 
     }
variable "container_port"  {
     type = number 
     }

variable "cpu"    {
     type = number 
     }
variable "memory" { 
    type = number 
    }

variable "desired_count" {
  type    = number
  default = 1
}

variable "enable_exec" {
  type    = bool
  default = true
}
