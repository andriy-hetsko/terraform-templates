resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-rds-subnets"
  subnet_ids = var.private_subnet_ids

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Managed     = "terraform"
  }
}

resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = var.publicly_accessible
  multi_az            = var.multi_az

  backup_retention_period = var.backup_retention_period

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Managed     = "terraform"
  }
}
