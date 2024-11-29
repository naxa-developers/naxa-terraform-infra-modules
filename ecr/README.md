# Terraform ECR Module

This module creates an Amazon Elastic Container Registry (ECR) repository with a name and tag derived from the application and environment variables.

## Inputs

| Name          | Description                                           | Type   | Default | Required |
|---------------|-------------------------------------------------------|--------|---------|----------|
| application   | The name of the application.                         | string | n/a     | yes      |
| environment   | The environment for the ECR repository (e.g., dev).  | string | n/a     | yes      |

## Outputs

| Name                  | Description                          |
|-----------------------|--------------------------------------|
| ecr_repository_name   | The name of the ECR repository.     |
| ecr_repository_arn    | The ARN of the ECR repository.      |
| ecr_repository_url    | The URL of the ECR repository.      |

## Example Usage

```hcl
module "ecr" {
  source      = "./path-to-module"
  application = "my-app"
  environment = "dev"
}