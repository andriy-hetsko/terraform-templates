{
  "project": {
    "name": "hetsko-ecs-new",
    "environment": "dev",
    "aws_region": "us-east-2"
  },

  "network": {
    "enabled": true,
    "cidr": "10.0.0.0/16",
    "azs": ["us-east-2a", "us-east-2b", "us-east-2c"],
    "public_subnets": ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"],
    "private_subnets": ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  },

    "alb": {
    "enabled": true
   },

  "services": {
    "api": {
      "image": "nginx:1.25-alpine",
      "container_port": 80,
      "app_port": 80,
      "cpu": 256,
      "memory": 512,
      "desired_count": 1,
      "enable_exec": true, 
      "healthcheck_path": "/",
      "path_pattern": "/api/*"
    },
    "grafana": {
      "image": "grafana/grafana:10.4.3",
      "container_port": 3000,
      "app_port": 3000,
      "cpu": 256,
      "memory": 512,
      "desired_count": 1,
      "enable_exec": true, 
      "healthcheck_path": "/api/health",
      "path_pattern": "/grafana/*"
    }
  }, 

  "compute": {
    "ecs": {
      "enabled": true,
    },
    "ec2": {
      "enabled": false,
      "instance_type": "t3.micro",
      "key_name": null
    }
  },

  "database": {
    "rds": {
      "enabled": true,
      "engine": "postgres",
      "engine_version": "17.2",
      "db_name": "appdb",
      "db_username": "postgres",
      "db_instance_class": "db.t3.micro",
      "allocated_storage": 50,
      "max_allocated_storage": null,
      "multi_az": false,
      "backup_retention_period": 7,
      "skip_final_snapshot": true,
      "deletion_protection": false
    },
    "ec2": {
      "enabled": false,
      "engine": "postgres",
      "instance_type": "t3.micro",
      "volume_size": 50
    }
  }
}

