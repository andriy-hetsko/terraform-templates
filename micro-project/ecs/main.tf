

module "ecs" {
  for_each = var.services

  source = "../modules/ecs"

  project_name = var.project_name
  environment  = var.environment

  service_name = each.key
  cluster_name = aws_ecs_cluster.this.name

  container_image = each.value.image
  container_port  = each.value.container_port
  cpu             = each.value.cpu
  memory          = each.value.memory
  desired_count   = each.value.desired_count

  execution_role_arn = data.terraform_remote_state.iam_ecs.outputs.execution_role_arn
  task_role_arn      = data.terraform_remote_state.iam_ecs.outputs.task_role_arn

  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  ecs_sg_id       = data.terraform_remote_state.sg.outputs.ecs_sg_id

  target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arns[each.key]
}
