# NAXA Terraform modules.

## Import and Use

- Use tags to import

### Example Usage with terragrunt.

#### Directory Structure

```
WorkingDirectory => ../naxa-terraform/Deployment/naxa-backend-boilerplate

.
├── develop
├── main
│   ├── inputs.hcl
│   ├── src
│   │   ├── extra_resource.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── terragrunt.hcl
├── staging
└── terragrunt.hcl

```

#### Example `terragrunt.hcl` at root

```hcl
remote_state {
  backend = "s3"
  config = {
    region                   = "ap-south-1"
    key                      = "${path_relative_to_include()}/terraform.tfstate"
    bucket                   = "naxa-terraform-statefiles"
    dynamodb_table           = "naxa-terraform-locks"
    shared_credentials_files = ["/Users/nischal/NAXA/naxa-terraform/.aws/credentials"]
    profile                  = "default"
    disable_bucket_update    = true
  }

  generate = {
    path        = "backend.tf"
    if_exists   = "overwrite_terragrunt"
  }
}

locals {
    application  = "naxa-backend-boilerplate"
    client       = "naxa-developers"
    cost         = "NAXA"
    team         = "DevOps"
    created_with = "NAXA-Terragrunt-CI"
    owner        = "NAXA"
    aws_region   = "ap-south-1"
    account_name = ""
}

```

#### Example `<EnvironmentDir>/terragrunt.hcl` for different environment

```hcl

include "root" {
  path = find_in_parent_folders()
}

terraform {
  # Sourcing from here rn, updating to a release from https://github.com/hotosm/TM-Extractor/ later.
  // source = "${local.base_source_url}?ref=v1.0.0"
  source = ".//src"
}


locals {
  # Automatically load environment-level variables
  environment_vars  = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  inputs  = read_terragrunt_config("inputs.hcl")

  # Extract the variables we need for easy access
  account_name      = local.environment_vars.locals.account_name
  aws_region        = local.environment_vars.locals.aws_region
  application       = local.environment_vars.locals.application
  team              = local.environment_vars.locals.team
  created_with      = local.environment_vars.locals.created_with
  owner             = local.environment_vars.locals.owner
  client            = local.environment_vars.locals.client
  cost              = local.environment_vars.locals.cost

  #Custom variables below
  environment = "development"
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
# Terraform provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

provider "aws" {
  # region and profile is for the architecture
  region                   = "${local.aws_region}"
  profile                  = "default"

  default_tags {
    tags = {
      Environment  = "${local.environment}"
      Application  = "${local.application}"
      Team         = "${local.team}"
      Owner        = "${local.owner}"
      Created_with = "${local.created_with}"
      Cost         = "${local.cost}"
      Client       = "${local.client}"
    }
  }
}
EOF
}

inputs = merge(local.inputs.locals)

```

#### Example `src/main.tf` for importing

```hcl

module "s3" {
  source                           = "/Users/nischal/NAXA/naxa-terraform/modules/s3"
  bucket_name                      = var.bucket_name
  create_iam_user                  = var.create_iam_user
  bucket_username                  = var.bucket_username
  create_public_folder             = var.create_public_folder
  public_folder_key                = var.public_folder_key
  enable_tagged_deletion           = var.enable_tagged_deletion
  deletion_tag                     = var.deletion_tag
  exipiry_days_for_tagged_deletion = var.exipiry_days_for_tagged_deletion
  tagged_deletion_path_key         = var.tagged_deletion_path_key
}
```
