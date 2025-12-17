module "security_groups" {
  source = "../modules/security-groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id
  app_port     = var.app_port

  
}
