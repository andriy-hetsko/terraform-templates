output "instance_profile_name" {
  value = module.iam_ec2.instance_profile_name
}

output "instance_profile_arn" {
  value = module.iam_ec2.instance_profile_arn
}

output "role_arn" {
  value = module.iam_ec2.role_arn
}
