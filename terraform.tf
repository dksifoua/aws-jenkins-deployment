terraform {
  required_version = ">= 1.6.6"

  backend "s3" {
    bucket  = "tf-state-dimitri"
    key     = "aws-jenkins-deployment/terraform.tfstate"
    region  = "us-east-1"
    profile = "dimitri@dksifoua.io"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dimitri@dksifoua.io"
}