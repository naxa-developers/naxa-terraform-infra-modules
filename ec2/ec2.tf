resource "aws_instance" "ec2_instance" {
  ami                         = var.ec2_instance_ami
  instance_type               = var.instance_type
  key_name                    = var.create_ssh_key_pair ? aws_key_pair.ssh_key[0].key_name : var.existing_ssh_key_pair_name
  subnet_id                   = var.ec2_subnet_id
  vpc_security_group_ids      = concat(var.ec2_sec_grps, [aws_security_group.ec2_sec_grp[0].id])
  associate_public_ip_address = var.associate_public_ip_address
  # iam_instance_profile   = "${local.name}-ec2-profile"
  # user_data                   = file("${path.module}/Userdata/ec2-base.sh")

  root_block_device {
    volume_size = "15"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${local.name}-ec2"
  }
}
