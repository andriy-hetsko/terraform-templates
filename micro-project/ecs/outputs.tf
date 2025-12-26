output "ecs_cluster_names" {
  description = "ECS cluster names"
  value = {
    for k, m in module.ecs :
    k => m.ecs_cluster_name
  }
}
output "ecs_services" {
  description = "ECS services created per service"
  value = {
    for service_name, mod in module.ecs :
    service_name => {
      name = mod.ecs_service_name
      arn  = mod.ecs_service_arn
    }
  }
}
