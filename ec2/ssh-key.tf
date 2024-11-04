# PEM key
resource "tls_private_key" "rsa_key_for_ssh" {
  count     = var.create_ssh_key_pair ? 1 : var.existing_ssh_key_pair_name == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  count      = var.create_ssh_key_pair ? 1 : var.existing_ssh_key_pair_name == "" ? 1 : 0
  key_name   = "${local.name}-EC2-instance-SSH-key"
  public_key = tls_private_key.rsa_key_for_ssh[count.index].public_key_openssh
}

resource "local_file" "ssh_private_key" {
  count    = var.create_ssh_key_pair ? 1 : var.existing_ssh_key_pair_name == "" ? 1 : 0
  content  = tls_private_key.rsa_key_for_ssh[count.index].private_key_pem
  filename = var.ssh_private_key_store_path == "" ? "${path.module}/Pem_key/${local.name}-EC2-instance-SSH-key.pem" : var.ssh_private_key_store_path
}
