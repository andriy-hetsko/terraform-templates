variable "project_name" {}
variable "environment" {}
variable "service_name" {}
variable "cluster_name" {}

# variable "container_name" {}
variable "container_image" {}
variable "container_port" {}

variable "cpu" {}
variable "memory" {}
variable "desired_count" {}

variable "task_role_arn" {}
variable "execution_role_arn" {}

variable "private_subnets" {}
variable "ecs_sg_id" {}
variable "target_group_arn" {}
variable "aws_region" { type = string }
