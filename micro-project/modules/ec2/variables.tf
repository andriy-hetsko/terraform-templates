variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "name" {
  type        = string
  description = "Logical service name (api, grafana, etc)"
}
variable "ami_settings" {
  type = object({
    ami_type       = string
    ami_os_version = string
    ami_codename   = string
    ami_arch       = string
    owners         = list(string)
    filters        = list(any)
  })
}
variable "data_volume" {
  type = object({
    enabled    = bool
    device     = optional(string)
    size       = optional(number)
    type       = optional(string)
    iops       = optional(number)
    throughput = optional(number)
  })
  default = {
    enabled = false
  }
}
variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}
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

variable "role" {
  description = "Logical role of EC2 instance (postgres17, app etc)"
  type        = string
}
