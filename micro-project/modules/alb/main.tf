resource "aws_lb" "this" {
  name               = "${var.project_name}-${var.environment}-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
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

resource "aws_lb_target_group" "this" {
  for_each = var.services

  name        = "${var.project_name}-${var.environment}-${each.key}"
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path = each.value.healthcheck_path
  }
}

resource "aws_lb_listener_rule" "this" {
  for_each = var.services

  listener_arn = aws_lb_listener.http.arn
  priority = coalesce( each.value.listener_priority,
    100 + index(sort(keys(var.services)), each.key)
  )


  condition {
    path_pattern {
      values = [each.value.path_pattern]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}
