variable "project_name" {}
variable "environment" {}

variable "ami_settings" {
  type = object({
    ami_type       = string
    ami_os_version = string
    ami_arch       = string
    owners         = list(string)
    filters        = list(any)
  })
}

variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "associate_public_ip" {
  type    = bool
  default = false
}

variable "root_volume" {
  type = object({
    size       = number
    type       = string
    iops       = optional(number)
    throughput = optional(number)
  })
}

variable "user_data" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
