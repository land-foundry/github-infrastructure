# Land Foundry GitHub Infrastructure

Create repositories from `land-foundry/repository-template` with public visibility, merge commits enabled, squash and rebase merging disabled, and automatic branch deletion after merge.

## Prepare

Use Terraform 1.13.5 and integrations/github 6.13.0 with the committed provider lock file. Authenticate through GitHub CLI or environment credentials; never commit credentials. Anonymous reads omit merge settings and cannot support reliable plans. Applying later requires appropriate repository permissions; App authentication also requires contents:write for merge-setting reads.

```text
terraform init -input=false
terraform fmt -check -recursive
terraform validate
```

## Create repositories

Each key in the repositories input is a name in Land Foundry. The optional description is set at creation. from_template defaults to true, copying only the default branch of repository-template, including its pinned AGENTS.md and repository-specific guidance section.

```text
terraform plan -input=false "-var-file=examples/create.tfvars" "-out=create.tfplan"
terraform show -no-color create.tfplan
```

[examples/create.tfvars](examples/create.tfvars) uses repository-provisioning-preview as a plan-only name. Replace it with the intended name before proposing a real creation. From empty state, expect one create and no changes or destruction. The default configuration has no import block.

Template contents are copied at creation time; later template changes do not update existing repositories. Review the template before an approved creation and customize project guidance afterward.

## Update existing repositories

Set from_template=false for an existing repository, as in [examples/existing.tfvars](examples/existing.tfvars). Adopt it through an explicit reviewed import mapping. This updates settings without replacing its files.

For a preview only, create an ignored local adoption.local.tf containing:

```hcl
import {
  to = github_repository.managed["github-governance"]
  id = "github-governance"
}
```

```text
terraform plan -input=false "-var-file=examples/existing.tfvars" "-out=existing.tfplan"
terraform show -no-color existing.tfplan
```

Expect an import and only necessary in-place settings updates. Stop if Terraform proposes creating an already-existing repository. The import block is only a proposal until applied; no terraform import command is needed for this preview. Remove the local import block before returning to the creation example.

Descriptions, template configuration, and unrelated settings are ignored for updates. Visibility is managed: adopting a private repository proposes making it public and requires explicit review. This configuration does not automatically discover or adopt existing repositories.

## State and approval

Supply the complete inventory for each Terraform state on every run. After adoption, retain existing entries when adding a repository; do not alternate these standalone examples against populated state. Removing or renaming a key can propose destruction. prevent_destroy blocks planned destruction while the resource remains configured.

The examples are separate previews from empty local state. Select persistent state storage and locking before an approved apply. State, saved plans, provider binaries, and credentials must stay out of Git.

Stop after plan review. Do not run terraform apply or terraform import without explicit authorization. A creation apply creates repositories; an adoption apply can both persist imports and update settings. PR approval is not apply approval. Refresh and review the plan before an authorized apply.

## Architecture Decisions

- [ADR-001: Use Terraform for GitHub repository provisioning](docs/adr/001-terraform-repository-provisioning.md)

## References

- [GitHub repository resource](https://registry.terraform.io/providers/integrations/github/6.13.0/docs/resources/repository)
- [Terraform import blocks](https://developer.hashicorp.com/terraform/language/import)
- [ADR-002](https://github.com/land-foundry/github-governance/blob/main/docs/adr/002-merge-commits.md)
