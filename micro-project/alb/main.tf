locals {
  alb_target_type = var.compute_type == "ecs" ? "ip" : "instance"
}


module "alb" {
  source = "../modules/alb"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnets   = data.terraform_remote_state.vpc.outputs.public_subnets
  alb_sg_id        = data.terraform_remote_state.sg.outputs.alb_sg_id

  listener_port     = var.listener_port
  target_port       = var.target_port
  healthcheck_path  = var.healthcheck_path

  target_type = local.alb_target_type
}
