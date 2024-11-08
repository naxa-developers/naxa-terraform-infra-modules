#VARIABLES

variable "application" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_instance_ami" {
  type    = string
  default = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "ec2_iam_instance_profile" {
  type    = string
  default = ""

}

variable "create_ssh_key_pair" {
  type    = bool
  default = false
}

variable "ssh_private_key_store_path" {
  type    = string
  default = ""
}

variable "existing_ssh_key_pair_name" {
  type    = string
  default = ""
}

variable "ec2_subnet_id" {
  type = string
}

variable "create_sec_grp" {
  type    = bool
  default = true
}

variable "ec2_sec_grps" {
  description = "List of security group IDs to assign to the EC2 instance"
  type        = list(string)
  default     = []
}

variable "ec2_root_vol_size" {
  type    = string
  default = "15"
}

variable "ec2_ebs_volumes" {
  type = list(object({
    size     = number
    type     = string
    device   = string
    vol_name = string
  }))

  default = [
    {
      size     = 20
      type     = "gp2"
      device   = "/dev/sdb"
      vol_name = "docker-volume"
    },
    {
      size     = 30
      type     = "gp2"
      device   = "/dev/sdc"
      vol_name = "project-volume"
    }
  ]
}

variable "ec2_sec_grp_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = optional(string)
  }))

  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

variable "ec2_sec_grp_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

// TODO: Use object based config in future
# variable "ec2_config" {
#   type = object({
#     ami                         = string
#     instance_type               = string
#     create_ssh_key_pair         = bool
#     existing_ssh_key_pair_name  = string
#     subnet_id                   = string
#     vpc_id                      = string
#     associate_public_ip_address = bool
#     iam_instance_profile        = string
#     root_volume_size            = string
#   })

#   default = {
#     ami                         = "ami-0dee22c13ea7a9a67"
#     instance_type               = "t2.small"
#     create_ssh_key_pair         = false
#     existing_ssh_key_pair_name  = ""
#     subnet_id                   = null
#     vpc_id                      = null
#     associate_public_ip_address = true
#     iam_instance_profile        = ""
#     root_volume_size            = 15
#   }
# }
