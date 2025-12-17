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
data "terraform_remote_state" "iam_ecs" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/iam-ecs/terraform.tfstate"
    region = var.aws_region
  }
}