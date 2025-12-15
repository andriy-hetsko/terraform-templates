module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  enable_ssm             = var.enable_ssm
  enable_cloudwatch_logs = var.enable_cloudwatch_logs


  enable_ecr_pull = var.compute_type 

  enable_s3_read = var.enable_s3_read
}
