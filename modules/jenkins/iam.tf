resource "aws_iam_role" "jenkins" {
  name               = "jenkins"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume.json
  tags               = var.tags
}

resource "aws_iam_policy" "jenkins" {
  name   = "jenkins"
  policy = data.aws_iam_policy_document.jenkins.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  policy_arn = aws_iam_policy.jenkins.arn
  role       = aws_iam_role.jenkins.name
}