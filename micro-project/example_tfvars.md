{
  "project": {
    "name": "hetsko-ec2-new",
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

  "compute": {
    "ecs": {
      "enabled": false
    },
    "ec2": {
      "enabled": true,
      "instance_type": "t3.micro",
      "key_name": null
    }    
  },

  "alb": {
    "enabled": true,
    "mode": "ec2"  
  }, 

  "ecs_services": {
    "frontend": {
      "image": "nginx:1.25-alpine",
      "container_port": 80,
      "app_port": 80,
      "cpu": 256,
      "memory": 512,
      "desired_count": 1,
      "enable_exec": true,
      "healthcheck_path": "/",
      "path_pattern": ["/*"],
      "listener_priority": 100
    },

    "whoami": {
      "image": "containous/whoami:v1.5.0",
      "container_port": 80,
      "app_port": 80,
      "cpu": 256,
      "memory": 512,
      "desired_count": 1,
      "enable_exec": true,
      "healthcheck_path": "/",
      "path_pattern": ["/whoami/*"], 
      "listener_priority": 10
    }
  }, 
  "ec2_services": {
  "api": {
    "instance": {
      "instance_type": "t3.small",
      "root_volume": {
        "size": 20,
        "type": "gp3"
      },
      "data_volume" = {
        "enabled" = false
      }, 
      "user_data_file": "user-data.sh"
    },
    "alb": {
      "target_port": 3000,
      "healthcheck_path": "/",
      "path_patterns": ["/api", "/api/*"],
      "listener_priority": 10
    }
  },
  "grafana": {
    "instance": {
      "instance_type": "t3.medium",
      "root_volume": {
        "size": 50,
        "type": "gp3"
      },
      "data_volume" = {
        "enabled" = false
      }, 
      "user_data_file": "user-data-graf.sh"
    },
    "alb": {
      "target_port": 3000,
      "healthcheck_path": "/",
      "path_patterns": ["/grafana", "/grafana/*"],
      "listener_priority": 20
    }
  }
}, 

  "database": {
    "rds": {
      "enabled": false,
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
      "enabled": true,
      "engine": "postgres",
      "instance_type": "t3.micro",
      "volume_size": 50
    }
  }
}
