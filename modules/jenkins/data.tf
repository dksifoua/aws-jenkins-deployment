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

data "aws_iam_policy_document" "ecs_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "jenkins" {
  statement {
    sid       = "AllowECS"
    actions   = ["ecs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "AllowCloudWatchLogs"
    actions   = ["logs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}