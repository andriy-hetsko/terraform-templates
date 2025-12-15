output "execution_role_arn" {
  value = module.iam_ecs.execution_role_arn
}

output "task_role_arn" {
  value = module.iam_ecs.task_role_arn
}
