resource "local_file" "jenkins_agent_conf" {
  content  = local.jenkins_agent_conf
  filename = "${path.module}/jcasc/clouds.ecs.yaml"
}

resource "null_resource" "build_docker_image" {
  triggers = {
    src_hash   = file("${path.module}/templates/clouds.ecs.yaml")
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
      task docker:build docker:tag docker:push
    EOF
  }

  depends_on = [local_file.jenkins_agent_conf]
}

resource "aws_cloudwatch_log_group" "jenkins" {
  name = var.log_group
  tags = var.tags
}

