output "ecr_repository_name" {
  description = "The name of the ECR repository."
  value       = aws_ecr_repository.ecr_repo.name
}

output "ecr_repository_arn" {
  description = "The ARN of the ECR repository."
  value       = aws_ecr_repository.ecr_repo.arn
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = aws_ecr_repository.ecr_repo.repository_url
}

output "lifecycle_policy" {
  description = "The lifecycle policy for the ECR repository."
  value       = aws_ecr_lifecycle_policy.ecr_repo_lifecycle.policy
}
