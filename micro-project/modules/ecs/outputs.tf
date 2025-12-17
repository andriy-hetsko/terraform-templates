output "ecs_cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ECS cluster ID"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  value       = aws_ecs_service.this.name
}

output "ecs_service_arn" {
  value = aws_ecs_service.this.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.this.name
}
