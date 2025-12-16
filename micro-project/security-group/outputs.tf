output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "ecs_sg_id" {
  value = module.security_groups.ecs_sg_id
}

output "ec2_sg_id" {
  value = module.security_groups.ec2_sg_id
}

output "postgres_sg_id" {
  value = module.security_groups.postgres_sg_id
}


