data "aws_ami" "this" {
  most_recent = true
  owners      = var.ami_settings.owners

  dynamic "filter" {
    for_each = local.ami_filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}
