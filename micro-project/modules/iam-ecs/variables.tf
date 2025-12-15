variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "extra_task_policy_arns" {
  type    = list(string)
  default = []
}


variable "enable_ecr_pull" {
  type    = bool
  default = true
}

variable "enable_secrets_manager" {
  type    = bool
  default = false
}

variable "enable_s3_read" {
  type    = bool
  default = false
}

variable "enable_cloudwatch_logs" {
  type    = bool
  default = false
}
