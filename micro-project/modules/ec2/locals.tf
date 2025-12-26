locals {
  ami_filters_map = {
    ubuntu = [
      {
        name   = "architecture"
        values = [
          var.ami_settings.ami_arch == "amd64" ? "x86_64" : var.ami_settings.ami_arch
        ]
      },
      {
        name   = "name"
        values = [
          "ubuntu/images/hvm-ssd-gp3/ubuntu-${var.ami_settings.ami_codename}-${var.ami_settings.ami_os_version}-amd64-server-*"
        ]
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

  tags = merge({
    Name        = "${var.project_name}-${var.environment}-${var.role}"
    Project     = var.project_name
    Environment = var.environment
    Role        = var.role
    ManagedBy   = "terraform"
  }, var.tags)
}