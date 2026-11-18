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
      url "https://github.com/DataDog/pup/releases/download/v2.5.1/pup_2.5.1_Darwin_arm64.tar.gz"
      sha256 "899097a5a44d843c8366ab4dcb085f26b51b1b648e2eb46b6ac88d954d436d2d"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.1/pup_2.5.1_Darwin_x86_64.tar.gz"
      sha256 "d281d1e0201447b52d636a28fadd5668f99e6fe858d673ddbadaa0552babd358"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.5.1/pup_2.5.1_Linux_arm64.tar.gz"
      sha256 "771d4b0446c80181e054da5ba2acb8be32c0860f09360822783694b148fdf8b6"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.1/pup_2.5.1_Linux_x86_64.tar.gz"
      sha256 "fda56bddb5b03c2060140eb102972c0c2d9d0f060d1a157fe8e4f93293fae086"
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
