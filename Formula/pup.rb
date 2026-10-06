# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  license "Apache-2.0"
  # Some 1.10.0 installs recorded their keg as version "64", which Homebrew
  # compares as newer than any 1.x release and so would never be upgraded.
  version_scheme 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.24.1/pup_1.24.1_Darwin_arm64.tar.gz"
      sha256 "245a1479a252af6abbff759cdcdc752c4bc9a7d79eb56300c3baa6836dd8be40"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.24.1/pup_1.24.1_Darwin_x86_64.tar.gz"
      sha256 "8267d6fd005a1e90515c29ad149409da5048693f8ef6cf741bc9eee66ddcc1f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.24.1/pup_1.24.1_Linux_arm64.tar.gz"
      sha256 "a527597a3e2974361a5c27b73a0527b5ae79515fcb2cb629df880e65d53f4816"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.24.1/pup_1.24.1_Linux_x86_64.tar.gz"
      sha256 "78b1a6020d34e00dc1f682ce654abea6b2707c6e4d9694ae9aaf9c320bc3751e"
    end
  end

  def install
    bin.install "pup"

    # `pup completions <shell>` prints a completion script generated from the
    # binary's own command tree, so the installed completions match the shipped
    # CLI exactly and are refreshed on every upgrade. Installed for the shells
    # Homebrew supports by default (bash, zsh, fish); `pup completions
    # <shell> --install` remains available for elvish/powershell and for an
    # auto-refreshing loader outside the keg.
    generate_completions_from_executable(bin/"pup", "completions")
  end

  test do
    assert_match "Datadog API CLI", shell_output("#{bin}/pup --help")

    assert_path_exists bash_completion/"pup"
    assert_path_exists zsh_completion/"_pup"
    assert_path_exists fish_completion/"pup.fish"
  end
end
