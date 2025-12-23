module "ecs" {
  for_each = var.services

  source = "../modules/ecs"

  project_name = var.project_name
  environment  = var.environment

  service_name = each.key
  cluster_name = var.cluster_name

  container_image = each.value.image
  container_port  = each.value.container_port
  cpu             = each.value.cpu
  memory          = each.value.memory
  desired_count   = each.value.desired_count

  target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arns[each.key]
}
