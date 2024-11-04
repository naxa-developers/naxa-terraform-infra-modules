#VARIABLES

variable "project_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_instance_ami" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "create_ssh_key_pair" {
  type    = bool
  default = true
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
