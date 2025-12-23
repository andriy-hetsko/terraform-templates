# output "ecs_cluster_name" {
#   value = module.ecs.ecs_cluster_name
# }

# output "ecs_service_name" {
#   value = module.ecs.ecs_service_name
# }

# output "ecs_service_arn" {
#   value = module.ecs.ecs_service_arn
# }

# output "ecs_log_group" {
#   value = module.ecs.log_group_name
# }
# output "services" {
#   value = {
#     for k, m in module.ecs :
#     k => m.service_name
#   }
# }

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
