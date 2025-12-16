output "instance_profile_name" {
  description = "IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.profile.name
}

output "instance_profile_arn" {
  description = "IAM instance profile ARN for EC2"
  value       = aws_iam_instance_profile.profile.arn
}

output "role_arn" {
  description = "IAM role ARN for EC2"
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.this.name
}
