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
      url "https://github.com/DataDog/pup/releases/download/v2.4.3/pup_2.4.3_Darwin_arm64.tar.gz"
      sha256 "16c4572c0c0d5fb3b18f640fbf57f16252e5ecf13d44f77f906c6ed4ac3bb267"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.3/pup_2.4.3_Darwin_x86_64.tar.gz"
      sha256 "d5aea5f7ed896df33e40fef9ddafb4ec5aa91bb14853a4f22a86178f55079c3c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.4.3/pup_2.4.3_Linux_arm64.tar.gz"
      sha256 "4ed48a28859415ba9f8a6877abe2efffa3ce26881e2d74ebf2359e338fcff242"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.3/pup_2.4.3_Linux_x86_64.tar.gz"
      sha256 "52cfdb6b4475bd30fe16b0863697654a63624e5da5910bd8581946ee5c6c2de1"
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
