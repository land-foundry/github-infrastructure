variable "repositories" {
  description = "Complete inventory for this Terraform state. Existing repositories require reviewed import and from_template=false."
  type = map(object({
    description   = optional(string)
    from_template = optional(bool, true)
  }))

  validation {
    condition = alltrue([
      for name in keys(var.repositories) :
      can(regex("^[A-Za-z0-9_.-]{1,100}$", name))
    ])
    error_message = "Repository names must contain 1-100 letters, digits, underscores, periods, or hyphens."
  }
}
