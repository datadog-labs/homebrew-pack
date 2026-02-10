# Datadog Pack

A Homebrew tap for managing Datadog-provided package updates. This tap allows you to install and update Homebrew packages through tools provided by Datadog.

## What is this?

This tap provides access to Datadog's custom Homebrew formulae, enabling you to easily install and manage Datadog tools and utilities on macOS and Linux systems via Homebrew.

## Installation

### Install a specific formula

```bash
brew install datadog/pack/<formula>
```

### Tap first, then install

```bash
brew tap datadog/pack
brew install <formula>
```

### Using Brewfile

Add to your `Brewfile`:

```ruby
tap "datadog/pack"
brew "<formula>"
```

## Usage

After tapping this repository, you can install, upgrade, and manage packages just like any other Homebrew formula:

```bash
brew install datadog/pack/<formula>
brew upgrade <formula>
brew uninstall <formula>
```

## Documentation

For more information on Homebrew usage:
- `brew help`
- `man brew`
- [Homebrew's documentation](https://docs.brew.sh)
