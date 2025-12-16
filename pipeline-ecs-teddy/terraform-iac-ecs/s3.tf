
resource "aws_s3_bucket" "terraform_state" {
	bucket = "ecs-teddy-state-tf"

	tags = {
		Environment = var.environment
		Project     = "pipeline-ecs-teddy"
	}
}
