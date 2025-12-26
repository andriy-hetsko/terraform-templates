# module "ec2" {
#   source = "../modules/ec2"

#   for_each = var.ec2_services

#   project_name = var.project_name
#   environment  = var.environment
#   role         = "app"
#   name = "${var.project_name}-${var.environment}-${each.key}"

#   ami_settings = {
#     ami_type       = "ubuntu"
#     ami_os_version = "24.04"
#     ami_codename   = "noble"
#     ami_arch       = "x86_64"
#     owners         = ["099720109477"]
#     filters        = []
#   }

#   instance_type = each.value.instance.instance_type
#   root_volume = {
#     size = each.value.instance.root_volume.size
#     type = each.value.instance.root_volume.type
# }

#   subnet_id            = data.terraform_remote_state.vpc.outputs.private_subnets[0]
#   security_group_ids   = [data.terraform_remote_state.sg.outputs.ec2_sg_id]
#   iam_instance_profile = data.terraform_remote_state.iam_ec2.outputs.instance_profile_name

#   associate_public_ip = var.associate_public_ip

#   user_data = file(
#     "${path.module}/${each.value.instance.user_data_file}"
#   )
#   user_data = file("${path.module}/user-data.sh")
#     tags = {
#     Name        = "${var.project_name}-${var.environment}-${each.key}"
#     Project     = var.project_name
#     Environment = var.environment
#     Service     = each.key
#     Managed   = "terraform"
#   }
# }
module "ec2" {
  source = "../modules/ec2"

  for_each = var.ec2_services

  project_name = var.project_name
  environment  = var.environment
  name         = each.key
  role         = "app"

  ami_settings = {
    ami_type       = "ubuntu"
    ami_os_version = "24.04"
    ami_codename   = "noble"
    ami_arch       = "x86_64"
    owners         = ["099720109477"]
    filters        = []
  }

  instance_type = each.value.instance_type
  subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  security_group_ids   = [data.terraform_remote_state.sg.outputs.ec2_sg_id]
  iam_instance_profile = data.terraform_remote_state.iam_ec2.outputs.instance_profile_name

  associate_public_ip = false

  root_volume = {
    size = each.value.root_volume_size
    type = "gp3"
  }

  data_volume = lookup(each.value, "data_volume", {
    enabled = false
  })

  user_data = file(each.value.user_data_file)
}


# resource "aws_lb_target_group_attachment" "ec2" {
#   for_each = var.alb.enabled && var.alb.mode == "ec2" ? var.ec2_services : {}

#   target_group_arn = data.terraform_remote_state.alb.outputs.target_group_arns[each.key]
#   target_id        = module.ec2.instance_id
#   port             = each.value.target_port
# }

resource "aws_lb_target_group_attachment" "ec2" {
  for_each = var.alb.enabled && var.alb.mode == "ec2" ? var.ec2_services : {}

  target_group_arn = module.alb.target_group_arns[each.key]
  target_id        = module.ec2[each.key].instance_id
  port             = each.value.target_port
}
