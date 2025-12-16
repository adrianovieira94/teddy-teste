

resource "aws_ecr_repository" "app" {
  name = "ecs-teddy-${var.environment}"
	image_tag_mutability = "MUTABLE"
	image_scanning_configuration {
		scan_on_push = true
	}
	tags = {
		Environment = var.environment
	}
}
