# IAM user creation
resource "aws_iam_user" "bucket_user" {
  count = var.create_iam_user ? 1 : 0
  name  = var.bucket_username != null ? var.bucket_username : "${var.bucket_name}-access-user"
}

# IAM policy to allow the user read/write access to the entire bucket
resource "aws_iam_policy" "bucket_rw_policy" {
  count       = var.create_iam_user ? 1 : 0
  name        = "${var.bucket_name}-read-write-policy"
  description = "IAM policy to allow read/write access to the S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.s3_bucket.arn}"
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.s3_bucket.arn}/*"
      }
    ]
  })
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  count      = var.create_iam_user ? 1 : 0
  user       = aws_iam_user.bucket_user[count.index].name
  policy_arn = aws_iam_policy.bucket_rw_policy[count.index].arn
}

# IAM Access keys for the user
resource "aws_iam_access_key" "bucket_user_access_key" {
  count = var.create_iam_user ? 1 : 0
  user  = aws_iam_user.bucket_user[count.index].name
}
