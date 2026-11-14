# GitHub Infrastructure — Moved

GitHub repository provisioning has moved to [platform-infrastructure/github](https://github.com/land-foundry/platform-infrastructure/tree/main/github).

- [Configuration and operating instructions](https://github.com/land-foundry/platform-infrastructure/blob/main/github/README.md)
- [Migration and state continuity guide](https://github.com/land-foundry/platform-infrastructure/blob/main/docs/github-infrastructure-migration.md)
- [Consolidation decision](https://github.com/land-foundry/platform-infrastructure/blob/main/docs/adr/002-consolidate-platform-infrastructure.md)

Do not plan or apply Terraform from this repository after cutover. Follow the migration guide to preserve existing state ownership and verify the destination plan before switching execution locations. Terraform configuration and examples have been removed here to avoid maintaining two execution locations.

## History

The [original configuration and operating documentation](https://github.com/land-foundry/github-infrastructure/tree/45f4be901f02ed43969044d671b1863740068f70) remain available in Git history. The [original provisioning ADR](docs/adr/001-terraform-repository-provisioning.md) is retained as historical context; its maintained copy is in platform-infrastructure.

Merge the destination change and complete the state continuity checks before merging this retirement change. Archive this repository only after cutover is verified.
