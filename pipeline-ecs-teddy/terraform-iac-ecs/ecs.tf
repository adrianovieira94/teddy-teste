module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "var.cluster_name-${var.environment}"

  capacity_providers = ["FARGATE"]

  services = {
    app = {
      cpu    = 256
      memory = 512
      launch_type = "FARGATE"

      container_definitions = {
        app = {
          image = "nginx:latest"
          cpu   = 256
          memory = 512
          essential = true
          portMappings = [{
            containerPort = 80
            protocol      = "tcp"
          }]
        }
      }

      subnet_ids = var.subnet_ids
      security_group_egress_rules = {
        all = {
          ip_protocol = "-1"
          cidr_ipv4   = "0.0.0.0/0"
        }
      }
    }
  }
  tags = {
    Environment = var.environment
    Project     = var.cluster_name
  }
}