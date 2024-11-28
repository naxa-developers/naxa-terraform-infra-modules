resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.application}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  
  tags = {
    Name        = "${var.application}-${var.environment}"
    Environment = var.environment
    Application = var.application
  }

}

resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = <<EOL
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOL
}
