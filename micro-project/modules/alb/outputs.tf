output "alb_dns_name" {
  value       = var.alb.enabled ? aws_lb.this[0].dns_name : null
  description = "ALB DNS name"
}

output "target_group_arns" {
  value = var.alb.enabled ? (
    var.alb.mode == "ecs" ? {
      for k, tg in aws_lb_target_group.ecs :
      k => tg.arn
    } : {
      for k, tg in aws_lb_target_group.ec2 :
      k => tg.arn
    }
  ) : {}
}
