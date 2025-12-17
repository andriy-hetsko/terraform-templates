output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}

output "ecs_service_arn" {
  value = module.ecs.ecs_service_arn
}

output "ecs_log_group" {
  value = module.ecs.log_group_name
}
