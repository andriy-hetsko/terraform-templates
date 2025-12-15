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
