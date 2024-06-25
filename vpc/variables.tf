variable "aws_rfc1918" {
  description = "Modified RFC 1918 CIDR with AWS minimum /16 prefixes"
  type        = list(string)

  default = [
    "10.0.0.0/16",
    "172.31.0.0/16",
    "192.168.0.0/16"
  ]
}

variable "project_meta" {
  description = "Metadata relating to the project for which the VPC is being created"
  type = object({
    name       = string
    short_name = string
    version    = string
    url        = string
  })
}

variable "deployment_environment" {
  description = "Deployment flavour or variant identified by this name"
  type        = string
}

variable "default_tags" {
  description = "Default resource tags to apply to AWS resources"
  type        = map(string)

  default = {
    project        = null
    maintainer     = null
    documentation  = null
    cost_center    = null
    IaC_Management = "Terraform"
  }
}

