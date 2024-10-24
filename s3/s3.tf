# CREATE S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "${var.bucket_name}"
  }
}

# s3 bucket acl controls
resource "aws_s3_bucket_ownership_controls" "s3_bucket_ctrls" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "enable_acl" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_acl" "example" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.example,
#     aws_s3_bucket_public_access_block.example,
#   ]

#   bucket = aws_s3_bucket.example.id
#   acl    = "public-read"
# }


resource "aws_s3_bucket_acl" "s3_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_ctrls, aws_s3_bucket_public_access_block.enable_acl]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}


# Create 'public' directory
resource "aws_s3_object" "public_folder" {
  depends_on = [aws_s3_bucket.s3_bucket, aws_s3_bucket_acl.s3_bucket, aws_s3_bucket_public_access_block.enable_acl]
  count      = var.create_public_folder ? 1 : 0
  bucket     = aws_s3_bucket.s3_bucket.bucket
  key        = var.public_folder_key
  acl        = "public-read"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  count  = var.enable_tagged_deletion ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id = "deleted"

    expiration {
      days = var.exipiry_days_for_tagged_deletion
    }

    filter {
      and {
        prefix = var.tagged_deletion_path_key
        tags = {
          deletion_state = var.deletion_tag
          autoclean      = "true"
        }
      }
    }
    status = "Enabled"
  }
}

# S3 Bucket Policy to allow public read access to 'public/' directory
resource "aws_s3_bucket_policy" "public_policy" {
  count      = var.enable_tagged_deletion ? 1 : 0
  bucket     = aws_s3_bucket.s3_bucket.id
  depends_on = [aws_s3_object.public_folder]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.s3_bucket.arn}/${var.public_folder_key}*"
        Principal = "*"
      }
    ]
  })
}

resource "aws_s3_bucket_versioning" "versioning" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
