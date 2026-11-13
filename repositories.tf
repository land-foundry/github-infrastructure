resource "github_repository" "github_governance" {
  name = "github-governance"

  visibility             = var.repository_settings.visibility
  allow_merge_commit     = var.repository_settings.allow_merge_commit
  allow_squash_merge     = var.repository_settings.allow_squash_merge
  allow_rebase_merge     = var.repository_settings.allow_rebase_merge
  delete_branch_on_merge = var.repository_settings.delete_branch_on_merge

  lifecycle {
    prevent_destroy = true

    # Limit this pilot to visibility and the four merge settings.
    ignore_changes = [
      description,
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
