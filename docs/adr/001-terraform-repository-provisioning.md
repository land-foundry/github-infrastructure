# Use Terraform for GitHub Repository Provisioning

* **ID:** 001
* **Date:** 2026-11-13
* **Status:** Proposed
* **Owner:** Land Foundry

## Context

Land Foundry uses GitHub Free for organizations and needs repeatable repository creation from repository-template with consistent visibility and merge settings.

GitHub's [repository creation controls](https://docs.github.com/en/organizations/managing-organization-settings/restricting-repository-creation-in-your-organization) allow organizations to control creation by members and Apps and to permit public-only creation. Private-only creation restrictions require Enterprise Cloud. Basic creation controls are therefore not entirely paywalled.

[Organization-wide rulesets](https://docs.github.com/en/organizations/managing-organization-settings/creating-rulesets-for-repositories-in-your-organization) require GitHub Team or Enterprise. These enforcement controls are distinct from provisioning repositories with our selected settings.

## Decision

Use Terraform in this repository to create repositories from land-foundry/repository-template and manage public visibility, merge commits enabled, squash and rebase merging disabled, and branch deletion after merge.

This provides a reviewed, repeatable settings configuration while remaining on Free. Terraform is our chosen automation approach; GitHub does not require Terraform, and API scripts are another option. Retain native organization controls where useful.

## Consequences

- Configuration and plans make proposed repository changes reviewable. Existing repositories require explicit adoption before settings management.
- Terraform requires credentials, state management, and an approved apply. It reconciles settings when run, rather than continuously preventing manual changes.
- Terraform uses GitHub's supported APIs; it does not bypass subscription limits or replace permissions and rulesets.
- Reassess the balance between Terraform and native enforcement if the organization's plan or requirements change.
