module "jenkins" {
  source                       = "./modules/jenkins"
  jenkins_controller_cpu       = 512
  jenkins_controller_image     = "dksifoua/jenkins:latest"
  jenkins_controller_memory    = 1024
  vpc_id                       = "vpc-cbef96b6"
  jenkins_controller_container = "jenkins-controller"
  log_group                    = "ecs/jenkins"
  tags = {
    Application = "Jenkins"
    Owner       = "Dimitri"
  }
}