resource "aws_instance" "this" {
  ami                    = data.aws_ami.this.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size = var.root_volume.size
    volume_type = var.root_volume.type
    iops        = try(var.root_volume.iops, null)
    throughput  = try(var.root_volume.throughput, null)
  }

  dynamic "ebs_block_device" {
  for_each = var.data_volume.enabled ? [1] : []
  content {
    device_name = var.data_volume.device
    volume_size = var.data_volume.size
    volume_type = var.data_volume.type
    iops        = try(var.data_volume.iops, null)
    throughput  = try(var.data_volume.throughput, null)
  }
}

  user_data = var.user_data != "" ? var.user_data : null

  metadata_options {
    http_tokens = "required"
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = local.tags
}



