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
      url "https://github.com/DataDog/pup/releases/download/v1.23.6/pup_1.23.6_Darwin_arm64.tar.gz"
      sha256 "2f06aa5fa19e519eb68c29c3b65737927af05ff7ea582b8c2ed4b7d89f10738f"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.6/pup_1.23.6_Darwin_x86_64.tar.gz"
      sha256 "ec6e102bd3e31bbc7e4fa647cfe91a6fd1cfd9c6d063c9abd85d4449d6d4d769"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.23.6/pup_1.23.6_Linux_arm64.tar.gz"
      sha256 "c80f14f6e1fda8e794748027cb6048dbbd4ed66feca322edf9cd534d6d817d34"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.6/pup_1.23.6_Linux_x86_64.tar.gz"
      sha256 "9139fa76433098ebad13a1ae3776783fe39a88f5460e12fb4c21bdc45610c714"
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
