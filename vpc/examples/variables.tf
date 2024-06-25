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
  type        = map(string)

  default = {
    name       = "my-fancy-application"
    short_name = "my-app"
    version    = "v3.2.1"
    url        = "https://fancyapp.example.net"
  }
}

variable "deployment_environment" {
  description = "Deployment flavour or variant identified by this name"
  type        = string

  default = "dev"
}

variable "default_tags" {
  description = "Default resource tags to apply to AWS resources"
  type        = map(string)

  default = {
    project        = "Fancy-App"
    maintainer     = "appadmin@example.net"
    documentation  = "https://docs.fancyapp.example.net"
    cost_center    = "fancy-department"
    IaC_Management = "Terraform"
  }
}

variable "aws_region" {
  type = string

  default = "us-east-1"
}
