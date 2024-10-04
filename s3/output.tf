output "bucket_name" {
  value = aws_s3_bucket.s3_bucket
}

output "bucket_user_arn" {
  value = {
    for k, user in aws_iam_user.bucket_user : k => user.arn
  }
}

output "public_folder_key" {
  value = {
    for k, folder in aws_s3_object.public_folder : k => folder.key
  }
}

output "deletion_policy" {
  value = var.enable_tagged_deletion ? jsonencode({
    deletion_tag                     = var.deletion_tag
    exipiry_days_for_tagged_deletion = var.exipiry_days_for_tagged_deletion
    tagged_deletion_path_key         = var.tagged_deletion_path_key
  }) : "No object deletion policy."
}
