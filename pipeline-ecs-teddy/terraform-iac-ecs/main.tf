
provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "NOME_DO_BUCKET"
    key            = "ecs-teddy/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.10.0"
}

required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
