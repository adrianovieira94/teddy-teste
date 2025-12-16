
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "remote" {
    organization = "SUA_ORGANIZACAO_TERRAFORM_CLOUD"

    workspaces {
      name = "ecs-teddy"
    }
  }
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.10.0"
}