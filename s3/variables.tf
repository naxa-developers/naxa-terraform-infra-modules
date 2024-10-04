variable "bucket_name" {
  type = string
}

variable "create_iam_user" {
  type    = bool
  default = false
}

variable "bucket_username" {
  type    = string
  default = null
}

variable "create_public_folder" {
  type    = bool
  default = true
}

variable "public_folder_key" {
  type    = string
  default = "public/"

}

variable "enable_tagged_deletion" {
  type    = bool
  default = true
}

variable "deletion_tag" {
  type    = string
  default = "deleted"
}

variable "exipiry_days_for_tagged_deletion" {
  type    = number
  default = 7
}

variable "tagged_deletion_path_key" {
  type    = string
  default = "/"
}



# variable "bucket_iam_user" {
#   type = object({
#     create_iam_user = optional(bool, false)
#     bucket_username = lookup(var.bucket_iam_user, "create_iam_user") ? required(string) : optional(string, "")
#   })
# }


# variable "bucket_config" {
#   type = object({
#     bucket_name                      = required(string)
#     create_public_folder             = optional(bool, true)
#     public_folder_key                = lookup(var.bucket_config, "create_public_folder") ? optional(string, "public/") : optional(string)
#     enable_tagged_deletion           = optional(bool, true)
#     deletion_tag                     = lookup(var.bucket_config, "enable_tagged_deletion") ? optional(string, "deleted") : optional(string)
#     exipiry_days_for_tagged_deletion = lookup(var.bucket_config, "enable_tagged_deletion") ? optional(number, 7) : optional(number)
#     tagged_deletion_path_key         = lookup(var.bucket_config, "enable_tagged_deletion") ? optional(string, "/") : optional(string)

#   })

#   # default = {
#   # }

#   # validation {
#   #   condition     = contains(["ENABLED", "DISABLED"], lookup(var.efs_settings, "transit_encryption"))
#   #   error_message = "Transit encryption needs to be ENABLED or DISABLED"
#   # }

# }
