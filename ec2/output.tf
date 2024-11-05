output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}

output "ec2_instance_ip" {
  value = var.associate_public_ip_address ? aws_instance.ec2_instance.public_ip : "No Public IP"
}
