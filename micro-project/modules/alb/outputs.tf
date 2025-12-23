output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arns" {
  description = "Map of target group ARNs by service name"
  value = {
    for k, tg in aws_lb_target_group.this :
    k => tg.arn
  }
}
