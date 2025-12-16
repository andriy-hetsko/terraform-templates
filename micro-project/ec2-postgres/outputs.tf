output "postgres_instance_id" {
  value = module.postgres_ec2.instance_id
}

output "postgres_private_ip" {
  value = module.postgres_ec2.private_ip
}

output "postgres_ami_id" {
  value = module.postgres_ec2.ami_id
}
