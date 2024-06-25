# Terraform AWS VPC Module

This is a terraform module that brings up a full AWS VPC with all the bells and whistles

This module helps deploy the following AWS resources

1. A primary VPC - the star of the show - with a modified RFC1918 IP space [^ref1] in compliance with AWS restrictions
2. An Internet gatway associated with the VPC
3. A NAT gateway for IPv4 and IPv6 egress traffic
4. An egress-only internet gateway for outgoing IPv6 traffic
5. A Public and a Private subnet with associated route tables containing appropriate routes
6. Prefix lists to maintain admin IP addresses to use in Security Group whitelists

Planned to be implemented:

- [TODO] VPC Endpoints for S3 and other services

## How to use

:warning: Please note that this module compatible with AWS provider version >= 5.0.0. Tested with v5.1.0;

1. Import the module in your root module:

```
module "vpc" {
  source = "git::https://gitlab.com/eternaltyro/terraform-aws-vpc.git"

  ...
  key = var.value
}
```

If you wish to use SSH to connect to git, then something like this will help:

```
module "vpc" {
  source = "git::ssh://username@gitlab.com/eternaltyro/terraform-aws-vpc.git"
}
```

2. Write a provider block with the official AWS provider:

```
terraform {
  required_version = ">= 1.4.0"

  requried_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
  }
}

provider "aws" {
  region = lookup(var.aws_region, var.deployment_environment)

  default_tags {
    tags = var.resource_tags
  }
}
```

3. Initialise the backend, and plan

```
$ terraform init
$ terraform plan
```

## Outputs

1. `vpc_id` - VPC ID
2. `public_subnets` - A list of public subnet IDs
3. `private_subnets` - A list of private subnet IDs
4. `ipv4_prefix_list_id` - ID of the prefix list for IPv4 addresses
4. `ipv6_prefix_list_id` - ID of the prefix list for IPv6 addresses

## Variables

- `aws_rfc1918` - A list of AWS restricted CIDRs that can be used for VPC address spacing. Defaults are set.
- `project_meta` - A map of project metadata containing project name, short name and version string. Defaults are set but empty.
- `deployment_environment` - A string indicator of the deployment environment or flavour or variant of the deployment. No defaults set.
- `default_tags` - A map of tag keys and values with basic keys and empty values by default

## References

[ref1]: AWS Documentation VPC CIDR blocks - https://docs.aws.amazon.com/vpc/latest/userguide/vpc-cidr-blocks.html

## Copyright and License texts

The project is licensed under GNU LGPL. Please make any modifications to this module public. Read LICENSE, COPYING.LESSER, and COPYING files for license text

Copyright (C) 2023 eternaltyro
This file is part of Terraform AWS VPC Module aka terraform-aws-vpc project

terraform-aws-vpc is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License.

terraform-aws-vpc is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

License text can be found in the repository
