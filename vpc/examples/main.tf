module "vpc" {
  // source = "git::https://gitlab.com/eternaltyro/terraform-aws-vpc.git"
  source = "./.."

  project_meta = var.project_meta

  deployment_environment = var.deployment_environment
  default_tags           = var.default_tags
}
