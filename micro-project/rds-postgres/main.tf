module "rds" {
  source = "../modules/rds-postgres"

  project_name = var.project_name
  environment  = var.environment

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids  = data.terraform_remote_state.vpc.outputs.private_subnets
  rds_sg_id           = data.terraform_remote_state.sg.outputs.rds_sg_id

  identifier = "${var.project_name}-${var.environment}-postgres"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  instance_class        = var.db_instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  engine_version = var.engine_version

  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period

  skip_final_snapshot  = var.skip_final_snapshot
  deletion_protection  = var.deletion_protection

  publicly_accessible = false
}
