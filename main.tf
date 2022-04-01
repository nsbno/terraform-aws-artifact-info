terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

locals {
  path = "/artifacts/${var.application_name}"
}

data "aws_ssm_parameter" "version" {
  name = var.application_name
}

data "aws_ssm_parameter" "location" {
  name = "${var.application_name}/location"
}

data "aws_ssm_parameter" "path" {
  name = "${var.application_name}/path"
}
