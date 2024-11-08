# EC2 security group
resource "aws_security_group" "ec2_sec_grp" {
  count       = var.create_sec_grp ? 1 : length(var.ec2_sec_grps) == 0 ? 1 : 0
  name        = "${local.name}-ec2-sg"
  description = "Sets Ingress and Egress for ${local.name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = {
      for index, rule in var.ec2_sec_grp_ingress :
      index => rule
    }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }

  }

  dynamic "egress" {
    for_each = {
      for index, rule in var.ec2_sec_grp_egress :
      index => rule
    }

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }

  }

  tags = {
    Name = "${local.name}-ec2_sec_grp"
  }
}
