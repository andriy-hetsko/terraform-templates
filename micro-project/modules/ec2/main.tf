locals {
  ami_filters_map = {
    ubuntu = [
      {
        name   = "architecture"
        values = [var.ami_settings.ami_arch]
      },
      {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu*${var.ami_settings.ami_os_version}-*"]
      },
      {
        name   = "root-device-type"
        values = ["ebs"]
      },
      {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    ]
    custom = var.ami_settings.filters
  }

  ami_filters = local.ami_filters_map[var.ami_settings.ami_type]
}

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

locals {
  tags = merge({
    Name        = "${var.project_name}-${var.environment}-ec2"
    Project     = var.project_name
    Environment = var.environment
  }, var.tags)
}

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

  user_data = var.user_data != "" ? var.user_data : null

  metadata_options {
    http_tokens = "required"
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = local.tags
}
