data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/vpc/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/security-group/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/alb/terraform.tfstate"
    region = var.aws_region
  }
}

module "ecs" {
  source = "../modules/ecs"

  project_name   = var.project_name
  environment    = var.environment

  cluster_name   = "${var.project_name}-${var.environment}"

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
