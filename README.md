# Land Foundry GitHub Infrastructure

A minimal Terraform pilot for five settings on the existing `land-foundry/github-governance` repository.

| Setting | Desired |
|---|---|
| visibility | public |
| allow_merge_commit | true |
| allow_squash_merge | false |
| allow_rebase_merge | false |
| delete_branch_on_merge | true |

## Prepare

Use Terraform 1.13.5 and the locked integrations/github 6.13.0 provider. These are explicit pilot pins, not claims of latest versions. No modules, CI apply workflow, or organization rulesets are included.

Authenticated reads are required: anonymous GitHub responses omit merge-method settings and can produce misleading plans. Renew the GitHub CLI sign-in or supply credentials through the environment; never commit them. The Codex connector's credentials are not available to Terraform. A later apply will require suitable repository administration permissions. With GitHub App authentication, this provider also requires contents:write for reliable merge-setting reads.

## Review without importing or applying

From this directory:

```text
terraform init -input=false
terraform fmt -check -recursive
terraform validate
terraform plan -input=false "-var-file=preview/import-only.tfvars" "-out=import.tfplan"
terraform show -no-color import.tfplan
terraform plan -input=false "-out=settings.tfplan"
terraform show -no-color settings.tfplan
```

The first plan uses the observed current values to preview import only: expect one import and no changes. Refresh the snapshot in preview/import-only.tfvars if live settings change. The second uses the proposed desired settings: expect one import and only the permitted in-place updates. Both start from the same empty state; neither imports anything into persistent state or applies repository changes.

The import target is github_repository.github_governance with GitHub ID github-governance under provider owner land-foundry. Verify the planned full_name is land-foundry/github-governance. Public visibility and merge commits may already match the target and then produce no changes.

Stop for review if either plan proposes creation, replacement, destruction, a different repository, or updates outside the five settings. The resource's ignore_changes list leaves unrelated settings outside this pilot; prevent_destroy guards against planned destruction while the resource remains configured.

Confirm the plan's observed merge-method settings against an authenticated GitHub read. An import-only preview with unexpected setting changes is not a valid baseline; resolve missing permissions or stale observations before proceeding.

## Approval boundary

Do not run terraform import or terraform apply yet. Applying a saved plan can both import the repository into state and update settings. Review and approval of the configuration PR is not approval to apply.

This preview uses local state only. State files and saved plans are ignored. Before any approved import or apply, choose persistent state storage and locking, arrange authenticated access, refresh the plan, and obtain explicit approval. Do not commit plans or state; they can contain sensitive values. No remote backend is provisioned by this pilot.

## References

- [GitHub repository resource](https://registry.terraform.io/providers/integrations/github/6.13.0/docs/resources/repository)
- [Terraform import blocks](https://developer.hashicorp.com/terraform/language/import)
- [Merge decision ADR-002](https://github.com/land-foundry/github-governance/blob/main/docs/adr/002-merge-commits.md)
