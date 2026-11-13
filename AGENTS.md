<!-- Shared instructions source:
Repository: https://github.com/land-foundry/agentic-registry
Artifact: instructions/engineering-restraint/AGENTS.md
Commit: 013c578db9faf6c1fc06a4765040cc5b6610f290
-->

<!-- BEGIN SHARED INSTRUCTIONS -->
# Engineering Restraint

Apply these principles to code, tests, documentation, configuration, and automation.

- **Every line is technical debt.** Add content only when it contributes to the requested outcome, clarity, correctness, or necessary validation. Remove unnecessary additions before completing the change. Do not compress useful content merely to reduce line count.
- **KISS — Keep It Simple, Stupid.** Prefer the simplest understandable solution that meets demonstrated requirements. Avoid speculative abstractions, options, extension points, and infrastructure.
- **DRY — Don't Repeat Yourself.** Reuse existing capabilities and maintain one authoritative source for each rule or piece of knowledge. Do not combine superficially similar concerns that need to evolve independently.
- **High cohesion.** Keep related responsibilities and information together. Each module, document, and change should have a clear purpose.
- **Low coupling.** Minimize dependencies, hidden assumptions, and changes that require unrelated components or documents to move together.

Before adding, inspect what already exists. Keep implementation within the requested scope. Before finishing, review the change for unnecessary structure, duplication, and content. Propose unrelated improvements separately.

Resolve tensions using correctness, understandability, and the requested outcome. Do not pursue any principle mechanically.
<!-- END SHARED INSTRUCTIONS -->

## Repository-Specific Guidance

This pilot previews Terraform management of github-governance visibility and four merge settings only. Preserve the lifecycle exclusions for unrelated repository attributes. Do not run terraform import or terraform apply without explicit approval; an import block is a proposal until applied. Do not commit state, saved plans, credentials, or provider binaries. Use the README's two plan commands and inspect all proposed actions. Select persistent state storage before any approved import or apply.
