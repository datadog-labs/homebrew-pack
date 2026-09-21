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
      url "https://github.com/DataDog/pup/releases/download/v1.23.0/pup_1.23.0_Darwin_arm64.tar.gz"
      sha256 "46bd7fcbe743e6b88552ccc777edcc2e0cd099e73c63a35bce9498d003fc8294"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.0/pup_1.23.0_Darwin_x86_64.tar.gz"
      sha256 "ad07f45ca2f7d3827b7b0fd7db50d477da04b3fd46e67ba7a0eeb6615fa85faa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.23.0/pup_1.23.0_Linux_arm64.tar.gz"
      sha256 "9211fd10c7d0b94fefeb5249e9d2ea8bf6d8ddfee88cab8ede9b18519441b691"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.0/pup_1.23.0_Linux_x86_64.tar.gz"
      sha256 "b3b70fa92485dcd065f6142ba15be4eb1f0dd4126f484a6cd3b837843e09f7f0"
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
