module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "5.9.0"
  name                   = var.vpc_settings.prefix
  cidr                   = var.vpc_settings.cidr
  azs                    = var.vpc_settings.azs
  private_subnets        = var.vpc_settings.private_subnets
  public_subnets         = var.vpc_settings.public_subnets
  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = false

  tags = {
    "Name"    = var.vpc_settings.prefix
    "project" = var.project_name
  }

  public_subnet_tags = {
    "Name" = "public-subnet-${var.vpc_settings.prefix}"
  }

  private_subnet_tags = {
    "Name" = "private-subnet-${var.vpc_settings.prefix}"
  }

  public_route_table_tags = {
    "Name" = "public-rt-${var.vpc_settings.prefix}"
  }

  private_route_table_tags = {
    "Name" = "private-rt-${var.vpc_settings.prefix}"
  }
}
