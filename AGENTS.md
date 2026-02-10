<!--
Unless explicitly stated otherwise all files in this repository are licensed
under the Apache License Version 2.0.
This product includes software developed at Datadog (https://www.datadoghq.com/).
Copyright 2026 Datadog, Inc.
-->

# Agent Guidelines for Datadog Pack

This document describes the Datadog Pack Homebrew tap project and establishes development practices for contributors and automated agents.

## Project Overview

The Datadog Pack tap is a Homebrew repository that provides custom formulae for Datadog-maintained tools and utilities. It enables users to install and update Datadog packages through the standard Homebrew package manager interface.

### Repository Structure

- **Formulae**: Located in the `Formula/` directory (or root directory for simple taps)
- **README.md**: User-facing documentation
- **AGENTS.md**: This file - development practices and guidelines

## Development Practices

### Branching Strategy

**Always create a branch before making changes:**

```bash
git checkout -b <descriptive-branch-name>
```

Branch naming conventions:
- Feature additions: `feature/add-xyz-formula`
- Updates: `update/formula-name-version`
- Bug fixes: `fix/issue-description`
- Documentation: `docs/description`

### Making Changes

1. Create a branch for your changes
2. Make necessary modifications to formulae or documentation
3. Test changes locally using `brew install --build-from-source`
4. Commit changes with clear, descriptive messages
5. Push branch to remote

### Pull Request Workflow

**Always create pull requests using the `gh` CLI tool:**

```bash
# Push your branch
git push -u origin <branch-name>

# Create a pull request with descriptive title and summary
gh pr create --title "Brief descriptive title" --body "Summary of changes"
```

**PR Guidelines:**
- **Title**: Keep concise but descriptive (under 70 characters)
- **Body**: Include:
  - Summary of changes
  - Formula added/updated (with version if applicable)
  - Testing performed
  - Any breaking changes or migration notes

**Example PR body structure:**
```markdown
## Summary
- Added formula for datadog-tool v1.2.3
- Updated installation instructions

## Testing
- Tested installation on macOS 13.x
- Verified formula audit passes

## Notes
None
```

### Formula Guidelines

When adding or updating formulae:
- Follow [Homebrew's Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Run `brew audit --strict <formula>` before committing
- Test installation: `brew install --build-from-source <formula>`
- Include sha256 checksums for all downloads
- Document dependencies clearly

### Commit Messages

Use clear, imperative commit messages:
- `Add formula for datadog-agent 7.50.0`
- `Update datadog-trace to version 2.1.0`
- `Fix installation path in datadog-cli formula`
- `Update README with usage examples`

## Automated Agent Behavior

When automated agents work on this repository:
1. Always create a feature branch
2. Make targeted, specific changes
3. Test changes when possible
4. Create concise, informative PRs using `gh pr create`
5. Include relevant context in PR descriptions
6. Never commit directly to `main`

## Resources

- [Homebrew Documentation](https://docs.brew.sh)
- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
