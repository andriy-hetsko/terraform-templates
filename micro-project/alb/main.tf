# locals {
#   alb_target_type = var.compute_type == "ecs" ? "ip" : "instance"
# }


module "alb" {
  source = "../modules/alb"

  alb = var.alb

  ecs_services = var.alb.mode == "ecs" ? var.ecs_services : {}
  ec2_services = var.alb.mode == "ec2" ? var.ec2_services : {}

  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  alb_sg_id      = data.terraform_remote_state.sg.outputs.alb_sg_id

  # listener_port = var.listener_port
  # target_type   = local.alb_target_type
  # services      = var.services
}
