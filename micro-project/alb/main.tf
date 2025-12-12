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
}
