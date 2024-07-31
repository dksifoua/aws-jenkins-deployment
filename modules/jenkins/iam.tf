data "aws_iam_policy_document" "ecs_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "ecs_execution_policy" {
  statement {
    actions   = ["logs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecs-jenkins"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_policy" "ecs_execution_policy" {
  name   = "ecs-jenkins"
  policy = data.aws_iam_policy_document.ecs_execution_policy.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  policy_arn = aws_iam_policy.ecs_execution_policy.arn
  role       = aws_iam_role.ecs_execution_role.name
}