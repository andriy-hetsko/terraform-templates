variable "project_name" { type = string }
variable "environment"  { type = string }

variable "service_name" { type = string }
variable "cluster_name" { type = string }

variable "container_image" { type = string }
variable "container_port"  { type = number }

variable "cpu"    { type = number }
variable "memory" { type = number }

variable "desired_count" { type = number }

variable "execution_role_arn" { type = string }
variable "task_role_arn"      { type = string }

variable "private_subnets" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
