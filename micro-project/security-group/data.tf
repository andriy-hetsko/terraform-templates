data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/vpc/terraform.tfstate"
    region = var.aws_region
  }
}
