module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.10.0" 

  cluster_name = "pipeline-ecs-teddy-${var.environment}-cluster"

  # Se quiser usar capacity provider FARGATE, o módulo faz isso via "cluster_settings"/"default_capacity_provider_strategy"
  default_capacity_provider_strategy = {
  default = {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }
}

  services = {
    app = {
      # Nomes devem bater com a pipeline:
      name = "pipeline-ecs-teddy-${var.environment}"

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
    Project     = "pipeline-ecs-teddy"
  }
}