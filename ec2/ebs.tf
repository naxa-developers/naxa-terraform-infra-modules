# Create EBS volumes
resource "aws_ebs_volume" "ec2_ebs_volumes" {
  count             = length(var.ec2_ebs_volumes)
  size              = var.ec2_ebs_volumes[count.index].size
  type              = var.ec2_ebs_volumes[count.index].type
  availability_zone = aws_instance.ec2_instance.availability_zone

  tags = {
    Name = "${local.name}-ec2-${var.ec2_ebs_volumes[count.index].vol_name}"
  }
}

# Attach EBS volumes to the EC2 instance
resource "aws_volume_attachment" "ec2_ebs_volumes_attachment" {
  count       = length(var.ec2_ebs_volumes)
  device_name = "/dev/sd${element(["d", "e", "f", "g", "h", "i"], count.index)}"
  volume_id   = aws_ebs_volume.ec2_ebs_volumes[count.index].id
  instance_id = aws_instance.ec2_instance.id
}
