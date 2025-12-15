module "iam_ecs" {
  source = "../modules/iam-ecs"

  project_name = var.project_name
  environment  = var.environment

  enable_ecr_pull         = var.enable_ecr_pull
  enable_secrets_manager = var.enable_secrets_manager
  enable_s3_read          = var.enable_s3_read
  enable_cloudwatch_logs  = var.enable_cloudwatch_logs
}
