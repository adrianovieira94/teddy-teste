
terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket  = "ecs-teddy-state-tf"
    key     = "ecs-teddy/terraform.tfstate"    
    region  = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}