/*
 * In this example we're deploying a lambda function with an artifact from S3!
 */
locals {
  name_prefix      = "infrademo"
  application_name = "my-cool-lambda-app"
}

module "artifact" {
  source = "../../"

  application_name = local.application_name
}


resource "aws_lambda_function" "this" {
  function_name = local.application_name

  s3_bucket = module.artifact.location
  s3_key    = "${module.artifact.path}/${module.artifact.version}.zip"

  runtime = "python3.9"
  handler = "cool.handler"

  role = "my-lambda-role"
}
