data "aws_region" "current" {}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name = var.log_group
  tags = var.tags
}