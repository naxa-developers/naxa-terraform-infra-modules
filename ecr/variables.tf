variable "application" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The environment for the ECR repository (e.g., dev, stag, prod)."
  type        = string
}

variable "image_tag_mutability" {
  description = "Set the tag mutability for the repository. Valid values are 'MUTABLE' and 'IMMUTABLE'."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable automatic image scanning on push."
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "The type of encryption to use. Valid values are 'AES256' and 'KMS'."
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "The KMS key ID to use for encryption when encryption_type is 'KMS'."
  type        = string
  default     = null
}

variable "prevent_destroy" {
  description = "Set to true to prevent the repository from being accidentally destroyed."
  type        = bool
  default     = false
}
