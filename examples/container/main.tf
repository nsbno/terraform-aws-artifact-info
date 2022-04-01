/*
 * In this example we're deploying a service to ECS with an artifact stored in ECR!
 */
locals {
  name_prefix      = "infrademo"
  application_name = "my-funky-container-app"
}

module "artifact" {
  source = "../../"

  application_name = local.application_name
}

module "service" {
  source = "github.com/nsbno/terraform-aws-ecs-service"

  name_prefix = local.application_name

  vpc_id             = data.aws_vpc.main.id
  private_subnet_ids = data.aws_subnet_ids.private.ids
  cluster_id         = data.aws_ecs_cluster.main.id

  application_container = {
    name     = "main"
    image    = "${module.artifact.location}/${module.artifact.path}:${module.artifact.version}"
    port     = 80
    protocol = "HTTP"
  }

  lb_listeners = [
    {
      listener_arn      = data.aws_lb_listener.http.arn
      security_group_id = one(data.aws_lb.main.security_groups)
      path_pattern      = "/${local.application_name}/*"
    }
  ]
}
