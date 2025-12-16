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

data "terraform_remote_state" "iam_ec2" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket
    key    = "${var.environment}/iam-ec2/terraform.tfstate"
    region = var.aws_region
  }
}

module "postgres_ec2" {
  source = "../modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  ami_settings = {
    ami_type       = "ubuntu"
    ami_codename   = "noble"
    ami_os_version = "24.04"
    ami_arch       = "amd64"
    owners         = ["099720109477"]
    filters        = []
  }

  instance_type = "t3.large"

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  security_group_ids = [
    data.terraform_remote_state.sg.outputs.postgres_sg_id
  ]

  iam_instance_profile = data.terraform_remote_state.iam_ec2.outputs.instance_profile_name
  associate_public_ip  = false

  root_volume = {
    size = 30
    type = "gp3"
  }

  data_volume = {
    enabled = true
    device  = "/dev/sdf"
    size    = 100
    type    = "gp3"
  }

  user_data = file("${path.module}/user-data-postgres.sh")
}
