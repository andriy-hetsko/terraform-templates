module "ec2" {
  source = "../modules/ec2"

  project_name = var.project_name
  environment  = var.environment
  role        = "app"

  ami_settings = {
    ami_type       = "ubuntu"
    ami_os_version = "24.04"
    ami_codename    = "noble"
    ami_arch       = "x86_64"
    owners         = ["099720109477"]
    filters        = []
  }

  instance_type        = var.instance_type
  subnet_id            = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  security_group_ids   = [data.terraform_remote_state.sg.outputs.ec2_sg_id]
  iam_instance_profile = data.terraform_remote_state.iam_ec2.outputs.instance_profile_name

  associate_public_ip = var.associate_public_ip

  root_volume = {
    size = 30
    type = "gp3"
  }
  user_data = file("${path.module}/user-data.sh")
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt-get update
  #   curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
  #   sudo systemctl enable docker
  #   sudo systemctl start docker
  #   sudo usermod -aG docker $USER 
  #   sudo systemctl enable amazon-ssm-agent
  #   sudo systemctl start amazon-ssm-agent
  #   sudo docker run -p 3000:80 -d nginx
  # EOF
}

resource "aws_lb_target_group_attachment" "ec2" {
  for_each = var.alb.enabled && var.alb.mode == "ec2" ? var.ec2_services : {}

  target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arn
  target_id        = module.ec2.instance_id
  port             = each.value.target_port
}
