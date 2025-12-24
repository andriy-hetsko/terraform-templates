resource "aws_lb" "this" {
  count = var.alb.enabled ? 1 : 0

  name               = "${var.project_name}-${var.environment}-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets
}
resource "aws_lb_listener" "http" {
  count = var.alb.enabled ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

# resource "aws_lb_target_group" "this" {
#   for_each = var.services

#   name        = "${var.project_name}-${var.environment}-${each.key}"
#   port        = each.value.container_port
#   protocol    = "HTTP"
#   vpc_id      = var.vpc_id
#   target_type = var.target_type

#   health_check {
#     path = each.value.healthcheck_path
#   }
# }

# resource "aws_lb_listener_rule" "this" {
#   for_each = var.services

#   listener_arn = aws_lb_listener.http.arn
#   priority = coalesce( each.value.listener_priority,
#     100 + index(sort(keys(var.services)), each.key)
#   )


#   condition {
#     path_pattern {
#       values = [each.value.path_pattern]
#     }
#   }

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this[each.key].arn
#   }
# }

resource "aws_lb_target_group" "ecs" {
  for_each = var.alb.enabled && var.alb.mode == "ecs" ? var.ecs_services : {}

  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = each.value.healthcheck_path
  }
}

resource "aws_lb_target_group" "ec2" {
  for_each = var.alb.enabled && var.alb.mode == "ec2" ? var.ec2_services : {}

  port        = each.value.target_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path = each.value.healthcheck_path
  }
}
resource "aws_lb_listener_rule" "ecs" {
  for_each = var.alb.enabled && var.alb.mode == "ecs" ? var.ecs_services : {}

  listener_arn = aws_lb_listener.http[0].arn
  priority     = each.value.listener_priority

  condition {
    path_pattern {
      values = each.value.path_patterns
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs[each.key].arn
  }
}
