terraform {
  required_version = ">= 1.6.6"

  cloud {
    organization = "dksifoua"

    workspaces {
      name = "aws-jenkins-deployment"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}