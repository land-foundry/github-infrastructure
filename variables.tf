variable "repository_settings" {
  description = "Five managed settings; defaults are the proposed desired state."
  type = object({
    visibility             = string
    allow_merge_commit     = bool
    allow_squash_merge     = bool
    allow_rebase_merge     = bool
    delete_branch_on_merge = bool
  })

  default = {
    visibility             = "public"
    allow_merge_commit     = true
    allow_squash_merge     = false
    allow_rebase_merge     = false
    delete_branch_on_merge = true
  }

  validation {
    condition     = var.repository_settings.visibility == "public"
    error_message = "This pilot manages github-governance as a public repository."
  }
}
