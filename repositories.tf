resource "github_repository" "managed" {
  for_each = var.repositories

  name        = each.key
  description = each.value.description

  visibility             = "public"
  allow_merge_commit     = true
  allow_squash_merge     = false
  allow_rebase_merge     = false
  delete_branch_on_merge = true

  dynamic "template" {
    for_each = each.value.from_template ? [true] : []
    content {
      owner                = "land-foundry"
      repository           = "repository-template"
      include_all_branches = false
    }
  }

  lifecycle {
    prevent_destroy = true

    # Set initial creation values; preserve unrelated settings after adoption.
    ignore_changes = [
      description,
      template,
      homepage_url,
      has_issues,
      has_discussions,
      has_projects,
      has_downloads,
      has_wiki,
      is_template,
      allow_auto_merge,
      allow_forking,
      allow_update_branch,
      merge_commit_title,
      merge_commit_message,
      squash_merge_commit_title,
      squash_merge_commit_message,
      web_commit_signoff_required,
      archived,
      topics,
      security_and_analysis,
      pages,
      vulnerability_alerts,
      ignore_vulnerability_alerts_during_read,
    ]
  }
}
