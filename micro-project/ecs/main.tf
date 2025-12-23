
module "ecs" {
  source = "../modules/ecs"

  project_name   = var.project_name
  environment    = var.environment

  cluster_name   = "${var.project_name}-${var.environment}"

  task_role_arn      = data.terraform_remote_state.iam_ecs.outputs.task_role_arn
  execution_role_arn = data.terraform_remote_state.iam_ecs.outputs.execution_role_arn

  container_name  = var.project_name
  container_image = var.container_image
  container_port  = var.container_port

  cpu    = var.cpu
  memory = var.memory

  desired_count = var.desired_count
  enable_exec   = var.enable_exec

  private_subnets   = data.terraform_remote_state.vpc.outputs.private_subnets
  ecs_sg_id         = data.terraform_remote_state.sg.outputs.ecs_sg_id
  target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arn
}

module "grafana" {
  source = "../modules/ecs"

  project_name   = "$(var.project_name)-grafana"
  environment    = var.environment

  cluster_name   = "${var.project_name}-${var.environment}-grafana"

  task_role_arn      = data.terraform_remote_state.iam_ecs.outputs.task_role_arn
  execution_role_arn = data.terraform_remote_state.iam_ecs.outputs.execution_role_arn

  container_name  = var.project_name
  container_image = var.container_image_garafana
  container_port  = var.container_port

  cpu    = var.cpu
  memory = var.memory

  desired_count = var.desired_count
  enable_exec   = var.enable_exec

  private_subnets   = data.terraform_remote_state.vpc.outputs.private_subnets
  ecs_sg_id         = data.terraform_remote_state.sg.outputs.ecs_sg_id
  target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arn
}
