variable "vpc_settings" {
  description = "Settings for ec2 instance"
  type = object({
    prefix      = string
    cidr            = string
    azs             = list(string)
    private_subnets = list(string)
    public_subnets  = list(string)
  })
}

variable "project_name" {
    type = string
    default = "myproject"
  
}

variable "region" {
  type = string
  default = "us-east-1"
  
}