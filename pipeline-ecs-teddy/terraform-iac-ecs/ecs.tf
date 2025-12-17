module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.10.0" 

  cluster_name = "ecs-teddy-${var.environment}-cluster"

  services = {
    app = {
      
      name = "ecs-teddy-${var.environment}"

      cpu         = 256
      memory      = 512
      launch_type = "FARGATE"
      desired_count = 1

      # Subnets e SGs
      assign_public_ip = true
      subnet_ids = var.subnet_ids

      security_group_ingress_rules = {
        all = {
          ip_protocol = "-1"
          cidr_ipv4   = "0.0.0.0/0"
        }
      }
      security_group_egress_rules = {
        all = {
          ip_protocol = "-1"
          cidr_ipv4   = "0.0.0.0/0"
        }
      }

      # Container definitions
      container_definitions = {
        app = {
          name                   = "app"
          image                  = "nginx:latest"
          cpu                    = 256
          memory                 = 512
          essential              = true
          readonlyRootFilesystem = false
          portMappings = [
            {
              containerPort = 80
              hostPort      = 80
              protocol      = "tcp"
            }
          ]
        }
      }
    }
  }

  tags = {
    Environment = var.environment
    Project     = "ecs-teddy"
  }
}