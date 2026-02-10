<!--
Unless explicitly stated otherwise all files in this repository are licensed
under the Apache License Version 2.0.
This product includes software developed at Datadog (https://www.datadoghq.com/).
Copyright 2026 Datadog, Inc.
-->

# Contributing to homebrew-pack

Thank you for your interest in contributing to the Datadog Pack Homebrew tap!

## Getting Started

This repository provides Homebrew formulae for Datadog-maintained tools. Before contributing, please familiarize yourself with:

- [Homebrew's Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Our [AGENTS.md](AGENTS.md) file for development practices
- Datadog's [Open Source Policy](https://datadoghq.atlassian.net/wiki/spaces/OS/pages/1761083447/Datadog+Open+Source+Policy)

## How to Contribute

### Reporting Issues

If you encounter a problem with a formula:

1. Check if the issue already exists in [GitHub Issues](https://github.com/DataDog/homebrew-pack/issues)
2. If not, create a new issue with:
   - Clear description of the problem
   - Steps to reproduce
   - Your system information (OS version, Homebrew version)
   - Expected vs. actual behavior

### Submitting Changes

1. **Fork the repository** and create a branch from `main`
2. **Make your changes** following our guidelines below
3. **Test your changes** thoroughly:
   ```bash
   brew install --build-from-source ./Formula/your-formula.rb
   brew test your-formula
   brew audit --strict your-formula
   ```
4. **Commit your changes** with clear, descriptive commit messages
5. **Push to your fork** and submit a pull request

### Formula Guidelines

When adding or updating formulae:

- Follow [Homebrew's Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Include accurate `desc` and `homepage` fields
- Use verified SHA256 checksums for all downloads
- Document all dependencies
- Add a meaningful `test do` block
- Run `brew audit --strict <formula>` before submitting
- Include license information

### Pull Request Process

1. Ensure your PR description clearly explains:
   - What changes you made
   - Why you made them
   - How you tested them
2. Link any related issues
3. Wait for review from maintainers (@platinummonkey)
4. Address any requested changes
5. Once approved, a maintainer will merge your PR

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive experience for everyone. We expect all contributors to:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

### Unacceptable Behavior

- Harassment, trolling, or discriminatory comments
- Publishing others' private information without permission
- Other conduct which could reasonably be considered inappropriate in a professional setting

### Enforcement

Instances of unacceptable behavior may be reported to the project maintainers. All complaints will be reviewed and investigated promptly and fairly.

## License

By contributing to this project, you agree that your contributions will be licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

## Questions?

If you have questions about contributing:

- Check our [AGENTS.md](AGENTS.md) for development practices
- Open an issue for discussion
- Contact the maintainers

Thank you for contributing to homebrew-pack!
