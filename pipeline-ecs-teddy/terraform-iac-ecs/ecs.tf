module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.10.0" 

  cluster_name = "ecs-teddy-${var.environment}-cluster"

  services = {
    app = {
      
      name = "cs-teddy-${var.environment}"

      cpu         = 256
      memory      = 512
      launch_type = "FARGATE"

      # Subnets e SGs
      subnet_ids = var.subnet_ids

      security_group_egress_rules = {
        all = {
          ip_protocol = "-1"
          cidr_ipv4   = "0.0.0.0/0"
        }
      }

      # Container definitions
      container_definitions = {
        app = {
          image     = "nginx:latest" 
          cpu       = 256
          memory    = 512
          essential = true

          port_mappings = [
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